
// SPDX-LICENSE-Identifier: MIT
pragma solidity ^0.8.18;
import {Test,console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;
    address USER = makeAddr("user");
    uint256 constant AMOUNT = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether; 


    function setUp() public {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE); // Give USER 10 ETH
    }

    function testMinimumDollarisFive() public view {
        assertEq(fundMe.MINIMUM_USD(),5 * 10 ** 18, "Minimum USD should be 5 ETH");
    }

    function testOwnerIsMsgSender() public view {
        assertEq(fundMe.i_owner(),msg.sender, "Owner should be the msg.sender");
    }

    function testGetVersion() public view {
        uint256 version = fundMe.getVersion();
        console.log("Chainlink Version: %s", version);
        assertEq(version, 4, "Chainlink version should be greater than 0");
    }

    function testFundFailsWithoutEnoughEth() public {
        vm.prank(USER);
        
        fundMe.fund{value: AMOUNT}();
        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(amountFunded,AMOUNT);  // Sending 1 ETH, which is less than the minimum of 5 ETH
    }

    function testAddsFunderToArray() public {
        vm.prank(USER);
        fundMe.fund{value: AMOUNT}();
        address funder = fundMe.getFunder(0);
        assertEq(funder, USER, "Funder should be added to the funder list");
    }

    function testOnlyOwnerCanWithdraw() public {
        vm.prank(USER);
        vm.expectRevert();
        fundMe.withdraw();
    }

    

}