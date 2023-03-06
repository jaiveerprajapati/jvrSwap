pragma solidity ^0.5.7;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "./Transferable.sol";

contract JVRswap is Ownable {
    uint256 internal constant MAX_CHANGE_TIMES = 5;

    Transferable public transToken;
    mapping(address => string[]) internal _registers;

    event Connect(address indexed eth, string indexed jvr);
    event Reconnect(
        address indexed eth,
        string indexed oldjvr,
        string indexed newjvr
    );

    constructor(Transferable _transToken) public {
        transToken = _transToken;
    }

    function burn() external {
        uint256 balance = transToken.balanceOf(address(this));
        transToken.transfer(address(0), balance);
    }

    function connect(string calldata _jvr) external {
        address eth = msg.sender;

        if (_registers[eth].length == 0) {
            emit Connect(eth, _jvr);
            _registers[eth].push(_jvr);
        } else {
            require(
                _registers[eth].length < MAX_CHANGE_TIMES,
                "Address change limit exceeded"
            );
            emit Reconnect(eth, getCurrentJVRAddress(eth), _jvr);
            _registers[eth].push(_jvr);
        }
    }

    function burn(Transferable _token, uint256 _value) external {
        _token.transfer(address(0), _value);
    }

    function burnFrom(Transferable _token, address _from, uint256 _value)
        external
    {
        _token.transferFrom(_from, address(0), _value);
    }

    function isConnected(address _eth) public view returns (bool) {
        return _registers[_eth].length != 0;
    }

    function getCurrentJVRAddress(address _eth)
        public
        view
        returns (string memory)
    {
        if (!isConnected(_eth)) {
            string memory empty;
            return empty;
        }

        uint256 count = _registers[_eth].length;
        return _registers[_eth][count - 1];
    }

    function getJVRAddressByIndex(address _eth, uint256 _index)
        public
        view
        returns (string memory)
    {
        return _registers[_eth][_index];
    }
}
