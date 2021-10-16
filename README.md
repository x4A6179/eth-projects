# Ethereum Projects Repository

This repo will be a one stop shop for the ethereum projects that I will create.
This will serve as a personal portfolio to exhibit my journey and experience to becoming a well-versed web3 developer

```solidity
pragma solidity ^0.8.0;

contract Experience {
    mapping(address => uint256) public experience;
    
    constructor() public {
	owner = msg.sender;
    }

    function getWeb3Exp(address userAddress) public returns (uint256 exp) {
        require(msg.sender == owner);
	return experience[userAddress]; // returns 2 (months)
    }
}
```

```javascript
const ethers = require('ethers');

async function createInstance = () => {

    const contract = await new ethers.getContractFactory("Experience");
    const experience = await contract.deploy();
    await experience.deployed();

}
```
