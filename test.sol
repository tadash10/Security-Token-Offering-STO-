// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SecurityTokenOffering {
    // Token details
    string public tokenName;
    string public tokenSymbol;
    uint256 public totalSupply;

    // KYC mapping
    mapping(address => bool) public kycVerified;

    // Accredited investors mapping
    mapping(address => bool) public accreditedInvestors;

    // Token balances mapping
    mapping(address => uint256) public balances;

    // Events
    event TokensIssued(address indexed investor, uint256 amount);
    event KYCVerified(address indexed investor);
    event InvestorAccredited(address indexed investor);
    event TokensTransferred(address indexed from, address indexed to, uint256 amount);

    // Constructor
    constructor(string memory _name, string memory _symbol, uint256 _totalSupply) {
        tokenName = _name;
        tokenSymbol = _symbol;
        totalSupply = _totalSupply;
    }

    // KYC verification
    function verifyKYC(address investor) external {
        // Perform KYC verification, based on relevant regulatory requirements

        // Mark investor as KYC verified
        kycVerified[investor] = true;

        emit KYCVerified(investor);
    }

    // Investor accreditation
    function accreditInvestor(address investor) external {
        // Perform investor accreditation checks, based on relevant regulatory requirements

        // Mark investor as accredited
        accreditedInvestors[investor] = true;

        emit InvestorAccredited(investor);
    }

    // Token issuance
    function issueTokens(address investor, uint256 amount) external {
        require(kycVerified[investor], "Investor is not KYC verified");
        require(accreditedInvestors[investor], "Investor is not accredited");

        // Issue tokens to the investor
        balances[investor] += amount;

        emit TokensIssued(investor, amount);
    }

    // Token transfer
    function transferTokens(address to, uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // Transfer tokens from sender to recipient
        balances[msg.sender] -= amount;
        balances[to] += amount;

        emit TokensTransferred(msg.sender, to, amount);
    }
}
