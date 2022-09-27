// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ZombieFactory {
    
    // event - специальная функция, вызов которой можно отследить во внешней среде, написанной на JS, например
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    // internal - можно вызвать в дочернем классе
    function _createZombie(string  _name, uint _dna) internal {

        // возвращает номер вставленного элемента + 1
        uint id = zombies.push(Zombie(_name, _dna)) - 1;

        // msg.sender - тот, кто вызвал функцию
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;

        NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public {

        require(ownerZombieCount[msg.sender] == 0);

        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}