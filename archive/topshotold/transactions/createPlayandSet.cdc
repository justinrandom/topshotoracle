import TopShot from 0xf8d6e0586b0a20c7

transaction {
    prepare(signer: AuthAccount) {
        // Get a reference to the admin resource
        let adminRef = signer.borrow<&TopShot.Admin>(from: /storage/TopShotAdmin)
            ?? panic("Could not borrow a reference to the Admin resource")

        // Create a new Play
        let playMetadata = {
            "FirstName": "Ja",
            "LastName": "Morant",
            "NbaSeason": "2019-20",
            "FullName": "Ja Morant",
            "DraftTeam": "Memphis Grizzlies",
            "DraftYear": "2019",
            "PlayerPosition": "G",
            "TeamAtMoment": "Memphis Grizzlies",
            "Height": "75",
            "Weight": "174",
            "Birthdate": "1999-08-10",
            "PlayType": "Rim",
            "PlayCategory": "Dunk",
            "HomeTeamScore": "108",
            "DateOfMoment": "2019-12-12 02:00:00 +0000 UTC",
            "TeamAtMomentNBAID": "1610612763",
            "TotalYearsExperience": "0",
            "DraftSelection": "2",
            "Tagline": "Memphis Grizzlies rookie standout Ja Morant soars above the Phoenix Suns defense and throws down the huge right-handed jam on December 11, 2019.",
            "DraftRound": "1",
            "JerseyNumber": "12",
            "Birthplace": "Dalzell, SC, USA",
            "AwayTeamName": "Memphis Grizzlies",
            "HomeTeamName": "Phoenix Suns",
            "AwayTeamScore": "115",
            "PrimaryPosition": "PG"
        }

        let playID = adminRef.createPlay(metadata: playMetadata)
        log("Created Play with ID: (playID)")

        // Create a new Set
        let setName = "Base Set"
        let setID = adminRef.createSet(name: setName)
        log("Created Set with ID: (setID)")

        // Add the play to the set
        let setRef = adminRef.borrowSet(setID: setID)
        setRef.addPlay(playID: playID)
        log("Added Play with ID: (playID) to Set with ID: (setID)")
    }
}
