pragma solidity ^0.5.8;

contract CEIPattern{

    mapping(address => uint) funds;

    function deposti() public payable {
        funds[msg.sender] = msg.value;
    }

    //check-effects-interaction pattern
    function withdraw(uint amount) public {

        //check - ensure caller has sufficient fund.
        require(funds[msg.sender] == amount);

        //effect - decrement fund balance first before transfer fund to recipient.
        // ensure current balance is updated before interacting with external call
        funds[msg.sender] -= amount;

        //interaction - last step is for external call
        // transfer is used to revert all state changes if error is thrown at recipient.
        msg.sender.transfer(amount);

    }
}
