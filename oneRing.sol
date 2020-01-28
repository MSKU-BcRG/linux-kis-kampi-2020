pragma solidity >=0.4.0 <0.7.0;
pragma experimental ABIEncoderV2;


contract oneRing {
    
    constructor(string memory ) public {
        
        
    }
    
    enum ElfType { Dark, Normal, Wood, High}
    
    struct  Elf {
        string Name;
        uint Age;
        ElfType Typ;
        bool  IsOneRingHas;
    }
    
    struct Ring {
        string Name;
        uint Wisdom;
        bool IsOneRing;
    }
    
    mapping(address => Elf) Elfies;
    mapping(address => Ring[]) Rings;
    
    function random() private view returns (uint256) {
       return uint256(int256(keccak256(abi.encode(block.timestamp, block.difficulty)))%251);
   }

    function Register(string memory name, uint age) public {
        Elfies[msg.sender] = Elf(name, age, ElfType(random()% 4), false);
    }
    
    function ForgeRing(string memory name) public {
        Elf memory current_elf = Elfies[msg.sender];
        if(current_elf.Typ == ElfType.Dark){
            current_elf.IsOneRingHas = true;
            createRing(name,(random()*current_elf.Age), true);
        }else{
            createRing(name,(random()*current_elf.Age), false);
        }
    }
    
    
    function createRing(string memory name, uint wisdom , bool isOneRing) private{
        Rings[msg.sender].push(Ring(name,wisdom, isOneRing));
    }
    
    function getRings() public view returns(Ring[] memory){
       return Rings[msg.sender];
    }
    
    function checkRingHas() public view returns(string memory){
        Elf memory current_elf = Elfies[msg.sender];
        if(current_elf.IsOneRingHas){
            return "I'm Sauron";
        }
        return "I'm a normal elf";
    }
    
}