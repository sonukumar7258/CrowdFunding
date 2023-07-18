// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/**
 * @title PriceConverter
 * @dev Library contract that provides functions to convert Ether (ETH) amounts to their equivalent USD value.
 * It uses Chainlink's AggregatorV3Interface to fetch the current ETH/USD price.
 */
library PriceConverter {
    
    /**
     * @dev Internal function to get the current ETH/USD price from Chainlink's Aggregator.
     * @return uint256 The current ETH/USD price with 18 decimal places.
     */
    function getUsdPrice() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int usdPrice, , , ) = priceFeed.latestRoundData();
        return uint256(usdPrice * 1e10);        
    }

    /**
     * @dev Internal function to convert the given ETH amount to its equivalent USD value.
     * @param ethAmount The amount of Ether to convert to USD.
     * @return uint256 The equivalent USD value with 18 decimal places.
     */
    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        // getUsdPrice() - will return the current USD amount of 1 ETH.
        // ethAmount - Amount for which we have to find the equivalent USD amount.
        // Decimals are not present in Solidity, that's why we have to deal with 18 decimals because 1 ETH = 1e18 wei.
        return uint256((getUsdPrice() * ethAmount) / 1e18);
    }
}

