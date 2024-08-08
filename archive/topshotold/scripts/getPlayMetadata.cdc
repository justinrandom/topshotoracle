import "TopShot"

pub struct PlayMetadata {
    pub let playID: UInt32
    pub let metadata: {String: String}

    init(playID: UInt32, metadata: {String: String}) {
        self.playID = playID
        self.metadata = metadata
    }
}

pub fun main(playIDs: [UInt32]): [PlayMetadata] {
    var playMetadataList: [PlayMetadata] = []

    for playID in playIDs {
        let metadata = TopShot.getPlayMetaData(playID: playID) ?? panic("Play metadata not found for playID: ".concat(playID.toString()))
        playMetadataList.append(PlayMetadata(playID: playID, metadata: metadata))
    }

    return playMetadataList
}
