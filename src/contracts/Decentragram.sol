pragma solidity ^0.5.0;

contract Decentragram {
  string public name = "Decentragram";
  uint public imageCount = 0;

  // store post
  struct Image {
    uint id;
    string hash;
    string description;
    uint tipAmount;
    address payable author;
  }

  event ImageCreated (
    uint id,
    string hash,
    string description,
    uint tipAmount,
    address payable author
  );

  event ImageTipped (
    uint id,
    string hash,
    string description,
    uint tipAmount,
    address payable author
  );
  mapping (uint => Image) public images;

  // create post
  function uploadImage(string memory _imgHash,string memory _desc) public {
    // Checks description is not empty
    require(bytes(_desc).length > 0);

    // Checks imageHash is not empty
    require(bytes(_imgHash).length > 0);
    require(msg.sender != address(0x0));
  
    imageCount = imageCount + 1;
    images[imageCount] = Image(imageCount,_imgHash , _desc, 0, msg.sender);

    emit ImageCreated(imageCount,_imgHash , _desc, 0, msg.sender);
  }

  // tip images
  function tipImages(uint _id) public payable{
    require(_id>0 && _id<=imageCount);
    Image memory _image = images[_id];
    address payable _author = _image.author;
    _author.transfer(msg.value); 
    _image.tipAmount  = _image.tipAmount + msg.value;
    images[_id] = _image;
    emit ImageTipped(_id, _image.hash, _image.description, _image.tipAmount, _image.author);
  }
}