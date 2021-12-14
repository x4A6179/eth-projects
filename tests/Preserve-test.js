const { expect } = require("chai");
const { ethers } = require("ethers");


before(async function() {
    const contractFactory = await ethers.getContractFactory("Preservation");
    [owner, ...accts] = await ethers.getSigners();
    const preservation = await contractFactory.deploy();
    const attackFactory = await ethers.getContractFactory("Attacker");
    const attacker = await attackFactory.deploy();
    })
describe("Preservation-Attack", function () {
    it("Should deploy the contract", async function() {
        expect(await preservation.owner().to.equal(owner.address));
    });
})