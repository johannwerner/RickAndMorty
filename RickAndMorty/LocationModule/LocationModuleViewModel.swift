import RxCocoa
import RxSwift

/// 
/// - Requires: `RxSwift`
/// - Note: A view model can refer to one or more use cases.
final class LocationModuleViewModel {

    // MARK: - Properties
    private var locationModel: LocationModel
    private var allCharacters: [CharacterModel]  = []

    // MARK: - View Effect
    let viewEffect = PublishRelay<LocationModuleViewEffect>()
    
    // MARK: Dependencies
    private let coordinator: LocationModuleCoordinator
    private let useCase: LocationModuleUseCase
    
    // MARK: Tooling
    private let disposeBag = DisposeBag()

    // MARK: - Life cycle
    
    init(coordinator: LocationModuleCoordinator,
         configurator: LocationModuleConfigurator,
         model: LocationModel
        ) {
        self.coordinator = coordinator
        self.useCase = LocationModuleUseCase(interactor: configurator.locationModuleInteractor)
        self.locationModel = model
        
        observeViewEffect()
        getCharacaters()
    }
}

// MARK: - Public functions

extension LocationModuleViewModel {
    
    var title: String {
        locationModel.name
    }
    
    var numberOfModels: Int {
        allCharacters.count
    }
    
    func modelForIndex(index: Int) -> CharacterModel? {
        allCharacters[safe: index]
    }

    func bind(to viewAction: PublishRelay<LocationModuleViewAction>) {
//        viewAction
//            .asObservable()
//            .subscribe(onNext: { [unowned self] viewAction in
//            })
//            .disposed(by: disposeBag)
    }
}

// MARK: - Private

private extension LocationModuleViewModel {
    
    func getCharacaters() {
        guard locationModel.residents.isEmpty == false else {
            return
        }
        useCase.getCharacters(locationModel: locationModel).subscribe(onNext: { [unowned self] status in
        switch status {
        case .loading:
            self.viewEffect.accept(.loading)
        case .error:
            self.viewEffect.accept(.error)
        case .success(let response):
            self.allCharacters = response
            self.viewEffect.accept(.success)
            }
        }).disposed(by: disposeBag)
    }
}

// MARK: - Rx

private extension LocationModuleViewModel {
    
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
