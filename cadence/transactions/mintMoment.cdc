import TopShot from 0xf8d6e0586b0a20c7

transaction {
    prepare(signer: AuthAccount) {
        // Define the playID and setID
        let playID: UInt32 = 5
        let setID: UInt32 = 1

        // Get a reference to the admin resource
        let adminRef = signer.borrow<&TopShot.Admin>(from: /storage/TopShotAdmin)
            ?? panic("Could not borrow a reference to the Admin resource")

        // Borrow the set reference
        let setRef = adminRef.borrowSet(setID: setID)

        // Mint a new Moment
        let newMoment <- setRef.mintMoment(playID: playID)

        // Get the moment collection reference from the signer
        let collectionRef = signer.borrow<&TopShot.Collection>(from: /storage/MomentCollection)
            ?? panic("Could not borrow a reference to the Moment collection")

        // Deposit the new Moment into the collection
        collectionRef.deposit(token: <-newMoment)

        log("Minted a new moment with ID: (newMoment.id)")
    }
}
