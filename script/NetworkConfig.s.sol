// SPDX License-Identifier: MIT;
// writing the code from scratch once again 
pragma solidity ^0.8.19;

import {fundMe} from "../src/fundMe.sol";
import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/mockV3aggr.sol";

contract network_config is Script{

    chain_config public final_addr;

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

    function ret_sep_addr() public pure returns(chain_config memory){
        chain_config memory addr_feed = chain_config({chain_address: 0x694AA1769357215DE4FAC081bf1f309aDC325306});
        return addr_feed;

    }

    function ret_anvil_addr() public returns(chain_config memory){

        vm.startBroadcast();
       MockV3Aggregator mock_anvil_addr =  new MockV3Aggregator (8,2000e8);
        vm.stopBroadcast();

        chain_config memory anvil_price_feed = chain_config({chain_address: address(mock_anvil_addr)});

        return anvil_price_feed;
    }

}


