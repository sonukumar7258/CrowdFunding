// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {PriceConverter} from "./PriceConverter.sol";


contract CrowdFunding{
    using PriceConverter for uint256;
    uint256 public mininumUsd = 5e18;
    address manager;
    address[] funders;
    mapping(address => uint256) AddresstoUsdAmount;

    constructor(){
        manager = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == manager, "Only manager can perform this action");
        _;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= mininumUsd, "You have to fund atleast 5usd!");
        // becasue anyone can fund
        funders.push(msg.sender);
        AddresstoUsdAmount[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner{

        for(uint i = 0; i < funders.length; i++){
            address funder = funders[i];
            AddresstoUsdAmount[funder] = 0;
        } 
        funders = new address[](0);

        // payable(msg.sender).transfer(address(this).balance);

        (bool success,) = payable(msg.sender).call{value: address(this).balance}("");
        require(success,"Call Failed!");
    }
























}
