//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract LearningMaterial {
    struct Material {
        address creator;
        uint8 id;
        string title;
        string url;
        string description;
        uint8 total_votes;
    }

    mapping (uint256 => Material) public materials;
    event saveEvent(uint256 indexed _materialId);
    uint8 public numMaterial;

    constructor () {
        numMaterial = 0;
        addMaterial (
            "Cadena",
            "https://www.cadena.dev/",
            "Become a blockchain developer"
        );
    }

    function addMaterial(
        string memory title,
        string memory url,
        string memory description
        ) public {
        Material storage material = materials[numMaterial];
        material.creator = msg.sender;
        material.total_votes = 0;
        materials[numMaterial] = Material(
            material.creator,
            numMaterial,
            title,
            url,
            description,
            material.total_votes
        );
        numMaterial++;
        }

    function getMaterial(uint256 materialId)
        public view returns (Material memory)
        {
            return materials[materialId];
        }

    function getMaterials () public view returns (Material[] memory) {
        Material[] memory id = new Material [](numMaterial);
        for (uint256 i=0; i < numMaterial; i++) {
            Material storage material = materials[i];
            id[i] = material;
        }
        return id;
    }

    function voteMaterial(uint256 materialId) public {
        Material storage material = materials[materialId];
        material.total_votes++;
    }
}