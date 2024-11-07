### NFT Data Structure

    -for holding NFT artibutes:
        -owner
        -metadata
        price
        isListed

    - Minting Function
    Mint for New NFTs
        -permission check from the caller
        -Genetrate unqie id token for NFT
        -We can using mapping or list function for store NFTs

      Listing NFTs
           -Set isListed artibuter to true
           update price artibute

      -Buying NFTs


            -Check function if the NFT listed for sale
            -verify function for accurate funds from buyer
            -update isListed false


      -Even Emission

            -NFT minted
            -NFT Listed
            -NFT Sold

      - Security Considerations

          -proper access control only owner can be listed NFTs
          -Most highly security implementation

          
