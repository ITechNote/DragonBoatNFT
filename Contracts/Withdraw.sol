// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * ERC-1155 Contract
 * If my smart contact got some money by selling my NFTs, 
 * how to withdraw ETH or ERC-20 token from the contract.
**/
interface IERC20 {
    function transfer(address _to, uint256 _amount) external returns (bool);
}

contract Basic_1155 is ERC1155, Ownable {
    constructor() ERC1155("ipfs://QmPZ5FR66M6kTgGzQ1JYiLAkw4Bw45dbkWg6PEazijeRLY") {}

    // For withdraw costumize ERC-20 token
    function withdrawToken(address _tokenContract, uint256 _amount) external onlyOwner {
        IERC20 tokenContract = IERC20(_tokenContract);
        
        // transfer the token from address of this contract
        // to address of the user (executing the withdrawToken() function)
        tokenContract.transfer(msg.sender, _amount);
    }
    
    // For withdraw ETH
    function withdraw() public onlyOwner{
        payable(msg.sender).transfer(address(this).balance);
    }
}
