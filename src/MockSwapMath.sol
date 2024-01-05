// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {SwapMath} from "./libraries/SwapMath.sol";

contract MockSwapMath {
    function computeSwapStep(
        uint256 liquidity,
        uint160 currentSqrtP,
        uint160 targetSqrtP,
        uint256 feeInFeeUnits,
        int256 specifiedAmount,
        bool isExactInput,
        bool isToken0
    ) external view returns (int256 usedAmount, int256 returnedAmount, uint256 deltaL, uint160 nextSqrtP) {
        return SwapMath.computeSwapStep(
            liquidity, currentSqrtP, targetSqrtP, feeInFeeUnits, specifiedAmount, isExactInput, isToken0
        );
    }

    function calcReachAmount(
        uint256 liquidity,
        uint256 currentSqrtP,
        uint256 targetSqrtP,
        uint256 feeInFeeUnits,
        bool isExactInput,
        bool isToken0
    ) external view returns (int256 reachAmount) {
        return SwapMath.calcReachAmount(liquidity, currentSqrtP, targetSqrtP, feeInFeeUnits, isExactInput, isToken0);
    }

    function estimateIncrementalLiquidity(
        uint256 absDelta,
        uint256 liquidity,
        uint160 currentSqrtP,
        uint256 feeInFeeUnits,
        bool isExactInput,
        bool isToken0
    ) external view returns (uint256 deltaL) {
        return SwapMath.estimateIncrementalLiquidity(
            absDelta, liquidity, currentSqrtP, feeInFeeUnits, isExactInput, isToken0
        );
    }

    function calcIncrementalLiquidity(
        uint256 absDelta,
        uint256 liquidity,
        uint160 currentSqrtP,
        uint160 nextSqrtP,
        bool isExactInput,
        bool isToken0
    ) external pure returns (uint256 deltaL) {
        return SwapMath.calcIncrementalLiquidity(absDelta, liquidity, currentSqrtP, nextSqrtP, isExactInput, isToken0);
    }

    function calcFinalPrice(
        uint256 absDelta,
        uint256 liquidity,
        uint256 deltaL,
        uint160 currentSqrtP,
        bool isExactInput,
        bool isToken0
    ) external pure returns (uint256) {
        return SwapMath.calcFinalPrice(absDelta, liquidity, deltaL, currentSqrtP, isExactInput, isToken0);
    }

    function calcReturnedAmount(
        uint256 liquidity,
        uint160 currentSqrtP,
        uint160 nextSqrtP,
        uint256 deltaL,
        bool isExactInput,
        bool isToken0
    ) external pure returns (int256 returnedAmount) {
        return SwapMath.calcReturnedAmount(liquidity, currentSqrtP, nextSqrtP, deltaL, isExactInput, isToken0);
    }
}
