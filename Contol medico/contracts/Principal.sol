// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./area.sol";

contract Principal {
    address public owner1;
    address public owner2;
     address private i_owner;
    address private i_ownerSecundario;
    mapping(address => bool) public registeredHR;
    mapping(address => address) public areaContracts;

    constructor(address _owner1, address _owner2) {
        owner1 = _owner1;
        owner2 = _owner2;
    }

    function setOwners(address owner, address ownerSecundario) public {
        i_owner = owner;
        i_ownerSecundario = ownerSecundario;
    }

    modifier onlyOwners() {
        require(msg.sender == owner1 || msg.sender == owner2, "Solo los propietarios pueden llamar a esta funcion");
        _;
    }

    modifier soloOwner {
        require(msg.sender == i_owner || msg.sender == i_ownerSecundario, "No eres owner del contrato");
        _;
    }


    function registerHR(address _hrAddress) public {
        registeredHR[_hrAddress] = true;
    }

    function createArea(string memory _areaName, address _areaContract) public {
        areaContracts[_areaContract] = _areaContract;
        Area area = Area(_areaContract);
        area.setAreaName(_areaName);
    }
}