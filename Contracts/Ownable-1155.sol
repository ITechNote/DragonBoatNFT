// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * ERC-1155 Contract
 * Learn the idea of ownable, who is owner and what is onlyOwner.
**/
contract Ownable_1155 is ERC1155, Ownable {
    constructor() ERC1155("ipfs://QmPZ5FR66M6kTgGzQ1JYiLAkw4Bw45dbkWg6PEazijeRLY") {}

    // Only owner can set new URI
    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }
}

