//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Nick on 1/29/22.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
