// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

/**
 * ERC-1155 Contract
 * Final contract of DragonBoat NFT.
 * with Ownable, MintAndBurn, Withdraw, OpenSea royalties and ERC-2981.
**/

// Create ERC-2981 interface
interface IERC2981Royalties {
    
    function royaltyInfo(uint256 _tokenId, uint256 _value)
        external
        view
        returns (address _receiver, uint256 _royaltyAmount);
}

// Build ERC-2981 contract
abstract contract ERC2981Base is ERC165, IERC2981Royalties {
    struct RoyaltyInfo {
        address recipient;
        uint24 amount;
    }

    /// @inheritdoc ERC165
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override
        returns (bool)
    {
        return
            interfaceId == type(IERC2981Royalties).interfaceId ||
            super.supportsInterface(interfaceId);
    }
}

// For withdraw ERC-20 token
interface IERC20 {
    function transfer(address _to, uint256 _amount) external returns (bool);
}

contract DragonBoatFestNFT is ERC1155, Ownable, ERC2981Base {
    constructor() ERC1155("ipfs://QmPZ5FR66M6kTgGzQ1JYiLAkw4Bw45dbkWg6PEazijeRLY") {}

    // Setting royalty for OpenSea, the .json file need to add "seller_fee_basis_points" and "fee_recipient"
    // more info: https://docs.opensea.io/docs/contract-level-metadata
    // (This function may cause Warning hint on Remix, but it's okay!)
    function contractURI() public view returns (string memory) {
        return "ipfs://QmPZ5FR66M6kTgGzQ1JYiLAkw4Bw45dbkWg6PEazijeRLY";
    }

    RoyaltyInfo private _royalties;

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function mint(uint256 id, uint256 amount) public onlyOwner {
        _mint(msg.sender, id, amount, "");
    }

    function burn(uint256 id, uint256 amount) public{
        _burn(msg.sender, id, amount);
    }

    function withdrawToken(address _tokenContract, uint256 _amount) external onlyOwner {
        IERC20 tokenContract = IERC20(_tokenContract);
        
        // transfer the token from address of this contract
        // to address of the user (executing the withdrawToken() function)
        tokenContract.transfer(msg.sender, _amount);
    }
    
    function withdraw() public onlyOwner{
        payable(msg.sender).transfer(address(this).balance);
    }

    // Set royalties by ERC-2981
    // Value 10000 means 100%, 100 means 1% etc
    function _setRoyalties(address recipient, uint256 value) internal {
        require(value <= 10000, 'ERC2981Royalties: Too high');
        _royalties = RoyaltyInfo(recipient, uint24(value));
    }

    function royaltyInfo(uint256, uint256 value)
        external
        view
        override
        returns (address receiver, uint256 royaltyAmount)
    {
        RoyaltyInfo memory royalties = _royalties;
        receiver = royalties.recipient;
        royaltyAmount = (value * royalties.amount) / 10000;
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC1155, ERC2981Base) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}



