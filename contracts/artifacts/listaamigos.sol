// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.18;

contract listaAmigos{

    struct amigo{
        string nombre;
        string apellido;
        uint8 edad;
        uint32 numero;
        address direccion;
    }
    amigo [] public amigos;

    mapping (string => uint) public indiceamigos;

  
    function agregarAmigo(string memory _nombre, string memory _apellido, uint8 _edad, uint32 _numero, address _direccion) public {
       amigo memory nuevoAmigo = amigo(_nombre, _apellido, _edad, _numero, _direccion);
       amigos.push(nuevoAmigo);
       indiceamigos[_nombre] = amigos.length-1;
    }

    function mostrarAmigo (string memory _nombre) public view returns(string memory, string memory, uint16, uint32, address){
        uint indice = indiceamigos[_nombre];
        return(amigos[indice].nombre, amigos[indice].apellido, amigos[indice].edad, amigos[indice].numero, amigos[indice].direccion);
    } 
    
}