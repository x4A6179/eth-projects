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

  event Transfer(address from, address to, uint256 value);
  event Approve(address owner, address sender, uint256 value);

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

  function _transfer(address _to, uint256 amount) internal return (bool) {
    require(_to != address(0), 'Unable to send zero address. Call burn function instead.');
    require(_balances[_from] >= amount, 'Insufficient funds.');
    _balances[_from] = _balances[_from] - amount;
    _balances[_to] = _balances[_to] + amount;
    emit Tranfer(_from, _to, amount);
    return true;
  }

  function _approve(address _owner, address _spender, uint256 amount) internal {
    require(_owner != address(0), "Cannot spend on behalf of null address.")
    require(_spender != address(0), "Null address cannot spend on behalf of another.")
    _allowances[_owner][_spender] = amount; // this adds to the owner's list of ok addresses & sets spending limit
    emit Approve(_owner, _spender, amount);
  }

  function transferFrom(address _sender, address _reciever, uint256 amount) external return (bool) {
    _transfer(_from, _to, amount);
    allowedAmount = _allowances[_from][_msgsender()];
    require(allowedAmount >= amount, "Unable to send more than allowed.");
    unchecked {
      _approve(_sender, _msgsender(), amount);
    }
    return true;
  }

  function _burn(address _address, uint256 numTokens) internal onlyOwner {
    require(_address != address(0), 'Null address cannot mint tokens');
    uint256 accountBalance = _balances[_address];
    require(accountBalance >= numTokens, 'Unable to burn more than account balance')
    unchecked {
      _balances[_address] = accountBalance - numTokens;
    }
    _totalSupply -= numTokens;
  }
}
