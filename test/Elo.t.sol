// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {Elo} from "../src/Elo.sol";
import {FixedPointMathLib as fp} from "solmate/utils/FixedPointMathLib.sol";

contract EloTest is Test {
    function setUp() public {}

    function testSixteenthRoot1() public {
        // 16th root of 65536 is 2
        uint256 value = Elo.sixteenthRoot(65536);
        assertEq(value, 2);
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
        assertEq(change, 718); // change of 7.20 ELO, but is imprecise due to rounding
        assertEq(negative, false);
    }

    // overdog (player 1) loses
    function testEloChangeNegative2() public {
        // player 1 (1300) loses against player 2 (1200)
        // with kfactor of 20, the elo change should be 12.8
        (uint256 change, bool negative) = Elo.ratingChange(1300, 1200, 0, 20);
        assertEq(change, 1282); // change of 12.80 ELO, but is imprecise due to rounding
        assertEq(negative, true);
    }

    // TODO: fuzz test?
}
