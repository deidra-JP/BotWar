// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../access/Ownable.sol";
import "../utils/math/Safemath.sol";

contract BotUnit is Ownable {
  
  using SafeMath for uint256;

  event Newinfantry(uint infantryId, string name, uint dna);

  uint dnaDigits = 16;
  uint dnaModulus = 10 ** dnaDigits;
  uint cooldownTime = 1 days;
  
  struct BotCommander {
    string name;
    uint dna;
    uint32 level;
    uint32 Order;
    uint16 winCount;
    uint16 lossCount;
  }

  struct Botinfantry {
    string name;
    uint dna;
    uint32 level;
    uint32 Order;
    uint32 readyTime;
  }


Botinfantry[] public botinfantrys;

mapping (uint => address) public botToOwner;
mapping (address => uint) ownerbotCount;

}