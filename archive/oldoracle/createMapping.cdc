import TopShotOracle from 0xf8d6e0586b0a20c7

transaction(setID: UInt32, tier: String, startPlayID: UInt32, endPlayID: UInt32) {
    prepare(acct: AuthAccount) {
        let adminRef = acct.borrow<&TopShotOracle.Admin>(from: /storage/TopShotOracleAdmin)
            ?? panic("Could not borrow a reference to the Admin resource")

        let playRange = TopShotOracle.PlayRange(startPlayID: startPlayID, endPlayID: endPlayID)
        adminRef.addOrUpdateMapping(setID: setID, tier: tier, playRanges: [playRange])
    }
}
