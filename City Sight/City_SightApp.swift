//
//  City_SightApp.swift
//  City Sight
//
//  Created by Gokhan Bozkurt on 27.03.2022.
//

import SwiftUI

@main
struct City_SightApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
