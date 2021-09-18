pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract testErc20 is ERC20, Ownable {
  struct holder {
    uint256 tokensHeld;
    uint256 daysHeld;
  }

  mapping(address => holder) private holders;

  function _mint()
}
