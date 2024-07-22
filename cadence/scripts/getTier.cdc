import TopShotTiers from 0xf8d6e0586b0a20c7

pub fun main(setID: UInt64, playID: UInt64): String {
    return TopShotTiers.getTier(setID: setID, playID: playID)
}
