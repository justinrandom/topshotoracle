import TopShot from 0x0b2a3299cc857e29
import Market from 0xc1e4f4f4c4257510
import TopShotMarketV3 from 0xc1e4f4f4c4257510

pub fun main(sellerAddress: Address): Int {
    let acct = getAccount(sellerAddress)
    let collectionRef = acct.getCapability(TopShotMarketV3.marketPublicPath)
        .borrow<&{Market.SalePublic}>()
        ?? panic("Could not borrow capability from public collection")
    
    return collectionRef.getIDs().length
}