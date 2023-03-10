// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/utils/Context.sol";
import "./interfaces/IJAGDexFactory.sol";
import "./JAGDexPair.sol";

contract JAGDexFactory is Context, IJAGDexFactory {
    address public feeTo;
    address public feeToSetter;

    mapping(address => mapping(address => address)) public getPair;
    address[] public allPairs;

    // event PairCreated(
    //     address indexed token0,
    //     address indexed token1,
    //     address pair,
    //     uint
    // );

    constructor(address _feeToSetter) {
        feeToSetter = _feeToSetter;
    }

    function allPairsLength() external view returns (uint) {
        return allPairs.length;
    }

    function createPair(
        address tokenA,
        address tokenB
    ) external returns (address pair) {
        require(tokenA != tokenB, "JAGDex: IDENTICAL_ADDRESSES");
        (address token0, address token1) = tokenA < tokenB
            ? (tokenA, tokenB)
            : (tokenB, tokenA);
        require(token0 != address(0), "JAGDex: ZERO_ADDRESS");
        require(
            getPair[token0][token1] == address(0),
            "JAGDex: PAIR_EXISTS"
        ); // single check is sufficient
        bytes memory bytecode = type(JAGDexPair).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
        IJAGDexPair(pair).initialize(token0, token1);
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair; // populate mapping in the reverse direction
        allPairs.push(pair);
        emit PairCreated(token0, token1, pair, allPairs.length);
    }

    function setFeeTo(address _feeTo) external {
        require(_msgSender() == feeToSetter, "JAGDex: FORBIDDEN");
        feeTo = _feeTo;
    }

    function setFeeToSetter(address _feeToSetter) external {
        require(_msgSender() == feeToSetter, "JAGDex: FORBIDDEN");
        feeToSetter = _feeToSetter;
    }
}
