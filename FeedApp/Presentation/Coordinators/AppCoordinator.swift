//
//  AppCoordinator.swift
//  FeedApp
//
//  Created by Тихтей  Павел on 05.04.2026.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    func start()
}

final class AppCoordinator: Coordinator {
    let navigationController: UINavigationController
    
    private let apiClient: ApiClientProtocol
    
    init(navigationController: UINavigationController,
         apiClient: ApiClientProtocol = ApiClient()) {
        self.navigationController = navigationController
        self.apiClient = apiClient
    }
    
    func start() {
        showFeed()
    }
    
    private func showFeed() {
        let viewModel = FeedViewModel(apiClient: apiClient)

        let viewController = FeedViewController(
            viewModel: viewModel,
            onSelectItem: { [weak self] item in
                self?.showDetails(for: item)
            }
        )
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    private func showDetails(for item: FeedItem) {
        let viewModel = DetailsViewModel(feedItem: item, apiClient: apiClient)
        let viewController = DetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
