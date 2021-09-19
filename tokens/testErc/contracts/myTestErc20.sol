pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

// Using this template calls directory from openzeppelin implementation
contract testErc20 is ERC20, Ownable {
  constructor(string memory name, string memory symbol) ERC20(name, symbol) {
    // only function needed to create the token
    _mint(msg.sender, 100 * 10**uint(decimals()));
  }
}
