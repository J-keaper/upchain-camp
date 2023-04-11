const { ethers, upgrades } = require("hardhat");

async function main() {
  const proxyAddress = "0x12f3Fa1295512292270474B3764BEaC2359E27b1";

  const KeaperV2 = await ethers.getContractFactory("KeaperV2");
  const keaperV2 = await upgrades.upgradeProxy(proxyAddress, KeaperV2);
  await keaperV2.deployed();

  console.log(`keaperV2 deployed:${keaperV2.address}`);

  console.log("wait index...");

  setTimeout(() => {
    verify(proxyAddress, "contracts/ERC20WithUpgrade.sol:KeaperV2", []);
  }, 30000);
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
