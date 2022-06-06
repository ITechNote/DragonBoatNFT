// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * ERC-1155 Contract
 * Write a Mint and Burn function, start your first NFT porject.
**/
contract MintAndBurn is ERC1155, Ownable {
    constructor() ERC1155("ipfs://QmPZ5FR66M6kTgGzQ1JYiLAkw4Bw45dbkWg6PEazijeRLY") {}

    // Only owner can set new URI
    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    // Only owner have permission to mint NFT
    function mint(uint256 id, uint256 amount) public onlyOwner {
        _mint(msg.sender, id, amount, "");
    }

    // Transfer NFT to zero address
    function burn(uint256 id, uint256 amount) public{
        _burn(msg.sender, id, amount);
    }
}

