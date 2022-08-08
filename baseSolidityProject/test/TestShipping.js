const ShippingStatus= artifacts.require("./Shipping.sol");

const truffleAssert = require('truffle-assertions');

contract('Shipping', () => {

  it("should return the status Pending", async ()=> {
    // Instance of our deployed contract
    const instance = await ShippingStatus.deployed();
    // Checking the initial status in our contract
    const status = await instance.Status();
    // Checking if the status is initially Pending as set in the constructor
    assert.equal(status, "Pending");
  });
it("should return the status Shipped", async ()=> {
// Instance of our deployed contract
    const instance = await ShippingStatus.deployed();

    // Calling the Shipped() function
    await instance.Shipped();

    // Checking the initial status in our contract
    const status = await instance.Status();

    // Checking if the status is Shipped
    assert.equal(status, "Shipped");
  });

    it("should return the status Delivered", async ()=> {

    // Instance of our deployed contract
    const instance = await ShippingStatus.deployed();

    // Calling the Shipped() function
    await instance.Delivered();

    // Checking the initial status in our contract
    const status = await instance.Status();

    // Checking if the status is Delivered
    assert.equal(status, "Delivered");
  });
});