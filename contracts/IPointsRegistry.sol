pragma solidity ^0.5.0;

interface IPointsRegistry {

    function setPoints(bytes32 id, uint256 points) external returns (bool);
    
    function balanceOf(bytes32 id) external view returns (uint256 totalBalance);

    event PointsSet(bytes32 indexed id, address sender, uint256 amount);
}