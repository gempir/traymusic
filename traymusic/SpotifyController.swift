//
//  SpotifyController.swift
//  https://github.com/benzguo/SpotifyController
//

import Foundation

enum SpotifyPlayerState : String {
    case Paused = "paused"
    case Playing = "playing"
    case Stopped = "stopped"
}

class SpotifyController {
    
    class func task(command: String) -> String? {
        let task = Process()
        let prefix = "tell application \"Spotify\" to"
        task.launchPath = "/usr/bin/osascript"
        task.arguments = ["-e", "\(prefix) \(command)"]
        let outPipe = Pipe()
        task.standardOutput = outPipe
        task.launch()
        task.waitUntilExit()
        let outHandle = outPipe.fileHandleForReading
        let output = NSString(data: outHandle.availableData, encoding: String.Encoding.ascii.rawValue) as NSString?
        return output?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    class func trackInfoTask(command: String) -> String? {
        return task(command: "\(command) of current track")
    }
    
    
    /// Is Spotify stopped, paused, or playing?
    class func playerState() -> SpotifyPlayerState? {
        return task(command: "player state").flatMap { SpotifyPlayerState(rawValue: $0) }
    }
       // MARK: Commands
    /// Pause playback.
    class func pause() { task(command: "pause") }
    
    /// Resume playback.
    class func play() { task(command: "play") }
    
    /// Skip to the next track.
    class func nextTrack() { task(command: "next track") }
    
    /// Skip to the previous track.
    class func previousTrack() { task(command: "previous track") }
    
    
    /// The name of the track.
    class func currentTrackName() -> String? { return trackInfoTask(command: "name") }
    
    /// The artist of the track.
    class func currentTrackArtist() -> String? { return trackInfoTask(command: "artist") }
}
