// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Privacy {

  bool public locked = true;
  uint256 public ID = block.timestamp;
  uint8 private flattening = 10;
  uint8 private denomination = 255;
  uint16 private awkwardness = uint16(now);
  bytes32[3] private data;

  constructor(bytes32[3] memory _data) public {
    data = _data;
  }
  
  function unlock(bytes16 _key) public {
    require(_key == bytes16(data[2]));
    locked = false;
  }

  /*
    A bunch of super advanced solidity algorithms...

      ,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`
      .,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,
      *.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^         ,---/V\
      `*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.    ~|__(o.o)
      ^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'  UU  UU
  */
}

/*
 Using the console & web3, I used the utils function getStorageAt.
 Since storage is packed 32 bytes at a time & 0 indexed, locating data[2] would be simple (data[2] == last value in array|storage location 5)
 Used simple contract function to convert the bytes32 item to bytes16
 Called Privacy.unlock function with the corresponding bytes16 value from openPrivacy contract
*/


contract openPrivacy {
    bytes16 key = bytes16(bytes32(0x2f1a4b3120b5110f5851227225a3aba00fd6fd9afe52758868b3b6046ed7c84e));
    
    function printKey() public view returns (bytes16 _keyhash) {
        return key;
    }
}