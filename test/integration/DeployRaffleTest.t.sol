// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {DeployRaffle} from "../../script/DeployRaffle.s.sol";
import {Raffle} from "../../src/Raffle.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";
import {Test, console} from "forge-std/Test.sol";

contract DeployRaffleTest is Test {
    DeployRaffle public deployer;
    Raffle public raffle;
    HelperConfig public helperConfig;

    function setUp() external {
        deployer = new DeployRaffle();
        (raffle, helperConfig) = deployer.run();
    }

    function testDeployRaffleCreateAndFundASunscriptionOnlyIfItDoesntExistYet() public view {
        if (block.chainid == 11155111) {
            assert(
                deployer.getAddressOfCreateSubscription() == address(0)
                    && deployer.getAddressOfFundSubscription() == address(0)
            );
        } else {
            assert(
                deployer.getAddressOfCreateSubscription() != address(0)
                    && deployer.getAddressOfFundSubscription() != address(0)
            );
        }
    }
}
