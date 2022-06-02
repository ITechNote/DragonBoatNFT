// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

/**
 * ERC-1155 Contract
 * Writing Solidity with Openzeppelin, how to compiler, 
 * deploys and run a smart contract on remix, make sure nothing goes wrong.
**/
contract Basic_1155 is ERC1155 {
    // Set IPFS or HTTP URI for your NFT
    constructor() ERC1155("ipfs://QmPZ5FR66M6kTgGzQ1JYiLAkw4Bw45dbkWg6PEazijeRLY") {}
}

