pragma solidity ^0.5.8;

contract CEIPattern{

    mapping(address => uint) funds;

    function deposti() public payable {
        funds[msg.sender] = msg.value;
    }

    //check-effects-interaction pattern
    function withdraw(uint amount) public {

        //check - ensure recipient / caller has sufficient fund.
        require(funds[msg.sender] == amount);

        //effect - decrement fund balance before transfer fund to recipient.
        funds[msg.sender] -= amount;

        //interaction - transfer is used to revert all state changes if error 
        //is thrown at recipient.
        msg.sender.transfer(amount);

    }
}