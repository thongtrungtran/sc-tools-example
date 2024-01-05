// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {SymTest} from "halmos-cheatcodes/SymTest.sol";
import {TickMath} from "src/libraries/TickMath.sol";
import {MockSwapMath} from "src/MockSwapMath.sol";

contract SwapMathTest is Test, SymTest {
    MockSwapMath swapMath = new MockSwapMath();

    /// @dev Here we set specified values for fee and liquidity amount since generated amount would cause arithmetic underflow/overflow
    uint256 feeInFeeUnits = 300;
    uint128 liquidity = 10_000_000_000 ether - 1;

    /// @dev For running Foundry fuzzing
    function test_computeSwapStep(uint160 currentSqrtP, uint160 targetSqrtP, bool isExactInput) public {
        _preConditions(currentSqrtP, targetSqrtP);

        bool isToken0 = isExactInput ? (currentSqrtP > targetSqrtP) : (currentSqrtP < targetSqrtP);

        int256 reachAmount =
            swapMath.calcReachAmount(liquidity, currentSqrtP, targetSqrtP, feeInFeeUnits, isExactInput, isToken0);

        if (isExactInput) {
            assertTrue(reachAmount >= 0);
        } else {
            assertTrue(reachAmount <= 0);
        }

        uint256 absDelta = isExactInput ? uint256(reachAmount) : uint256(-reachAmount);

        if (absDelta != 0) {
            absDelta -= 1;
            uint256 fee = swapMath.estimateIncrementalLiquidity(
                absDelta, liquidity, currentSqrtP, feeInFeeUnits, isExactInput, isToken0
            );
            uint256 nextSqrtP = swapMath.calcFinalPrice(absDelta, liquidity, fee, currentSqrtP, isExactInput, isToken0);
            if (currentSqrtP > targetSqrtP) {
                assertGe(nextSqrtP, targetSqrtP);
            } else {
                assertLe(nextSqrtP, targetSqrtP);
            }
        }
    }

    /// @dev For running Halmos
    function check_computeSwapStep(uint160 currentSqrtP, uint160 targetSqrtP, bool isExactInput) public {
        _preConditions(currentSqrtP, targetSqrtP);

        bool isToken0 = isExactInput ? (currentSqrtP > targetSqrtP) : (currentSqrtP < targetSqrtP);

        int256 reachAmount =
            swapMath.calcReachAmount(liquidity, currentSqrtP, targetSqrtP, feeInFeeUnits, isExactInput, isToken0);

        if (isExactInput) {
            assert(reachAmount >= 0);
        } else {
            assert(reachAmount <= 0);
        }

        uint256 absDelta = isExactInput ? uint256(reachAmount) : uint256(-reachAmount);

        if (absDelta != 0) {
            absDelta -= 1;
            uint256 fee = swapMath.estimateIncrementalLiquidity(
                absDelta, liquidity, currentSqrtP, feeInFeeUnits, isExactInput, isToken0
            );
            uint256 nextSqrtP = swapMath.calcFinalPrice(absDelta, liquidity, fee, currentSqrtP, isExactInput, isToken0);
            if (currentSqrtP > targetSqrtP) {
                assert(nextSqrtP >= targetSqrtP);
            } else {
                assert(nextSqrtP <= targetSqrtP);
            }
        }
    }

    function _preConditions(uint160 currentSqrtP, uint160 targetSqrtP) internal {
        vm.assume(currentSqrtP >= TickMath.MIN_SQRT_RATIO && currentSqrtP <= TickMath.MAX_SQRT_RATIO);
        vm.assume(targetSqrtP >= TickMath.MIN_SQRT_RATIO && targetSqrtP <= TickMath.MAX_SQRT_RATIO);
        vm.assume(
            uint256(currentSqrtP) * 95 < uint256(targetSqrtP) * 100
                && uint256(targetSqrtP) * 100 < uint256(currentSqrtP) * 105
        );
    }
}
