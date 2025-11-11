//
//  OCRitApp.swift
//  OCRit
//
//  Created by Chenluo Deng on 11/11/25.
//

import SwiftUI

@main
struct OCRitApp: App {
    var body: some Scene {
        Window("OCR it!", id: "main") {
            ContentView()
        }.windowStyle(.hiddenTitleBar).defaultSize(width: 500, height: 400).windowResizability(.contentSize)
        
        Window("Settings", id: "settingsWindow") {
            SettingsView()
        }.keyboardShortcut(",").defaultSize(width: 500, height: 300).windowResizability(.contentSize)
    }
}
