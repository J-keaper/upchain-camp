const { expect } = require("chai");

describe("Counter", function () {
  let counter, owner, otherAccount;

  before(async function () {
    [owner, otherAccount] = await ethers.getSigners();
    console.log(
      `owner:${owner.toString()}, otherAccount: ${otherAccount.toString()}`
    );

    const Counter = await ethers.getContractFactory("Counter");
    counter = await Counter.deploy(2);
    await counter.deployed();
    console.log("counter deployed:" + counter.address);
  });

  it("init equal 2", async function () {
    expect(await counter.value()).to.equal(2);
  });

  it("add 2 equal 4", async function () {
    await counter.add(2);
    expect(await counter.value()).to.equal(4);
  });

  it("owner call success", async function () {
    expect(await counter.connect(owner).add(2)).to.be.ok;
  });

  it("other account call fail", async function () {
    await expect(counter.connect(otherAccount).add(2)).to.be.revertedWith(
      "only owner"
    );
  });
});
