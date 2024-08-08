import "TopShot"

// This script returns a dictionary of set IDs to arrays of play IDs

// Returns: {UInt32: [UInt32]}
// Dictionary of set IDs to arrays of play IDs

pub fun main(): {UInt32: [UInt32]} {
    var playIDsBySetID: {UInt32: [UInt32]} = {}
    let nextSetID = TopShot.nextSetID

    var setID: UInt32 = 0
    while setID < nextSetID {
        let plays = TopShot.getPlaysInSet(setID: setID)
        if plays != nil {
            playIDsBySetID[setID] = plays!
        }
        setID = setID + 1
    }

    return playIDsBySetID
}
