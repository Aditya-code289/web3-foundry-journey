// SPDX License-Identifier: MIT;
pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

error Not_Enough_Amt();
error not_owner();
error withdraw_failed();

contract fundMe{

    uint public constant min_usd = 5e18;
    address public immutable chain_addr; // ALways use constant, immutable to optimize gas 
    uint public count = 0;
    address immutable public owner;

    mapping(address=>uint) public addressToAmt;
    mapping(uint=>uint) indexToAmt;

    constructor(address input_addr){
        chain_addr = input_addr;
        owner = msg.sender;
    }

    modifier OnlyOwner{
        if(msg.sender != owner){
            revert not_owner();
        }
        _;
    }

    function fetch_price() public returns(uint256){

        AggregatorV3Interface priceFeed = AggregatorV3Interface(chain_addr);
        (,int eth_price , , ,) =priceFeed.latestRoundData();
        return uint(eth_price);
    }

    function conversion(uint eth_amt) public returns(uint256){
        uint256 usd_amt = (eth_amt*fetch_price());
        usd_amt = usd_amt/1e18;
        return usd_amt;

    }

    function get_fund() public payable {

        if(conversion(msg.value) < min_usd){
            revert Not_Enough_Amt();
        }
        count ++;
        addressToAmt[msg.sender] = msg.value;
        indexToAmt[count] = msg.value;

    }

    function withdraw() public payable OnlyOwner {
            // using call method 

        (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");  // writing uint amt_ is WRONG!!!
        // call returns bool, if the withdraw is success or not, that's it, on that basis we put the if cond 

        if(success!=true){
            revert withdraw_failed();
        }


    }







}