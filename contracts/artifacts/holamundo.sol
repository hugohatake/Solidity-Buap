// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract holaMundo{
    uint public numeroFavorito = 7;
    bool public tienenumeroFavorito = true;
    string public nombre = "Hugo";

    function cambiarnombre(string memory _nombre ) public returns (bool){
        nombre = _nombre;
        return true;
    }
}