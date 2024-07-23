import TopShot from 0xf8d6e0586b0a20c7
import TopShotBadges from 0xf8d6e0586b0a20c7

pub fun main(account: Address): {UInt64: [String]} {
    let badgeResults: {UInt64: [String]} = {}

    // Get the user's moment collection
    let collectionRef = getAccount(account).getCapability(/public/MomentCollection)!.borrow<&{TopShot.MomentCollectionPublic}>()
        ?? panic("Could not borrow capability from public collection")

    // Get all moment IDs in the user's collection
    let momentIDs = collectionRef.getIDs()

    // Iterate over all moments and get their badges
    for momentID in momentIDs {
        let badges = TopShotBadges.getMomentBadges(account: account, momentID: momentID)
        badgeResults[momentID] = badges
    }

    return badgeResults
}
