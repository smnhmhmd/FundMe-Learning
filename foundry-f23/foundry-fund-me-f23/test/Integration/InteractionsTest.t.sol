//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

contract InteractionsTest is Test {
    FundMe public fundMe;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 GAS_PRICE = 1;

    function setUp() external {
        DeployFundMe deploy = new DeployFundMe();
        fundMe = deploy.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testUserCanFundInteractions() public {
        FundFundMe fundFundMe = new FundFundMe();
        //vm.prank(USER);
        //fundMe.fund{value: 1e18}();
        fundFundMe.fundFundMe(address(fundMe));
        console.log("Funded by FundFundMe");


        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));
        console.log("Withdrawn by WithdrawFundMe");
        assert(address(fundMe).balance == 0);
    }
}