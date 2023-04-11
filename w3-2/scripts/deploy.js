const { ethers, upgrades } = require("hardhat");

async function main() {
  const KeaperToken = await ethers.getContractFactory("KeaperV1");
  const keaperToken = await upgrades.deployProxy(KeaperToken);
  await keaperToken.deployed();

  console.log(`keaperV1 deployed:${keaperToken.address}`);

  console.log("wait index...");
  setTimeout(() => {}, 60000);
  verify(keaperToken.address, "contracts/ERC20.sol:KeaperV1", []);

  // const KeaperV2 = await ethers.getContractFactory("KeaperV2");
  // const keaperV2 = await upgrades.upgradeProxy(keaperToken.address, KeaperV2);
  // await keaperV2.deployed();

  // console.log(`keaperV2 deployed:${keaperV2.address}`);
}

async function verify(contractAddress, contract, args) {
  if (hre.network.name === "mumbai") {
    console.log(`verify ${contract}, address:${contractAddress}`);
    await hre.run("verify:verify", {
      address: contractAddress,
      contract: contract,
      constructorArguments: args,
    });
  }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
