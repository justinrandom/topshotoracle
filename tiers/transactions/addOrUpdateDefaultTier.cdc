import TopShotTiers from 0xf8d6e0586b0a20c7

transaction(setID: UInt64, tier: String) {
    let adminRef: &TopShotTiers.Admin

    prepare(signer: AuthAccount) {
        self.adminRef = signer.borrow<&TopShotTiers.Admin>(from: /storage/TopShotTiersAdmin)
            ?? panic("Could not borrow a reference to the Admin resource")
    }

    execute {
        self.adminRef.addOrUpdateDefaultTier(setID: setID, tier: tier)
        log("Added or updated default tier successfully")
    }
}
