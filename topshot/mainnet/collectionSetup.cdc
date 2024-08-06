import TopShot from 0x0b2a3299cc857e29

pub fun main(address: Address): Bool {
    let acct = getAccount(address)
    return acct.getCapability(/public/MomentCollection).check<&{TopShot.MomentCollectionPublic}>()
}
