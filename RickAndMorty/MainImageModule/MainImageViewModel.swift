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
    private let useCase: FavoriteUseCase
    
    // MARK: Tooling
    private let disposeBag = DisposeBag()
    
    // MARK: - Properties
    private var model: ResponseModel

    // MARK: - Life cycle
    
    init(coordinator: MainImageCoordinator,
         configurator: MainImageConfigurator,
         model: ResponseModel
        ) {
        self.coordinator = coordinator
        self.useCase = FavoriteUseCase(interactor: configurator.mainImageInteractor)
        self.model = model
        observeViewEffect()
        addFavoritesToModel()
    }
}

// MARK: - Public functions

extension MainImageViewModel {

    var numberOfModels: Int {
        model.results.count
    }
    
    var selectedIndex: Int {
        model.selectedIndex ?? 0
    }
    
    func modelForIndex(index: Int) -> CharacterModel? {
        model.results[safe: index]
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
                    guard let model = self.modelForIndex(index: index) else {
                        assertionFailure("model is nil")
                        return
                    }
                    self.favoriteChacater(model: model)
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Private functions

private extension MainImageViewModel {
    func favoriteChacater(model: CharacterModel) {
        let status = self.useCase.favoriteCharacter(
            model: model
           )
        switch status {
        case .character(let model):
            self.viewEffect.accept(.character(model))
        }
    }
    
    func addFavoritesToModel() {
        let listOfFavoriteIds = UserDefaultsManager().listOfFavoriteIds
        
        listOfFavoriteIds.forEach { id in
            var character = model.results.first(where: { $0.id == id})
            character?.isFavorite = true
        }
        
        let newModels = model.results.map({ character -> CharacterModel in
            var characterCopy = character
            let somevalue = listOfFavoriteIds.first(where: { $0 == characterCopy.id})
            characterCopy.isFavorite = somevalue != nil
            return characterCopy
        })
        self.model.results = newModels
    }
    
    func updateFavorite(model: CharacterModel) {
        let newModels = self.model.results.map({ character -> CharacterModel in
            if character.id == model.id {
                return model
            }
                return character
            })
        self.model.results = newModels
    }
}

// MARK: - Rx

private extension MainImageViewModel {
    
    /// - Note: Privately observing view effects in the view model is meant to make the association between a specific effect and certain view states easier.
    func observeViewEffect() {
        viewEffect
            .asObservable()
            .subscribe(onNext: { [unowned self] effect in
                switch effect {
                case .character(let model):
                    self.updateFavorite(model: model)
                }
            })
            .disposed(by: disposeBag)
    }
}
