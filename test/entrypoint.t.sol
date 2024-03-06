// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {MyEntryPoint} from "../src/myEntryPoint.sol";
import {smartAccount, UserOperation} from "../src/Account.sol";
import {AccountFactory} from "../src/AccountFactory.sol";
import {Paymaster} from "../src/paymaster.sol";
import {signUtils} from "./mock/signUtils.sol";

contract CounterEntryPoint is Test {
    MyEntryPoint public entryPoint;
    smartAccount AbiSender;
    AccountFactory factory;
    Paymaster paymaster;
    signUtils sign;

    // Account Owner = makeAccount("Owner");
    address ownr = 0xB33F98b2173222D88BAc8d77c4aED1e240E70c21;

    function setUp() public {
        entryPoint = new MyEntryPoint();
        factory = new AccountFactory();
        paymaster = new Paymaster();
        sign = new signUtils();
        vm.deal(address(this), 10 ether);
    }

    function testAA() public {
        bytes memory data = abi.encodeWithSignature(
            "createAccount(address)",
            ownr
        );
        bytes memory initcode = abi.encodePacked(address(factory), data);

        address senderAddress = 0xffD4505B3452Dc22f8473616d50503bA9E1710Ac;
        uint nonce = entryPoint.getNonce(senderAddress, 0);

        bytes memory _calldata = abi.encodeWithSignature("execute()");
        bytes memory paymasterData = abi.encodePacked((address(paymaster)));

        bytes
            memory signature = hex"0231791f04365ae262e45c058ed9f362552e7cf47ebec533e2ddd52a03c143eb1f60da1fd6aac2934c8a8bd42f25bf521dc142cebd9f8d71391c0d8a466039c61c";

        console2.logBytes(signature);

        entryPoint.depositTo{value: 2 ether}(address(paymaster));
        console2.log(senderAddress);
        UserOperation memory UO = UserOperation(
            senderAddress,
            nonce,
            initcode,
            _calldata,
            200_000,
            200_000,
            50_000,
            10 gwei,
            5 gwei,
            paymasterData,
            signature
        );

        // entryPoint.getUserOpHash(UO);
        address beneficiary = makeAddr("Beneficiary");
        UserOperation[] memory batch = new UserOperation[](1);
        batch[0] = UO;

        entryPoint.handleOps(batch, payable(beneficiary));

        console2.log("////////////////user Op creted//////////////////");
        AbiSender = smartAccount(senderAddress);
        AbiSender.count();
        address _owner = AbiSender.owner();
        assertEq(ownr, _owner);
    }

    function getAddress(
        bytes memory initcode
    ) public returns (address senderAddress) {
        try entryPoint.getSenderAddress(initcode) {} catch Error(
            string memory stat
        ) {
            if (bytes(stat).length > 0) {
                senderAddress = abi.decode(bytes(stat), (address));
            }
        }
    }
    function testgetHash() public {
        sign.getHash();
    }
}
