import RxCocoa
import RxSwift

/// Contains the use cases for Main Image View
/// - Requires: `RxSwift`
/// - Note: A view model can refer to one or more use cases.
final class MainImageViewModel {

    // MARK: MvRx
    let viewEffect = PublishRelay<MainImageViewEffect>()
    
    // MARK: Dependencies
    private let coordinator: MainImageCoordinator
    private let useCase: MainImageUseCase
    
    // MARK: Tooling
    private let disposeBag = DisposeBag()
    
    // MARK: - Properties
    private var model: MainImageModel

    // MARK: - Life cycle
    
    init(coordinator: MainImageCoordinator,
         configurator: MainImageConfigurator,
         model: MainImageModel
        ) {
        self.coordinator = coordinator
        self.useCase = MainImageUseCase(interactor: configurator.mainImageInteractor)
        self.model = model
        observeViewEffect()
        addFavoritesToModel()
    }
}

// MARK: - Public functions

extension MainImageViewModel {

    var numberOfModels: Int {
        model.models.count
    }
    
    var selectedIndex: Int {
        model.selectedIndex
    }
    
    func modelForIndex(index: Int) -> MainImageModel.ImageModel? {
        model.models[safe: index]
    }
    
    func favoriteButtonText(index: Int) -> String {
        let model = modelForIndex(index: index)
        return model?.isFavorite == true ? "Unfavorite": "Favorite"
    }
    
    func bind(to viewAction: PublishRelay<MainImageViewAction>) {
                viewAction
            .asObservable()
            .subscribe(onNext: { [unowned self] viewAction in
                switch viewAction {
                case .favoriteIndex(let index):
                    guard var model = self.modelForIndex(index: index) else {
                        assertionFailure("model is nil")
                        return
                    }
                    self.favoriteChacater(model: &model)
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Private functions

private extension MainImageViewModel {
    func favoriteChacater(model: inout MainImageModel.ImageModel) {
        self.useCase.favoriteCharacter(
            model: &model
           )
        .subscribe(onNext: { [unowned self] status in
            switch status {
            case .character(let model):
            self.viewEffect.accept(.character(model))
                }
            })
            .disposed(by: disposeBag)
    }
    
    func addFavoritesToModel() {
        let listOfFavoriteIds = UserDefaultsManager().listOfFavoriteIds
        
        listOfFavoriteIds.forEach { id in
            var character = model.models.first(where: { $0.id == id})
            character?.isFavorite = true
        }
        
        let newModels = model.models.map({ character -> MainImageModel.ImageModel in
            var characterCopy = character
            let somevalue = listOfFavoriteIds.first(where: { $0 == characterCopy.id})
            characterCopy.isFavorite = somevalue != nil
            return characterCopy
        })
        self.model.models = newModels
    }
}

// MARK: - Rx

private extension MainImageViewModel {
    
    /// - Note: Privately observing view effects in the view model is meant to make the association between a specific effect and certain view states easier.
    func observeViewEffect() {
        viewEffect
            .asObservable()
            .subscribe(onNext: { effect in
                switch effect {
                case .character:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}
