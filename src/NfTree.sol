//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";



contract NfTree is ERC721, Ownable {
    struct Tree {
        uint256 id;
        uint256 plantedTime;
        uint256 lastWateredTime;
        bool isMatured;
        bool isMinted;
        string imageURI;
    }

    mapping(uint256 => Tree) public trees; //this mapping gives the Tree struct for a particular treeId/tokenId if we pass it as the index for trees array
    uint256 public s_treeCounter;

    event TreePlanted(uint256 indexed treeId, address indexed planter);
    event TreeWatered(uint256 indexed treeId, address indexed waterer);
    event TreeMinted(uint256 indexed treeId, address indexed minter, string imageURI);

    constructor() ERC721("NfTree", "NFTT") {
        s_treeCounter=0;
    }

    function plantNfTree() external {
        require(balanceOf(msg.sender) == 0, "Only one tree per address is allowed.");
        s_treeCounter++;
        uint256 tokenId = s_treeCounter;
        uint256 currentTime = block.timestamp;

        trees[tokenId] = Tree(tokenId, currentTime, currentTime, false, false, "");

        emit TreePlanted(tokenId, msg.sender);
    }

    function waterNfTree(uint256 treeId) external {
        require(ownerOf(treeId) == msg.sender, "Only tree owner can water the tree.");
        require(trees[treeId].isMatured == false, "Cannot water a matured tree.");
        require(trees[treeId].isMinted == false, "Tree has already been minted.");
        require(trees[treeId].lastWateredTime + 1 days <= block.timestamp, "Can only water once per day.");

        trees[treeId].lastWateredTime = block.timestamp;
        //event emitted after tree is watered
        emit TreeWatered(treeId, msg.sender);
    }

function mintNfTree(uint256 treeId, string memory imageURI) external{
    require(ownerOf(treeId) == msg.sender, "Only tree owner can mint the tree.");
    require(trees[treeId].isMatured == true, "Tree has not yet matured.");
    require(trees[treeId].isMinted == false, "Tree has already been minted.");
    //minimum 15 days of watering is required
    require(trees[treeId].plantedTime + 15 days <= block.timestamp, "Tree needs to be watered continuously for 15 days.");

    trees[treeId].isMinted = true;
    trees[treeId].imageURI = imageURI;

    _safeMint(msg.sender, treeId);
    //event emitted when the Nft is minted
    emit TreeMinted(treeId, msg.sender, imageURI);
}

function getTreeDetails(uint256 treeId) external view returns (Tree memory) {
    require(treeId <= s_treeCounter, "Invalid tree ID");
    return trees[treeId];
}


}
