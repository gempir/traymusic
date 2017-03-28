//
//  StatusMenuController.swift
//  traymusic
//
//  Created by Daniel Pasch-Sannapiu on 26/03/2017.
//  Copyright © 2017 gempir. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
        
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    @IBAction func playClicked(_ sender: NSMenuItem) {

        if SpotifyController.playerState() == SpotifyPlayerState.Paused {
            SpotifyController.play()
        }
        else {
            SpotifyController.pause()
        }
        
    }
    
    @IBAction func previousClicked(_ sender: NSMenuItem) {
        SpotifyController.previousTrack()
    }
    
    @IBAction func nextClicked(_ sender: NSMenuItem) {
        SpotifyController.nextTrack()
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
    
    override func awakeFromNib() {
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true
        statusItem.image = icon
        statusItem.menu = statusMenu
    }

}
