// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {FixedPointMathLib as fp} from "solmate/utils/FixedPointMathLib.sol";

contract GasTest {
    function meme(uint256 x) public pure returns (uint256) {
        return fp.sqrt(fp.sqrt(fp.sqrt(fp.sqrt(x))));
    }

    function powwad(int256 x) public pure returns (int256) {
        return fp.powWad(x, 0.0625e18);
    }
}
