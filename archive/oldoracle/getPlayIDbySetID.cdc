import TopShotOracle from 0xf8d6e0586b0a20c7

pub fun main(setID: UInt32): [UInt32] {
    return TopShotOracle.getPlayIDsForSetID(setID: setID)
}
