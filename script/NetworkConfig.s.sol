// SPDX License-Identifier: MIT;
// writing the code from scratch once again 
pragma solidity ^0.8.19;

import {fundMe} from "../src/fundMe.sol";
import {Script} from "forge-std/Script.sol";

contract network_config{

    address public final_addr;

    constructor(){
        if(block.chainid == 11155111){
            final_addr = ret_sep_addr();
        }
        else{
            final_addr = ret_anvil_addr();
        }
    }

    struct chain_config {
        address chain_address;
    }

    function ret_sep_addr() public view returns(chain_config memory){
        chain_config memory addr_feed = chain_config{chain_address: 0x694AA1769357215DE4FAC081bf1f309aDC325306}();
        return addr_feed;

    }

    function ret_anvil_addr() public view returns(chain_config memory){}

}


