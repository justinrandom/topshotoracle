import TopShot from 0x0b2a3299cc857e29

pub struct MyPlay {
    pub let playID: UInt32
    pub let metadata: {String: String}

    init(playID: UInt32, metadata: {String: String}) {
        self.playID = playID
        self.metadata = metadata
    }
}

pub struct TopShotData {
    pub let totalSupply: UInt64
    pub let plays: [MyPlay]
    pub let currentSeries: UInt32
    pub var lastPlayFetched: Bool
    pub let nextPlayID: UInt32

    init() {
        self.totalSupply = TopShot.totalSupply
        self.currentSeries = TopShot.currentSeries
        self.plays = []
        self.lastPlayFetched = false
        self.nextPlayID = TopShot.nextPlayID
    }

    pub fun addPlay(p: MyPlay) {
        self.plays.append(p)
        if TopShot.nextPlayID - 1 == p.playID {
            self.lastPlayFetched = true
        }
    }
}

pub fun main(start: UInt32, end: UInt32): TopShotData {
    let ts = TopShotData()
    var i = start
    while i < end {
        let pm = TopShot.getPlayMetaData(playID: i)
        if pm == nil {
            break
        }
        ts.addPlay(p: MyPlay(playID: i, metadata: pm!))
        i = i + 1
    }
    return ts
}
