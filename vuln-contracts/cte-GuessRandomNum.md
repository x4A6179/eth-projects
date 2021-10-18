# Solution for Capture the Ether GuessTheRandomNumberChallenge

## contract
```solidity
pragma solidity ^0.4.21;

contract GuessTheRandomNumberChallenge {
    uint8 answer; // still possible to access value

    function GuessTheRandomNumberChallenge() public payable {
        require(msg.value == 1 ether);
        answer = uint8(keccak256(block.blockhash(block.number - 1), now));
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function guess(uint8 n) public payable {
        require(msg.value == 1 ether);

        if (n == answer) {
            msg.sender.transfer(2 ether);
        }
    }
}
```

## Solution
- Deploy the contract
- Utilize web3/ethers to call the contract and identify what's being held in storage space index 0
- Convert response hex object to decimal

```javascript
web3.eth.getStorageAt("<deployed contract address>", 0); // Web3.js
ethers.provider.getStorageAt("<deployed contract address>", 0); // ethers.js
```
