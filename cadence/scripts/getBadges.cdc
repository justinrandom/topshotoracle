import TopShotBadges from 0xf8d6e0586b0a20c7

pub fun main(account: Address, momentID: UInt64): [String] {
    return TopShotBadges.getMomentBadges(account: account, momentID: momentID)
}
