// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18;

import "@openzeppelin/contracts/access/AccessControl.sol";

error noOwner();
error noTransferencia();

contract fondeo is AccessControl{
    bytes32 public constant ADMIN_ROL =keccak256("ADMIN_ROL");

    constructor() {
        _setupRole(ADMIN_ROL, msg.sender);
    }
    

    modifier soloAdmin() {
        if ( !( hasRole(ADMIN_ROL, msg.sender) ) ) {
            revert noOwner();
        }
                    _;
    }

    function nuevoAdmin(address _admin) public soloAdmin returns(bool){
        _setupRole(ADMIN_ROL,_admin);
    }

    address[] donanteslista;
    mapping (address => uint) donanteDinero;

    function deposito() public payable {
        donanteslista.push(msg.sender);
        //donanteDinero[msg.sender] = donanteDinero[msg.sender] + msg.value;
        donanteDinero[msg.sender] +=msg.value;
    }

    function verDineroDonado() public view returns (uint){
        return donanteDinero[msg.sender];
    }

    function retiroEfectivo() public soloAdmin{
        if (payable (msg.sender).send(address(this).balance)){

        for (uint256 donantesIndex = 0; donantesIndex < donanteslista.length; donantesIndex++){
            address donanteDireccion = donanteslista[donantesIndex];
            donanteDinero[donanteDireccion]=0;
        }
        donanteslista = new address[](0);
    }
    else{
        revert noTransferencia();
    }

}
}