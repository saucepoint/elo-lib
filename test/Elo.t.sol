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

    // underdog (player1) wins
    function testEloChangePositive() public {
        // player 1 (1200) wins against player 2 (1400)
        // with kfactor of 20, the elo change should be 15
        (uint256 change, bool negative) = Elo.ratingChange(1200, 1400, 100, 20);
        assertEq(change, 1520); // change of 15.20 ELO
        assertEq(negative, false);
    }

    // underdog (player1) loses
    function testEloChangeNegative() public {
        // player 1 (1200) loses against player 2 (1400)
        // with kfactor of 20, the elo change should be 4.8
        (uint256 change, bool negative) = Elo.ratingChange(1200, 1400, 0, 20);
        assertEq(change, 480); // change of 4.8 ELO
        assertEq(negative, true);
    }

    function testEloChangeDraw() public {
        // player 1 (1200) draws against player 2 (1400)
        // with kfactor of 20, the elo change should be 5.2
        (uint256 change, bool negative) = Elo.ratingChange(1200, 1400, 50, 20);
        assertEq(change, 520); // change of 5.2 ELO
        assertEq(negative, false);
    }

    // overdog (player 1) wins
    function testEloChangePositive2() public {
        // player 1 (1300) wins against player 2 (1200)
        // with kfactor of 20, the elo change should be 7.2
        (uint256 change, bool negative) = Elo.ratingChange(1300, 1200, 100, 20);
        assertEq(change, 720); // change of 7.20 ELO
        assertEq(negative, false);
    }

    // overdog (player 1) loses
    function testEloChangeNegative2() public {
        // player 1 (1300) loses against player 2 (1200)
        // with kfactor of 20, the elo change should be 12.8
        (uint256 change, bool negative) = Elo.ratingChange(1300, 1200, 0, 20);
        assertEq(change, 1280); // change of 12.80 ELO
        assertEq(negative, true);
    }

    // TODO: fuzz test?
}
