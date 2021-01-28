import RxCocoa
import RxSwift

///
/// - Requires: `RxSwift`
/// - Note: A view model can refer to one or more use cases.
final class ErrorModuleViewModel {

    // MARK: ViewEffect
    let viewEffect = PublishRelay<ErrorModuleViewEffect>()
    
    // MARK: Dependencies
    private let coordinator: ErrorModuleCoordinator
    private let useCase: ErrorModuleUseCase
    
    // MARK: Tooling
    private let disposeBag = DisposeBag()

    // MARK: - Life cycle
    
    init(coordinator: ErrorModuleCoordinator,
         configurator: ErrorModuleConfigurator) {
        self.coordinator = coordinator
        self.useCase = ErrorModuleUseCase(interactor: configurator.errorModuleInteractor)
        
        observeViewEffect()
    }
}

// MARK: - Public functions

extension ErrorModuleViewModel {
    
    func bind(to viewAction: PublishRelay<ErrorModuleViewAction>) {
        viewAction
            .asObservable()
            .subscribe(onNext: { [unowned self] viewAction in
                switch viewAction {
                case .primaryButtonPressed:
                self.coordinator.dismissError(animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Private functions

private extension ErrorModuleViewModel {

}

// MARK: - Rx

private extension ErrorModuleViewModel {
    
    /// - Note: Privately observing view effects in the view model is meant to make the association between a specific effect and certain view states easier.
    private func observeViewEffect() {
        viewEffect
            .asObservable()
            .subscribe(onNext: { effect in
                switch effect {
                case .someEffect: break
                }
            })
            .disposed(by: disposeBag)
    }
}
