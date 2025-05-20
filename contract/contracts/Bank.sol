// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./Vault.sol";

contract Bank is Vault {
    event Withdrawn(address indexed user, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call withdraw.");
        _;
    }

    function withdraw(uint256 _value) public onlyOwner {
        require(
            _value > 0 && _value <= sentValue,
            "Insufficient balance in Vault."
        );

        sentValue -= _value;

        (bool success, ) = msg.sender.call{value: _value}("");
        require(success, "Failed to send ether");

        emit Withdrawn(msg.sender, _value);
    }
}
