//
//  ContentView.swift
//  City Sight
//
//  Created by Gokhan Bozkurt on 27.03.2022.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    @EnvironmentObject var model : ContentModel
    var body: some View {
        
        // Detect the authorization status of geolocating the user
        if model.authorizationState == .notDetermined {
            // If undetermined show onboarding
        } else if model.authorizationState == .authorizedWhenInUse || model.authorizationState == .authorizedAlways {
            // If approved show home view
            HomeView()
        } else {
            // If denied show denied view
           
        }
    
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
