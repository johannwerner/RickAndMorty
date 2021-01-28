import RxSwift

/// 
/// - Requires: `RxSwift`
protocol LocationModuleInteractor {
    func getCharacters(url: String) -> Observable<Async<Any>>
}
