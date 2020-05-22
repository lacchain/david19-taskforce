pragma solidity ^0.5.0;

import "@openzeppelin/contracts-ethereum-package/contracts/access/roles/WhitelistedRole.sol";
import "./IPointsRegistry.sol";

contract PointsRegistry is IPointsRegistry, WhitelistedRole {

  mapping (bytes32 => uint256) _points;

  function setPoints(bytes32 subjectId, uint256 amount) onlyWhitelisted external returns(bool) {
    _points[subjectId] = amount;
    emit PointsSet(subjectId, msg.sender, amount);
    return true;
  }
  
  function balanceOf(bytes32 subjectId) external view returns(uint256){
    return _points[subjectId];
  }
  
}