// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

interface IJAGDexCallee {
    function jagdexCall(address, uint, uint, bytes calldata) external;
}
