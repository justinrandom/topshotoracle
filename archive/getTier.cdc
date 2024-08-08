import TopShotTiers from 0xf8d6e0586b0a20c7

pub fun main(setID: UInt64, playID: UInt64): String {
    let tier = TopShotTiers.getTier(setID: setID, playID: playID)
    if let unwrappedTier = tier {
        return TopShotTiers.tierToString(tier: unwrappedTier)
    } else {
        return "Tier not found"
    }
}
