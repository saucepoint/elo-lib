// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {FixedPointMathLib as fp} from "solmate/utils/FixedPointMathLib.sol";

library Elo {
    /// @notice Get the 16th root of a number, used in ELO calculations
    /// @dev Elo calculations require the 400th root (10 ^ (x / 400)), however this can be simplified to the 16th root (10 ^ ((x / 25) / 16))
    function sixteenthRoot(uint256 x) internal pure returns (uint256) {
        return fp.sqrt(fp.sqrt(fp.sqrt(fp.sqrt(x))));
    }

    /// @notice Calculates the change in ELO rating, after a given outcome
    /// @param ratingA the ELO rating of the player A
    /// @param ratingB the ELO rating of the player B
    /// @param score the score of the player A, scaled by 100. 100 = win, 50 = draw, 0 = loss
    /// @param kFactor the k-factor or development multiplier used to calculate the change in ELO rating. 20 is the typical value
    function ratingChange(uint256 ratingA, uint256 ratingB, uint256 score, uint256 kFactor)
        internal
        pure
        returns (uint256 change, bool negative)
    {
        // scale up the inputs by a factor of 100
        // since our elo math is scaled up by 100 (to avoid integer division)
        uint256 _kFactor;
        bool _negative = ratingB < ratingA;
        uint256 ratingDiff;

        unchecked {
            _kFactor = kFactor * 10_000;
            ratingDiff = _negative ? ratingA - ratingB : ratingB - ratingA;
        }
        require(ratingDiff <= 1125, "Rating difference too large");
        if (_negative) require(ratingDiff < 800, "Rating difference too large");

        // -------------------------------------------------
        // expected score = 1 / (1 + 10 ^ (ratingDiff / 400))

        uint256 n;
        uint256 _powered;
        uint256 powered;
        uint256 kExpectedScore;
        uint256 kScore;

        unchecked {
            // apply offset of 800 to scale the result by 100
            n = _negative ? 800 - ratingDiff : 800 + ratingDiff;
            _powered = fp.rpow(10, n / 25, 1);
            powered = sixteenthRoot(_powered);

            // given `change = kFactor * (score - expectedScore)` we can distribute kFactor to both terms
            kExpectedScore = _kFactor / (100 + powered); // scaled up by 100
            kScore = kFactor * score; // input score is already scaled up by 100

            // determines the sign of the change
            negative = kScore < kExpectedScore;
            change = negative ? kExpectedScore - kScore : kScore - kExpectedScore;
        }
    }
}
