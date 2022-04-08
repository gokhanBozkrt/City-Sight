//
//  BusinessRowView.swift
//  City Sight
//
//  Created by Gokhan Bozkurt on 5.04.2022.
//

import SwiftUI

struct BusinessRowView: View {
  @ObservedObject var business:Business
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
               // image
                let uiImage = UIImage(data: business.imageData ?? Data())
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .frame(width: 58, height: 58)
                    .cornerRadius(15)
                    .scaledToFit()
                // name and distance
                VStack(alignment:.leading) {
                    Text(business.name ?? "")
                        .bold()
                    Text(String(format: "%.1f km away",(business.distance ?? 0)/1000))
                        .font(.caption)
                }
                Spacer()
                // star rating and number of reviews
                VStack(alignment:.leading) {
                    Image("regular_\(business.rating ?? 0)")
                    Text("\(business.reviewCount ?? 0) reviews")
                        .font(.caption)
                }
            }
            Divider()
        }
        .foregroundColor(.black)

    }
}


