import UIKit

/// Handles the navigation in and out of CharacterCoordinator
/// - Requires: ``
final class CharacterCoordinator {

    // MARK: Dependencies
    private let navigationController: UINavigationController
    private let configurator: CharacterConfigurator

    // MARK: - Life cycle
    
    init(
        navigationController: UINavigationController,
        configurator: CharacterConfigurator
        ) {
        self.navigationController = navigationController
        self.configurator = configurator
    }
}

// MARK: - Navigation IN

extension CharacterCoordinator {
    
    func showCharcterVier(animated: Bool, model: ResponseModel) {
           let viewModel = CharacterViewModel(
               coordinator: self,
               configurator: configurator,
               model: model
           )
           let viewController = CharacterViewController(viewModel: viewModel)
           navigationController.pushViewController(
               viewController,
               animated: animated
           )
    }
}

// MARK: - Navigation OUT

extension CharacterCoordinator {
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
