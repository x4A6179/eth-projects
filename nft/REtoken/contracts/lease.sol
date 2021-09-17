// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/utils/math/SafeMath.sol';
import '@openzeppelin/contracts/access/AccessControl.sol';

contract LeaseAgreement is Ownable, ERC721 {
  // need to include something to hold who (addresses) involved with contract
  using SafeMath for uint256;

  struct Investor {
    uint256 daysInvested;
    uint256 index;
  }

  mapping(address => Investor) private investors;
  address[] private invested;

  uint256 public constant maxInvolved = 4;
  uint256 public totalSupply = 1;
  uint256 public sharePrice;

  //Events to emit to the blockchain whenever there is a change of contract state
  event LogNewInvestor(address indexed _address);
  event RemovedInvestor (address indexed _address);
  event priceChange (uint256 newPrice);

  // constructor to create LeaseAgreement (possible called by manager)
    // possible
  constructor (string memory _name, string memory _symbol) ERC721(_name, _symbol) { }
  // function setPrice (called by manager role)
  function setPrice (uint256 _price) external onlyOwner {
    sharePrice = _price;
    emit priceChange(sharePrice);
  }

  function isInvested (address _address) internal view returns (bool status) {
    require(_address != address(0), "Null Address not allowed in contract");
    if (invested.length == 0) return false;
    return (invested[investors[_address].index] == _address);
  }

  function addInvestor (address _address) external onlyOwner {
    require(_address != address(0), "Not able to add null address to agreement.");
    require(invested.length < maxInvolved, "Unable to add another address.");
    require(isInvested(_address) == false, "Address already invested");
    investors[_address].index = invested.length;
    invested.push(_address);
    investors[_address].daysInvested = investors[_address].daysInvested > 0 ? investors[_address].daysInvested : 0;
    emit LogNewInvestor(_address);
  }

  function removeInvestor (address _address) external onlyOwner {
    require(_address != address(0), "Unable to interact with null address.");
    require(invested.length > 0, "Unable to remove. Contract is empty.");
    require(isInvested(_address), "Address not registered in contract.");
    uint256 removedIndex = investors[_address].index;
    address swappedAddr = invested[invested.length - 1];
    invested[removedIndex] = swappedAddr;
    investors[swappedAddr].index = removedIndex;
    invested.pop();
    emit RemovedInvestor(_address);
  // function to accept LeaseAgreement (called by manager)
  // function to sign LeaseAgreement (would be called by the signee)
  // revert LeaseAgreement on where conditions arent met (possible test)
  // need off chain calculation to determine days invested
  }
}
