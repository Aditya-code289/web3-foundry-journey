// SPDX License-Identifier:MIT;
pragma solidity ^0.8.19;

import {fundMe} from "../src/fundMe.sol";
import {network_config} from "../script/NetworkConfig.s.sol";
import {Test, console} from "forge-std/Test.sol";

contract test_fundme is Test{

    fundMe FUNDME;
    network_config NETC;
    address Divyansh = makeAddr("DIVYANSH");
    address Aadi = makeAddr("Aditya");

    receive() external payable{} // this is to make the test cpntract capable of receiving tokens 

    function setUp() external  {
        NETC = new network_config();

        vm.startPrank(Aadi);
        FUNDME = new fundMe(NETC.final_addr()); // SO the wner of this contract is now Aadi and no longer the tes contract 
        vm.stopPrank();

    }
    
    function testOwner() public view {
        assertEq(FUNDME.owner(), address(Aadi));
    }

    function test_fetch_pr() public view{
        console.log(FUNDME.fetch_price());
    }

    function test_get_fund() public{
        vm.expectRevert();
        FUNDME.get_fund{value: 1500000000000000 wei}();
    }

    function test_withdraw() public{
        vm.startPrank(Divyansh); // test for not_owner calling the function 
        vm.expectRevert();
        FUNDME.withdraw();
        vm.stopPrank();
        // here divyansh calls the withdraw but since he is not the owner the call should fail!!
    }

    function test_withdraw_owner_pass() public{
        vm.startPrank(address(Aadi));
        FUNDME.withdraw(); // test for owner calls thw withdraw and it works 
        vm.stopPrank();
    }   

    function test_withdraw_amt() public {
        vm.startPrank(Divyansh);
        vm.deal(Divyansh, 5 ether);  
        FUNDME.get_fund{value: 3 ether}(); // this firs part assumes divyansh as msg.sender and divyansh transfers 5 ether to Aadi's contr
        vm.stopPrank();    

        vm.startPrank(Aadi);
        FUNDME.withdraw(); // the owner calls the withdraw and 3 ether goes from fund me to aadi's wallet 
        vm.stopPrank();

        // then we write our assert conditions 
        assertEq(address(FUNDME).balance, 0);
        assertEq(address(Aadi).balance, 3 ether);
        assertEq(address(Divyansh).balance, 2 ether);

        console.log(address(FUNDME).balance);
        console.log(address(Aadi).balance);
        console.log(address(Divyansh).balance);

    }

    function test_mapping () public{
        vm.startPrank(Divyansh);
        vm.deal(Divyansh, 5 ether);  
        FUNDME.get_fund{value: 3 ether}(); 
        vm.stopPrank();    

        assertEq(FUNDME.addressToAmt(address(Divyansh)), 3 ether);
        assertEq(FUNDME.indexToAmt(1), 3 ether);

    }


}