//
//  Business.swift
//  City Sight
//
//  Created by Gokhan Bozkurt on 30.03.2022.
//

import Foundation
import SwiftUI

class Business: Decodable, Identifiable,ObservableObject {
  @Published var imageData:Data?
    
    var id:String?
    var alias:String?
    var name:String?
    var imageUrl:String?
    var isClosed:Bool?
    var url:String?
    var reviewCount:Int?
    var categories:[Category]?
    var rating:Double?
    var coordinates:Coordinate?
    var transactions:[String]?
    var price:String?
    var location:Location?
    var phone:String?
    var displayPhone:String?
    var distance:Double?
    
    enum CodingKeys: String,CodingKey {
        case imageUrl = "image_url"
        case isClosed = "is_closed"
        case reviewCount = "review_count"
        case displayPhone = "display_phone"
        
        case id, alias,name,url,categories,rating,coordinates,transactions,price,location,phone,distance
    }
    func getImageData() {
        // check imageurl isnt nil
        guard imageUrl != nil else {
            return
        }
        // Download the data for thr image
        if let url = URL(string: imageUrl!) {
            // get a session
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                
                if error == nil {
                    // set the image data
                    DispatchQueue.main.async {
                        self.imageData = data!
                    }
                  
                }
            }
                .resume()
           
        }
    }
}

struct Location: Decodable {
    var address1:String?
    var address2:String?
    var address3:String?
    var city:String?
    var zipCode:String?
    var country:String?
    var state:String?
    var displayAddress:[String]?
    
    enum CodingKeys: String,CodingKey {
        case zipCode = "zip_code"
        case displayAddress = "display_address"
        
        case address1
        case address2
        case address3
        case city
        case country
        case state
    }
    
}



struct Category: Decodable {
    var alias:String?
    var title:String?
}

struct Coordinate: Decodable {
    var latitude:Double?
    var longitute:Double?
}


