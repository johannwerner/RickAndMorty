import UIKit

/// Handles the navigation in and out of EpisodeCoordinator
/// - Requires: ``
final class EpisodeCoordinator {

    // MARK: Dependencies
    private let navigationController: UINavigationController
    private let configurator: EpisodeConfigurator

    // MARK: - Life cycle
    
    init(
        navigationController: UINavigationController,
        configurator: EpisodeConfigurator
        ) {
        self.navigationController = navigationController
        self.configurator = configurator
    }
}

// MARK: - Navigation IN

extension EpisodeCoordinator {
    
    func showEpisode(url: URL, animated: Bool) {
           let viewModel = EpisodeViewModel(
               coordinator: self,
               configurator: configurator,
               url: url
           )
           let viewController = EpisodeViewController(viewModel: viewModel)
           navigationController.pushViewController(
               viewController,
               animated: animated
           )
    }
}

// MARK: - Navigation OUT

extension EpisodeCoordinator {}
