import TopShot from "TopShot"
import NonFungibleToken from "NonFungibleToken"

transaction(recipient: Address, momentIDs: [UInt64]) {
    prepare(acct: AuthAccount) {
        let recipientAccount = getAccount(recipient)

        // Borrow the recipient's moment collection references
        let momentCollectionReceiverRef = recipientAccount.getCapability(/public/MomentCollection)!
            .borrow<&{TopShot.MomentCollectionPublic}>()
        let nftCollectionReceiverRef = recipientAccount.getCapability(/public/MomentCollection)!
            .borrow<&{NonFungibleToken.CollectionPublic}>()

        // Ensure at least one of the receiver references exists
        if momentCollectionReceiverRef == nil && nftCollectionReceiverRef == nil {
            panic("Recipient does not have a valid TopShot collection linked")
        }

        // Borrow the sender's collection reference
        let collectionRef = acct.borrow<&TopShot.Collection>(from: /storage/MomentCollection)
            ?? panic("Could not borrow reference to the sender's collection")

        for momentID in momentIDs {
            // Withdraw the NFT from the sender's collection
            let nft <- collectionRef.withdraw(withdrawID: momentID)

            // Deposit the NFT into the recipient's collection
            if momentCollectionReceiverRef != nil {
                momentCollectionReceiverRef!.deposit(token: <-nft)
            } else if nftCollectionReceiverRef != nil {
                nftCollectionReceiverRef!.deposit(token: <-nft)
            } else {
                panic("No collection receiver reference found")
            }
        }
    }
}
