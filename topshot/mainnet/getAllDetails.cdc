import TopShot from 0x0b2a3299cc857e29

pub struct MomentDetails {
    pub let id: UInt64
    pub let playID: UInt32
    pub let meta: TopShot.MomentData
    pub let setID: UInt32
    pub let setName: String
    pub let serialNumber: UInt32
    pub let subeditionID: UInt32?

    init(id: UInt64, playID: UInt32, meta: TopShot.MomentData, setID: UInt32, setName: String, serialNumber: UInt32, subeditionID: UInt32?) {
        self.id = id
        self.playID = playID
        self.meta = meta
        self.setID = setID
        self.setName = setName
        self.serialNumber = serialNumber
        self.subeditionID = subeditionID
    }
}

pub fun main(account: Address): [{UInt64: MomentDetails}] {
    let acct = getAccount(account)
    let collectionRef = acct.getCapability(/public/MomentCollection)!.borrow<&{TopShot.MomentCollectionPublic}>()
        ?? panic("Could not borrow capability from public collection")
    
    let momentIDs = collectionRef.getIDs()
    var results: [{UInt64: MomentDetails}] = []

    for id in momentIDs {
        let momentRef = collectionRef.borrowMoment(id: id)
            ?? panic("Could not borrow moment reference")

        let playID = momentRef.data.playID
        let meta = momentRef.data
        let setID = momentRef.data.setID
        let setName = TopShot.getSetName(setID: setID) ?? panic("Could not get set name")
        let serialNumber = momentRef.data.serialNumber
        let subeditionID = TopShot.getMomentsSubedition(nftID: id)

        let details = MomentDetails(
            id: id,
            playID: playID,
            meta: meta,
            setID: setID,
            setName: setName,
            serialNumber: serialNumber,
            subeditionID: subeditionID
        )

        results.append({id: details})
    }

    return results
}
