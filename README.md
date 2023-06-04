# Security-Token-Offering-STO-
This high-level Solidity script represents a basic implementation of an STO platform. It includes the following features:

    Token issuance: The issueTokens function allows the issuance of security tokens to investors who have passed the KYC verification and are accredited.

    KYC verification: The verifyKYC function verifies the KYC status of an investor before issuing tokens to them.

    Investor accreditation: The accreditInvestor function performs checks to ensure that an investor is accredited before allowing them to participate in the token offering.

    Token transfer: The transferTokens function allows token holders to transfer tokens to other addresses, maintaining the necessary balance checks.

    State variables: The contract includes state variables to store the token name, symbol, total supply, KYC status, accredited investor status, and token balances.

    Events: Events are emitted to provide transparency and traceability for token issuances, KYC verifications, investor accreditations, and token transfers.

The script SecurityTokenOffering contains the following functions:

    verifyKYC: Allows the contract owner to verify the KYC status of an investor by marking them as KYC verified.
    accreditInvestor: Enables the contract owner to accredit an investor by marking them as an accredited investor.
    issueTokens: Issues tokens to an investor if they are both KYC verified and accredited, updating their token balance.
    transferTokens: Allows token holders to transfer tokens to another address.
    burnTokens: Enables token holders to burn a specified amount of their tokens, reducing their own balance and the total supply of tokens.
    updateTotalSupply: Allows the contract owner to update the total supply of tokens.
    pauseContract: Allows the contract owner to pause the contract, preventing certain functions from being executed.
    unpauseContract: Allows the contract owner to unpause the contract, re-enabling the execution of all functions.
    withdrawFunds: Allows the contract owner to withdraw any available funds held in the contract's balance.
    getContractBalance: Retrieves the current balance of the contract in terms of ETH.
