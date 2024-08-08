import "TopShot"
import "MetadataViews"

pub fun main(account: Address, id: UInt64): {String: AnyStruct} {

    // get the public capability for the owner's moment collection and borrow a reference to it
    let collectionRef = getAccount(account).getCapability(/public/MomentCollection)
        .borrow<&{TopShot.MomentCollectionPublic}>()
        ?? panic("Could not get public moment collection reference")

    // Borrow a reference to the specified moment
    let token = collectionRef.borrowMoment(id: id)
        ?? panic("Could not borrow a reference to the specified moment")

    // Get the moment's metadata to access its play and set IDs
    let data = token.data

    // Use the moment's play ID to get all the metadata associated with that play
    let playMetadata = TopShot.getPlayMetaData(playID: data.playID) ?? panic("Play doesn't exist")

    // Use the moment's set ID to get the set metadata
    let setMetadata = TopShot.getSetData(setID: data.setID)?.name ?? panic("Set doesn't exist")

    // Prepare the result dictionary
    let metadataResult: {String: AnyStruct} = {
        "playMetadata": playMetadata,
        "setMetadata": setMetadata
    }

    return metadataResult
}
