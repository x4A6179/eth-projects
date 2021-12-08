// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTMarketplace is ReentrancyGuard {
    using Counters for Counters.Counter;
    Counters.Counter private _itemIds;
    Counters.Counter private _itemsSold;

    address payable owner;
    mapping(uint256 => Item) private idToItem;

    constructor() {
        owner = payable(msg.sender);
    }

    struct Item {
        uint256 itemId;
        uint256 tokenId;
        uint256 price;
        address tokenContract;
        address payable seller;
        address payable owner;
        bool sold;
    }

    function getListingPrice(uint256 _itemId) public view returns (uint256 price) {
        return idToItem[_itemId].price;
    }

    // process to list item for sale
    function postForSale(
        address tokenContract, 
        uint256 tokenId, 
        uint256 price) public payable nonReentrant {
            require(price > 0, "Price must at least be 1 wei");
            
            _itemIds.increment();
            uint256 itemId = _itemIds.current();
            idToItem[itemId] = Item(
                itemId,
                tokenId,
                price,
                tokenContract,
                payable(msg.sender),
                payable(address(0)),
                false
            );
            IERC721(tokenContract).transferFrom(msg.sender, address(this), tokenId);
    }

    // process for creating/completing the sale (i.e. transferring)
    function createSale(
        address tokenContract,
        uint256 itemId
    ) public payable nonReentrant {
        uint256 listPrice = idToItem[itemId].price;
        uint256 tokenId = idToItem[itemId].tokenId;
        require(msg.value == listPrice, "Must send enough funds to match list price");

        idToItem[itemId].seller.transfer(msg.value);
        IERC721(tokenContract).transferFrom(address(this), msg.sender, tokenId);
        idToItem[itemId].owner = payable(msg.sender);
        idToItem[itemId].sold = true;
        _itemsSold.increment();
        payable(owner).transfer(listPrice);
    }

    // process for showing owned tokens
    function getOwnedTokens() public view returns (MarketItem[] memory) {
        uint256 totalItems = _itemIds.current();
        uint256 itemCount = 0;
        uint256 curIndex = 0;

        for (uint256 i = 0; i < totalItems; i++) {
            if (idToItem[i + 1].owner == msg.sender) {
                itemCount += 1;
            }
        }
        MarketItem[] memory marketItems = new MarketItem[](itemCount);
        for (uint256 i = 0; i < totalItems; i++) {
            if (idToItem[i + 1] == msg.sender) {
                uint256 indexNow = i + 1;
                MarketItem storage currentItem = idToItem[indexNow];
                itemCount[curIndex] = currentItem;
                curIndex += 1;
            }
        }
        return marketItems;
    }
}