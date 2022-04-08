//
//  BusinessSectionView.swift
//  City Sight
//
//  Created by Gokhan Bozkurt on 3.04.2022.
//

import SwiftUI

struct BusinessSectionView: View {
    var title: String
    var businesses: [Business]
    
    var body: some View {
        Section(header: BusinessSectionHeaderView(title: title)) {
            ForEach(businesses) { business in
                NavigationLink(destination: BusinessDetail(business: business) ) {
                    BusinessRowView(business: business)
                }
               
            }
    }
}
}
    
