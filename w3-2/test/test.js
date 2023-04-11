const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");

describe("Test Vault", function () {
  let token, vault, owner, otherAccount;

  before(async function () {
    [owner, otherAccount] = await ethers.getSigners();
    console.log(
      `owner:${owner.toString()}, otherAccount: ${otherAccount.toString()}`
    );

    const KeaperV1 = await ethers.getContractFactory("KeaperV1");
    token = await upgrades.deployProxy(KeaperV1);
    await token.deployed();
    console.log("Token deployed:" + token.address);

    const Vault = await ethers.getContractFactory("Vault");
    vault = await Vault.deploy(token.address);
    await vault.deployed();
    console.log("Vault deployed:" + vault.address);
  });

  it("deposite before upgrade", async function () {
    await expect(
      vault.deposit(ethers.utils.parseEther("1.0"))
    ).to.be.revertedWith("");
  });

  it("deposite after upgrade", async function () {
    const KeaperV2 = await ethers.getContractFactory("KeaperV2");
    token = await upgrades.upgradeProxy(token.address, KeaperV2);
    await token.deployed();
    console.log("Token deployed:" + token.address);
    await expect(
      vault.deposit(ethers.utils.parseEther("1.0"))
    ).to.be.revertedWith("");
  });
});
