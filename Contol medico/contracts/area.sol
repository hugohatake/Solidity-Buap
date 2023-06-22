// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Area {
    struct Employee {
        string firstName;
        string lastName;
        uint8 day;
        uint8 month;
        uint16 year;
        address ethAddress;
        string rfc;
        bool isEmployed;
        uint256 registeredDate;
        uint256 terminationDate;
    }

    mapping(address => Employee) public employees;

    string public areaName;
    address private i_owner;
    address private i_ownerSecundario;

    constructor(address owner, address ownerSecundario) {
        i_owner = owner;
        i_ownerSecundario = ownerSecundario;
    }

    modifier soloOwner {
        require(esOwner(msg.sender), "No eres owner del contrato");
        _;
    }

    function esOwner(address _address) private view returns (bool) {
        return _address == i_owner || _address == i_ownerSecundario;
    }

    function setAreaName(string memory _areaName) public soloOwner {
        areaName = _areaName;
    }

    function registerEmployee(
        string memory _firstName,
        string memory _lastName,
        uint8 _day,
        uint8 _month,
        uint16 _year,
        address _ethAddress,
        string memory _rfc
    ) public soloOwner {
        require(employees[_ethAddress].ethAddress == address(0), "El empleado ya esta registrado");
        employees[_ethAddress] = Employee({
            firstName: _firstName,
            lastName: _lastName,
            day: _day,
            month: _month,
            year: _year,
            ethAddress: _ethAddress,
            rfc: _rfc,
            isEmployed: true,
            registeredDate: block.timestamp,
            terminationDate: 0
        });
    }

    function editEmployee(
        address _ethAddress,
        string memory _firstName,
        string memory _lastName,
        uint8 _day,
        uint8 _month,
        uint16 _year,
        string memory _rfc
    ) public soloOwner {
        require(employees[_ethAddress].ethAddress != address(0), "No se encontro al empleado");
        Employee storage employee = employees[_ethAddress];
        employee.firstName = _firstName;
        employee.lastName = _lastName;
        employee.day = _day;
        employee.month = _month;
        employee.year = _year;
        employee.rfc = _rfc;
    }

    function terminateEmployee(address _ethAddress) public soloOwner {
        require(employees[_ethAddress].ethAddress != address(0), "No se encontro al empleado");
        Employee storage employee = employees[_ethAddress];
        require(employee.isEmployed, "El empleado ya fue dado de baja");
        employee.isEmployed = false;
        employee.terminationDate = block.timestamp;
    }
}