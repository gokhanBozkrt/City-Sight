//
//  ListView.swift
//  City Sight
//
//  Created by Gokhan Bozkurt on 3.04.2022.
//

import SwiftUI

struct BusinessListView: View {
    @EnvironmentObject var model : ContentModel
    var body: some View {
        ScrollView(showsIndicators:false) {
            LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                
                BusinessSectionView(title: "Restaurants", businesses: model.restaurants)
                BusinessSectionView(title: "Sights", businesses: model.sights)
            }
        }
    }
}

struct BusinessListView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessListView()
    }
}
