import RxSwift
import RxAlamofire

/// Currently does nothing but exists for future use
/// - Requires: `RxSwift`, `Async`
final class CharacterInteractorApi: CharacterInteractor {
    // MARK: - Internal
    
    func getLocation(url: String) -> Observable<Async<Any>> {
            RxAlamofire
                .requestJSON(
                    .get,
                     url,
                     parameters: nil
                )
                .flatMap { (response, json) -> Observable<Any> in
                    Observable.just(json)
                }.async()
        }
}
