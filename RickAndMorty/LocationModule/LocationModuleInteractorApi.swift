import RxSwift
import RxAlamofire

/// 
/// - Requires: `RxSwift`, `Async`
final class LocationModuleInteractorApi: LocationModuleInteractor {
    
    
    // MARK: Dependencies
    
    // MARK: - Life cycle
}

// MARK: - Internal
extension LocationModuleInteractorApi {
    func getCharacters(url: String) -> Observable<Async<Any>> {
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

// MARK: - Private
private extension LocationModuleInteractorApi {}
