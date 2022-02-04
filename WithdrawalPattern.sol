pragma solidity ^0.5.8;

// Instead of distribuintg fund to all users, allow user to request
// withdraw fund. isolate the interation part.
// This is not a complete contract.
// it is simply to show the 'pulling' or withdrawing
// of funds.
contract WithdrawalPattern {
    mapping(address => uint) funds;

   // allow fund to be pulled 
   function allowForPull(address receiver, uint amount) private {
       funds[receiver] += amount;
   }

   // user come to withdraw one at a time.
   function withdrawFunds() public {
       uint amount = funds[msg.sender];

       require (amount != 0);
       require(address(this).balance >= amount);

       funds[msg.sender] = 0;
       msg.sender.transfer(amount);
   }

}