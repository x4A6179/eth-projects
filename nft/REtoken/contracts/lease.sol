pragma solidity ^0.7.0;

import '@openzeppelin/contracts/token/ERC721/presets/ERC721Enumerable.sol'
import '@openzeppelin/contracts/token/ERC721/presets/ERC721Burnable.sol'
import '@openzeppelin/contracts/access/Ownable.sol'

contract LeaseAgreement is Ownable, ERC721Burnable, ERC721Enumerable {
  // need to include something to hold who (addresses) involved with contract
  mapping(address => bool) private partiesInvolved;
  // constructor to create LeaseAgreement (possible called by manager)
    // possible
  constructor (string memory _name, string memory _symbol) ERC721(_name, _symbol) {}
  // function to accept LeaseAgreement (called by manager)
  // function to sign LeaseAgreement (would be called by the signee)
  // revert LeaseAgreement on where conditions arent met (possible test)
}
