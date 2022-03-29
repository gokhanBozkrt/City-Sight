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
        let userLocation = locations.first
        if userLocation != nil {
            
            // ToDo If we have coordinates of the user send yelp api
            // Stop requesting the location after we get it once
            locationManager.startUpdatingLocation()
           // getBusinesses(category: "art", location: userLocation)
            getBusinesses(category: "restaurants", location: userLocation!)
        }
       
    }
    // MARK: Yelp Api coordianates
    func getBusinesses(category:String,location:CLLocation) {
        // CREATE URL
        /*
        let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=20"
        let url = URL(string: urlString)
         */
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        let url = urlComponents?.url
            if let url = url  {
                // CREATE URL REQUEST
                var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
                request.httpMethod = "GET"
                request.addValue("Bearer iCFO0i6LlbjqhSNxpENLvNpe2S2fYpN5AvVFG59tygOBGl8wxVW3mlaqS2iB5CMFeBnSi3Omo8LiNGTU14w5-K3kpLvtLk2q3ddULi2eqqodJZYYAYOCw8jQFhFCYnYx", forHTTPHeaderField: "Authorization")
                // GET URL SESSION
                let session = URLSession.shared
                // CREATE DATA TASK
                let dataTask = session.dataTask(with: request) { data, response, error in
                    // check that there is no error
                    if error == nil {
                        print(response)
                    }
                }
                dataTask.resume()
        // START DATA TASK
        
        }
    }
    
}
