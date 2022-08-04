// SPDX-License-Identifier: UNLICENSED

pragma solidity >0.8.0;

contract MarketPlace {

    // продавец
    address public seller;
    
    // покупатель. 
    address public buyer;

    // баланс по адресу
    mapping (address => uint) public balances;

    event ListItem(address seller, uint price);

    event PurchasedItem(address seller, address buyer, uint price);

    // состояние для товара купили / еще можно купить
    enum StateType {
        ItemAvailable,
        ItemPurchased
    }

    StateType public State;

    constructor() public {
        seller = msg.sender;
        State = StateType.ItemAvailable;
    }

    function buy(address seller, address buyer, uint price) public payable {

        require(price <= balances[buyer], "Insufficient balance");

        State = StateType.ItemPurchased;
        balances[buyer] -= price;
        balances[seller] += price;

        emit PurchasedItem(seller, buyer, price);
    }
}