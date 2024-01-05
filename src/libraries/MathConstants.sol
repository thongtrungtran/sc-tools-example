// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/// @title Contains constants needed for math libraries
library MathConstants {
  uint256 internal constant TWO_FEE_UNITS = 200_000;
  uint256 internal constant TWO_POW_96 = 2 ** 96;
  uint96 internal constant TWO_POW_24 = 2 ** 24;
  uint96 internal constant TWO_POW_32 = 2 ** 32;
  uint128 internal constant MIN_LIQUIDITY = 100;
  uint8 internal constant RES_96 = 96;
  uint24 internal constant FEE_UNITS = 100_000;
  uint32 internal constant RATIO_UNITS = 1_000_000_000;
  // it is strictly less than 5% price movement if jumping MAX_TICK_DISTANCE ticks
  int24 internal constant MAX_TICK_DISTANCE = 480;
  // max number of tick travel when inserting if data changes
  uint256 internal constant MAX_TICK_TRAVEL = 10;
  uint32 internal constant MAX_VESTING_PERIOD = 24 hours;
}
