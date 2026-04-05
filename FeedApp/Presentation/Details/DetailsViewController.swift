//
//  DetailsViewController.swift
//  FeedApp
//
//  Created by Тихтей  Павел on 05.04.2026.
//

import UIKit
import SwiftUI

class DetailsViewController: UIHostingController<DetailsView> {

    // MARK: - Init

    init(viewModel: DetailsViewModel) {
        super.init(
            rootView: DetailsView(viewModel: viewModel)
        )
        title = "Details"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
