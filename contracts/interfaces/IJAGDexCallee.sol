// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IJAGDexCallee {
    function jagdexCall(address, uint, uint, bytes calldata) external;
}
