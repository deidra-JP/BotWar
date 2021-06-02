// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./BotUnit.sol";
import "../token/ERC721/ERC721.sol";
import "../utils/math/Safemath.sol";
import "../access/Ownable.sol";

contract BotOwnership is ERC721 {
  using SafeMath for uint256;
  
  mapping (uint => address) BotApprovals;

  function balanceOf(address _owner) public view returns (uint256 _balance) {
    return ownerbotCount[_owner];
  }

  function ownerOf(uint256 _tokenId) public view returns (address _owner) {
    return botToOwner[_tokenId];
  }  

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerbotCount[_to] = ownerbotCount[_to].add(1);
    ownerbotCount[msg.sender] = ownerbotCount[msg.sender].sub(1);
    botToOwner[_tokenId] = _to;
    Transfer(_from, _to, _tokenId);
  }

  function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    _transfer(msg.sender, _to, _tokenId);
  }

  function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    BotApprovals[_tokenId] = _to;
    Approval(msg.sender, _to, _tokenId);
  }

  function takeOwnership(uint256 _tokenId) public {
    require(BotApprovals[_tokenId] == msg.sender);
    address owner = ownerOf(_tokenId);
    _transfer(owner, msg.sender, _tokenId);
  }
}
    