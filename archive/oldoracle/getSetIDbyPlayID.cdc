import TopShotOracle from 0xf8d6e0586b0a20c7

pub fun main(playID: UInt32): {UInt32: [String]} {
    return TopShotOracle.getSetsForPlayID(playID: playID)
}
