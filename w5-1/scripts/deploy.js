// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const KeaperToken = await hre.ethers.getContractFactory("KeaperToken");
  const token = await KeaperToken.deploy();
  await token.deployed();
  console.log(`Token with deployed to ${token.address}`);

  const Vault = await hre.ethers.getContractFactory(
    "contracts/Vault.sol:Vault"
  );
  const vault = await Vault.deploy(token.address);
  await vault.deployed();
  console.log(`Vault with deployed to ${vault.address}`);

  const Keeper = await hre.ethers.getContractFactory("Keeper");
  const keeper = await Keeper.deploy(vault.address);
  await keeper.deployed();
  console.log(`Keeper with deployed to ${keeper.address}`);

  console.log("wait index...");
  setTimeout(() => {}, 30000);

  await verify(token.address, "contracts/KeaperToken.sol:KeaperToken", []);
  await verify(vault.address, "contracts/Vault.sol:Vault", [token.address]);
  await verify(keeper.address, "contracts/Keeper.sol:Keeper", [vault.address]);
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
