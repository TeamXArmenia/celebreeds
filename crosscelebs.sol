pragma solidity ^0.4.20;
import "./celebs.sol";
contract crosscelebs{
    
    /* function getbalanceof(address bo) public returns(uint){
         return ct.balanceOf(bo);
     }
     */
     struct Pelson 
     {
         uint b;
     }
     Pelson[2] Persons;
     function main() returns( uint, uint){
         Persons[0].b=1;
         
         Pelson memory  person=Persons[0]; // @Artyom should be refference to set the value;
         person.b=2;
         return ( person.b,  Persons[0].b);
     }
     
     
     CelebrityToken ct = CelebrityToken(0x0DCd2F752394c41875e259e00bb44fd505297caF);
     function getownerof(uint256 _tokenId) public returns(bool){
          
         var test=ct.personIndexToOwner(_tokenId);
         return true;
     }
uint public a;
   function test(bool b) public returns(uint){
       if(b==true)
       {
           a=a+=2;
       }
       else
       {
           a+=3;
       }
         //breed(12,false,22,true,"asd","bch");
     }
       struct Person {
    string name;
    string surname; 
    uint64 genes; 
    uint64 birthTime;
   // uint64 cooldownEndBlock;//todo remove this //block.number // uint64((cooldowns[_kitten.cooldownIndex]/secondsPerBlock) + block.number); secondsPerBlock=15; cooldownindex=breedingcount
    uint32 fatherId;
    uint32 motherId;
    uint32 readyToBreedWithId;
    uint32 trainedcount;
    uint32 bittencount;
    bool readyToBreedWithGen;
    bool gender;
  }
  
    function breed(uint256 _mypersonid, bool _mypersongeneration, uint256 _withpersonid, bool  _withpersongeneration, string _boyname, string _girlname) external  payable { //@Artyom mother
    Person storage person; //@Artyom reference
       uint64 _generatedGen=73245;  //TODO actual gene generation be careful with person[_withpersonid/mypersonid]
       bool _gender=false; //TODO generate gender
       string  _surname=person.surname;
      // string _name=_boyname; //todo based on generated gender
       
   //    _birthPerson(_boyname, _surname, _generatedGen, uint32(_withpersonid), uint32(_mypersonid), _gender, true);
  }
     
     
    //function _birthPerson(string _name, string _surname,uint256 _genes, uint32 _fatherId,uint32 _fatherId2,bool asd, bool xuy) private {
    function _birthPerson(string _name, string _surname, uint64 _genes, uint32 _fatherId, uint32 _motherId, bool _gender, bool _generation) private {
 
    Person memory _person = Person({
        name: _name,
        surname: _surname,
        genes: uint64(_genes),
        birthTime: uint64(now),
       // cooldownEndBlock: _cooldownEndBlock, //block.number // uint64((cooldowns[_kitten.cooldownIndex]/secondsPerBlock) + block.number); secondsPerBlock=15; cooldownindex=breedingcount
        fatherId: uint32(_fatherId),
        motherId: uint32(_fatherId),
        readyToBreedWithId: 0,
        trainedcount: 0,
        bittencount: 0,
        readyToBreedWithGen: false,
        gender: false
    });


    
  }
  
}