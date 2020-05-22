pragma solidity ^0.5.0;

interface ILevelPointsRegistry {
    
    enum Level{
        CommittedCitizen,
        HeroPromise,
        HeroApprentice,
        Hero,
        HeroMaster,
        David19
    }
    
    struct Citizen {
        uint256 points;
        Level level;
    }

    function setPoints(bytes32 subjectId, uint256 points, Level level) external returns (bool);
    
    function balanceOf(bytes32 subjectId) external view returns (uint256 totalBalance);

    function levelOf(bytes32 subjectId) external view returns (Level level);

    event PointsSet(bytes32 indexed subjectId, address sender, uint256 amount, Level level);
}