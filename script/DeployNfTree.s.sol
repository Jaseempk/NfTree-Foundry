//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Script} from  "forge-std/Script.sol";
import {NfTree} from "../src/NfTree.sol";


contract DeployNfTree is Script{
    function run()external returns(NfTree){

        vm.startBroadcast();
        NfTree nfTree=new NfTree();
        vm.stopBroadcast();
        return nfTree;

    }
}