import RxCocoa
import RxSwift

/// Contains the use cases for Main Image View
/// - Requires: `RxSwift`
/// - Note: A view model can refer to one or more use cases.
final class CharacterViewModel {

    // MARK: ViewEffect
    let viewEffect = PublishRelay<CharacterViewEffect>()
    
    // MARK: Dependencies
    private let coordinator: CharacterCoordinator
    private let useCase: GetResidentsUseCase
    
    // MARK: Tooling
    private let disposeBag = DisposeBag()
    
    // MARK: - Properties
    private var model: ResponseModel
    private var dataSourceArray: [CharacterEnum] = []
    
    private func originIsUnknown(location: CharacterModel.Location) -> Bool {
        location.url.isEmpty == true
    }
    
    enum OriginStatus {
        case unkown
        case noResidents
        case residents
    }

    // MARK: - Life cycle
    
    init(coordinator: CharacterCoordinator,
         configurator: CharacterConfigurator,
         model: ResponseModel
        ) {
        self.coordinator = coordinator
        self.useCase = GetResidentsUseCase(interactor: configurator.mainImageInteractor)
        self.model = model
        observeViewEffect()
        setUpDataSourceArray()
    }
}

// MARK: - Public functions

extension CharacterViewModel {
    
    var tableViewCount: Int {
        dataSourceArray.count
    }

    var selectedIndex: Int {
        model.selectedIndex ?? 0
    }
    
    var character: CharacterModel {
        model.results[selectedIndex]
    }
    
    func typeForIndex(index: Int) -> CharacterEnum {
        dataSourceArray[index]
    }

    func bind(to viewAction: PublishRelay<CharacterViewAction>) {
                viewAction
            .asObservable()
            .subscribe(onNext: { viewAction in
                switch viewAction {
                case .favoriteIndex: break
                }
            })
            .disposed(by: disposeBag)
    }
    
    func showLocation(location: CharacterModel.Location) {
        guard originIsUnknown(location: location) == false else {
            return
        }
        useCase.getLocation(url: location.url).subscribe(onNext: { [unowned self] status in
            switch status {
            case .loading:
                self.viewEffect.accept(.loading)
            case .error:
                self.viewEffect.accept(.error)
            case .success(let response):
                self.viewEffect.accept(.success)
                self.coordinator.showLocation(
                    model: response,
                    animated: true
                )
            }
            }).disposed(by: disposeBag)
    }
}

// MARK: - Private functions

private extension CharacterViewModel {
    func setUpDataSourceArray() {
        dataSourceArray.append(CharacterEnum.mainImage(character.imageUrlToShow))
        if originIsUnknown(location: character.origin) == true {
            dataSourceArray.append(CharacterEnum.text("Origin: Uknown"))
        } else {
            dataSourceArray.append(CharacterEnum.location(location: character.origin, name: "Origin"))
        }
        dataSourceArray.append(CharacterEnum.text("Species \(character.species)"))
        dataSourceArray.append(CharacterEnum.text("Gender \(character.gender)"))
        dataSourceArray.append(CharacterEnum.text("Status \(character.status)"))
        
        dataSourceArray.append(CharacterEnum.location(location: character.location, name: "Last Known Location"))
    }
}

// MARK: - Rx

private extension CharacterViewModel {
    
    /// - Note: Privately observing view effects in the view model is meant to make the association between a specific effect and certain view states easier.
    func observeViewEffect() {
        viewEffect
            .asObservable()
            .subscribe(onNext: { effect in
                switch effect {
                case .success: break
                case .loading: break
                case .error: break
                }
            })
            .disposed(by: disposeBag)
    }
}

extension CharacterViewModel {
    enum CharacterEnum {
        case mainImage(URL)
        case location(location: CharacterModel.Location, name: String)
        case text(String)
//        case images([URL])
    }
 
}
