import RxSwift
import RxAlamofire

/// <#Brief description of the purpose of the interactor implementation#>
/// - Requires: `RxSwift`, `Async`
class ImageGalleryModuleInteractorApi: ImageGalleryModuleInteractor {
    
    // MARK: Dependencies
    
    // MARK: - Life cycle

    
}

// MARK: - Internal
extension ImageGalleryModuleInteractorApi {
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
