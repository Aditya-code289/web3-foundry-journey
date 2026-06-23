//SPDX License-Identifier: MIT;
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {fundMe} from "../src/fundMe.sol";

contract testContract is Test{

    uint number = 1;

    fundMe FUNDME; // declearing this as a state variable to have its access on other functions 
    function setUp() external{
        // number = number+1;
        FUNDME = new fundMe();
    }

    function testdemo() view public{

        assertEq(FUNDME.min_usd(),1e18); 
        console.log(FUNDME.min_usd()); //console only show result when -vv is used 
        // console.log("price fetched:", FUNDME.fetch_price());


        // assertEq(number,2);
        // console.log("HII", number);
        // console.log("kese ho");
    }

    function testOwner() view public{
        // assertEq(FUNDME.owner(), address(this));
        console.log("price fetched:", FUNDME.fetch_price());
    }


}