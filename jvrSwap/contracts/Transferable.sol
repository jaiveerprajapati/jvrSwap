pragma solidity ^0.5.7;

/**
 * @title ERC20 interface without bool returns
 * @dev see https://eips.ethereum.org/EIPS/eip-20
 */
interface Transferable {
    function transfer(address to, uint256 value) external;
    function transferFrom(address from, address to, uint256 value) external;
    function balanceOf(address who) external view returns (uint256);
}
