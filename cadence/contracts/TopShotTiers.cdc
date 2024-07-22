pub contract TopShotTiers {

    // Define the mixed-tier sets with their play IDs and corresponding tiers
    pub var mixedTierSets: {UInt64: {UInt64: String}}
    // Define default tiers based on set IDs
    pub var defaultTiers: {UInt64: String}

    // Resource to manage the tier mappings
    pub resource Admin {
        
        pub fun addOrUpdateMixedTierSet(setID: UInt64, playID: UInt64, tier: String) {
            // If the setID already exists, update it, otherwise, create a new entry
            if let existingSet = TopShotTiers.mixedTierSets[setID] {
                var updatedSet = existingSet
                updatedSet[playID] = tier
                TopShotTiers.mixedTierSets[setID] = updatedSet
            } else {
                TopShotTiers.mixedTierSets[setID] = {playID: tier}
            }
        }

        pub fun removePlayIDFromMixedTierSet(setID: UInt64, playID: UInt64) {
            if let existingSet = TopShotTiers.mixedTierSets[setID] {
                var updatedSet = existingSet
                updatedSet.remove(key: playID)
                TopShotTiers.mixedTierSets[setID] = updatedSet
            }
        }

        pub fun addOrUpdateDefaultTier(setID: UInt64, tier: String) {
            TopShotTiers.defaultTiers[setID] = tier
        }
    }

    init() {
        self.mixedTierSets = {
            74: {
                2648: "legendary",
                2649: "legendary",
                2837: "legendary",
                2650: "rare",
                2651: "rare"
            },
            100: {
                3345: "legendary",
                3919: "legendary",
                5304: "legendary",
                4163: "rare",
                5301: "rare"
            },
            109: {
                3938: "legendary",
                5299: "legendary",
                4162: "rare",
                5300: "rare"
            },
            114: {
                3938: "legendary",
                5299: "legendary",
                4162: "rare",
                5300: "rare"
            },
            117: {
                4126: "legendary",
                4128: "legendary",
                5305: "legendary",
                4124: "rare",
                4125: "rare",
                4127: "rare",
                5306: "rare"
            },
            141: {
                5149: "fandom",
                5150: "fandom",
                5151: "fandom",
                5152: "fandom",
                5153: "fandom",
                5154: "fandom",
                5155: "fandom",
                5156: "fandom",
                5157: "fandom",
                5158: "fandom",
                5159: "fandom",
                5160: "fandom",
                5161: "fandom",
                5162: "fandom",
                5163: "fandom",
                5164: "fandom",
                5165: "fandom",
                5166: "fandom",
                5167: "fandom",
                5168: "fandom",
                5169: "fandom",
                5170: "fandom",
                5171: "fandom",
                5172: "fandom",
                5173: "fandom",
                5174: "fandom",
                5175: "fandom",
                5176: "fandom",
                5194: "fandom",
                5195: "fandom",
                5196: "fandom",
                5197: "fandom",
                5177: "rare",
                5178: "rare",
                5179: "rare",
                5180: "rare",
                5181: "rare",
                5182: "rare",
                5183: "rare",
                5184: "rare",
                5185: "rare",
                5186: "rare",
                5187: "rare",
                5188: "rare",
                5189: "rare",
                5190: "rare",
                5192: "rare",
                5193: "rare"
            }
        }

        self.defaultTiers = {
            1: "ultimate",
            2: "common",
            3: "ultimate",
            4: "legendary",
            5: "rare",
            6: "rare",
            7: "rare",
            8: "legendary",
            9: "rare",
            10: "rare",
            11: "rare",
            12: "legendary",
            13: "rare",
            14: "common",
            15: "rare",
            16: "rare",
            17: "rare",
            18: "rare",
            19: "rare",
            20: "legendary",
            21: "rare",
            22: "common",
            23: "legendary",
            24: "rare",
            25: "rare",
            26: "common",
            27: "ultimate",
            28: "legendary",
            29: "rare",
            30: "rare",
            31: "legendary",
            32: "common",
            33: "common",
            34: "common",
            35: "rare",
            36: "common",
            37: "hustle and show",
            38: "rare",
            39: "common",
            40: "rare",
            41: "legendary",
            42: "ultimate",
            43: "fandom",
            44: "common",
            45: "fandom",
            46: "rare",
            47: "rare",
            48: "common",
            49: "fandom",
            50: "legendary",
            51: "common",
            52: "ultimate",
            53: "legendary",
            54: "rare",
            55: "rare",
            56: "fandom",
            57: "legendary",
            58: "common",
            59: "common",
            60: "common",
            61: "legendary",
            62: "fandom",
            63: "rare",
            64: "rare",
            65: "common",
            66: "fandom",
            67: "common",
            68: "rare",
            69: "legendary",
            70: "fandom",
            71: "rare",
            72: "common",
            73: "common",
            75: "rare",
            76: "fandom",
            77: "fandom",
            78: "fandom",
            79: "rare",
            80: "fandom",
            81: "rare",
            82: "legendary",
            83: "rare",
            84: "common",
            85: "rare",
            86: "fandom",
            87: "fandom",
            88: "fandom",
            89: "rare",
            90: "common",
            91: "common",
            92: "common",
            93: "rare",
            94: "rare",
            95: "rare",
            96: "legendary",
            97: "rare",
            98: "common",
            99: "rare",
            101: "fandom",
            102: "rare",
            103: "legendary",
            104: "common",
            105: "common",
            106: "legendary",
            107: "fandom",
            108: "common",
            110: "legendary",
            111: "common",
            112: "rare",
            113: "common",
            115: "rare",
            116: "legendary",
            118: "legendary",
            119: "common",
            120: "rare",
            121: "legendary",
            122: "legendary",
            123: "legendary",
            124: "common",
            125: "common",
            126: "common",
            127: "rare",
            128: "rare",
            129: "common",
            130: "rare",
            131: "legendary",
            132: "common",
            133: "common",
            134: "rare",
            135: "rare",
            136: "rare",
            137: "common",
            138: "fandom",
            139: "legendary",
            140: "ultimate",
            142: "rare",
            143: "fandom",
            144: "common",
            145: "common",
            146: "rare",
            147: "legendary",
            148: "rare",
            149: "rare",
            150: "rare",
            151: "ultimate",
            152: "rare",
            153: "legendary"
        }

        self.account.save(<-create Admin(), to: /storage/TopShotTiersAdmin)
        self.account.link<&Admin>(/public/TopShotTiersAdmin, target: /storage/TopShotTiersAdmin)
    }

    // Function to get the tier of an NFT based on setID and playID
    pub fun getTier(setID: UInt64, playID: UInt64): String {
        // Check if the set is a mixed-tier set
        if let mixedSet = self.mixedTierSets[setID] {
            // Check if the play ID is in the mixed-tier set
            if let tier = mixedSet[playID] {
                return tier
            }
        }

        // Return the tier based on the set ID
        if let tier = self.defaultTiers[setID] {
            return tier
        }

        // Return a default tier if set ID is not found
        return "unknown"
    }
}
