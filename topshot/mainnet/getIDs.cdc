import TopShot from 0x0b2a3299cc857e29

pub fun main(address: Address) : [UInt64] {
    let acct = getAccount(address)
    let collectionRef = acct.getCapability(/public/MomentCollection)!.borrow<&{TopShot.MomentCollectionPublic}>()
        ?? panic("Could not borrow capability from public collection")
    
    return collectionRef.getIDs()
}