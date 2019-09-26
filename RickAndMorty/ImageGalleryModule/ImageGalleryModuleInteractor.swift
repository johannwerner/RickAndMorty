import RxSwift

/// <#Brief description of the purpose of the interactor#>
/// - Requires: `RxSwift`
protocol ImageGalleryModuleInteractor {
    func getCharacters(url: String) -> Observable<Async<Any>>
    func favoriteCharacters(ids: [Int]) -> Observable<Async<Any>>
}
