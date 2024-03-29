# Design Pattern

This section focuses on some of the key secuirty patterns / principles in Smart Contract Design.  
One of the main reasons is that your code must be able to respond to bugs and vulnerabilities gracefully.

## Key Security Patterns

Some of the Security Design Patterns in smart contracts :
1. Checks Effect Interation pattern
2. Withdrawal (Pull Over Push) pattern
3. Access Restriction Pattern
4. Emergency Action Pattern
   - speed bump
   - rate limit
   - circuit breaker


--------

### 1. Checks Effect Interaction (CEI) pattern :
- What :
  - secure / right ordering :
     ```
     - check first
     - effects to state variable
     - interaction last
     ```
- Why needed ?
  - avoid re-entrancy attack
    - function that is invoked repeatedly that should be executed once - DAO attack.     
     
- How
  - first validating all arguments 
    - throw appropriate errors when arguments do no meet the expected output
  - once validated, then make changes to smart contract states
  - only interact with other smart contract or account in the last step
     - i.e. ensure current contract has finshied executing all its functionalities.

- When to use it ?
  - good for function that needs to make external calls (to other smart contract or account)

- *Note :*
    - *regarded as optimistic method :*
      - *effects are written down as completed, before they actually took place*
      - *This is ok as the whole transaction can be reverted (via transfer() call), if effect fails.* 

- example :
  - see [CEIPattern.sol](https://github.com/dtan1/designpattern/blob/main/CEIPattern.sol)

-----
### 2. Withdrawal Pattern (Pull Over Push) :
- What
  - distruibute funds over a large number of users / recipients. 

- When
  - distruibute airdrop or dividents, or
  - sending profits of bets to multiple winners, or
  - refund to all participants when target not reached etc

- Why 
  - shift the risk associated with transferring ether to the user / recipient
  - sending ether to another address in ethereum involves a call to receiving entity
    - this external call can potentially fail :
      - the receiving contract could have a fallback function that simply throws an exception
      - run out of gas - lots of external calls within one function call
        - it only needs one of the transfers to fail in order to revert all transfers that already happened and stop the following transfers from executing.
              
- How
  - Push over pull :
    - let each user withdraws (pulls) a certain amount, (rather than being sent to him (push)).
    - this helps to isolate each external call (and shifts the risk of failure from the contract to the user),
  - consists of 3 participants :
    ```
    - entity responsible for initiating of the transfer or issuing the withdrawal notification 
      - (owner of contract or contract itself)
    - smart contract that keeps track of all the balances
    - receipients : each has to actively request for withdrawal
    ```
  - methods :
    - a mapping to keep track of users amount.
      - add entry to mapping if user is new
      - add amount if user already exists
    - user withdraws by issuing a transaction to withdrawal method that uses Check-effects-interaction pattern.
      - i.e. update user’s balance before transferring.

- *Note*
  - *consideration : tradeoff between security and convenience*
    - *requires user to send additional transaction  (i.e. requesting for withdrawal)*
      - *higher gas requirement*
      - *user experience*
    - *should only be used when there is strong incentive for all participants to withdraw their funds*
 
- example :
  - see [WithdrawalPattern.sol](https://github.com/dtan1/designpattern/blob/main/WithdrawalPattern.sol)

------

### 3. Access Restriction Pattern :
- What :
  - Restrict the access to contract functionality according to certain criteria

- When :
  - against unauthorized access
  - should only be callable under certain conditions by other contracts
  - provide restriction to certain functions

- How :
  - via modifiers (in solidity)
  - ownership check - see example below

- example :
  - [Ownable contract by Openzepellin](https://docs.openzeppelin.com/contracts/2.x/api/ownership#Ownable)

------


### 4. Emergency Action Pattern :
- Can be divided into 3 different actions, in order of severity : 
  ```
  a. delaying action - speed bump
  b. limiting action - rate limit
  c. emergency stop - circuit breaker
  ```

#### a. Speed Bump
- What : 
  - delay contract actions

- when & Why :
  - when malicious events occur - it gives the smart contract owner time to act accordingly
  - e.g. The DAO had a 27 days delay installed in which no functions could be executed, leaving the funds in the contract, increasing the likelihood of recovery.

- how :
  - needs a recovery function for it to be really useful e.g. some sort of withdrawal function etc
 
- example :
  ```
  struct RequestWithdrawal {
  ...
  }
  ```

#### b. Rate Limit
- What :
  - limiting action

- Why needed (problem) :
  - request a rush on a certain function

- How (solution) :
  - regualte how often a task can be executed within a certain period of time
  - or limit amount of fund an owner can withdraw - to prevent rapid drainage of funds
  - or limit number of issued tokens (in distruibution) over time.

- When to use ?
  - a depositor may only be allowed to withdraw a certain amount or percentage of total deposits over a certain time period
  - additional withdrawals in that time period may fail or require some sort of special approval

- example
  ```
  contract RateLimit {
  ...
  }
  ```
 
#### c. Circuit Breaker
- What :
  - pause or stop action
  - capable of stopping the execution of a function inside a smart contract.

- How :
  - can be manually triggered by trusted parties, e.g. contract admin
  - or automaticlly triggered via programmatic rules when a certain pre-defined conditions are met.
  
- When :
  - a bug is discovered

- Method :
  - 2 modifiers :
    - makes sure that all actions in the contract are suspended when a bug is discovered 
      - only the admin is able to toggle this boolean.
    - allow one to withdraw funds in case of a severe bug.

- example
  ```
  bool private stopped = false;
  ...
  ```






