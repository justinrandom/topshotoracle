import TopShot from 0x0b2a3299cc857e29

pub struct Moment {
    pub var id: UInt64?
    pub var playId: UInt32?
    pub var meta: TopShot.MomentData?
    pub var play: {String: String}?
    pub var setId: UInt32?
    pub var setName: String?
    pub var serialNumber: UInt32?

    init(_ moment: &TopShot.NFT?) {
        self.id = moment?.id
        self.meta = moment?.data
        self.playId = moment?.data?.playID
        self.play = TopShot.getPlayMetaData(playID: self.playId!)
        self.setId = moment?.data?.setID
        self.setName = TopShot.getSetName(setID: self.setId!)
        self.serialNumber = moment?.data?.serialNumber
    }
}

pub fun main(address: Address, momentIDs: [UInt64]): [Moment] {
    let acct = getAccount(address)
    let collectionRef = acct.getCapability(/public/MomentCollection)!.borrow<&{TopShot.MomentCollectionPublic}>()!
    var moments: [Moment] = []

    for momentID in momentIDs {
        moments.append(Moment(collectionRef.borrowMoment(id: momentID)))
    }

    return moments
}