// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {PriceConverter} from "./PriceConverter.sol";

/**
 * @title CrowdFunding
 * @dev This contract allows crowdfunding using Ether (ETH) with a minimum required funding amount in USD equivalent.
 * The manager deploys the contract and can receive the collected funds once the campaign is over.
 */
contract CrowdFunding {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5e18; // Minimum amount in USD required to participate in the crowdfunding campaign.
    address immutable i_manager; // Immutable address of the manager who deploys and controls the crowdfunding campaign.
    address[] public funders; // Addresses of participants who funded the campaign.
    mapping(address => uint256) public AddresstoUsdAmount; // Mapping to track the USD amount funded by each participant.

    /**
     * @dev Constructor function sets the manager's address as the deployer of the contract.
     */
    constructor() {
        i_manager = msg.sender;
    }

    /**
     * @dev Modifier to restrict access to only the manager of the crowdfunding campaign.
     */
    modifier onlyOwner() {
        require(msg.sender == i_manager, "Only manager can perform this action");
        _;
    }

    /**
     * @dev Allows anyone to fund the crowdfunding campaign by sending ETH with a value equivalent to at least the minimum USD amount.
     * @notice The contributed amount must be greater than or equal to 5 USD equivalent in ETH.
     */
    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "You have to fund at least 5 USD!");
        // Anyone can fund the campaign.
        funders.push(msg.sender);
        AddresstoUsdAmount[msg.sender] += msg.value;
    }

    /**
     * @dev Allows the manager to withdraw the collected funds after the campaign is over.
     * It resets the funders' balances and removes their addresses from the list.
     */
    function withdraw() public onlyOwner {
        for (uint256 i = 0; i < funders.length; i++) {
            address funder = funders[i];
            AddresstoUsdAmount[funder] = 0;
        }
        funders = new address[](0);

        // Transfer the contract balance to the manager's address.
        (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "Call Failed!");
    }

    /**
     * @dev Fallback function to handle incoming Ether transfers and automatically fund the campaign.
     */
    fallback() external payable {
        fund();
    }

    /**
     * @dev Receive function to handle incoming Ether transfers and automatically fund the campaign.
     */
    receive() external payable {
        fund();
    }
}
