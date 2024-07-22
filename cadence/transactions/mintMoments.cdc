import TopShot from 0xf8d6e0586b0a20c7

transaction {
    prepare(signer: AuthAccount) {
        // Define the setID
        let setID: UInt32 = 1

        // Get a reference to the admin resource
        let adminRef = signer.borrow<&TopShot.Admin>(from: /storage/TopShotAdmin)
            ?? panic("Could not borrow a reference to the Admin resource")

        // Borrow the set reference
        let setRef = adminRef.borrowSet(setID: setID)

        // Get the moment collection reference from the signer
        let collectionRef = signer.borrow<&TopShot.Collection>(from: /storage/MomentCollection)
            ?? panic("Could not borrow a reference to the Moment collection")

        // Mint and deposit new moments for playIDs 5 to 17
        let playIDs: [UInt32] = [18, 19, 20, 21, 22, 23, 24,25, 26, 27, 28, 29,30, 31,32,33,34,35]
        for playID in playIDs {
            let newMoment <- setRef.mintMoment(playID: playID)
            collectionRef.deposit(token: <-newMoment)
        }
    }
}
