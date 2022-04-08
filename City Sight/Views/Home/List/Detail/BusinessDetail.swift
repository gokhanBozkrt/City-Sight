//
//  BusinessDetail.swift
//  City Sight
//
//  Created by Gokhan Bozkurt on 8.04.2022.
//

import SwiftUI

struct BusinessDetail: View {
    var business:Business
    var body: some View {
        VStack(alignment:.leading) {
            VStack(alignment:.leading,spacing: 0) {
                // business image
                GeometryReader() { geo in
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width:geo.size.width, height: geo.size.height)
                        .clipped()
                }
                .ignoresSafeArea(.all, edges: .top)
             
                // open closed indicator
                ZStack(alignment:.leading) {
                    Rectangle()
                        .frame(height: 38)
                        .foregroundColor(business.isClosed! ? .gray : .blue)
                    Text(business.isClosed! ? "CLOSED" : "OPEN")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.leading)
                }
            }
        
            Group {
                // Business name
                Text(business.name!)
                    .font(.largeTitle)
                    .padding()
                // address
                if business.location?.displayAddress != nil {
                    ForEach(business.location!.displayAddress!, id: \.self) { address in
                        Text(address)
                            .padding(.horizontal)
                    }
                } else {
                    Text("Couldnt find the address")
                }
             // rating
                Divider()
                Image("regular_\(business.rating ?? 0)")
                    .padding()
                // Phone
                HStack {
                    Text("Phone:")
                    Text(business.displayPhone ?? "0")
                    Spacer()
                    Link("Call", destination: URL(string: "phone:\(business.phone ?? "")")!)
                }.padding()
                Divider()
                // Reviews
                HStack {
                    Text("Reviews:")
                    Text("\(business.reviewCount ?? 0)")
                    Spacer()
                    Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                }.padding()
                Divider()
                // Website
                HStack {
                    Text("Website:")
                    Text(business.url ?? "")
                        .lineLimit(1)
                    Spacer()
                    Link("Visit ", destination: URL(string: "\(business.url ?? "")")!)
                }.padding()
                Divider()
                //
            }
            // Get directions button
            Button {
                // TODO:
            } label: {
                ZStack {
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                    Text("Get Direction")
                        .foregroundColor(.white)
                        .bold()
                }
            }.padding()

        }
    }
}



/*
struct BusinessDetail_Previews: PreviewProvider {
    static var previews: some View {
        BusinessDetail(business: Business.getTestData())
    }
}
*/
