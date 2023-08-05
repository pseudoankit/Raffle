// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Raffle {
    error Raffle__NotEnoughEthSent();

    uint256 private immutable i_entranceFee;
    uint256 private immutable i_interval;
    uint256 private s_lastTimeStamp;
    address payable[] private s_players;

    /** Events */
    event EnteredRaffle(address indexed player);

    constructor(uint256 _entrancefee, uint256 _interval) {
        i_entranceFee = _entrancefee;
        i_interval = _interval;
        s_lastTimeStamp = block.timestamp;
    }

    function enterRaffle() external payable {
        if(msg.value < i_entranceFee) {
            revert Raffle__NotEnoughEthSent();
        }
        s_players.push(payable(msg.sender));
        emit EnteredRaffle(msg.sender);
    }

    function pickWinner() external {
        if((block.timestamp - s_lastTimeStamp) < i_interval) {
            revert();
        }

    }

    /** Getters */

    function getEntranceFee() external view returns(uint256) {
        return i_entranceFee;
    }
}