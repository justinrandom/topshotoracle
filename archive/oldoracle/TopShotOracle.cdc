pub contract TopShotOracle {

    // Struct to define a play range
    pub struct PlayRange {
        pub let startPlayID: UInt32
        pub let endPlayID: UInt32

        init(startPlayID: UInt32, endPlayID: UInt32) {
            self.startPlayID = startPlayID
            self.endPlayID = endPlayID
        }
    }

    // Resource to define the admin of the contract
    pub resource Admin {
        // Function to add or update a mapping
        pub fun addOrUpdateMapping(setID: UInt32, tier: String, playRanges: [PlayRange]) {
            TopShotOracle.addOrUpdateMapping(setID: setID, tier: tier, playRanges: playRanges)
        }

        // Function to delete a mapping
        pub fun deleteMapping(setID: UInt32, tier: String) {
            TopShotOracle.deleteMapping(setID: setID, tier: tier)
        }
    }

    // Dictionary to store the mappings
    pub var playMappings: {UInt32: {String: [PlayRange]}}

    init() {
        self.playMappings = {}
        self.account.save(<-create Admin(), to: /storage/TopShotOracleAdmin)
        self.account.link<&Admin>(/public/TopShotOracleAdmin, target: /storage/TopShotOracleAdmin)
    }

    // Function to add or update a mapping
    pub fun addOrUpdateMapping(setID: UInt32, tier: String, playRanges: [PlayRange]) {
        if self.playMappings[setID] == nil {
            self.playMappings[setID] = {}
        }
        var tierMapping = self.playMappings[setID]!
        tierMapping[tier] = playRanges
        self.playMappings[setID] = tierMapping
    }

    // Function to delete a mapping
    pub fun deleteMapping(setID: UInt32, tier: String) {
        if let tierMapping = self.playMappings[setID] {
            tierMapping.remove(key: tier)
            if tierMapping.keys.length == 0 {
                self.playMappings.remove(key: setID)
            } else {
                self.playMappings[setID] = tierMapping
            }
        } else {
            panic("Mapping for setID (setID) does not exist.")
        }
    }

    // Function to check the tier of a moment
    pub fun getTier(setID: UInt32, playID: UInt32): String? {
        let setMappings = self.playMappings[setID]
        if setMappings == nil {
            return nil
        }

        for tier in setMappings!.keys {
            let ranges = setMappings![tier]!
            for range in ranges {
                if playID >= range.startPlayID && playID <= range.endPlayID {
                    return tier
                }
            }
        }

        return nil
    }

    // Function to get sets for a given playID
    pub fun getSetsForPlayID(playID: UInt32): {UInt32: [String]} {
        var playIDResult: {UInt32: [String]} = {}
        for setID in self.playMappings.keys {
            let setMappings = self.playMappings[setID]!
            for tier in setMappings.keys {
                let ranges = setMappings[tier]!
                for range in ranges {
                    if playID >= range.startPlayID && playID <= range.endPlayID {
                        if playIDResult[setID] == nil {
                            playIDResult[setID] = []
                        }
                        playIDResult[setID]!.append(tier)
                    }
                }
            }
        }
        return playIDResult
    }

    // Function to get playIDs for a given setID
    pub fun getPlayIDsForSetID(setID: UInt32): [UInt32] {
        var playIDs: [UInt32] = []
        let setMappings = self.playMappings[setID] ?? panic("Set ID not found")
        
        for tier in setMappings.keys {
            let ranges = setMappings[tier]!
            for range in ranges {
                var currentID = range.startPlayID
                while currentID <= range.endPlayID {
                    playIDs.append(currentID)
                    currentID = currentID + 1
                }
            }
        }

        return playIDs
    }
}
