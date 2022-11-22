// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {Elo} from "../src/Elo.sol";
import {FixedPointMathLib as fp} from "solmate/utils/FixedPointMathLib.sol";

contract EloTest is Test {
    function setUp() public {}

    function testNthRoot1() public {
        // 4th root of 81 is 3
        uint256 value = Elo.nthRoot(81, 4);
        assertEq(value, 3);
    }

    function testNthRootWad() public {
        // sqrt of 4e36 is 2e18
        uint256 value = Elo.nthRoot(4e36, 2);
        assertEq(value, 2e18);
    }

    function testNthRootWad2() public {
        // 10th root of 1e25 is 316
        uint256 value = Elo.nthRoot(1e25, 10);
        assertEq(value, 316);
    }

    function testNthRoot2() public {
        // 9th root of 512000000000 is 20
        uint256 value = Elo.nthRoot(512_000_000_000, 9);
        assertEq(value, 20);
    }

    function testNthRoot3() public {
        uint256 value = Elo.nthRoot(fp.rpow(10, 21, 1), 20);
        assertEq(value, 11);
    }

    function testNthRoot4() public {
        uint256 powered = fp.rpow(10, 20, 1);
        assertEq(powered, 1e20);
        uint256 value = Elo.nthRoot(powered, 10);
        // 10th root of 1e20 is 100
        assertEq(value, 100);
    }

    function testEloChange() public {
        // player 1 (1200) wins against player 2 (1400)
        // with kfactor of 20, the elo change should be 15
        (uint256 change, bool negative) = Elo.ratingChange(1200, 1400, 100, 20);
        assertEq(change, 1520);
        assertEq(negative, false);
    }
}
