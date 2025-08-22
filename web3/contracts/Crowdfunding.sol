pragma solidity ^0.8.9;

contract Crowdfunding {
     struct Campaign{
        address owner;
        string tittle;
        string discription;
        uint256 target;
        uint256 deadline;
        uint256 amountCollected;
        string image;
        address [] donators;
        uint256 [] donations;


     }
     mapping (uint => Campaign) public Campaigns;
     uint public numberOfCampaigns = 0;

function createCampaign(
    address _owner,
    string memory _title,
    string memory _description,
    uint256 _target,
    uint256 _deadline,
    string memory _image
    ) public return (uint256) {
        Campaign storage campaign = campaigns[numberOfCampaigns]

        // is everything is ok 
        require(campaign.deadline < block.timestamp, "The deadline should be a date in the future");
        campaign.owner = _owner;
        campaign.tittle = _title;
        campaign.discription = _description;
        campaign.target = _target;
        campaign.deadline = deadline;
        campaign.amountCollected = 0;
        campaign.image = _image;

        numberOfCampaigns++;
        return numberOfCampaigns-1;

   
}


     function donatetoCampaign(uint256 _id )public payable{
        uint256 amount = msg.value;
        Campaign storage campaign = campaigns[_id];
        campaign.donators.push(msg.sender);
        campaign.donations.push(amount);
        (bool sent, ) = payable(campaign.owner).call{value: amount} ("");
        if (sent) {
            campaign.amountCollected = campaign.amountCollected + amount;
        }

}

     function getDonators(){}

}