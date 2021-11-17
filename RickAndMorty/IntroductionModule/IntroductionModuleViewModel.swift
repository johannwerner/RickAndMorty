import RxCocoa
import RxSwift

///
/// - Requires: `RxSwift`, `RxCocoa`
/// - Note: A view model can refer to one or more use cases.

final class IntroductionModuleViewModel {

    // MARK: ViewEffect
    let viewEffect = PublishRelay< IntroductionModuleViewEffect>()
    
    // MARK: Dependencies
    private let coordinator: IntroductionModuleCoordinator
    private let useCase: IntroductionModuleUseCase
    
    // MARK: Tooling
    private let disposeBag = DisposeBag()

    // MARK: - Life cycle
    
    init(
        coordinator: IntroductionModuleCoordinator,
        configurator: IntroductionModuleConfigurator
        ) {
        self.coordinator = coordinator
        self.useCase =  IntroductionModuleUseCase(interactor: configurator.introductionModuleInteractor)
        
        observeViewEffect()
    }
}

// MARK: - Public functions

extension IntroductionModuleViewModel {
    
    func bind(to viewAction: PublishRelay< IntroductionModuleViewAction>) {
        viewAction
            .asObservable()
            .subscribe(onNext: { [unowned self] viewAction in
                switch viewAction {
                case .primaryButtonPressed:
                    self.showNextView()
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Private functions

private extension IntroductionModuleViewModel {
    func showNextView() {
        getCharacters()
    }
    
    func getCharacters() {
        useCase.getCharacters()
            .subscribe(onNext: { [unowned self] status in
                switch status {
                case .loading:
                    self.viewEffect.accept(.loading)
                case .error:
                    self.viewEffect.accept(.error)
                    self.coordinator.showError(animated: true)
                case .success(let model):
                    self.viewEffect.accept(.success)
                    self.coordinator.showCharacterList(
                        model: model,
                        animated: true
                    )
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Rx

private extension IntroductionModuleViewModel {
    
    /// - Note: Privately observing view effects in the view model is meant to make the association between a specific effect and certain view states easier.
    func observeViewEffect() {
        viewEffect
            .asObservable()
            .subscribe(onNext: { effect in
                switch effect {
                case .success: break
                case .loading: break
                case   .error: break
                }
            })
            .disposed(by: disposeBag)
    }
}
