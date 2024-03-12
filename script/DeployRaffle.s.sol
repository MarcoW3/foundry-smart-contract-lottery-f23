// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {Raffle} from "../src/Raffle.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {CreateSubscription, FundSubscription, AddConsumer} from "./Interactions.s.sol";

contract DeployRaffle is Script {
    address address_CreateSubscription;
    address address_FundSubscription;
    //address address_AddConsumer;

    function run() external returns (Raffle, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig();
        (
            uint256 entranceFee,
            uint256 interval,
            address vrfCoordinator,
            bytes32 gasLane,
            uint64 subscriptionId,
            uint32 callbackGasLimit,
            address link,
            uint256 deployerKey
        ) = helperConfig.activeNetworkConfig();

        if (subscriptionId == 0) {
            CreateSubscription createSubscription = new CreateSubscription();
            subscriptionId = createSubscription.createSubscription(vrfCoordinator, deployerKey);
            address_CreateSubscription = address(createSubscription);

            FundSubscription fundSubscription = new FundSubscription();
            fundSubscription.fundSubscription(vrfCoordinator, subscriptionId, link, deployerKey);
            address_FundSubscription = address(fundSubscription);
        }

        vm.startBroadcast(deployerKey);
        Raffle raffle = new Raffle(entranceFee, interval, vrfCoordinator, gasLane, subscriptionId, callbackGasLimit);
        vm.stopBroadcast();

        AddConsumer addConsumer = new AddConsumer();
        addConsumer.addConsumer(address(raffle), vrfCoordinator, subscriptionId, deployerKey);
        //address_AddConsumer = address(addConsumer);
        return (raffle, helperConfig);
    }

    /////////////////////////
    //   Getter Function   //
    /////////////////////////

    function getAddressOfCreateSubscription() external view returns (address) {
        return address_CreateSubscription;
    }

    function getAddressOfFundSubscription() external view returns (address) {
        return address_FundSubscription;
    }

    /*function getAddressOfAddConsumer() external view returns (address) {
        return address_AddConsumer;
    }*/
}
