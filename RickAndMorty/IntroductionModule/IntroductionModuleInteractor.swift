import RxSwift
protocol IntroductionModuleInteractor {
    func getCharacters() -> Observable<Async<Any>> 
}
