import RxSwift

/// The protocol for CharacterInteractor
/// - Requires: `RxSwift`
protocol CharacterInteractor {
    func getCharacters(url: String) -> Observable<Async<Any>>
}
