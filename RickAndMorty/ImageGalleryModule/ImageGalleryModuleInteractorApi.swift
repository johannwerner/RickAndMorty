import RxSwift
import RxAlamofire

/// 
/// - Requires: `RxSwift`, `Async`
final class ImageGalleryModuleInteractorApi: ImageGalleryModuleInteractor {
    
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
    
    func favoriteCharacters(ids: [Int]) -> Observable<Async<Any>> {
            RxAlamofire
            .requestJSON(
                .get,
                 url(ids: ids),
                 parameters: nil
            )
            .flatMap { (response, json) -> Observable<Any> in
                Observable.just(json)
            }.async()
    }
}

// MARK: - Private
private extension ImageGalleryModuleInteractorApi {
    func url(ids: [Int]) -> String {
        var url = FavoriteConstants.rickAndMortyApi
        ids.forEach { url.append(contentsOf: String($0)+",") }
        url.removeLast()
        return url
    }
}
