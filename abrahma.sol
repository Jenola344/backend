// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NovaToken is ERC20, Ownable {
    constructor() ERC20("SPAGERO", "SBE") Ownable(msg.sender) {
        _mint(msg.sender, 500_000 * 1e18); // Initial 500k to deployer
        _mint(address(this), 500_000 * 1e18); // Remaining for airdrop/pair/etc
    }

    function sendToClassmates(address[] calldata classmates, uint256 amountEach) external onlyOwner {
        require(classmates.length <= 11, "Max 11 classmates");
        uint256 total = amountEach * classmates.length;
        require(balanceOf(address(this)) >= total, "Not enough tokens in contract");

        for (uint256 i = 0; i < classmates.length; i++) {
            _transfer(address(this), classmates[i], amountEach);
        }
    }
}