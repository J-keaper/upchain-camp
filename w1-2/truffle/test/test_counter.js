var Counter = artifacts.require("Counter");

contract("Counter", function (accounts) {
  it("test_add", async function () {
    var instance = await Counter.deployed();
    return instance
      .add(2)
      .then(function () {
        return instance.value();
      })
      .then(function (value) {
        assert.equal(value, 4);
      });
  });
});
