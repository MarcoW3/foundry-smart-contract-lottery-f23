// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "../../lib/forge-std/src/Test.sol";
import {CreateSubscription, FundSubscription, AddConsumer} from "../../script/Interactions.s.sol";
import {Raffle} from "../../src/Raffle.sol";
import {DeployRaffle} from "../../script/DeployRaffle.s.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";
import {VRFCoordinatorV2Mock} from
    "../../lib/chainlink-brownie-contracts/contracts/src/v0.8/mocks/VRFCoordinatorV2Mock.sol";
import {Vm} from "../../lib/forge-std/src/Vm.sol";

contract InteractionsTest is Test {
    CreateSubscription createSubscription;

    function setUp() external {
        createSubscription = new CreateSubscription();
    }

    function testCreateSubscriptionUsingConfigReturnsCreateSubscriptionsOutput() public {

        vm.recordLogs();
        uint64 subId_a = createSubscription.createSubscriptionUsingConfig();
        Vm.Log[] memory entries = vm.getRecordedLogs();
        bytes32 subId = entries[2].topics[1];
        
        uint64 subId_b = uint64(uint256(subId));

        assert(subId_a == subId_b);
    }
}
