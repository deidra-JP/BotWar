// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../access/Ownable.sol";
import "../utils/math/Safemath.sol";

contract BotUnit is Ownable {
  
  using SafeMath for uint256;

  event Newinfantry(uint infantryId, string name, uint dna, uint order);

  uint dnaDigits = 16;
  uint dnaModulus = 10 ** dnaDigits;
  uint cooldownTime = 1 days;
  
  struct BotCommander {
    string name;
    uint discordDna;
    uint32 level;
    uint32 order;
    uint16 winCount;
    uint16 lossCount;
  }

  struct BotInfantry {
    string name;
    uint dna;
    uint32 order;
    uint32 cost;
    uint32 level;
    uint32 readyTime;
  }


BotInfantry[] public botinfantrys;

mapping (uint256 => address) private _owners;
mapping (address => uint256) private _balances;


modifier onlyOwnerOf(uint _botId) {
    require(msg.sender == _owners[_botId]);
    _;
  }

function _createInfantry(string memory _name, uint _dna, uint32 _order) internal {
  botinfantrys.push(BotInfantry(_name, _dna, _order, 1, 1, uint32(block.timestamp + cooldownTime)));
  uint infantryid = botinfantrys.length - 1;
  _owners[infantryid] = msg.sender;
  _balances[msg.sender]++;
  emit Newinfantry(infantryid, _name, _dna, _order);
}

function _generateRandomDna(string memory _str) private view returns (uint) {
    uint rand = uint(keccak256(abi.encode(_str)));
    return rand % dnaModulus;
  }

function createRandomInfantry(string memory _name, uint32 _order) public {
    require(_balances[msg.sender] == 0);
    uint randDna = _generateRandomDna(_name);
    randDna = randDna - randDna % 100;
    _createInfantry(_name, randDna, _order);
  }
}

