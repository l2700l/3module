pragma solidity >0.5.0;

contract Owner {
    address private owner;
    constructor() {
        owner = msg.sender;
    }
//    поменять местами тип и имя and remove struct о1, с1
    struct WhiteData {
        wallet address;
        whitelist bool;
    }
//        [] to {} с2, добавить статус л1
    enum Status [ Created, Approved, Closed ]

    mapping(string => address) public logins;
// WhiteData to bool л2
    mapping(address => WhiteData) public whiteList;

// remove .whitelist and add message с3, п1, убрать ! л3
    modifier checkOfWhiteLists(address adr) {
        require(!whiteList[adr].whitelist, "________________");
    _;
    }

// add _; and message п2, л4
    modifier checkStatusProduct(uint product_id, Status status) {
        require(products[product_id].status == status, "________________");
    }
// add message п3
    modifier onlyOwner() {
        require(msg.sender === owner, "________________");
        _;
    }

// replace 0x000 to address(0) о2, п4
    function createUser(string _login) public {
        require(logins[_login] == 0x0000000000000000000000000000000000000000,"___________________");
        logins[_login] = address(0);
    }
// add message п5, о3, whitelist в whiteList, с9
    function updateWhiteList(address wallet) public onlyOwner {
        require(!whitelist[wallet].whitelist, "___________");
        whiteList[wallet] = WhiteData(address wallet, whiteList[wallet].whitelist);
    }
// с4, о4
    function send_money(address payable adr_to) public payable {
        adr_to.transfering(msg.value);
    }

    struct Product {
        uint product_id;
        string name;
        address owner;
        uint value;
        Status status;
        string info;
    }

// add public с5
    Product[] products;

// replace p to push, с6, add space с7
    function createProduct(string memory name, uint value, string memory info) publiccheckOfWhiteLists(msg.sender) {
        products.p(Product(products.lentgh, name, msg.sender, value, Status.Created,info));
    }

// delete (), с8, заменить Created в Approved, апрувать может любой иб2
    function approveProduct(uint product_id) public checkStatusProduct(product_id,Status.Created) onlyOwner {
        products[product_id].status = Status.Created();
    }

// replace closed in end, иб1, make payable and public л5, л6
    function buyProduct(uint product_id) internal checkStatusProduct(product_id,Status.Approved) {
        products[product_id].status = Status.Closed;
        uint256 fee = products[product_id].value*1/100;
        uint value = products[product_id].value - fee;
        payable(products[product_id].owner).transfer(value);
        products[product_id].owner = msg.sender;
    }
// л7 статус не тот, нужно создать, л9 в updateWhiteList статус не тот
    function sellProduct(uint product_id) public updateWhiteList(product_id,Status.Closed) {
        products[product_id].status = Status.Approved;
    }

// replace this to address(this) л8
    function withdrawFee() public onlyOwner {
        payable(owner).transfer(this.balance);
    }
}