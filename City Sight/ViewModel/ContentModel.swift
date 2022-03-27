//
//  ContentModel.swift
//  City Sight
//
//  Created by Gokhan Bozkurt on 27.03.2022.
//

import Foundation
import CoreLocation
import SwiftUI

class ContentModel: NSObject, CLLocationManagerDelegate,ObservableObject {
    
    var locationManager = CLLocationManager()
    
   override init() {
       // init method of nsobject
       super.init()
        // Set content model as the delegate of the location manager
        locationManager.delegate = self
        
        // Request Permission from the user
        locationManager.requestWhenInUseAuthorization()
      
    }
    
  // MARK: - Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            // We have permission
            // TO DO:  Start geolocating the user,after we get permission
            locationManager.startUpdatingLocation()
            
        } else if locationManager.authorizationStatus == .denied  {
            // we dont have permission
        }
    }
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Gives us the location of user
        print(locations.first ?? "no location")
        // ToDo If we have coordinates of the user send yelp api
        // Stop requesting the location after we get it once
        locationManager.startUpdatingLocation()
        
    }
    
}
