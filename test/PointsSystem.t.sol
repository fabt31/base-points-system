// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "forge-std/Test.sol";
import "../contracts/PointsSystem.sol";
contract PointsSystemTest is Test {
    PointsSystem pts;
    function setUp() public { pts = new PointsSystem("BasePoints", "BP"); }
    function test_awardPoints() public {
        pts.award(address(1), 100, "deposit");
        assertEq(pts.points(address(1)), 100);
    }
    function test_tierBronzeDefault() public {
        assertEq(pts.getTierName(address(1)), "Bronze");
    }
    function test_tierGoldAt5000() public {
        pts.award(address(1), 5000, "trading");
        assertEq(pts.getTierName(address(1)), "Gold");
    }
}
