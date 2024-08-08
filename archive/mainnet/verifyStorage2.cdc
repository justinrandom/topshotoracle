import TopShot from 0x0b2a3299cc857e29

pub fun main(address: Address): Bool {
    let acct = getAccount(address)
    let collection = acct.borrow<&TopShot.Collection>(from: /storage/MomentCollection)

    // Debugging logs
    log("Collection in storage is nil")

    return collection != nil
}
