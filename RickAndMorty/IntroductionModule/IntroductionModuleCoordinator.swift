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
        coordinator.showImageGallery(model: model, animated: true)
    }
    
    
}

//private extension ResponseModel {
//    init(introductionResponseModel: ResponseModel) {
//        let results = introductionResponseModel.results.map { character -> CharacterModel in
//            CharacterModel(introductionCharacter: character)
//        }
//        let info = ResponseModel.Info(next: introductionResponseModel.info.next)
//        self.results = results
//        self.info = info
//        self.selectedIndex = nil
//    }
//}
//
//private extension CharacterModel {
//    init(introductionCharacter: ResponseModel.CharacterModel) {
//        self.image = introductionCharacter.image
//        self.isFavorite = false
//        self.id = introductionCharacter.id
//    }
//}

//private extension ResponseModel.Info {
//    init(introductionInfo: ResponseModel.Info) {
//        self.next = introductionInfo.next
//    }
//}
//
//private extension ImageGalleryItem {
//    init(models: [CharacterModel]) {
//        let imageGalleryImages = models.compactMap { character -> ImageGalleryItem.Image? in
//            ImageGalleryItem.Image(url: character.image, id: character.id)
//        }
//        self.images = imageGalleryImages
//    }
//}
//
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
