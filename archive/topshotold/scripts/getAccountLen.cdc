import "TopShot"

pub fun main(address: Address): Int {
    let acct = getAccount(address)
    let collectionRef = acct.getCapability(/public/MomentCollection)!.borrow<&{TopShot.MomentCollectionPublic}>()
        ?? panic("Could not borrow capability from public collection")
    
    return collectionRef.getIDs().length
}
