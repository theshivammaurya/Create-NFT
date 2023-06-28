// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ImageNft is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("Ironman", "IM") {}

    function createNFT(address receiver, string memory tokenURI)
        public
        returns (uint256)
    {
        uint256 newTokenId = _tokenIds.current();
        _safeMint(receiver, newTokenId);
        _setTokenURI(newTokenId, tokenURI);

        _tokenIds.increment();
        return newTokenId;
    }

    function burnToken(uint256 tokenId) external {
        require(
            _isApprovedOrOwner(msg.sender, tokenId),
            "Caller is not the owner or approved"
        );
        _burn(tokenId);
    }
}