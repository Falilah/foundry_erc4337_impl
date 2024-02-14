// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {smartAccount} from "./Account.sol";

contract AccountFactory {
    function createAccount(address _owner) public returns (address) {
        smartAccount newAccount = new smartAccount(_owner);
        return address(newAccount);
    }
}
