const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("myTestErc20", function() {
  it("Should initialize the erc20 token with a specified name/symbol", async function () {
    const myTestErc20 = await ethers.getContractFactory("myTestErc20");
    const testerc20 = await myTestErc20.deploy("DopeMoonToken", "DMT");
    await testerc20.deployed();
    expect(testerc20.name()).to.equal("DopeMoonToken");
    expect(testerc20.symbol()).to.equal("DMT");
  });
});
