import UIKit

/// To Show error view
/// - Requires: `UIKit`
final class ErrorModuleCoordinator {

    // MARK: Dependencies
    private let navigationController: UINavigationController
    private let configurator: ErrorModuleConfigurator
    
    // MARK: Tooling

    // MARK: - Life cycle
    
    init(
        navigationController: UINavigationController,
        configurator: ErrorModuleConfigurator
    ) {
        self.navigationController = navigationController
        self.configurator = configurator
    }
}

// MARK: - Navigation IN

extension ErrorModuleCoordinator {
    
    func showError(animated: Bool) {
        let viewModel = ErrorModuleViewModel(
            coordinator: self, configurator: configurator
        )
        let viewController = ErrorModuleViewController(viewModel: viewModel)
        let errorNavigationController = UINavigationController(rootViewController: viewController)
        navigationController.present(
            errorNavigationController,
            animated: animated
        )
    }
}

// MARK: - Navigation OUT

extension ErrorModuleCoordinator {

    func dismissError(animated: Bool) {
        navigationController.dismiss(animated: animated)
    }
}
