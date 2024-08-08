import TopShot from 0x0b2a3299cc857e29

pub fun main(address: Address): Bool {
    let acct = getAccount(address)
    let collectionRef = acct.getCapability(/public/MomentCollection).borrow<&{TopShot.MomentCollectionPublic}>()
    return collectionRef != nil
}
