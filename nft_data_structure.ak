contract NFTMarketplace {
    record NFT {
        address owner;
        string metadata;
        uint price;
        bool isListed;
    }

    map(uint => NFT) public nfts;

    function mintNFT(uint id, string metadata) public {
        nfts[id] = NFT(msg.sender, metadata, 0, false);
        emit NFTMinted(id, msg.sender);
    }

    function listNFT(uint id, uint price) public {
        require(nfts[id].owner == msg.sender, "Not the owner");
        nfts[id].isListed = true;
        nfts[id].price = price;
        emit NFTListed(id, price);
    }

    function buyNFT(uint id) public payable {
        require(nfts[id].isListed, "NFT not for sale");
        require(msg.value >= nfts[id].price, "Insufficient funds");
        
        nfts[id].owner.transfer(msg.value);
        nfts[id].owner = msg.sender;
        nfts[id].isListed = false;
        emit NFTSold(id, msg.sender);
    }
}
