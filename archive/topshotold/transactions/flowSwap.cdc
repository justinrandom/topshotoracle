import TopShot from "TopShot"
import FlowToken from "FlowToken"
import FungibleToken from "FungibleToken"
import FlowSwapV1 from "FlowSwapV1"

transaction(momentID: UInt64) {
    prepare(acct: AuthAccount) {
        // Borrow the sender's TopShot collection reference
        let collectionRef = acct.borrow<&TopShot.Collection>(from: /storage/MomentCollection)
            ?? panic("Could not borrow reference to the sender's collection")

        // Withdraw the NFT from the sender's collection
        let nft <- collectionRef.withdraw(withdrawID: momentID) as! @TopShot.NFT

        // Get the FlowSwap contract account
        let flowSwapAccount = getAccount(0xf8d6e0586b0a20c7) // Replace with actual FlowSwap contract address

        // Borrow the FlowSwap Swap resource
        let flowSwapRef = flowSwapAccount.getCapability(/public/flowSwap)
            .borrow<&FlowSwapV1.Swap>()
            ?? panic("Could not borrow reference to the FlowSwap Swap resource")

        // Perform the swap
        flowSwapRef.swap(moment: <-nft, recipient: acct.address)
    }
}
