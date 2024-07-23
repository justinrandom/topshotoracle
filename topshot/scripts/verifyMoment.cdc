import TopShot from 0xf8d6e0586b0a20c7

pub fun main(account: Address, momentID: UInt64): TopShot.MomentData {
    let collectionRef = getAccount(account).getCapability(/public/MomentCollection)!.borrow<&{TopShot.MomentCollectionPublic}>()
        ?? panic("Could not borrow capability from public collection")

    let momentRef = collectionRef.borrowMoment(id: momentID)
        ?? panic("Could not borrow moment reference")

    return momentRef.data
}
