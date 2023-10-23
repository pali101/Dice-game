// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract DiceGame {
    event DiceRolled(
        address indexed player,
        uint256 betAmount,
        uint8 rolledNumber,
        uint8 chosenNumber,
        bool won
    );

    function rollDice(uint8 chosenNumber) external payable {
        require(
            chosenNumber >= 1 && chosenNumber <= 6,
            "Invalid number. Choose a number between 1-6"
        );
        require(msg.value > 0, "Must bet something");
        uint8 rolledNumber = _generateRandomNumber();
        bool win = (chosenNumber == rolledNumber);

        if (win) {
            uint256 prize = msg.value * 6;
            payable(msg.sender).transfer(prize);
        }
        emit DiceRolled(msg.sender, msg.value, rolledNumber, chosenNumber, win);
    }

    function _generateRandomNumber() internal view returns (uint8) {}
}
