//
//  PaginationItemView.swift
//  Mockup
//
//  Created by Vladislav Erchik on 8.12.20.
//

import Foundation
import SwiftUI

struct PaginationItemView: View {
    let item: SaleItem
    
    var body: some View {
        HStack(alignment: .top) {
            ImageView(withURL: item.thumb)
                .clipShape(Circle())
                .frame(width: 80, height: 80)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .fontWeight(.semibold)
                
                HStack(spacing: 8) {
                    Text("$\(item.salePrice.description)")
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                    
                    Text("$\(item.normalPrice.description)")
                        .font(.system(size: 14))
                        .fontWeight(.light)
                        .strikethrough()
                }
                
                Text("Raiting: %\(item.steamRatingPercent)")
                    .padding(.top, 16)
            }
        }.frame(maxWidth: .infinity, alignment: .topLeading)
    }
}

struct PaginationItemView_Previews: PreviewProvider {
    static var previews: some View {
        PaginationItemView(item: .mock)
    }
}
