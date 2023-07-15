//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from  "../lib/foundry-devops/src/DevOpsTools.sol";
import {NfTree} from "../src/NfTree.sol";

contract MintNfTree is Script{

    uint256 public treeId=1;
    string public constant TREE="ipfs://Qmbm7BiY8VYyCnwn8wiZGZRKi3DuoJXDsDfkZz7KqQ7b4z";


    function run()external{
        address mostRecentlyDeployed= DevOpsTools.get_most_recent_deployment(
            "NfTree",
        block.chainid
        );
        mintNftOnContract(mostRecentlyDeployed);    
    }
    function mintNftOnContract(address contractAddress) public{
        vm.startBroadcast();
        NfTree(contractAddress).plantNfTree();
        //need to simulate the passing of 15 days watering in here,but didn't got the time
        NfTree(contractAddress).waterNfTree(treeId);
        NfTree(contractAddress).mintNfTree(treeId,TREE);
        vm.stopBroadcast();
    }
}