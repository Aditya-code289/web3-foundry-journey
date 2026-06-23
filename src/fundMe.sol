//SPDX License-Convertor:MIT;
pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

error NotOwner();  // now this can be replaced using if at require place
error Withdraw_failed();
error Insuff_amount();

contract fundMe{

    address[] public Sender_contract; 
    address public immutable owner;                          // changing to immutable
    uint  public constant min_usd = 1e18;   // 1 USD = 0.005 ETH              // changing to constant

    function fetch_price() public view returns(uint) {
        //Adderess: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        //ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int price,,,) = priceFeed.latestRoundData();

        return uint(price*1e10);
    }

    function conversion(uint eth_amt) public view returns(uint){
        uint result = (eth_amt * fetch_price())/1e18;
        return result;
    }

    function get_fund() public payable{
        // require(conversion(msg.value) >= min_usd, "Not enough emount");
        if(conversion(msg.value) < min_usd){
            revert Insuff_amount();
        }

        Sender_contract.push(msg.sender);
    }

    constructor(){ 
        owner = msg.sender;
    }

    modifier onlyOwner{
        // require(msg.sender == owner, "Not Owner");
        if(msg.sender != owner){
            revert NotOwner();
        }
        _;
    }

    function withdraw() public payable onlyOwner{

        // Transfer
        // payable(msg.sender).transfer(address(this).balance);

        // call
        (bool success,) =payable(msg.sender).call{value: address(this).balance}("");
        // require(success, "failed");
        if(success!= true){
            revert Withdraw_failed();
        }
    }

}

