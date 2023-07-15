//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployNfTree} from  "../script/DeployNfTree.s.sol";
import {NfTree} from "../src/NfTree.sol";

contract NfTreeTest is Test{

DeployNfTree public deployer;
NfTree public nfTree;
string public constant TREE="ipfs://Qmbm7BiY8VYyCnwn8wiZGZRKi3DuoJXDsDfkZz7KqQ7b4z";



 function setUp()public{
    deployer=new DeployNfTree();
    nfTree=deployer.run();
 }
 function testNameIsCorrect() public view{
    string memory expectedName="NfTree";
    string memory actualName=nfTree.name();

    assert(
        keccak256(abi.encodePacked(expectedName))==
        keccak256(abi.encodePacked(actualName))
    );
 }
 /**
  * 
 function testIfNftMinted() public {

    vm.prank(address(1));
    nfTree.mintTree(0,TREE);
    assert(nfTree.balanceOf(address(0))==1);
    assert(keccak256(abi.encodePacked(TREE))==keccak256(abi.encodePacked(nfTree.getTreeDetails(1).imageURI)));
 }
  */
   
}