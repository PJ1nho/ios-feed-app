//
//  DetailsView.swift
//  FeedApp
//
//  Created by Тихтей  Павел on 05.04.2026.
//

import SwiftUI

struct DetailsView: View {
    
    @ObservedObject private var viewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DetailsView(viewModel: DetailsViewModel())
}
