// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vault {
    address public owner;
    uint256 public sentValue;
    uint256 public timestamp;
    uint256 public gasUsed;

    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {
        require(msg.value > 0, "Must send some ether.");

        sentValue = msg.value;
        timestamp = block.timestamp;

        // (bool success, ) = msg.sender.call{value: msg.value}("");
        // require(success, "Failed to send ether");
    }

    function getCaller() public view returns (address) {
        return msg.sender;
    }

    function getOrigin() public view returns (address) {
        return tx.origin;
    }

    // function getBlockDetails() public view returns (uint, uint, uint, address) {
    //     return (block.number, block.prevrandao, block.gaslimit, block.coinbase);
    // }

    function getBlockDetails() public view returns (uint blockNumber, uint blockPrevrandao, uint blockGasLimit, address blockCoinBase) {
    return {
        blockNumber = block.number;
        blockPrevrandao = block.prevrandao;
        blockGasLimit = block.gaslimit;
        blockCoinBase = block.coinbase;
    }
    }

    function trackGasUsage() public {
        uint256 initialGas = gasleft();

        // 가스 소비를 유도
        uint256 sum = 0;
        for (uint256 i = 0; i < 10; i++) {
            sum += i;
        }

        uint256 finalGas = gasleft();

        gasUsed = initialGas - finalGas;
    }

    function generateHash(string calldata _msg) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_msg));
    }
}
