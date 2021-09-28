# ERC-20 Implementations

Created this repo as a placeholder for all erc implementations.
See source code for understanding of each project.

```solidity
pragma solidity ^0.8.0;

import './ERC20.sol'

contract testERC20 is ERC20 {

    mapping(address => uint256) public projectsCreated;

    function numProjects(address _address) public returns (uint256) {
        return projectsCreated[_address];
    }
}
