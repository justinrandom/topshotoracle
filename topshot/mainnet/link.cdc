import TopShot from 0x0b2a3299cc857e29

transaction {
    prepare(acct: AuthAccount) {
        if !acct.getCapability<&{TopShot.MomentCollectionPublic}>(/public/MomentCollection).check() {
            acct.link<&{TopShot.MomentCollectionPublic}>(/public/MomentCollection, target: /storage/MomentCollection)
        }
    }
}
