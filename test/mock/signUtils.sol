// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {ECDSA} from "../../lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol";

contract signUtils {
    function getTypedDataHash() public view returns (bytes32) {
        return
            ECDSA.toEthSignedMessageHash(
                keccak256(abi.encodePacked(keccak256("wee")))
            );
    }
}
