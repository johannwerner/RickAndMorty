import UIKit

/// Entry point into app to introduce the app
/// - Requires: `UIKit`
final class IntroductionModuleCoordinator {

    // MARK: Dependencies
    private let navigationController: UINavigationController
    private let configurator:  IntroductionModuleConfigurator
    
    // MARK: Tooling

    // MARK: - Life cycle
    
    init(
        navigationController: UINavigationController,
        configurator:  IntroductionModuleConfigurator
        ) {
        self.navigationController = navigationController
        self.configurator = configurator
    }
}

// MARK: - Navigation IN

extension  IntroductionModuleCoordinator {
    
    func showIntroduction(animated: Bool) {
        let viewModel = IntroductionModuleViewModel(
            coordinator: self,
            configurator: configurator
        )
        let viewController =  IntroductionModuleViewController(viewModel: viewModel)
        navigationController.pushViewController(
            viewController,
            animated: animated
        )
    }
}

// MARK: - Navigation OUT

extension  IntroductionModuleCoordinator {

    func showCharacterList(model: ResponseModel, animated: Bool) {
            let interactor = ImageGalleryModuleInteractorApi()
            let configurator = ImageGalleryModuleConfigurator(imageGalleryModuleInteractor: interactor)
            let coordinator = ImageGalleryModuleCoordinator(navigationController: navigationController, configurator: configurator)
            coordinator.showImageGallery(
                model: model,
                animated: true
            )
    }
    
    
}

// MARK: - Navigation to Error View

extension IntroductionModuleCoordinator {
    func showError(
        animated: Bool
    ) {
        let configurator = ErrorModuleConfigurator(errorModuleInteractor: ErrorModuleInteractorApi())
        let coordinator = ErrorModuleCoordinator(navigationController: navigationController, configurator: configurator)
        coordinator.showError(animated: animated)
    }
}
