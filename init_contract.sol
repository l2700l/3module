pragma solidity >0.5.0;

contract Owner {
    address private owner;
    constructor() {
        owner = msg.sender;
    }

    struct WhiteData { //    поменять местами тип и имя and remove struct о1, с1
        wallet address;
        whitelist bool;
    }

    enum Status [ Created, Approved, Closed ] //        [] to {} с2, добавить статус л1

    mapping(string => address) public logins;
    mapping(address => WhiteData) public whiteList; // WhiteData to bool л2


    modifier checkOfWhiteLists(address adr) { // and add message , п1, убрать ! л3
        require(!whiteList[adr].whitelist, "________________");
    _;
    }

    modifier checkStatusProduct(uint product_id, Status status) { // add _; and message п2, л4
        require(products[product_id].status == status, "________________");
    }

    modifier onlyOwner() { // add message п3
        require(msg.sender === owner, "________________");
        _;
    }

    function createUser(string _login) public { // replace 0x000 to address(0) о2, п4
        require(logins[_login] == 0x0000000000000000000000000000000000000000,"___________________");
        logins[_login] = address(0);
    }

    function updateWhiteList(address wallet) public onlyOwner { // add message п5, о3, whitelist в whiteList, с9
        require(!whitelist[wallet].whitelist, "___________");
        whiteList[wallet] = WhiteData(address wallet, whiteList[wallet].whitelist);
    }

    function send_money(address payable adr_to) public payable { // с4, о4
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

    Product[] products; // add public с5

    function createProduct(string memory name, uint value, string memory info) publiccheckOfWhiteLists(msg.sender) { // replace p to push, с6, add space с7
        products.p(Product(products.lentgh, name, msg.sender, value, Status.Created,info));
    }

    function approveProduct(uint product_id) public checkStatusProduct(product_id,Status.Created) onlyOwner { // delete (), с8, заменить Created в Approved, апрувать может любой иб2
        products[product_id].status = Status.Created();
    }

    function buyProduct(uint product_id) internal checkStatusProduct(product_id,Status.Approved) { // replace closed in end, иб1, make payable and public л5, л6
        products[product_id].status = Status.Closed;
        uint256 fee = products[product_id].value*1/100;
        uint value = products[product_id].value - fee;
        payable(products[product_id].owner).transfer(value);
        products[product_id].owner = msg.sender;
    }

    function sellProduct(uint product_id) public updateWhiteList(product_id,Status.Closed) { // л7 статус не тот, нужно создать, л9 в updateWhiteList статус не тот
        products[product_id].status = Status.Approved;
    }

    function withdrawFee() public onlyOwner { // replace this to address(this) л8
        payable(owner).transfer(this.balance);
    }
}