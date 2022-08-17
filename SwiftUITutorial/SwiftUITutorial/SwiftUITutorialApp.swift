//
//  SwiftUITutorialApp.swift
//  SwiftUITutorial
//
//  Created by 강태준 on 2022/08/15.
//

import SwiftUI

@main
struct SwiftUITutorialApp: App {
    @StateObject private var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
