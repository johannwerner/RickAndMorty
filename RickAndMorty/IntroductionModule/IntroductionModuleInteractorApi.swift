import RxSwift
import RxAlamofire
///
/// - Requires:
final class IntroductionModuleInteractorApi: IntroductionModuleInteractor {}

extension IntroductionModuleInteractorApi {
    // MARK: - Internal
    
    func getCharacters() -> Observable<Async<Any>> {
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

private extension IntroductionModuleInteractorApi {
    var url: String {
        "https://rickandmortyapi.com/api/character/"
    }
}

