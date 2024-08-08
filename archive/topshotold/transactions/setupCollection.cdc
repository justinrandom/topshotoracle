import TopShot from "TopShot"

transaction {
    prepare(acct: AuthAccount) {
        // Create a new empty collection
        let collection <- TopShot.createEmptyCollection()

        // Save the collection to the account storage
        acct.save(<-collection, to: /storage/MomentCollection)

        // Create a public capability for the collection
        acct.link<&{TopShot.MomentCollectionPublic}>(/public/MomentCollection, target: /storage/MomentCollection)
    }
}
