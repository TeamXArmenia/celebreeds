  pragma solidity ^0.4.18;

contract teststackdeep {
    
    struct MyStruct {
    string x1;//name;
    string x2;//surname; 
    uint64 x3;//genes; 
    uint64 x4;//birthTime;
    uint32 x5;//fatherId;
    uint32 x6;//motherId;
    uint32 x7;//readyToBreedWithId;
    uint32 x8;//trainedcount;
    uint32 x9;//beatencount;
    bool x10;//readyToBreedWithGen;
    bool x11;//gender;
    bool x12;//fatherGeneration;
    bool x13;//motherGeneration;
  }
  
  function deepfunc(string _x1, string _x2, uint64 _x3, bool _x11, bool _z1, uint256 _x6, uint256 _x5) private returns(uint256) { // about this steps   
    MyStruct memory ms = MyStruct({
        x1: _x1,
        x2: _x2,
        x3: _x3,
        x4: uint64(now),
        x5: 0,
        x6: 0,
        x7: 0,
        x8: 0,
        x9: 0,
        x10: false,
        x11: _x11,
        x12: false,
        x13: false

        
    });
    uint256 newPersonId;
    return newPersonId;
  }
     function succeedingfunc(string x1, string x2,uint64 x3, bool x11) external  returns(uint256) {
     uint256 result= deepfunc(x1, x2 ,x3, x11, false,0,0);
     return result;
  }
  function failingfunc(uint256 y1, bool y2, uint256 y3, bool  y4, string y5, string y6) public payable { //@Artyom mother
     
    MyStruct MS; 
    uint64 g1=MS.x3;
    uint64 g2=MS.x3;
    uint newid=deepfunc(y6, y6, 0, false, true, y3,y1);

  }
  
}
  