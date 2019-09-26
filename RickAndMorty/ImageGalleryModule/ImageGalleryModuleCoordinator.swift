import UIKit
import RxCocoa
import RxSwift

/// <#Brief description of the purpose of the coordinator#>
/// - Requires: `RxSwift`
class ImageGalleryModuleCoordinator {

    // MARK: Dependencies
    private let navigationController: UINavigationController
    private let configurator: ImageGalleryModuleConfigurator
    
    // MARK: - Properties
    fileprivate let listOfFavoriteIds = UserDefaultsManager().listOfFavoriteIds
    
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
    
    func showImageGallery(model: ImageGalleryItem, animated: Bool) {
        let viewModel = ImageGalleryModuleViewModel(
            coordinator: self,
            configurator: configurator,
            model: ImageGalleryModuleModel(imageGalleryItem: model)
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
        imageGalleryModuleModel: ImageGalleryModuleModel,
        animted: Bool
        ) {
        let model = MainImageModel(
            model: imageGalleryModuleModel
        )
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

private extension MainImageModel {
    init(model: ImageGalleryModuleModel) {
        assert(model.selectedIndex != nil)
        let mainImageModels = model.imageGalleryItem.images.compactMap { imageGalleryItem -> MainImageModel.ImageModel? in
            MainImageModel.ImageModel(imageGalleryItemImage: imageGalleryItem)
        }
        self.selectedIndex = model.selectedIndex ?? 0
        self.models = mainImageModels
    }
}

private extension MainImageModel.ImageModel {
    init(imageGalleryItemImage: ImageGalleryItem.Image) {
        self = MainImageModel.ImageModel(
            url: imageGalleryItemImage.url,
            id: imageGalleryItemImage.id,
            isFavorite: false
        )
    }
}
