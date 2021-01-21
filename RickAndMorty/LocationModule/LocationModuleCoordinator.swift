import UIKit

///
/// - Requires: `UIKit`
final class LocationModuleCoordinator {

    // MARK: Dependencies
    private let navigationController: UINavigationController
    private let configurator: LocationModuleConfigurator

    // MARK: - Life cycle
    
    init(
        navigationController: UINavigationController,
        configurator: LocationModuleConfigurator
        ) {
        self.navigationController = navigationController
        self.configurator = configurator
    }
}

// MARK: - Navigation IN

extension LocationModuleCoordinator {
    
    func showLocation(model: LocationModel, animated: Bool) {
        let viewModel = LocationModuleViewModel(
            coordinator: self,
            configurator: configurator,
            model: model
        )
        let viewController = LocationModuleViewController(viewModel: viewModel)
        navigationController.pushViewController(
            viewController,
            animated: animated
        )
    }
}

// MARK: - Navigation OUT

// MARK: - MainImageModel Dependancy

extension LocationModuleCoordinator {
    func showLargeImage(
        model: ResponseModel,
        animted: Bool
        ) {
        let interactor = MainImageInteractorApi()
        let configurator = MainImageConfigurator(mainImageInteractor: interactor)

        let coordinator = MainImageCoordinator(
            navigationController: navigationController,
            configurator: configurator
        )

        coordinator.showLargeImage(
            model: model,
            animated: true
        )
    }
}

// MARK: - Navigation to Error View

extension LocationModuleCoordinator {
    func showError(
        animated: Bool
    ) {
        let configurator = ErrorModuleConfigurator(errorModuleInteractor: ErrorModuleInteractorApi())
        let coordinator = ErrorModuleCoordinator(
            navigationController: navigationController,
            configurator: configurator
        )
        coordinator.showError(animated: animated)
    }
}
