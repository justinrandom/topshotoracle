import TopShot from 0x0b2a3299cc857e29
import MetadataViews from 0x1d7e57aa55817448

pub struct MomentDetails {
    pub let id: UInt64
    pub let playID: UInt32
    pub let meta: TopShot.MomentData
    pub let setID: UInt32
    pub let setName: String
    pub let serialNumber: UInt32
    pub let subeditionID: UInt32?
    pub let playMetadata: {String: String}
    pub let setMetadata: String
    pub let editionsMetadata: AnyStruct?

    init(
        id: UInt64,
        playID: UInt32,
        meta: TopShot.MomentData,
        setID: UInt32,
        setName: String,
        serialNumber: UInt32,
        subeditionID: UInt32?,
        playMetadata: {String: String},
        setMetadata: String,
        editionsMetadata: AnyStruct?
    ) {
        self.id = id
        self.playID = playID
        self.meta = meta
        self.setID = setID
        self.setName = setName
        self.serialNumber = serialNumber
        self.subeditionID = subeditionID
        self.playMetadata = playMetadata
        self.setMetadata = setMetadata
        self.editionsMetadata = editionsMetadata
    }
}

pub fun main(account: Address, momentID: UInt64): MomentDetails {
    let acct = getAccount(account)
    let collectionRef = acct.getCapability(/public/MomentCollection)!.borrow<&{TopShot.MomentCollectionPublic}>()
        ?? panic("Could not borrow capability from public collection")

    let momentRef = collectionRef.borrowMoment(id: momentID)
        ?? panic("Could not borrow moment reference")

    let id = momentRef.id
    let playID = momentRef.data.playID
    let meta = momentRef.data
    let setID = momentRef.data.setID
    let setName = TopShot.getSetName(setID: setID) ?? panic("Could not get set name")
    let serialNumber = momentRef.data.serialNumber
    let subeditionID = TopShot.getMomentsSubedition(nftID: momentID)

    // Get play metadata
    let playMetadata = TopShot.getPlayMetaData(playID: meta.playID) ?? panic("Play doesn't exist")

    // Get set metadata
    let setMetadata = TopShot.getSetData(setID: meta.setID)?.name ?? panic("Set doesn't exist")

    // Fetch editions metadata if available
    let editionsView: MetadataViews.Editions? = momentRef.getViews().contains(Type<MetadataViews.Editions>())
        ? momentRef.resolveView(Type<MetadataViews.Editions>()) as? MetadataViews.Editions
        : nil

    return MomentDetails(
        id: id,
        playID: playID,
        meta: meta,
        setID: setID,
        setName: setName,
        serialNumber: serialNumber,
        subeditionID: subeditionID,
        playMetadata: playMetadata,
        setMetadata: setMetadata,
        editionsMetadata: editionsView
    )
}
