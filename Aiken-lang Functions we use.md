1. Data Structure

-Records 
   ...

   record NFT {
    address owner;
    string metadata;
    uint price;
    bool isListed;
    uint royalties;
    uint auctionEndTime;
    uint highestBid;
    address highestBidder;
}

...


-=maps

...

map(uint => NFT) public nfts;
map(address => list<uint>) public userOwnedNFTs;

...
