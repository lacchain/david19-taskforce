pragma solidity ^0.5.0;

import "@openzeppelin/contracts-ethereum-package/contracts/access/roles/WhitelistedRole.sol";
import "./ILevelPointsRegistry.sol";

contract LevelPointsRegistry is ILevelPointsRegistry, WhitelistedRole {

  mapping (bytes32 => Citizen) _points;

  function setPoints(bytes32 subjectId, uint256 amount, Level level) onlyWhitelisted external returns(bool) {
    Citizen storage citizen = _points[subjectId];

    citizen.points = amount;  
    citizen.level = level;
    _points[subjectId] = citizen;

    emit PointsSet(subjectId, msg.sender, amount, level);
    return true;
  }
  
  function balanceOf(bytes32 subjectId) external view returns(uint256){
    return _points[subjectId].points;
  }
  
  function levelOf(bytes32 subjectId) external view returns(Level){
    return _points[subjectId].level;    
  }
  
}
