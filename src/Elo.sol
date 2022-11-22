// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {FixedPointMathLib as fp} from "solmate/utils/FixedPointMathLib.sol";

library Elo {
    /// @notice Calculates the N-th root of a number (x), using the babylonian method
    function nthRoot(uint256 x, uint256 n) internal pure returns (uint256 value) {
        uint256 guess = 90;
        uint256 precision = 1;
        uint256 delta = 2;
        uint256 nMinus = n - 1;

        while (delta > precision) {
            value = ((nMinus * guess) + (x / fp.rpow(guess, nMinus, 1))) / n;
            delta = value > guess ? value - guess : guess - value;
            guess = value;
        }
    }

    /// @notice Calculates the change in ELO rating, after a given outcome
    /// @param ratingA the ELO rating of the player A
    /// @param ratingB the ELO rating of the player B
    /// @param score the score of the player A, 1 = won, 0 = lost, 0.5 = draw
    function ratingChange(uint256 ratingA, uint256 ratingB, uint256 score, uint256 kFactor)
        internal
        pure
        returns (uint256 change, bool negative)
    {
        // scale up the inputs by a factor of 100
        // since our elo math is scaled up by 100 (to avoid integer division)
        uint256 _kFactor = kFactor * 10_000;

        bool _negative = ratingB < ratingA;
        uint256 ratingDiff = _negative ? ratingA - ratingB : ratingB - ratingA;
        
        // expected score = 1 / (1 + 10 ^ (ratingDiff / 400))
        uint256 _powered = fp.rpow(10, (ratingDiff + 800) / 40, 1);
        uint256 powered = nthRoot(_powered, 10);

        // change = kFactor * (score - expectedScore)
        // therefore, distribute kFactor to both terms
        uint256 kExpectedScore = _kFactor / (100 + powered);
        uint256 kScore = kFactor * score;

        negative = kScore < kExpectedScore;
        change = negative ? kExpectedScore - kScore : kScore - kExpectedScore;
    }
}
