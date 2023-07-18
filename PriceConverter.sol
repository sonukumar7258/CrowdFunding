// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


library PriceConverter {
    
    function getUsdPrice() internal view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int usdPrice, , ,) = priceFeed.latestRoundData();
        return uint256(usdPrice * 1e10);        
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        // getUsdPrice() - will returns Current Usd Amount of 1Eth
        // ethAmount - Amount which we have to find the equivalent Usd amount
        // Decimals are not present in Solidity thats why we have to deal it with 18 decimal because 1 eth = 1e18 wei  
        return uint256((getUsdPrice() * ethAmount) / 1e18) ;
    }

}