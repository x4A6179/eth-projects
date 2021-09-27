const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("myTestErc20", function() {
  it("Should initialize the erc20 token with a specified name/symbol", async function () {
    const myTestErc20 = await ethers.getContractFactory("testErc20");
    const testerc20 = await myTestErc20.deploy("DopeMoonToken", "DMT");
    await testerc20.deployed();
    name = await testerc20.name();
    symbol = await testerc20.symbol();
    expect(name).to.equal("DopeMoonToken");
    expect(symbol).to.equal("DMT");
  });
});
