// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

contract Contract {
  address private owner;

  constructor() {
    owner = msg.sender;
  }

  enum Status {
    Created,
    ToSale,
    Approved,
    Closed
  }

  mapping(string => address) public logins;
  mapping(address => bool) public whiteList;

  modifier checkOfWhiteLists(address adr) {
    require(whiteList[adr], "this address not in whitelist");
    _;
  }

  modifier checkStatusProduct(uint product_id, Status status) {
    require(
      products[product_id].status == status,
      "produce status invalid"
    );
    _;
  }

  modifier onlyOwner() {
    require(msg.sender == owner, "you not owner");
    _;
  }

  function createUser(string memory _login) public {
    require(logins[_login] == address(0), "this login exist");
    logins[_login] = msg.sender;
  }

  function updateWhiteList(address wallet) public onlyOwner {
    require(!whiteList[wallet], "address already in whitelist");
    whiteList[wallet] = true;
  }

  struct Product {
    uint product_id;
    string name;
    address owner;
    uint value;
    Status status;
    string info;
  }

  Product[] public products;

  function createProduct(
    string memory name,
    uint value,
    string memory info
  ) public checkOfWhiteLists(msg.sender) {
    products.push(
      Product(
        products.length,
        name,
        msg.sender,
        value,
        Status.Created,
        info
      )
    );
  }

  function approveProduct(
    uint product_id
  ) public checkStatusProduct(product_id, Status.Created) onlyOwner {
    products[product_id].status = Status.Approved;
  }

  function buyProduct(
    uint product_id
  ) public payable checkStatusProduct(product_id, Status.Approved) {
    uint256 fee = (products[product_id].value * 1) / 100;
    uint value = products[product_id].value - fee;

    payable(products[product_id].owner).transfer(value);

    products[product_id].owner = msg.sender;
    products[product_id].status = Status.Closed;
  }

  function sellProduct(
    uint product_id
  ) public checkStatusProduct(product_id, Status.Created) {
    products[product_id].status = Status.ToSale;
  }

  function withdrawFee() public onlyOwner {
    payable(owner).transfer(address(this).balance);
  }
}
