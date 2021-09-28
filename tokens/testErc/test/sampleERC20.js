const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("myTestErc20", function() {
  it("Should initialize the erc20 token with a specified name/symbol", async function () {
    const myTestErc20 = await ethers.getContractFactory("testErc20");
    const testerc20 = await myTestErc20.deploy("DopeMoonToken", "DMT");
    await testerc20.deployed();

    const [owner] = await ethers.getSigners();
    name = await testerc20.name();
    symbol = await testerc20.symbol();
    //owner = await testerc20.owner();
    totalSupply = await testerc20.totalSupply();
    expect(name).to.equal("DopeMoonToken");
    expect(symbol).to.equal("DMT");
    expect(await testerc20.connect(owner).balanceOf(owner.address)).to.equal(totalSupply);
  });

  it("Should be able to transfer tokens from owner to another address", async function () {
    // deploying the contract
    const myTestErc20 = await ethers.getContractFactory("testErc20");
    const testErc20 = await myTestErc20.deploy("DopeMoonToken", "DMT");
    await testErc20.deployed();

    // gets a list of other accounts to which you can test from
    const [owner, addr1] = await ethers.getSigners();

    // transfering tokens from the owner to another address.
    initOwnerTokens = await testErc20.balanceOf(owner.address);
    amount = 5;
    await testErc20.transfer(addr1.address, amount);
    expect(await testErc20.balanceOf(addr1.address)).to.equal(amount);
    expect(await testErc20.balanceOf(owner.address)).to.equal(initOwnerTokens - amount);
  });

  it("Should be able to increase allowance another address", async function () {
    const myTestErc20 = await ethers.getContractFactory("testErc20");
    const testErc20 = await myTestErc20.deploy("DopeMoonToken", "DMT");
    await testErc20.deployed();

    const [owner, addr1, addr2] = await ethers.getSigners();

    initAllowance = await testErc20.allowance(owner.address, addr1.address);
    amount = 5;
    await testErc20.connect(owner).addAllowance(addr1.address, amount);
    newAllowance = await testErc20.allowance(owner.address, addr1.address);
    expect(newAllowance - initAllowance).to.equal(amount);
  });

  it("Should be able to transfer from one address to another", async function () {
    const myTestErc20 = await ethers.getContractFactory("testErc20");
    const testErc20 = await myTestErc20.deploy("DopeMoonToken", "DMT");
    await testErc20.deployed();

    const [owner, addr1, addr2] = await ethers.getSigners();

    initOwnerTokens = await testErc20.balanceOf(owner.address);
    initRemoteTokens = await testErc20.balanceOf(addr1.address);
    amount = 5;
    await testErc20.connect(owner).addAllowance(addr1.address, amount);

    await testErc20.connect(addr1).transferFrom(owner.address, addr1.address, amount);
    expect(await testErc20.balanceOf(addr1.address)).to.equal(initRemoteTokens + amount);
  });

  xit("Should revert transaction when amount > token held by address", async function () {

  });

  xit("Should prevent account from transfering more than allowed amount", async function() {

  });
});
