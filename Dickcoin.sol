pragma solidity ^0.4.0;

import "./ERC20.sol";

contract DickCoin is ERC20{
   // struct teststr{
     //   int a;
       // int b;
    //}
  //  function testfunc(teststr x){
//    }
    uint public  totalSupply=100000;
    string public constant symbol="8==o";
    string public constant name="Dick Coin";
    uint8 public constant decimals=0;
    mapping(address=>uint) public balancesOf;
    
    function DickCoin(){
        balancesOf[msg.sender]=totalSupply;
    }
    function totalSupply() constant returns (uint _totalSupply){
        return totalSupply;
    }

    function balanceOf(address _owner) constant returns (uint balance){
        return balancesOf[_owner];
    }
    function transfer(address _to, uint _value) returns (bool success){
        require(balancesOf[msg.sender]>=_value);
        balancesOf[msg.sender]-=_value;
        balancesOf[_to]+=_value;
        Transfer(msg.sender,_to,_value);
        return true;
    }
    function transfaretest(address _to, uint _value) returns (bool success){
         Transfer(msg.sender,_to,_value);
    }
     function transfaretest2() returns (bool success){
         Transfer2(msg.sender);
    }
     function transfaretest3(uint256 _value) returns (bool success){
         Transfer3(msg.sender,_value);
         return true;
    }
    function transfaretest4(address _to, uint _value) returns (bool success){
        Transfer4(msg.sender,_to,_value,balancesOf[msg.sender], balancesOf[_to]);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint _value) returns (bool success){
        return false;
    }
    function approve(address _spender, uint _value) returns (bool success){
        return false;
    }
    function allowance(address _owner, address _spender) constant returns (uint remaining){
        return 0;
    }
    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Transfer2(address indexed _from);
    event Transfer3(address indexed _from,uint _value);
    event Transfer4(address indexed _from, address indexed _to, uint _value, uint val1,uint val2);
    event Approval(address indexed _owner, address indexed _spender, uint _value);
    event Transfertest(address indexed _from, address indexed _to, uint _value);
}
contract transfarer
{
    function senddicksto(address sendto, uint amount){
		DickCoin m = DickCoin(0x81915E958F8F686d755BBDaFe4a0054Fd1a87358);
		m.transfaretest(sendto, amount);
	}

}
contract ThatCallsSomeContract1 {
    function callTheOtherContract(uint256 amount) public {
        address _contractAddress=0x26536340A0e62059dcCf0a61044edc511edD2c33;
        _contractAddress.call(bytes4(keccak256("transfaretest3(uint256)")),amount);
      //  _contractAddress.delegatecall(bytes4(keccak256("transfaretest3(uint256)")),amount);
       
    }
}

contract ThatCallsSomeContract2 {
    function callTheOtherContract(uint256 amount) public {
        address _contractAddress=0x26536340A0e62059dcCf0a61044edc511edD2c33;
        _contractAddress.call(bytes4(keccak256("transfaretest2()")));
     
       
    }
}

contract ThatCallsSomeContract3 {
    function callTheOtherContract(uint256 amount) public {
        address _contractAddress=0x26536340A0e62059dcCf0a61044edc511edD2c33;
      //  _contractAddress.call(bytes4(keccak256("transfaretest3(uint256)")),amount);
        _contractAddress.delegatecall(bytes4(keccak256("transfaretest3(uint256)")),amount);
       
    }
}

contract ThatCallsSomeContract4 {
    function callTheOtherContract(uint256 amount) public {
        address sendto=0xE5c49927Afd5057f1784e482765960E2fD74fDF5;
        address _contractAddress=0x26536340A0e62059dcCf0a61044edc511edD2c33;
      //  _contractAddress.call(bytes4(keccak256("transfaretest(uint256)")),amount);
        _contractAddress.delegatecall(bytes4(keccak256("transfaretest(address,uint256)")),sendto,amount);
       
    }
}

contract ThatCallsSomeContract5 {
    function callTheOtherContract(uint256 amount) public {
        address sendto=0xE5c49927Afd5057f1784e482765960E2fD74fDF5;
        address _contractAddress=0xf7458fa59d61A353EEbF6643794159b2DA0c540F;
        _contractAddress.delegatecall(bytes4(keccak256("transfaretest4(address,uint256)")),sendto,amount);
       
    }
}
contract ThatCallsSomeContract6 {
    function callTheOtherContract(uint256 amount) public {
        address sendto=0xE5c49927Afd5057f1784e482765960E2fD74fDF5;
        address _contractAddress=0xf7458fa59d61A353EEbF6643794159b2DA0c540F;
        _contractAddress.call(bytes4(keccak256("transfaretest4(address,uint256)")),sendto,amount);
       
    }
}
contract ThatCallsSomeContract7 {
    function callTheOtherContract(uint256 amount) public {
        
        	DickCoin m = DickCoin(0xf7458fa59d61A353EEbF6643794159b2DA0c540F);
	
        address sendto=0xE5c49927Afd5057f1784e482765960E2fD74fDF5;
       	m.transfaretest4(sendto, amount);
       
    }
}