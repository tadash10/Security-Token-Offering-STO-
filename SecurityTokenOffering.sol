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

    // Circuit breaker
    bool private paused;

    modifier whenNotPaused() {
        require(!paused, "Contract is paused");
        _;
    }

    // Constructor
    constructor(string memory _name, string memory _symbol, uint256 _totalSupply) {
        tokenName = _name;
        tokenSymbol = _symbol;
        totalSupply = _totalSupply;
    }

    // Function to verify KYC status
    function verifyKYC(address investor) external onlyOwner {
        kycVerified[investor] = true;
        emit KYCVerified(investor);
    }

    // Function to accredit an investor
    function accreditInvestor(address investor) external onlyOwner {
        accreditedInvestors[investor] = true;
        emit InvestorAccredited(investor);
    }

    // Function to issue tokens to an investor
    function issueTokens(address investor, uint256 amount) external whenNotPaused {
        require(kycVerified[investor], "Investor is not KYC verified");
        require(accreditedInvestors[investor], "Investor is not accredited");

        balances[investor] += amount;
        emit TokensIssued(investor, amount);
    }

    // Function to transfer tokens
    function transferTokens(address to, uint256 amount) external whenNotPaused {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        balances[to] += amount;

        emit TokensTransferred(msg.sender, to, amount);
    }

    // Function to burn tokens
    function burnTokens(uint256 amount) external whenNotPaused {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        totalSupply -= amount;

        emit TokensTransferred(msg.sender, address(0), amount);
    }

    // Function to update the total supply of tokens
    function updateTotalSupply(uint256 newTotalSupply) external onlyOwner {
        require(newTotalSupply >= totalSupply, "New total supply must be greater than or equal to current total supply");

        totalSupply = newTotalSupply;
    }

    // Function to pause the contract
    function pauseContract() external onlyOwner {
        paused = true;
    }

    // Function to unpause the contract
    function unpauseContract() external onlyOwner {
        paused = false;
    }

    // Function to withdraw ETH from the contract
    function withdrawFunds() external onlyOwner {
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "No funds available for withdrawal");

        payable(owner).transfer(contractBalance);
    }

    // Function to retrieve contract balance
    function getContractBalance() external view onlyOwner returns (uint256) {
        return address(this).balance;
    }

