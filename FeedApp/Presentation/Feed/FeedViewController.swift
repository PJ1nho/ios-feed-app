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

    init(viewModel: FeedViewModel, onSelectItem: @escaping (FeedItem) -> Void) {
        super.init(
            rootView: FeedView(viewModel: viewModel, onSelectItem: onSelectItem)
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
