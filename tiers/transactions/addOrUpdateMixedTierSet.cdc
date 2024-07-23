import TopShotTiers from 0xf8d6e0586b0a20c7

transaction(setID: UInt64, playID: UInt64, tierRawValue: UInt8) {
    let adminRef: &TopShotTiers.Admin

    prepare(signer: AuthAccount) {
        self.adminRef = signer.borrow<&TopShotTiers.Admin>(from: /storage/TopShotTiersAdmin)
            ?? panic("Could not borrow a reference to the Admin resource")
    }

    execute {
        let tierEnum: TopShotTiers.Tier = TopShotTiers.Tier(rawValue: tierRawValue) ?? panic("Invalid tier value")
        
        self.adminRef.addOrUpdateMixedTierSet(setID: setID, playID: playID, tier: tierEnum)
    }
}
