// SPDX License-Identifier:MIT;
pragma solidity ^0.8.19;

import {fundMe} from "../src/fundMe.sol";
import {network_config} from "../script/NetworkConfig.s.sol";
import {Test} from "forge-std/Test.sol";

contract test_fundme is Test{

    fundMe FUNDME;
    network_config NETC;

    function setUp() external {
        NETC = new network_config();
        FUNDME = new fundMe(NETC.final_addr());

    }
    
    function testDemo() public {
        assertEq(FUNDME.owner(), address(this));
    }

}