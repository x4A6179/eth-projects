// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

// Using this template calls directory from openzeppelin implementation
contract testErc20 is IERC20, Ownable {
  mapping(address => mapping(address => uint256)) private _allowances;
  mapping(address => uint256) private _balances;

  address private _owner;
  string private _name;
  string private _symbol;
  uint256 private _totalSupply = 3000; // creating a token with 3k max supply (no burns)

  event Approve(address owner, address sender, uint256 value);

  constructor(string memory n, string memory sym) {
    _name = n;
    _symbol = sym;
    _owner = msg.sender;              // intializes the owner as the address that deploys the contract
    _balances[_owner] = _totalSupply; // gives the total # of supply to the owner address
  }

  function name() public view returns (string memory) {
    return _name;
  }

  function owner() public view override returns (address) {
    return _owner;
  }

  function symbol() public view returns (string memory) {
    return _symbol;
  }

  function totalSupply() public view override returns (uint256) {
    return _totalSupply;
  }

  function balanceOf(address _address) public view override returns (uint256) {
    return _balances[_address];
  }

  function allowance(address owningAcc, address spendingAcc) external view override returns (uint256) {
    return _allowances[owningAcc][spendingAcc];
  }

  function approve(address spender, uint256 amount) external override returns (bool) {
    _approve(msg.sender, spender, amount);
    return true;
  }

  function transfer(address to, uint256 value) external override returns (bool) {
    _transfer(msg.sender, to, value);
    return true;
  }

  function _transfer(address _from, address _to, uint256 amount) internal returns (bool) {
    require(_to != address(0), 'Unable to send zero address. Call burn function instead.');
    require(_balances[_from] >= amount, 'Insufficient funds.');
    _balances[_from] = _balances[_from] - amount;
    _balances[_to] = _balances[_to] + amount;
    emit Transfer(_from, _to, amount);
    return true;
  }

  function _approve(address _owningAddress, address _spender, uint256 amount) internal {
    require(_owningAddress != address(0), "Cannot spend on behalf of null address.");
    require(_spender != address(0), "Null address cannot spend on behalf of another.");
    _allowances[_owningAddress][_spender] = amount; // this adds to the owner's list of ok addresses & sets spending limit
    emit Approve(_owningAddress, _spender, amount);
  }

  function transferFrom(address _sender, address _reciever, uint256 amount) external override returns (bool) {
    _transfer(_sender, _reciever, amount);
    uint256 allowedAmount = _allowances[_sender][msg.sender];
    require(allowedAmount >= amount, "Unable to send more than allowed.");
    unchecked {
      _approve(_sender, msg.sender, amount);
    }
    return true;
  }

  function _burn(address _address, uint256 numTokens) internal onlyOwner {
    require(_address != address(0), 'Null address cannot mint tokens');
    uint256 accountBalance = _balances[_address];
    require(accountBalance >= numTokens, 'Unable to burn more than account balance');
    unchecked {
      _balances[_address] = accountBalance - numTokens;
    }
    _totalSupply -= numTokens;
  }

  function addAllowance(address _address, uint256 amount) external returns (bool) {
    _approve(msg.sender, _address, _allowances[msg.sender][_address] + amount);
    return true;
  }

  function decreaseAllowance(address _address, uint256 amount) public returns (bool) {
    uint256 currentAllowance = _allowances[msg.sender][_address];
    require(currentAllowance >= amount, "Reduced amount would be below zero");
    unchecked {
      _approve(msg.sender, _address, _allowances[msg.sender][_address] - amount);
    }
    return true;
  }
}
