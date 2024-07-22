import TopShotOracle from 0xf8d6e0586b0a20c7

pub fun main(setID: UInt32, playID: UInt32): String? {
    return TopShotOracle.getTier(setID: setID, playID: playID)
}
