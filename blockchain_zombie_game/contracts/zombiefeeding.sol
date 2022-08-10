// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./zombiefactory.sol";

contract ZombieFeeding is ZombieFactory {

  function feedAndMultiply(uint _zombieId, uint _targetDna) public {

    // Убедимся, что зомби принадлежит нам.
    require(msg.sender == zombieToOwner[_zombieId]);

    /* Хранилище используют, чтобы сохранить переменные в блокчейн навсегда. Память используют для временного 
    хранения переменных, они стираются в промежутках, когда внешняя функция обращается к контракту. Это похоже  
    на жесткий диск компьютера и оперативную память. */

    Zombie storage myZombie = zombies[_zombieId];
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;

    _createZombie("NoName", newDna);
  }
}