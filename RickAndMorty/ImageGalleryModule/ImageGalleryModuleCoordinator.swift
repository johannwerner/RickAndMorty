import UIKit
import RxCocoa
import RxSwift

///
/// - Requires: `RxSwift`
final class ImageGalleryModuleCoordinator {

    // MARK: Dependencies
    private let navigationController: UINavigationController
    private let configurator: ImageGalleryModuleConfigurator
    
    // MARK: Tooling
    private let disposeBag = DisposeBag()

    // MARK: - Life cycle
    
    init(
        navigationController: UINavigationController,
        configurator: ImageGalleryModuleConfigurator
        ) {
        self.navigationController = navigationController
        self.configurator = configurator
    }
}

// MARK: - Navigation IN

extension ImageGalleryModuleCoordinator {
    
    func showImageGallery(model: ResponseModel, animated: Bool) {
        let viewModel = ImageGalleryModuleViewModel(
            coordinator: self,
            configurator: configurator,
            model: model
        )
        let viewController = ImageGalleryModuleViewController(viewModel: viewModel)
        navigationController.pushViewController(
            viewController,
            animated: animated
        )
    }
}

// MARK: - Navigation OUT

// MARK: - MainImageModel Dependancy

extension ImageGalleryModuleCoordinator {
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

extension ImageGalleryModuleCoordinator {
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
