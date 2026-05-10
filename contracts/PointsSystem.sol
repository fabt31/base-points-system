// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/AccessControl.sol";

/// @title PointsSystem — Non-transferable loyalty points for Base protocols
contract PointsSystem is AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant CAMPAIGN_ROLE = keccak256("CAMPAIGN_ROLE");

    string public name;
    string public symbol;

    mapping(address => uint256) public points;
    mapping(address => uint256) public lifetimePoints;
    mapping(address => uint256) public tier;
    mapping(address => address) public referrer;
    mapping(address => uint256) public referralCount;

    uint256[] public tierThresholds = [0, 1000, 5000, 25000]; // Bronze, Silver, Gold, Diamond

    uint256 public totalPointsIssued;
    uint256 public season = 1;
    uint256 public seasonMultiplier = 100; // 100 = 1x, 200 = 2x

    event PointsEarned(address indexed user, uint256 amount, string reason);
    event PointsSpent(address indexed user, uint256 amount);
    event TierUpdated(address indexed user, uint256 newTier);
    event ReferralRecorded(address indexed referrer, address indexed referee);

    constructor(string memory name_, string memory symbol_) {
        name = name_;
        symbol = symbol_;
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function award(address user, uint256 amount, string calldata reason) external onlyRole(MINTER_ROLE) {
        uint256 adjusted = (amount * seasonMultiplier) / 100;
        points[user] += adjusted;
        lifetimePoints[user] += adjusted;
        totalPointsIssued += adjusted;
        _updateTier(user);
        emit PointsEarned(user, adjusted, reason);
    }

    function spend(address user, uint256 amount) external onlyRole(MINTER_ROLE) {
        require(points[user] >= amount, "Insufficient points");
        points[user] -= amount;
        emit PointsSpent(user, amount);
    }

    function recordReferral(address referee, address ref) external onlyRole(MINTER_ROLE) {
        require(referrer[referee] == address(0), "Already referred");
        referrer[referee] = ref;
        referralCount[ref]++;
        emit ReferralRecorded(ref, referee);
    }

    function _updateTier(address user) internal {
        uint256 pts = lifetimePoints[user];
        uint256 newTier = 0;
        for (uint256 i = tierThresholds.length - 1; i > 0; i--) {
            if (pts >= tierThresholds[i]) { newTier = i; break; }
        }
        if (newTier != tier[user]) {
            tier[user] = newTier;
            emit TierUpdated(user, newTier);
        }
    }

    function getTierName(address user) external view returns (string memory) {
        uint256 t = tier[user];
        if (t == 3) return "Diamond";
        if (t == 2) return "Gold";
        if (t == 1) return "Silver";
        return "Bronze";
    }
}