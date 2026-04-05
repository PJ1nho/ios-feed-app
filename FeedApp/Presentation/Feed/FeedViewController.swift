//
//  ViewController.swift
//  FeedApp
//
//  Created by Тихтей  Павел on 05.04.2026.
//

import UIKit
import SwiftUI

final class FeedViewController: UIHostingController<FeedView> {
    
    // MARK: - Init

    init(viewModel: FeedViewModel) {
        super.init(
            rootView: FeedView(viewModel: viewModel)
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
