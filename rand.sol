pragma solidity ^0.4.18;

contract Random {
  uint64 _seed=0;uint64 _seed1 = 1;uint64 _seed2 = 2;uint64 _seed3 = 3;uint64 _seed4 = 4;

function test() returns(uint) {
    int a=5;
    int b=8;
    return uint(a-b);
}
  // return a pseudo random number between lower and upper bounds
  // given the number of previous blocks it should hash.
  function random(uint64 upper) public returns (uint64 randomNumber1,uint64 randomNumber2,uint64 randomNumber3,uint64 randomNumber4) {
    _seed1 = uint64(keccak256(block.blockhash(block.number), _seed, now,1,2));
    _seed2 = uint64(keccak256(block.blockhash(block.number), _seed, now,2,1));
    _seed3 = uint64(keccak256(block.blockhash(block.number), _seed, now,3));
    _seed4 = uint64(keccak256(block.blockhash(block.number), _seed, now,4));
    return (_seed1 % upper,_seed2 % upper,_seed3 % upper,_seed4 % upper);
  }
   function _generateGene(uint64 _genes1,uint64 _genes2,uint256 _mypersonid,uint256 _withpersonid) returns(uint64,bool) {
       uint64 _gene;
       uint64 _gene1;
       uint64 _gene2;
       uint256 _finalGene=0;
       bool gender=false;
       for(uint i=0;i<10;i++) {
           _gene1 =_genes1%10;
           _gene2=_genes2%10;
           _genes1=_genes1/10;
           _genes2=_genes2/10;
           if(_gene1>=_gene2) {
               _gene=uint64(keccak256(block.blockhash(block.number), i, now,_mypersonid,_withpersonid))%(_gene1-_gene2+1)+_gene2+1;
           }
           else {
               _gene=uint64(keccak256(block.blockhash(block.number), i, now,_mypersonid,_withpersonid))%(_gene2-_gene1+1)+_gene1+1;
           }
           if(_gene>9)
           _gene=9;
           
           _finalGene+=(uint(10)**i)*_gene;
       }
      
      if(uint64(keccak256(block.blockhash(block.number), i, now,_mypersonid,_withpersonid))%2>0)
      gender=true;
      
      return(uint64(_finalGene),gender);
  } 
}