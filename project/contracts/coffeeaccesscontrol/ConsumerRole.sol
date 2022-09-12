pragma solidity ^0.4.24;

import "./Roles.sol";

contract ConsumerRole {

  using Roles for Roles.Role;

  event ConsumerAdded(address indexed account);
  event ConsumerRemoved(address indexed account);

  // Define a struct 'consumers' by inheriting from 'Roles' library, struct Role
  Roles.Role private consumers;

  // In the constructor make the address that deploys this contract the 1st consumer
  constructor() public {
    _addConsumer(msg.sender);
  }


  // Checks to see if msg.sender has the appropriate consumer role
  modifier onlyConsumer() {
    require(isConsumer(msg.sender));
    _;
  }


  function isConsumer(address account) public view returns (bool) {
    return consumers.has(account);
  }

  function addConsumer(address account) public onlyConsumer {
    _addConsumer(account);
  }

  function renounceConsumer() public {
    _removeConsumer(msg.sender);
  }

  function _addConsumer(address account) internal {
    consumers.add(account);
    emit ConsumerAdded(account);
  }

  function _removeConsumer(address account) internal {
    consumers.remove(account);
    emit ConsumerRemoved(account);
  }
}