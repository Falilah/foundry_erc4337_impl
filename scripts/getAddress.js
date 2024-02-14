import { BaseError, ContractFunctionRevertedError } from 'viem'
import { account, walletClient, publicClient } from './config'
import { wagmiAbi } from './abi'

import { BaseError, ContractFunctionRevertedError } from 'viem'
import { account, walletClient, publicClient } from './config'
import { wagmiAbi } from './abi'

async function executeFunction(accountAddress) {
  try {
    const result = await publicClient.simulateContract({
      address: accountAddress,
      abi: wagmiAbi,
      functionName: 'getSenderAddress',
      account,
    })

    // You can return the result or any specific data from the mint function
    return result
  } catch (err) {
    if (err instanceof BaseError) {
      const revertError = err.walk(
        (err) => err instanceof ContractFunctionRevertedError
      )
      if (revertError instanceof ContractFunctionRevertedError) {
        const errorName = revertError.data?.errorName ?? ''
        // You can handle the revert error or do something with `errorName`
      }
    }

    // Handle other types of errors if needed
    throw err // Re-throw the error if not handled
  }
}

// Example usage:
const accountAddress = '0x123456789abcdef123456789abcdef123456789a'
const result = await executeMintFunction(accountAddress)
// Process the result or handle errors accordingly
