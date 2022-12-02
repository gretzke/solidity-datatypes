// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.17;

contract DataTypes {
    uint256 public num;
    int256 private amount;
    bool internal boo;
    address public addr = 0xb794F5eA0ba39494cE839613fffBA74279579268;
    bytes1 private byt = 0xb5;
    string public str = "Hello";

    uint[] public arr;
    uint[5] public fixedSizeArr;

    enum Status {
        Accepted,
        Rejected,
        Canceled
    }
    Status public status;

    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todos;

    mapping(address => uint) public map;

    function setNum(uint256 newNum) public {
        num = newNum;
    }

    function setAmount(int256 newAmount) external {
        amount = newAmount;
    }

    function setExternalBoo(bool newBoo) external {
        setInternalBoo(newBoo);
    }

    function setInternalBoo(bool newBoo) internal {
        boo = newBoo;
    }

    function getBoo() public view returns (bool) {
        return boo;
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

    function setByt(bytes1 newByt) private {
        byt = newByt;
    }

    function setExternalByt(bytes1 newByt) external {
        setByt(newByt);
    }

    function push(uint i) public {
        arr.push(i);
    }

    function getArrSingle(uint i) public view returns (uint) {
        return arr[i];
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
}
