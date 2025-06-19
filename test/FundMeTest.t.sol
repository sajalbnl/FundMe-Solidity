
// SPDX-LICENSE-Identifier: MIT
pragma solidity ^0.8.18;
import {Test,console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    function setUp() public {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
    }

    function testMinimumDollarisFive() public {
        assertEq(fundMe.MINIMUM_USD(),5 * 10 ** 18, "Minimum USD should be 5 ETH");
    }

    function testOwnerIsMsgSender() public {
        assertEq(fundMe.i_owner(),msg.sender, "Owner should be the msg.sender");
    }

    function testGetVersion() public {
        uint256 version = fundMe.getVersion();
        console.log("Chainlink Version: %s", version);
        assertEq(version, 4, "Chainlink version should be greater than 0");
    }

}