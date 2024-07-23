import TopShot from 0xf8d6e0586b0a20c7

transaction(setName: String) {
    prepare(signer: AuthAccount) {
        // Get a reference to the admin resource
        let adminRef = signer.borrow<&TopShot.Admin>(from: /storage/TopShotAdmin)
            ?? panic("Could not borrow a reference to the Admin resource")

        // Create a new Set
        let setID = adminRef.createSet(name: setName)
    }
}
