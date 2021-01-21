import UIKit

/// Handles the navigation in and out of MainImageCoordinator
/// - Requires: ``
final class MainImageCoordinator {

    // MARK: Dependencies
    private let navigationController: UINavigationController
    private let configurator: MainImageConfigurator

    // MARK: - Life cycle
    
    init(
        navigationController: UINavigationController,
        configurator: MainImageConfigurator
        ) {
        self.navigationController = navigationController
        self.configurator = configurator
    }
}

// MARK: - Navigation IN

extension MainImageCoordinator {
    
    func showLargeImage(
        model: CharacterResponse,
        animated: Bool
    ) {
       let viewModel = MainImageViewModel(
           coordinator: self,
           configurator: configurator,
           model: model
       )
       let viewController = MainImageViewController(viewModel: viewModel)
       navigationController.pushViewController(
           viewController,
           animated: animated
       )
    }
}

// MARK: - Navigation OUT

extension MainImageCoordinator {
    func showCharacterView(animated: Bool, model: CharacterResponse) {
        let interactor = CharacterInteractorApi()
        let configurator = CharacterConfigurator(mainImageInteractor: interactor)
        let coordinator = CharacterCoordinator(
            navigationController: navigationController,
            configurator: configurator
        )
        coordinator.showCharcterVier(
            animated: animated,
            model: model
        )
    }
}
