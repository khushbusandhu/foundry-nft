//SPDX-License-Identifier:mit
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";

contract MooodNftTest is Test {
    DeployMoodNft public deployer;

    function setUp() public {
        deployer = new DeployMoodNft();
    }

    function testConvertSvgToUri() public view {
        string memory expectedUri =
            "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iNTAwIiBoZWlnaHQ9IjUwMCI+PHRleHQgeD0iMCIgeT0iMTUiIGZpbGw9ImJsYWNrIj5IaSEgWW91ciBicm93c2VyIGRlY29kZWQgdGhpczwvdGV4dD48L3N2Zz4=";
        // string memory svg = '<svg xmlns="http://www.w3.org/2000/svg" width="500" height="500"><text x="0" y="15" fill="red"> hi! you decoded this! </text></svg>';
        string memory svg = vm.readFile("./img/example.svg");
        // somehow, using vm.readFile() directly work, but reading it in string directly have an error.

        string memory actualUri = deployer.svgToImageURI(svg);
        console.log(actualUri);
        console.log(expectedUri);
        // strings (special type) are array of bytes
        // assert(expectedName == actualName); //we can't do this" ==" directly . because we directly compare arrays to arrays
        // so we convert the strings to -> bytes (bytes32) -> which we can then use keccak256() to output the hash. and then compare the hash
        assert(keccak256(abi.encodePacked(actualUri)) == keccak256(abi.encodePacked(expectedUri)));
    }
}
