//
//  PaginationView.swift
//  Mockup
//
//  Created by Vladislav Erchik on 7.12.20.
//

import Foundation
import SwiftUI

struct PaginationView: View {
    @ObservedObject var viewModel = PaginationViewModel()
    
    var body: some View {
        List(0..<viewModel.listItems.count, id: \.self) { idx in
            PaginationItemView(item: viewModel.listItems[idx])
                .onAppear(perform: {
                    viewModel.fetchMoreIfNeeded(index: idx)
                })
        }
        .onAppear(perform: {
            viewModel.requestItems()
        })
    }
}

struct PaginationView_Previews: PreviewProvider {
    static var previews: some View {
        PaginationView()
    }
}
