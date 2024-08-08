import TopShot from "TopShot"

pub fun main(address: Address): Bool {
    let acct = getAccount(address)
    let collectionRef = acct.getCapability(/public/MomentCollection).borrow<&{TopShot.MomentCollectionPublic}>()
    return collectionRef != nil
}
