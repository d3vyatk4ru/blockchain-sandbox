pragma solidity  ^0.8.0;

contract Shipping {

    // Pending - товар отпрален
    // Shipped - товар в пути
    // Delivered - товар доставлен
    enum ShippingStatus { Pending, Shipped, Delivered}

    ShippingStatus private status;

    // init event
    event LogNewAlert(string description);

    constructor() public {
        status = ShippingStatus.Pending;
    }


    function Shipped() public {

        status = ShippingStatus.Shipped;
        // call event
        emit LogNewAlert("Your package has been shipped");
    }

    function Delivered() public {

        status = ShippingStatus.Delivered;
        // call event
        emit LogNewAlert("Your package has arrived");
    }

    // internal - видимость только в этом и наследуемом контрактах
    function getStatus(ShippingStatus _status) internal pure returns (string memory) {
        
        if (ShippingStatus.Pending == _status) {
            return "Pending";
        }

        if (ShippingStatus.Shipped == _status) {
            return "Shipped";
        }

        if (ShippingStatus.Delivered == _status) {
            return "Delivered";
        } else {
            return "";
        }
    }

    function Status() public view returns (string memory) {

        ShippingStatus _status = status;
        return getStatus(_status);
    }
}