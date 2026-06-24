// /* We want ki if we deploy on local anvil blcokchain or if we deploy on sepolia testnet, then our contract automatically catches 
//    our requirement and test and deploy accordingly depending of what rpc_url we have provided or have provided none 

//    // Also, we try to avoid the testnet as it has limited calls to api rpc url, the third party companies, so here are going to solve this issue 

//    // also the issue of hardcoded address 

// */

// //SPDX License-Identifier: MIT;
// pragma solidity ^0.8.19;

// import {Script} from "forge-std/Script.sol";
// import {MockV3Aggregator} from "../test/Mocks/aggrv3.sol";

// contract helpConfig is Script{

//     network_addr public active_addr;
//     uint8 public constant decimal = 8;
//     int public initial_price = 2000e8; // the constructor expects int256 not uint as some inputs like temperature can be negative 

//     //we will create two function one which returns sepolia eth address and one which returns anvil local chain address
//     // now we will create a custom data type which stores the address of the req network 
//     // then we write ifelse statement to select betwwen the functions 
//     // *** IN CONSTRUCTOR SO THAT IT GETS CARRY ON WHOLE TIME AFTER DEPLOYEMENT 

//     constructor (){
//         if(block.chainid == 11155111){
//             active_addr = ret_sep_addr();
//         }
//         else{
//             active_addr = ret_anvil_addr();
//         }
//     }

//     struct network_addr{
//         address pricefeed_addr;
//     }

    

//     function ret_sep_addr() public pure returns(network_addr memory){
//         network_addr memory sep_addr = network_addr({pricefeed_addr:0x694AA1769357215DE4FAC081bf1f309aDC325306});
//         return sep_addr;
//     }


//     function ret_anvil_addr() public returns (network_addr memory){

//         if(active_addr.pricefeed_addr != address(0)){
//             return active_addr;       
            
//         // this is being done so that the mock contract does not deploy again when it is deployed for once, it is done to keep the address same which helps in effecient testing 
        
//         }
        
//         vm.startBroadcast();
//         MockV3Aggregator mockPriceFeed =  new MockV3Aggregator(decimal, initial_price); // no need to define the data tyoe here as it is already has been in state variables

//         vm.stopBroadcast();

//         network_addr memory anvil_addr = network_addr({pricefeed_addr: address(mockPriceFeed)});

//         return anvil_addr;
//     }
// }