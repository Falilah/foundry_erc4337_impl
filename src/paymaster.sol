import {IPaymaster} from "../lib/account-abstraction/contracts/interfaces/IPaymaster.sol";
import {UserOperation} from "../lib/account-abstraction/contracts/interfaces/IAccount.sol";
import {IEntryPoint} from "../lib/account-abstraction/contracts/interfaces/IEntryPoint.sol";

contract Paymaster is IPaymaster {
    function validatePaymasterUserOp(
        UserOperation calldata,
        bytes32,
        uint256
    )
        external
        pure
        override
        returns (bytes memory context, uint256 validationData)
    {
        context = new bytes(0);
        validationData = 0;
    }

    function postOp(
        PostOpMode mode,
        bytes calldata context,
        uint256 actualGasCost
    ) external override {}

    function _validateEntryPointInterface(
        IEntryPoint _entryPoint
    ) internal virtual {
        require(
            IERC165(address(_entryPoint)).supportsInterface(
                type(IEntryPoint).interfaceId
            ),
            "IEntryPoint interface mismatch"
        );
    }
}

interface IERC165 {
    /// @notice Query if a contract implements an interface
    /// @param interfaceID The interface identifier, as specified in ERC-165
    /// @dev Interface identification is specified in ERC-165. This function
    /// uses less than 30,000 gas.
    /// @return `true` if the contract implements `interfaceID` and
    /// `interfaceID` is not 0xffffffff, `false` otherwise
    function supportsInterface(bytes4 interfaceID) external view returns (bool);
}
