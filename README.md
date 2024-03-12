# Proveably Random Raffle Contract

## About

This code is to create a proveably random smart contract lottery.

## What we want it to do?

1. Users can enter by paying for a ticket
   1. The ticket fees are going to go to the winner during the draw      
2. After X period of time, the lottery will automatically draw a winner
   1. And this will be done programmatically
3. Using Chainlink VRF and Chainlink Automation
   1. Chainlink VRF -> Randomness
   2. Chainlink Automation -> Time based trigger

## Tests!

1. Write some deply scripts
2. Write our test
   1. Work on local chain
   2. Forked Testnet
   3. Forked Mainet