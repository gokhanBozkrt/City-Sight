//
//  BusinessSectionHeaderView.swift
//  City Sight
//
//  Created by Gokhan Bozkurt on 3.04.2022.
//

import SwiftUI

struct BusinessSectionHeaderView: View {
    var title:String
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)
            Text(title)
                .font(.headline)
        }
    }
}

struct BusinessSectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessSectionHeaderView(title: "Restaurants")
    }
}
