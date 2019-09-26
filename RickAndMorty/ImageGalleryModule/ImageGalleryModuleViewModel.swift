import RxCocoa
import RxSwift

/// <#Brief description of the purpose of the view model#>
/// - Requires: `RxSwift`, `MvRx`
/// - Note: A view model can refer to one or more use cases.
class ImageGalleryModuleViewModel {

    // MARK: - Properties
    private var responseModel: ResponseModel

    // MARK: - View Effect
    let viewEffect = PublishRelay<ImageGalleryModuleViewEffect>()
    
    // MARK: Dependencies
    private let coordinator: ImageGalleryModuleCoordinator
    private let useCase: ImageGalleryModuleUseCase
    
    // MARK: Tooling
    private let disposeBag = DisposeBag()

    // MARK: - Life cycle
    
    init(coordinator: ImageGalleryModuleCoordinator,
         configurator: ImageGalleryModuleConfigurator,
         model: ResponseModel
        ) {
        self.coordinator = coordinator
        self.useCase = ImageGalleryModuleUseCase(interactor: configurator.imageGalleryModuleInteractor)
        self.responseModel = model
        
        observeViewEffect()
    }
}

// MARK: - Public functions

extension ImageGalleryModuleViewModel {
    
    var numberOfModels: Int {
        responseModel.results.count
    }
    
    func modelForIndex(index: Int) -> CharacterModel? {
        responseModel.results[safe: index]
    }
    
    func showNextView() {
        useCase.getCharacters(url: responseModel.info.next)
            .subscribe(onNext: { [unowned self] status in
                switch status {
                case .success(let model):
                    self.responseModel.results.append(contentsOf: model.results)
                    self.viewEffect.accept(.success)
                case .loading: break
                case .error: break
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
                    self.coordinator.showLargeImage(
                        model: self.responseModel,
                        animted: true
                    )
                case .loadMore:
                    self.showNextView()
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Private functions

private extension ImageGalleryModuleViewModel {

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
                }
            })
            .disposed(by: disposeBag)
    }
}
