import TopShotOracle from 0xf8d6e0586b0a20c7

transaction(setID: UInt32, tier: String) {

    prepare(signer: AuthAccount) {
        // Borrow a reference to the Admin resource
        let adminRef = signer.borrow<&TopShotOracle.Admin>(from: /storage/TopShotOracleAdmin)
            ?? panic("Could not borrow a reference to the Admin resource")

        // Call the deleteMapping function
        adminRef.deleteMapping(setID: setID, tier: tier)
    }

    execute {
        log("Mapping deleted successfully.")
    }
}
