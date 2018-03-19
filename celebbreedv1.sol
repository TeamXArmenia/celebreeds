pragma solidity ^0.4.18;
import "./celebs.sol";

contract CelebrityBreederToken is ERC721 {
  
   /// @dev The Birth event is fired whenever a new person comes into existence.
  event Birth(uint256 tokenId, string name, address owner);

  /// @dev The TokenSold event is fired whenever a token is sold.
  event TokenSold(uint256 tokenId, uint256 oldPrice, uint256 newPrice, address prevOwner, address winner, string name);

  /// @dev Transfer event as defined in current draft of ERC721. 
  ///  ownership is assigned, including births.
  event Transfer(address from, address to, uint256 tokenId);
  
  CelebrityToken private CelGen0=CelebrityToken(0xf284F0C86562931888C39794c77B563e5a0B51DA); //@Artyom set to correct token address
  
  string public constant NAME = "CryptoCelebrityBreederCards"; 
  string public constant SYMBOL = "CeleBreedCard"; // solhint-disable-line

  uint256 public breedingFee = 0.01 ether;
  uint256 private constant CreationLimitGen0 = 5000;
  uint256 private constant MaxValue =  1000000 ether;
  
  mapping (uint256 => address) public personIndexToOwnerGen1;
  mapping (address => uint256) private ownershipTokenCountGen1;
  mapping (uint256 => address) public personIndexToApprovedGen1;
  mapping (uint256 => uint256) private personIndexToPriceGen1;
  mapping (uint256 => address) public ExternalAllowdContractGen0;
  mapping (uint256 => address) public ExternalAllowdContractGen1; 
  address public CeoAddress; //todo set these
  address public DevAddress; //todo set these
  

   struct Person {
    string name;
    string surname; 
    uint64 genes; 
    uint64 birthTime;
   // uint64 cooldownEndBlock;//block.number // uint64((cooldowns[_kitten.cooldownIndex]/secondsPerBlock) + block.number); secondsPerBlock=15; cooldownindex=breedingcount
    uint32 fatherId;
    uint32 motherId;
    uint32 readyToBreedWithId;
    uint32 trainedcount;
    uint32 bittencount;
    bool readyToBreedWithGen;
    bool gender;
    bool fatherGeneration;
    bool motherGeneration;
  }
  
  Person[] private PersonsGen0;
  Person[] private PersonsGen1;
  
    modifier onlyCEO() {
    require(msg.sender == CeoAddress);
    _;
  }

  /// @dev Access modifier for COO-only functionality
  modifier onlyDEV() {
    require(msg.sender == DevAddress);
    _;
  }

  /// Access modifier for contract owner only functionality
 /* modifier onlyTopLevel() {
    require(
      msg.sender == CeoAddress ||
      msg.sender == DevAddress
    );
    _;
  }
  */
  function CelebrityBreederToken() public { //todo remove this from constructor and set to correct addresses.
      CeoAddress= msg.sender;
      DevAddress= msg.sender;
  }
    function setBreedingFee(uint256 newfee) external onlyCEO{
      breedingFee=newfee;
  }
  function allowexternalContract(address _to, uint256 _tokenId,bool _tokengeneration) public { //@Artyom only gen1
    // Caller must own token.
    require(_owns(msg.sender, _tokenId, _tokengeneration));
    
    if(_tokengeneration) {
        if(_addressNotNull(_to)) {
            ExternalAllowdContractGen1[_tokenId]=_to;
        }
        else {
             delete ExternalAllowdContractGen1[_tokenId];
        }
    }
    else {
       if(_addressNotNull(_to)) {
            ExternalAllowdContractGen0[_tokenId]=_to;
        }
        else {
             delete ExternalAllowdContractGen0[_tokenId];
        }
    }

  }
  //@Artyom Required for ERC-721 compliance.
  function approve(address _to, uint256 _tokenId) public { //@Artyom only gen1
    // Caller must own token.
    require(_owns(msg.sender, _tokenId, true));

    personIndexToApprovedGen1[_tokenId] = _to;

    Approval(msg.sender, _to, _tokenId);
  }
  // @Artyom Required for ERC-721 compliance.
  //@Artyom only gen1
   function balanceOf(address _owner) public view returns (uint256 balance) {
    return ownershipTokenCountGen1[_owner];
  }
  
    function getPerson(bool generation,uint256 _tokenId) public view returns ( string name, string surname, uint64 genes,uint64 birthTime, uint32 fatherId, uint32 motherId,uint32 readyToBreedWithId, uint32 trainedcount,uint32 bittencount,bool readyToBreedWithGen, bool gender) {
    Person storage person;
    if(generation==false) {
        person = PersonsGen0[_tokenId];
    }
    else {
        person = PersonsGen1[_tokenId];
    }
         
    name = person.name;
    surname=person.surname;
    genes=person.genes;
    birthTime=person.birthTime;
    fatherId=person.fatherId;
    motherId=person.motherId;
    readyToBreedWithId=person.readyToBreedWithId;
    trainedcount=person.trainedcount;
    bittencount=person.bittencount;
    readyToBreedWithGen=person.readyToBreedWithGen;
    gender=person.gender;
  }
  
  // @Artyom Required for ERC-721 compliance.
   function implementsERC721() public pure returns (bool) { 
    return true;
  }

  // @Artyom Required for ERC-721 compliance.
  function name() public pure returns (string) {
    return NAME;
  }

// @Artyom Required for ERC-721 compliance.
  function ownerOf(uint256 _tokenId) public view returns (address owner)
  {
    owner = personIndexToOwnerGen1[_tokenId];
    require(owner != address(0));
  }
  
  //@Artyom only gen1
   function purchase(uint256 _tokenId) public payable {
    address oldOwner = personIndexToOwnerGen1[_tokenId];
    address newOwner = msg.sender;

    uint256 sellingPrice = personIndexToPriceGen1[_tokenId];
    personIndexToPriceGen1[_tokenId]=MaxValue;

    // Making sure token owner is not sending to self
    require(oldOwner != newOwner);

    // Safety check to prevent against an unexpected 0x0 default.
    require(_addressNotNull(newOwner));

    // Making sure sent amount is greater than or equal to the sellingPrice
    require(msg.value >= sellingPrice);

   // uint256 payment = uint256(SafeMath.div(SafeMath.mul(sellingPrice, 94), 100));
    uint256 purchaseExcess = SafeMath.sub(msg.value, sellingPrice);

    _transfer(oldOwner, newOwner, _tokenId);

    // Pay previous tokenOwner if owner is not contract
    if (oldOwner != address(this)) {
    //  oldOwner.transfer(payment); //(1-0.06) //old code for holding some percents
    oldOwner.transfer(sellingPrice);
    }

    TokenSold(_tokenId, sellingPrice, personIndexToPriceGen1[_tokenId], oldOwner, newOwner, PersonsGen1[_tokenId].name);

    msg.sender.transfer(purchaseExcess);
  }
  
   //@Artyom only gen1
   function priceOf(uint256 _tokenId) public view returns (uint256 price) {
    return personIndexToPriceGen1[_tokenId];
  }

 
  function setCEO(address _newCEO) external onlyCEO {
    require(_newCEO != address(0));

    CeoAddress = _newCEO;
  }

 //@Artyom only gen1
 function setprice(uint256 _tokenId, uint256 _price) public {
    require(_owns(msg.sender, _tokenId, true));
    if(_price<=0 || _price>=MaxValue) {
        personIndexToPriceGen1[_tokenId]=MaxValue;
    }
    else {
        personIndexToPriceGen1[_tokenId]=_price;
    }
    
 }
 
  function setDEV(address _newDEV) external onlyDEV {
    require(_newDEV != address(0));

    DevAddress = _newDEV;
  }
  
    // @Artyom Required for ERC-721 compliance.
  function symbol() public pure returns (string) {
    return SYMBOL;
  }


  // @Artyom Required for ERC-721 compliance.
   //@Artyom only gen1
  function takeOwnership(uint256 _tokenId) public {
    address newOwner = msg.sender;
    address oldOwner = personIndexToOwnerGen1[_tokenId];

    // Safety check to prevent against an unexpected 0x0 default.
    require(_addressNotNull(newOwner));

    // Making sure transfer is approved
    require(_approvedGen1(newOwner, _tokenId));

    _transfer(oldOwner, newOwner, _tokenId);
  }
  
  //@Artyom only gen1
  function tokensOfOwner(address _owner) public view returns(uint256[] ownerTokens) {
    uint256 tokenCount = balanceOf(_owner);
    if (tokenCount == 0) {
        // Return an empty array
      return new uint256[](0);
    } 
    else {
      uint256[] memory result = new uint256[](tokenCount);
      uint256 totalPersons = totalSupply();
      uint256 resultIndex = 0;

      uint256 personId;
      for (personId = 0; personId <= totalPersons; personId++) {
        if (personIndexToOwnerGen1[personId] == _owner) {
          result[resultIndex] = personId;
          resultIndex++;
        }
      }
      return result;
    }
  }
  
   // @Artyom Required for ERC-721 compliance.
   //@Artyom only gen1
   function totalSupply() public view returns (uint256 total) {
    return PersonsGen1.length;
  }

  // @Artyom Required for ERC-721 compliance.
   //@Artyom only gen1
  function transfer( address _to, uint256 _tokenId) public {
    require(_owns(msg.sender, _tokenId, true));
    require(_addressNotNull(_to));

    _transfer(msg.sender, _to, _tokenId);
  }
  
   // @Artyom Required for ERC-721 compliance.
   //@Artyom only gen1
    function transferFrom(address _from, address _to, uint256 _tokenId) public {
    require(_owns(_from, _tokenId, true));
    require(_approvedGen1(_to, _tokenId));
    require(_addressNotNull(_to));

    _transfer(_from, _to, _tokenId);
  }
  
   function _addressNotNull(address _to) private pure returns (bool) {
    return _to != address(0);
  }

  /// For checking approval of transfer for address _to
  function _approvedGen1(address _to, uint256 _tokenId) private view returns (bool) {
    return personIndexToApprovedGen1[_tokenId] == _to;
  }
  //@Artyom only gen0
   function createPersonGen0(string _name, string _surname,uint64 _genes, bool _gender) external onlyCEO {
    _birthPerson(_name, _surname ,_genes, 0, 0, _gender, false);
  }
  
  function breed(uint256 _mypersonid, bool _mypersongeneration, uint256 _withpersonid, bool  _withpersongeneration, string _boyname, string _girlname) public payable { //@Artyom mother
       require(_owns(msg.sender, _mypersonid, _mypersongeneration));
       require(readyToBread(_mypersonid, _mypersongeneration, _withpersonid,  _withpersongeneration)); 
       require(breedingFee<=msg.value);
    
    Person storage person; //@Artyom reference
    if(_mypersongeneration==false) { //todo put this code snippet inside function everywhere
        person = PersonsGen0[_withpersonid];
        delete ExternalAllowdContractGen0[_mypersonid];
    }
    else {
        person = PersonsGen1[_withpersonid];
        delete ExternalAllowdContractGen1[_mypersonid];
    }
    
       uint64 _generatedGen=73245;  //TODO actual gene generation be careful with person[_withpersonid/mypersonid]
       bool _gender=false; //TODO generate gender
       string storage _surname=person.surname;
      // string _name=_boyname; //todo based on generated gender
       _girlname=_boyname; //decide which name to pass
       uint newid=_birthPerson(_girlname, _surname, _generatedGen, uint32(_withpersonid), uint32(_mypersonid), _gender, true);
        if(_mypersongeneration) {
            PersonsGen1[newid].fatherGeneration=_withpersongeneration; // @ Artyom, did here because stack too deep for function
            PersonsGen1[newid].motherGeneration=_mypersongeneration;
        }
       _payout();
  }
  function prepareToBreed(uint256 _mypersonid, bool _mypersongeneration, uint256 _withpersonid, bool _withpersongeneration) external { //@Artyom father
      require(_owns(msg.sender, _mypersonid, _mypersongeneration)); 
      
       Person storage person; //@Artyom reference
    if(_mypersongeneration==false) {
        person = PersonsGen0[_mypersonid];
    }
    else {
        person = PersonsGen1[_mypersonid];
    }
      if(_withpersonid==0) {
        delete person.readyToBreedWithId;
        delete person.readyToBreedWithGen;
      }
      else {
       person.readyToBreedWithId=uint32(_withpersonid); 
       person.readyToBreedWithGen=_withpersongeneration;
      }
      
  }
  function readyToBread(uint256 _mypersonid, bool _mypersongeneration, uint256 _withpersonid, bool _withpersongeneration) public view returns(bool) {

    Person storage withperson; //@Artyom reference
    if(_withpersongeneration==false) {
        withperson = PersonsGen0[_withpersonid];
    }
    else {
        withperson = PersonsGen1[_withpersonid];
    }
   
   if(withperson.readyToBreedWithGen==_mypersongeneration) {
       if(withperson.readyToBreedWithId==_mypersonid) {
       return true;
   }
   }
  
    
    return false;
    
  }
  function _birthPerson(string _name, string _surname, uint64 _genes, uint32 _fatherId, uint32 _motherId, bool _gender, bool _generation) private returns(uint256) { // about this steps   
    Person memory _person = Person({
        name: _name,
        surname: _surname,
        genes: _genes,
        birthTime: uint64(now),
       // cooldownEndBlock: _cooldownEndBlock, //block.number // uint64((cooldowns[_kitten.cooldownIndex]/secondsPerBlock) + block.number); secondsPerBlock=15; cooldownindex=breedingcount
        fatherId: _fatherId,
        motherId: _motherId,
        readyToBreedWithId: 0,
        trainedcount: 0,
        bittencount: 0,
        readyToBreedWithGen: false,
        gender: _gender,
        fatherGeneration: false,
        motherGeneration: false
        
    });
    
    uint256 newPersonId;
    if(_generation==false) {
         newPersonId = PersonsGen0.push(_person) - 1;
    }
    else {
         newPersonId = PersonsGen1.push(_person) - 1;
         personIndexToPriceGen1[newPersonId] = MaxValue; //@Artyom indicating not for sale
          // per ERC721 draft-This will assign ownership, and also emit the Transfer event as
        _transfer(address(0), msg.sender, newPersonId);
        

    }

    Birth(newPersonId, _name, msg.sender);
    return newPersonId;
  }
  
  function _owns(address claimant, uint256 _tokenId,bool _tokengeneration) private view returns (bool) {
   if(_tokengeneration) {
        return ((claimant == personIndexToOwnerGen1[_tokenId]) || (claimant==ExternalAllowdContractGen1[_tokenId]));
   }
   else {
       return ((claimant == CelGen0.personIndexToOwner(_tokenId)) || (claimant==ExternalAllowdContractGen0[_tokenId]));
   }
  }
  
  //TODO make sure to call this properly everywhere
  function _payout() private {
    CeoAddress.transfer((this.balance/3)*2); //TODO discuss the amounts and make sure nothing is left on the account.
    DevAddress.transfer(this.balance/3);
  }
  
   // @Artyom Required for ERC-721 compliance.
   //@Artyom only gen1
   function _transfer(address _from, address _to, uint256 _tokenId) private {
    // Since the number of persons is capped to 2^32 we can't overflow this
    ownershipTokenCountGen1[_to]++;
    //transfer ownership
    personIndexToOwnerGen1[_tokenId] = _to;

    // When creating new persons _from is 0x0, but we can't account that address.
    if (_from != address(0)) {
      ownershipTokenCountGen1[_from]--;
      // clear any previously approved ownership exchange
      delete personIndexToApprovedGen1[_tokenId];
      delete ExternalAllowdContractGen1[_tokenId];
    }

    // Emit the transfer event.
    Transfer(_from, _to, _tokenId);
  }
  
    function train(uint256 _personid, bool _persongeneration, uint8 _gene) external payable {
        
    }
    function checktrainingprice(uint256 _personid, bool _persongeneration, uint8 _geneordertotrain) view {
         Person storage person;
    if(_persongeneration==false) {
        person = PersonsGen0[_personid];
    }
    else {
        person = PersonsGen1[_personid];
    }
    person.trainedcount
    
    }

  //TODO beating and couching with their getprices based on if its yours or elses price goes up twice.
  
}

