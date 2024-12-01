// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

interface AggregatorV3Interface {
    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );
}

library PriceConverter {
    function getPrice() internal view returns (uint256) {
        // ETH/USD price feed on Sepolia Testnet
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (, int256 price, , , ) = priceFeed.latestRoundData();
        return uint256(price * 1e10); // Adjust to 18 decimal places
    }

    function getConversionRate(uint256 ethAmount) 
        internal 
        view 
        returns (uint256) 
    {
        uint256 ethPrice = getPrice(); 
        return (ethPrice * ethAmount) / 1e18;
    }
}