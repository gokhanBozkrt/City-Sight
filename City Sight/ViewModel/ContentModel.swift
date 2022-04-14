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
    @Published var authorizationState = CLAuthorizationStatus.denied
    
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
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
       
        // Update the authorizationState property
        authorizationState = locationManager.authorizationStatus
        
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
      //    print(locations.first ?? "no location")
        let userLocation = locations.first
        if userLocation != nil {
            
            // ToDo If we have coordinates of the user send yelp api
            // Stop requesting the location after we get it once
            locationManager.startUpdatingLocation()
            getBusinesses(category: Constants.restaurantsKey, location: userLocation!)
            getBusinesses(category: Constants.sighthKey, location: userLocation!)
        }
       
    }
    // MARK: Yelp Api coordianates
    func getBusinesses(category:String,location:CLLocation) {
        // CREATE URL
        /*
        let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=20"
        let url = URL(string: urlString)
         */
        var urlComponents = URLComponents(string: Constants.apiUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "10")
        ]
        let url = urlComponents?.url
            if let url = url  {
                // CREATE URL REQUEST
                var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
                request.httpMethod = "GET"
                request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
                // GET URL SESSION
                let session = URLSession.shared
                // CREATE DATA TASK
                let dataTask = session.dataTask(with: request) { data, response, error in
                    // check that there is no error
                    if error == nil {
                      // parse json
               //       print(response)
                        do {
                            let decoder = JSONDecoder()
                            let result = try decoder.decode(BusinessSearch.self, from: data!)
                            // Sort businesses
                            var businesses = result.businesses
                            businesses.sorted { b1, b2 in
                                return b1.distance ?? 0 < b2.distance ?? 0
                            }
                            
                            // Call the get image function of the businesses
                            for b in businesses {
                                b.getImageData()
                            }
                            DispatchQueue.main.async {
                              switch category {
                                case Constants.sighthKey:
                                    self.sights = businesses
                                case Constants.restaurantsKey:
                                    self.restaurants = businesses
                                default:
                                    break
                                }
                                
                            }
                            
                        } catch {
                            print(error)
                        }
                    }
                }
                dataTask.resume()
        }
    }
    
}


