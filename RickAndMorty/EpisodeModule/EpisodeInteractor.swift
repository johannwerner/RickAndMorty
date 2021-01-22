import RxSwift

/// The protocol for EpisodeInteractor
/// - Requires: `RxSwift`
protocol EpisodeInteractor {
    func getModel(url: URL) -> Observable<Async<Any>>
}
