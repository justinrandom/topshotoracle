import TopShot from 0x0b2a3299cc857e29

pub fun main(address: Address): {String: Bool} {
    let acct = getAccount(address)
    let capabilityCheck = acct.getCapability(/public/MomentCollection).check<&{TopShot.MomentCollectionPublic}>()
    
    // We cannot check the storage directly from a public account
    // Instead, let's return if the capability is available
    return {
        "publicCapability": capabilityCheck
    }
}
