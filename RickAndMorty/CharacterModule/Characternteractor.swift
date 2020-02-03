import RxSwift

/// The protocol for CharacterInteractor
/// - Requires: `RxSwift`
protocol CharacterInteractor {
    func getLocation(url: String) -> Observable<Async<Any>>
}
