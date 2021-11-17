import RxSwift

/// The protocol for CharacterInteractor
/// - Requires: `RxSwift`
protocol CharacterInteractor {
    func getModel(url: URL) -> Observable<Async<Any>>
}
