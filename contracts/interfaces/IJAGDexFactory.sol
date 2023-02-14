// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IJAGDexFactory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address , address ) external view returns (address );
    function allPairs(uint) external view returns (address );
    function allPairsLength() external view returns (uint);

    function createPair(address , address ) external returns (address );

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}