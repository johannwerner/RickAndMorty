import UIKit
import RxCocoa
import RxSwift

/// Handles the navigation in and out of MainImageCoordinator
/// - Requires: `RxSwift`
final class MainImageCoordinator {

    // MARK: Dependencies
    private let navigationController: UINavigationController
    private let configurator: MainImageConfigurator
    
    // MARK: Tooling
    private let disposeBag = DisposeBag()

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
    
    func showLargeImage(model: MainImageModel, animated: Bool) {
       showLargeImageImplementation(model: model, animated: animated)
    }
}

private extension MainImageCoordinator {
    func showLargeImageImplementation(model: MainImageModel, animated: Bool) {
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

extension MainImageCoordinator {}
