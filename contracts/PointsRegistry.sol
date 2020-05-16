pragma solidity ^0.5.0;

import "@openzeppelin/contracts-ethereum-package/contracts/access/roles/WhitelistedRole.sol";
import "./IPointsRegistry.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";

contract PointsRegistry is IPointsRegistry, WhitelistedRole {
    
  using SafeMath for uint256;

  mapping (bytes32 => uint256) _points;

  function addPoints(bytes32 subjectId, uint256 amount) onlyWhitelisted external returns(bool) {
    _points[subjectId] = _points[subjectId].add(amount);
    emit PointsAdded(subjectId, msg.sender, amount);
    return true;
  }

  function subPoints(bytes32 subjectId, uint256 amount) onlyWhitelisted external returns(bool) {
    _points[subjectId] = _points[subjectId].sub(amount, "points amount exceeds balance");
    emit PointsRemoved(subjectId, msg.sender, amount);
    return true;
  }
  
  function balanceOf(bytes32 subjectId) external view returns(uint256){
    return _points[subjectId];
  }
  
}
