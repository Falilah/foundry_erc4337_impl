// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MyEntryPoint} from "../src/myEntryPoint.sol";

contract EntryPointScript is Script {
    uint256 deployerPrivateKey;

    function setUp() public {
        deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    }

    function run() public {
        vm.broadcast(deployerPrivateKey);
        MyEntryPoint entryPoint = new MyEntryPoint();
    }
}
