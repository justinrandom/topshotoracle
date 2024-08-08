import TopShot from 0x0b2a3299cc857e29

transaction {
    prepare(acct: AuthAccount) {

        // Create a public capability for the collection
        let success = acct.link<&{TopShot.MomentCollectionPublic}>(
            /public/MomentCollection,
            target: /storage/MomentCollection
        )
        log("Linking successful: (success)")
    }
}
