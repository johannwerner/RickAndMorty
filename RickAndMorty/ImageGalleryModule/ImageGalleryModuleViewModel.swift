import RxCocoa
import RxSwift

/// 
/// - Requires: `RxSwift`, `MvRx`
/// - Note: A view model can refer to one or more use cases.
final class ImageGalleryModuleViewModel {

    // MARK: - Properties
    var isShowingFavorites = false
    private var responseModel: ResponseModel
    private var favorites: [CharacterModel] = []
    private var allCharacters: [CharacterModel] {
        responseModel.results
    }

    // MARK: - View Effect
    let viewEffect = PublishRelay<ImageGalleryModuleViewEffect>()
    
    // MARK: Dependencies
    private let coordinator: ImageGalleryModuleCoordinator
    private let useCase: ImageGalleryModuleUseCase
    private let favoriteUseCase: ImageGalleryFavoriteUseCase
    
    // MARK: Tooling
    private let disposeBag = DisposeBag()

    // MARK: - Life cycle
    
    init(coordinator: ImageGalleryModuleCoordinator,
         configurator: ImageGalleryModuleConfigurator,
         model: ResponseModel
        ) {
        self.coordinator = coordinator
        self.useCase = ImageGalleryModuleUseCase(interactor: configurator.imageGalleryModuleInteractor)
        self.favoriteUseCase = ImageGalleryFavoriteUseCase(interactor:  configurator.imageGalleryModuleInteractor)
        self.responseModel = model
        
        observeViewEffect()
    }
}

// MARK: - Public functions

extension ImageGalleryModuleViewModel {
    
    var numberOfModels: Int {
        results.count
    }
    
    var favoritesButtonText: String {
        isShowingFavorites ? hideFavoritesText: showFavoritesText
    }
    
    func modelForIndex(index: Int) -> CharacterModel? {
        results[safe: index]
    }
    
    func showNextView() {
        useCase.getCharacters(url: responseModel.info.next)
            .subscribe(onNext: { [unowned self] status in
                switch status {
                case .success(let model):
                    self.responseModel.results.append(contentsOf: model.results)
                    self.responseModel.info = model.info
                    self.viewEffect.accept(.success)
                case .loading:
                    self.viewEffect.accept(.loading)
                case .error:
                    self.viewEffect.accept(.error)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func showFavorites() {
        if listOfIds.isEmpty == true {
            favorites = []
            viewEffect.accept(.success)
            return
        }
        favoriteUseCase.getFavoriteCharacters()
            .subscribe(onNext: { [unowned self] status in
                switch status {
                case .success(let models):
                    self.favorites = models
                    self.isShowingFavorites = true
                    self.viewEffect.accept(.success)
                case .loading:
                    self.viewEffect.accept(.loading)
                case .error:
                    self.viewEffect.accept(.error)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func bind(to viewAction: PublishRelay<ImageGalleryModuleViewAction>) {
        viewAction
            .asObservable()
            .subscribe(onNext: { [unowned self] viewAction in
                switch viewAction {
                case .selectedIndex(let index):
                    self.responseModel.selectedIndex = index
                    self.responseModel.results = self.results
                    self.coordinator.showLargeImage(
                        model: self.responseModel,
                        animted: true
                    )
                case .loadMore:
                    if self.isShowingFavorites == false {
                        self.showNextView()
                    }
                case .showFavorites:
                    self.shouldShowFavorites()
                    self.isShowingFavorites = !self.isShowingFavorites
                    self.viewEffect.accept(.success)
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Private

private extension ImageGalleryModuleViewModel {
    var results: [CharacterModel] {
        isShowingFavorites ? favorites : allCharacters
    }
    
    var listOfIds: [Int] {
        UserDefaultsManager().listOfFavoriteIds
    }
    
    var showFavoritesText: String {
        "image_gallery_model_show_favorites".localizedString()
    }
    
    var hideFavoritesText: String {
        "image_gallery_model_hide_favorites".localizedString()
    }
    
    func shouldShowFavorites() {
        if isShowingFavorites == false {
            self.showFavorites()
        }
    }
}

// MARK: - Rx

private extension ImageGalleryModuleViewModel {
    
    /// - Note: Privately observing view effects in the view model is meant to make the association between a specific effect and certain view states easier.
    func observeViewEffect() {
        viewEffect
            .asObservable()
            .subscribe(onNext: { effect in
                switch effect {
                case .success: break
                case .loading: break
                case .error:
                    self.coordinator.showError(animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}
