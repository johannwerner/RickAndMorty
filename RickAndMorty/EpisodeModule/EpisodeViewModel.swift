import RxCocoa
import RxSwift

/// Contains the use cases for Main Image View
/// - Requires: `RxSwift`
/// - Note: A view model can refer to one or more use cases.


final class EpisodeViewModel {

    // MARK: ViewEffect
    let viewEffect = PublishRelay<EpisodeViewEffect>()
    
    // MARK: Dependencies
    private let coordinator: EpisodeCoordinator
    private let useCase: EpisodeUseCase
    
    // MARK: Tooling
    private let disposeBag = DisposeBag()
    
    // MARK: - Properties
    private var url: URL
    private var dataSourceArray: [EpisodeEnum] = []
    private var episodeModel: EpisodeModel?

    // MARK: - Life cycle
    
    init(coordinator: EpisodeCoordinator,
         configurator: EpisodeConfigurator,
         url: URL
        ) {
        self.coordinator = coordinator
        self.useCase = EpisodeUseCase(interactor: configurator.mainImageInteractor)
        self.url = url
        observeViewEffect()
        getEpisode()
    }
}

// MARK: - Public functions

extension EpisodeViewModel {
    
    var title: String? {
        episodeModel?.name
    }
    
    var tableViewCount: Int {
        dataSourceArray.count
    }
    
    func typeForIndex(index: Int) -> EpisodeEnum {
        dataSourceArray[index]
    }

    func bind(to viewAction: PublishRelay<EpisodeViewAction>) {
                viewAction
            .asObservable()
            .subscribe(onNext: { viewAction in
                switch viewAction {
                case .favoriteIndex: break
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Private functions

private extension EpisodeViewModel {
    
    func getEpisode() {
        useCase.getEpisode(url: url).subscribe(onNext: { [unowned self]status in
            switch status {
            case .loading:
                self.viewEffect.accept(.loading)
            case .error:
                self.viewEffect.accept(.error)
            case .success(let episodeModel):
                self.episodeModel = episodeModel
                self.viewEffect.accept(.success)
            }
        }).disposed(by: disposeBag)
    }
}

// MARK: - Rx

private extension EpisodeViewModel {
    
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

extension EpisodeViewModel {
    enum EpisodeEnum {
        case images([URL])
    }

}

