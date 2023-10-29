//Fund
//Withdraw

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 SEND_VALUE = 0.1 ether;

    function fundFundMe(address mostRecetlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecetlyDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Funded FundMe with %s", SEND_VALUE);
    }

    function run() external {
        address mostRecetlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        vm.broadcast();
        fundFundMe((mostRecetlyDeployed));
        vm.stopBroadcast();
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address mostRecetlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecetlyDeployed)).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecetlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        vm.broadcast();
        withdrawFundMe((mostRecetlyDeployed));
        vm.stopBroadcast();
    }
}
