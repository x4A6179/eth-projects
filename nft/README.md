# NFT Subfolder

This subfolder will contain the ERC721 & ERC 1155 standard token I create.
Feel free to provide pointers or tips as I continue to explore these standards.

```solidity
pragma solidity ^0.8.0;

import('@openzepplin/contracts/token/ERC721/ERC721.sol')

contract MyNFT is ERC721 {
    constructor() ERC721("DopeMoonToken", "DMT") {
    }
}
```
