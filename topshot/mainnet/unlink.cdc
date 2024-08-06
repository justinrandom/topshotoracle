transaction {
    prepare(acct: AuthAccount) {
        // Unlink the public capability regardless of its existence
        acct.unlink(/public/MomentCollection)
        log("Unlinked public capability at /public/MomentCollection.")
    }
}
