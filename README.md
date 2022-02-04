# Design Pattern

This branch focuses on some of the key secuirty patterns in Smart Contract Design.

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
- right ordering :
  ```
  - check first
  - effects to state variable
  - interaction last
  ```
  - in details :
    - first validating all arguments 
      - throw appropriate errors when arguments do no meet the expected output
    - once validated, then make changes to smart contract states
    - only interact with other smart contract in the last step
      - i.e. ensure current contract has finshied executing all its functionalities.

- when to use it ?
  - good for function that needs to make external calls (to other smart contract)

- optimistic method :
  - effects are written down as completed, before they actually took place
  - This is ok as the whole transaction can be reverted (via transfer() call), if effect fails. 

- What is it good for or needed ?
  - avoid re-entrancy attack
    - function that is invoked repeatedly that should be executed once - DAO attack.

- example :
  - see [CEIPattern.sol](https://github.com/dtan1/designpattern/blob/main/CEIPattern.sol)




