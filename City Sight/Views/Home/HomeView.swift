//
//  HomeView.swift
//  City Sight
//
//  Created by Gokhan Bozkurt on 2.04.2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model : ContentModel
    @State var isMapShowing = false
    var body: some View {
        
        if model.restaurants.count != 0 || model.sights.count != 0 {
            NavigationView {
                // Determine if we should show list or map
                if !isMapShowing {
                    // show list
                    VStack(alignment: .leading    ) {
                        HStack {
                            Image(systemName: "location")
                            Text("Ankara")
                            Spacer()
                            Text("Switch the map view")
                          }
                        Divider()
                        BusinessListView()
                    }.padding([.horizontal,.top])
                        .navigationBarHidden(true)
                } else {
                    // show map
                }
            }
      
        } else {
            ProgressView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
