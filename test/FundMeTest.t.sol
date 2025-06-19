// SPDX-LICENSE-Identifier: MIT
pragma solidity ^0.8.18;
import {Test,console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    function setUp() public {
        fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

    function testMinimumDollarisFive() public {
        assertEq(fundMe.MINIMUM_USD(),5 * 10 ** 18, "Minimum USD should be 5 ETH");
    }

    function testOwnerIsMsgSender() public {
        assertEq(fundMe.i_owner(),address(this), "Owner should be the msg.sender");
    }

    function testGetVersion() public {
        uint256 version = fundMe.getVersion();
        console.log("Chainlink Version: %s", version);
        assertEq(version, 4, "Chainlink version should be greater than 0");
    }

}