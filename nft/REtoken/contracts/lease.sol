// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC721/presets/ERC721Enumerable.sol';
import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/utils/math/SafeMath.sol';
import '@openzeppelin/contracts/access/AccessControl.sol';

contract LeaseAgreement is Ownable, ERC721Enumerable {
  // need to include something to hold who (addresses) involved with contract
  using SafeMath for uint256;

  bytes32 public constant LANDLORD_ROLE = keccak256("LANDLORD_ROLE");
  bytes32 public constant LEASEE_ROLE = keccak256("LEASEE_ROLE");

  mapping(address => bool) private isPartyInvolved;

  uint256 public maxPartiesInvolved = 4;
  uint256 public totalSupply = 1;

  address[] private totalInvolved;
  uint256 private leasePrice;

  // constructor to create LeaseAgreement (possible called by manager)
    // possible
  constructor (string memory _name, string memory _symbol) ERC721(_name, _symbol) {
    _setupRole(DEFAULT_ADMIN_ROLE, msg.sender)
  }
  // function setLeasePrice (called by manager role)
  function setLeasePrice (uint256 _price) external onlyRole(LANDLORD_ROLE) {
    leasePrice = _price;
  }

  function addToLease (address[] leasees, uint256 numberOfDays) external onlyRole("LANDLORD_ROLE") {
    for (uint256 i = 0; i < leasees.length; i++) {
      require(leasees[i] != address(0), "Not able to add null address to lease agreement");
      require(totalInvolved.length < maxPartiesInvolved, "Unable to add another address");
      isPartyInvolved[leasees[i]] = true;
      totalInvolved.push(leasees[i]);
    }
  }

  function removeFromLease (address[] leasees) external onlyRole("LANDLORD_ROLE") {
    for (uint256 i = 0; i < leasees.length; i++) {
      require(leasees[i] != address(0), "Can not interact with null address");
      require(totalInvolved.length > 0, "No others involved in contract");
      // need to finish function; should remove the enter addresses from contract list
  }
  // function to accept LeaseAgreement (called by manager)
  // function to sign LeaseAgreement (would be called by the signee)
  // revert LeaseAgreement on where conditions arent met (possible test)
}
