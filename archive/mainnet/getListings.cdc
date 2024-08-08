import TopShot from 0x0b2a3299cc857e29
import Market from 0xc1e4f4f4c4257510
import TopShotMarketV3 from 0xc1e4f4f4c4257510

pub struct SaleMoment {
    pub let id: UInt64
    pub let playId: UInt32
    pub let meta: TopShot.MomentData
    pub let setId: UInt32
    pub let setName: String
    pub let serialNumber: UInt32
    pub let price: UFix64

    init(id: UInt64, playId: UInt32, meta: TopShot.MomentData, setId: UInt32, setName: String, serialNumber: UInt32, price: UFix64) {
        self.id = id
        self.playId = playId
        self.meta = meta
        self.setId = setId
        self.setName = setName
        self.serialNumber = serialNumber
        self.price = price
    }
}

pub fun main(sellerAddress: Address): [SaleMoment] {
    let acct = getAccount(sellerAddress)
    let collectionRef = acct.getCapability(TopShotMarketV3.marketPublicPath)
        .borrow<&{Market.SalePublic}>()
        ?? panic("Could not borrow capability from public collection")
    
    var saleMoments: [SaleMoment] = []

    for momentID in collectionRef.getIDs() {
        log("Fetching moment with ID: ".concat(momentID.toString()))
        
        let momentOpt = collectionRef.borrowMoment(id: momentID)
        if momentOpt == nil {
            log("Could not borrow moment with ID: ".concat(momentID.toString()))
            continue
        }
        let moment = momentOpt!
        
        let priceOpt = collectionRef.getPrice(tokenID: momentID)
        if priceOpt == nil {
            log("Could not get price for moment with ID: ".concat(momentID.toString()))
            continue
        }
        let price = priceOpt!
        
        let playId = moment.data.playID
        let meta = moment.data
        
        let setId = moment.data.setID
        
        let setNameOpt = TopShot.getSetName(setID: setId)
        if setNameOpt == nil {
            log("Could not get set name for set ID: ".concat(setId.toString()))
            continue
        }
        let setName = setNameOpt!
        
        let serialNumber = moment.data.serialNumber

        saleMoments.append(SaleMoment(
            id: momentID,
            playId: playId,
            meta: meta,
            setId: setId,
            setName: setName,
            serialNumber: serialNumber,
            price: price
        ))
    }

    return saleMoments
}
