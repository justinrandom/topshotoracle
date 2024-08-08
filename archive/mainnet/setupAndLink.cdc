import TopShot from 0x0b2a3299cc857e29

transaction {
    prepare(acct: AuthAccount) {
        // Check if the collection already exists in storage
        if acct.borrow<&TopShot.Collection>(from: /storage/MomentCollection) == nil {
            // Create a new TopShot Collection
            let collection <- TopShot.createEmptyCollection() as! @TopShot.Collection
            // Save the new Collection in storage
            acct.save(<-collection, to: /storage/MomentCollection)
        }

        // Check if the public capability already exists
        if !acct.getCapability<&{TopShot.MomentCollectionPublic}>(/public/MomentCollection).check() {
            acct.link<&{TopShot.MomentCollectionPublic}>(/public/MomentCollection, target: /storage/MomentCollection)
        }
    }
}
