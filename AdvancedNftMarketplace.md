contract AdvancedNFTMarketplace {
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

    map(uint => NFT) public nfts;
    map(address => list<uint>) public userOwnedNFTs;

    function mintNFT(uint id, string metadata, uint royalties) public {
        nfts[id] = NFT(msg.sender, metadata, 0, false, royalties, 0, 0, address(0));
        userOwnedNFTs[msg.sender].append(id);
        emit NFTMinted(id, msg.sender);
    }

    function startAuction(uint id, uint startingPrice, uint duration) public {
        require(nfts[id].owner == msg.sender, "Not the owner");
        nfts[id].auctionEndTime = block.timestamp + duration;
        nfts[id].highestBid = startingPrice;
        emit AuctionStarted(id, startingPrice, nfts[id].auctionEndTime);
    }

    function placeBid(uint id) public payable {
        require(block.timestamp < nfts[id].auctionEndTime, "Auction ended");
        require(msg.value > nfts[id].highestBid, "Bid too low");

        // Refund the previous highest bidder
        if (nfts[id].highestBidder != address(0)) {
            nfts[id].highestBidder.transfer(nfts[id].highestBid);
        }

        nfts[id].highestBid = msg.value;
        nfts[id].highestBidder = msg.sender;
        emit NewBidPlaced(id, msg.sender, msg.value);
    }

    function endAuction(uint id) public {
        require(block.timestamp >= nfts[id].auctionEndTime, "Auction not ended");
        require(nfts[id].highestBidder != address(0), "No bids placed");

        // Transfer ownership and funds
        nfts[id].owner.transfer(nfts[id].highestBid * (100 - nfts[id].royalties) / 100);
        nfts[id].owner = nfts[id].highestBidder;
        nfts[id].isListed = false;
        emit AuctionEnded(id, nfts[id].highestBidder);
    }
}
