// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.18;

contract listaAnimales{

    struct animal{
        string nombre;
        uint16 edad;
        string especie;
        address direccion;
    }

    animal [] public animales;

    mapping (string => uint) public indiceanimales;

    function agregarAnimal(string memory _nombre, uint16 _edad, string memory _especie, address _direccion) public {
        animal memory nuevoAnimal = animal(_nombre, _edad, _especie, _direccion);
        animales.push(nuevoAnimal);
        indiceanimales[_nombre] = animales.length-1;
    }

    function mostrarAnimal (string memory _nombre) public view returns (string memory,uint16, string memory, address ){
        uint indice = indiceanimales[_nombre];
        return(animales[indice].nombre, animales[indice].edad, animales[indice].especie, animales[indice].direccion);
    }

    function modificarAnimal(string memory _nombre, uint16 _nuevaEdad, address _nuevaDireccion) public {
        uint indice = indiceanimales[_nombre];
        require(indice < animales.length, "Animal no encontrado");

        animales[indice].edad = _nuevaEdad;
        animales[indice].direccion = _nuevaDireccion;
        }

}