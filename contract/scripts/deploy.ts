import { ethers } from "hardhat";
import { makeAbi } from "./abiGenerator";

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log(`Deploying contracts with the account: ${deployer.address}`);

  // Todo: deploy script를 구현하여 주세요.
  const ContractBank = await ethers.getContractFactory("Bank");
  const bank = await ContractBank.deploy();
  await bank.waitForDeployment();

  console.log(`Bank contract deployed at: ${bank.target}`);
  await makeAbi("Bank", bank.target);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
