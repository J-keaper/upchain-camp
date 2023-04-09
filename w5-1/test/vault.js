const { expect } = require("chai");

describe("Test Vault", function () {
  let token, vault, owner, otherAccount;

  before(async function () {
    [owner, otherAccount] = await ethers.getSigners();
    console.log(
      `owner:${owner.toString()}, otherAccount: ${otherAccount.toString()}`
    );

    const KeaperToken = await ethers.getContractFactory("KeaperToken");
    token = await KeaperToken.deploy();
    await token.deployed();
    console.log("Token deployed:" + token.address);

    const Vault = await ethers.getContractFactory("Vault");
    vault = await Vault.deploy(token.address);
    await vault.deployed();
    console.log("Vault deployed:" + vault.address);
  });

  it("deposite without approve", async function () {
    await expect(vault.deposite(100)).to.be.revertedWith(
      "ERC20: insufficient allowance"
    );
  });

  it("deposite after approve", async function () {
    await token.approve(vault.address, ethers.utils.parseEther("2.0"));
    expect(await vault.deposite(ethers.utils.parseEther("2.0"))).to.be.ok;
    expect(await vault.balanceOf()).to.equal(ethers.utils.parseEther("2.0"));
    expect(await vault.totalAmount()).to.equal(ethers.utils.parseEther("2.0"));
  });

  it("withdraw after deposite", async function () {
    expect(await vault.withdraw(ethers.utils.parseEther("1.0"))).to.be.ok;
    expect(await vault.balanceOf()).to.equal(ethers.utils.parseEther("1.0"));
    expect(await vault.totalAmount()).to.equal(ethers.utils.parseEther("1.0"));
  });

  it("collect", async function () {
    await token.approve(vault.address, ethers.utils.parseEther("4.0"));
    expect(await vault.deposite(ethers.utils.parseEther("4.0"))).to.be.ok;
    expect(await vault.totalAmount()).to.equal(ethers.utils.parseEther("5.0"));
    expect(await vault.collect()).to.ok;
    expect(await vault.totalAmount()).to.equal(ethers.utils.parseEther("0"));
  });
});
