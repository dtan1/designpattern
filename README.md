# Design Pattern

This section focuses on some of the key secuirty patterns / principles in Smart Contract Design.  
One of the main reasons is that your code must be able to respond to bugs and vulnerabilities gracefully.

## Key Security Patterns

Some of the Security Design Patterns in smart contracts :
1. Checks Effect Interation pattern
2. Pull Over Push pattern
3. Guard Check Pattern
4. Emergency Stop Pattern
   - rate limit
   - speed bump
   - circuit breaker

### 1. Checks Effect Interaction (CEI) pattern :
- secure / right ordering :
  ```
  - check first
  - effects to state variable
  - interaction last
  ```
  - in details :
    - first validating all arguments 
      - throw appropriate errors when arguments do no meet the expected output
    - once validated, then make changes to smart contract states
    - only interact with other smart contract or account in the last step
      - i.e. ensure current contract has finshied executing all its functionalities.

- optimistic method :
  - effects are written down as completed, before they actually took place
  - This is ok as the whole transaction can be reverted (via transfer() call), if effect fails. 

- when to use it ?
  - good for function that needs to make external calls (to other smart contract or account)

- what is it good for or why needed ?
  - avoid re-entrancy attack
    - function that is invoked repeatedly that should be executed once - DAO attack.

- example :
  - see [CEIPattern.sol](https://github.com/dtan1/designpattern/blob/main/CEIPattern.sol)




