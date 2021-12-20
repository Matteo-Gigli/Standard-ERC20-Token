//SPDX-License-Identifier: UNLICENSED

pragma solidity >0.5.0 <0.9.0;
import "./Erc20Interface.sol";

contract newToken is IERC20{

    string public name;
    string public symbol;
    uint256 public totSupply;
    uint8 public decimals;
    mapping(address=>uint256)public balances;
    mapping(address=>mapping(address=>uint256)) private allowed;

    constructor(string memory _name, string memory _symbol, uint256 _totalSupply, uint8 _decimals){
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        balances[msg.sender] += _totalSupply;
        totSupply = _totalSupply;
    }

    function totalSupply()public view override returns(uint256){
        return totSupply;
    }

    function balanceOf(address _owner)public view override returns(uint256){
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value)public override returns(bool success){
        require(balances[msg.sender] > _value, "No Money in Your Wallet");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint _amount)public override returns(bool success){
        require(balances[msg.sender] > _amount, "Can't approve this amount");
        allowed[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }

    function allowance(address _owner, address _spender)public override view returns(uint256){
        return allowed[_owner][_spender];
    }

    function transferFrom(address _from, address _to, uint256 _amount)public override returns(bool success){
        require(allowed[_from][msg.sender] >= _amount, "You don't have this allowance");
        balances[_from] -= _amount;
        balances[_to] += _amount;
        allowed[_from][msg.sender] -= _amount;
        emit Transfer(_from, _to, _amount);
        return true;
    }
}