
//SPDX-License-Identifier:MIT
pragma solidity ^0.8.30;

contract snackVault{

//State variables
    uint256 public vaultBalance = 0;
    address public  workerA = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address public workerB = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    address public workerC = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
    address public workerD = 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB;
    string public weeklySnackReq;


    //calculate the average Snack cost
    function avgSnackCost(uint256 _totalSnackCost,uint256 _totalWorkers) public pure returns(uint256){
    require(_totalWorkers > 0,"total workers must be greater than 0");
        return   _totalSnackCost/_totalWorkers;
      
    }
        //Get the balance of the snack vault
    function getVaultBalance() public view returns(uint256){
        return vaultBalance;
    }

    //update non-monetary state variable
    function updateWeeklySnackReq(string memory _weeklySnackReq ) public {
         weeklySnackReq = _weeklySnackReq;
    }

      //Use to make deposit/payment
    function contribute() public payable{
        vaultBalance += msg.value;
    }

    //withdraw with transfer
    function withdrawWithTransfer() public{
        uint256 payment = 0.01 ether;
        require(vaultBalance >= payment,"Insufficient vault balance");
        vaultBalance -= payment;
        payable(workerA).transfer(payment);

    }

    //withdraw with send
    function withdrawWithSend() public{
        uint256 payment = 0.01 ether;
        vaultBalance -= payment;
        bool success = payable(workerB).send(payment);
        require(success,"ETH transfer using 'send' failed");

    }

    //withdraw with call
    function withdrawWithCall() public{
        uint256 payment = 0.01 ether;
        require(vaultBalance >= payment,"Insufficient vault balance");
        vaultBalance -= payment;
        (bool success,) = payable(workerC).call{value:payment}("");
        require(success,"ETH transfer using 'send' failed");
    }

    //Allows the contract to receive ETH
    receive() external payable {
        vaultBalance += msg.value;
    }
}

//Contract Address = 0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8