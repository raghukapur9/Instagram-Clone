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

  mapping (uint => Image) public images;

  // create post
  function uploadImage(string memory _imgHash,string memory _desc) public {
    imageCount = imageCount + 1;
    images[imageCount] = Image(imageCount,_imgHash , _desc, 0, msg.sender);

    emit ImageCreated(imageCount,_imgHash , _desc, 0, msg.sender);
  }

  // tip posts
}