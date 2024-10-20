//specify solidity version
pragma solidity 0.8.19;
//create a contract named balancetracker
contract balancetracker{
        //creates a relation between key-value pairs of adresses and their balances, named balances
        mapping(address => uint) public balances;
        //a function to insert adress:balance pairs to the mapping
        function adder(address useradd, uint256 userbal) public {
            //the balance userbal is assigned to adress useradd
            balances[useradd] = userbal;
        }
        function retriever(address usersearch) public view returns(uint256) {
            //searches the dictionary balances and returns balance associated with address usersearch.
            return balances[usersearch];}

}