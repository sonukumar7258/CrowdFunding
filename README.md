# CrowdFunding Smart Contracts

A set of Solidity smart contracts for a decentralized crowdfunding application.

## Introduction

The CrowdFunding Smart Contracts project contains Solidity contracts that enable crowdfunding campaigns on the Ethereum blockchain. The contracts allow individuals to fund a campaign using Ether (ETH) with a minimum required funding amount in USD equivalent. The smart contracts can be integrated into any decentralized application (DApp) that requires crowdfunding functionality.

## Features

- Crowdfunding campaign creation with a minimum funding amount specified in USD.
- Participants can contribute to the campaign using Ether (ETH).
- The smart contract ensures that participants contribute at least the minimum required funding amount.
- The manager can withdraw the collected funds after the campaign ends.
- The contract automatically converts the contributed Ether to its equivalent USD value using Chainlink's Price Feed.

## Usage

To use the CrowdFunding Smart Contracts, follow the steps below:

1. Deploy the smart contracts to the Ethereum network of your choice.

2. Use a Web3 provider like MetaMask to interact with the contracts.

3. Create a new crowdfunding campaign by specifying the minimum funding amount in USD.

4. Allow participants to contribute to the campaign using the "fund" function, sending the desired amount of Ether.

5. Once the campaign is over, the manager can withdraw the collected funds using the "withdraw" function.

