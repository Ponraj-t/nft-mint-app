// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
contract MyNFT is ERC721, ReentrancyGuard {
 // Variables
 address public owner;
 uint256 public maxNftCount = 5;
 uint256 public nftMintedCount = 0;
 uint256 public mintingStartTime = 1641532800; // 7 Jan 2023 00:00:00 GMT
 uint256 public mintingEndTime = 1642152000; // 14 Jan 2023 00:00:00 GMT
 // Mapping to keep track of whether a wallet has already minted an NFT or not
 mapping(address => bool) private _hasMinted;
 // Constructor
 constructor(string memory name_, string memory symbol_)
 ERC721(name_, symbol_)
 {
 owner = msg.sender;
 }
 // Function to mint NFTs
 function mintNFT(string memory tokenURI) public nonReentrant {
 require(
 block.timestamp >= mintingStartTime && block.timestamp <= mintingEndTime,
 "Minting is not allowed at this time"
 );
 require(
 !_hasMinted[msg.sender],
 "You have already minted an NFT"
 );
 require(
 nftMintedCount < maxNftCount,
 "All NFTs have been minted"
 );
 uint256 tokenId = nftMintedCount + 1;
 _safeMint(msg.sender, tokenId);
 _setTokenURI(tokenId, tokenURI);
 nftMintedCount += 1;
 _hasMinted[msg.sender] = true;
 }
}
