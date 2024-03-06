// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {IAccount, UserOperation} from "../lib/account-abstraction/contracts/interfaces/IAccount.sol";
import {ECDSA} from "../lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol";

contract smartAccount is IAccount {
    address public owner;
    uint public count;

    constructor(address _owner) {
        owner = _owner;
    }

    function validateUserOp(
        UserOperation calldata op,
        bytes32,
        uint256
    ) external view returns (uint256 validationData) {
        // typically here we'd check this signature
        address recovered = ECDSA.recover(
            ECDSA.toEthSignedMessageHash(keccak256("wee")),op.signature
        );
        return recovered == owner ? 1 : 0;
    }

    // this is our state changing function, which could be called anything
    function execute() external {
        count++;
    }
}
