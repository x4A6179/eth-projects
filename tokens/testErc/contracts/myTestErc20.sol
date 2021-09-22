pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

// Using this template calls directory from openzeppelin implementation
contract testErc20 is IERC20, Ownable {
  mapping(address => mapping(address => uint256)) private _allowances;
  mapping(address => uint256) private _balances

  string private _name;
  string private _symbol;
  uint256 private _totalSupply = 3000; // creating a token with 3k max supply (no burns)

  constructor(string memory name, string memory symbol) {
    _name = name;
    _symbol = symbol;
  }

  function name() public view override return (string memory) {
    return _name;
  }

  function symbol() public view override return (string memory) {
    return _symbol;
  }

  function totalSupply() public view override return (uint256) {
    return _totalSupply;
  }

  function getBalance(address _address) public view return (uint256) {
    return _balances[_address];
  }

  function _transfer(address _from, address _to, uint256 amount) internal return (bool) {
    require(_from == msg.sender);
    require(_from != address(0), 'Unable to tranfer from zero address.');
    require(_to != address(0), 'Unable to send zero address. Call burn function instead.');
    require(_balances[_from] >= amount, 'Insufficient funds.');
    _balances[_from] = _balances[_from] - amount;
    _balances[_to] = _balances[_to] + amount;
    emit Tranfer(_from, _to, amount);
    return true;
  }

  function safeTransferFrom(address _to, uint256 amount) external return ()
  return _transfer(msg.sender(), _to, amount);
}
