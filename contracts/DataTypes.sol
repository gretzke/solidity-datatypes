// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";

contract A {
    uint256 public x;

    constructor(uint256 _x) {
        x = _x;
    }
}

enum Status {
    Accepted,
    Rejected,
    Canceled
}

struct Todo {
    string text;
    bool completed;
    mapping(uint256 => uint256) map;
}

type CustomNumber is uint256;
error CustomErrorWithParameter(address test);

contract DataTypes is Ownable {
    uint256 public num;
    int256 private amount;
    bool internal _bool;
    address public addr = 0xb794F5eA0ba39494cE839613fffBA74279579268;
    bytes1 private _byte = 0xb5;
    string public str = "Hello";
    bytes32 public role = keccak256("admin");
    uint[] public arr;
    uint[5] public fixedSizeArr;
    uint256 public counter = 0;
    mapping(uint256 => A) public contracts;
    CustomNumber public customNum;
    Status public status;
    Todo[] public todos;
    Todo public myTodo;

    constructor() {
        contracts[counter++] = new A(15);
        customNum = CustomNumber.wrap(999);
        myTodo.text = "Hello World";
        myTodo.completed = true;
        myTodo.map[0] = 1;
    }

    function deployContract(uint256 x) public {
        contracts[counter++] = new A(x);
    }

    mapping(address => uint) public map;

    function setNum(uint256 newNum) public {
        num = newNum;
    }

    // function overloading
    function setNum(uint256 newNum, uint256 x) public {
        num = newNum + x;
    }

    function setAmount(int256 newAmount) external {
        amount = newAmount;
    }

    function setExternalBool(bool newBoo) external {
        setInternalBool(newBoo);
    }

    function setInternalBool(bool newBoo) internal {
        _bool = newBoo;
    }

    function getBool() public view returns (bool) {
        return _bool;
    }

    function getAddr() public view returns (address) {
        return (addr);
    }

    function getPure() external pure returns (uint16) {
        return (15 + 17);
    }

    function getStatus() public view returns (Status) {
        return status;
    }

    function setStatus(Status _status) public {
        status = _status;
    }

    function setByte(bytes1 newByt) private {
        _byte = newByt;
    }

    function setExternalByte(bytes1 newByt) external {
        setByte(newByt);
    }

    function push(uint i) public {
        arr.push(i);
    }

    function getArrSingle(uint i) public view returns (uint) {
        return arr[i];
    }

    function getArrDynamic() public view returns (uint[] memory) {
        return arr;
    }

    function getArr() public view returns (uint[5] memory) {
        return fixedSizeArr;
    }

    function concatStr(string memory newStr) external view returns (string memory) {
        return string.concat(str, newStr);
    }

    function createStruct(string calldata _text) public {
        todos.push(Todo(_text, false));
    }

    function getStruct(uint _index) public view returns (string memory text, bool completed) {
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }

    function getMap(address _addr) public view returns (uint) {
        return map[_addr];
    }

    function setMap(address _addr, uint _i) public {
        map[_addr] = _i;
    }

    function allTodos() public view returns (Todo[] memory) {
        return todos;
    }

    function payMe(uint256 _x) public payable {
        num = _x;
        require(msg.value > 0, "You need to send some Ether");
        (bool success, ) = msg.sender.call{value: msg.value}("");
        assert(success);
    }

    function fail() public {
        revert CustomErrorWithParameter(msg.sender);
    }
}
