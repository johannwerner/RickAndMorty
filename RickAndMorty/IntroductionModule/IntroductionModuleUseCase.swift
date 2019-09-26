import RxSwift
/// An introduction to the app
/// - Requires:
final class IntroductionModuleUseCase {
    
    // MARK: Dependencies
    private let interactor:  IntroductionModuleInteractor
    
    // MARK: - Life cycle
    
    init(interactor:  IntroductionModuleInteractor) {
        self.interactor = interactor
    }
}

// MARK: - Public functions

extension IntroductionModuleUseCase {    
    func getCharacters() -> Observable<IntroductionModuleStatus> {
        interactor.getCharacters()
            .map { (result: Async<Any>) -> IntroductionModuleStatus in
                switch result {
                case .loading:
                    return .loading
                case .success(let data):
                    guard let imageData = data as? Dictionary<String, Any> else {
                         return.error
                     }
                    guard let listOfArray = imageData["results"] as? Array<Dictionary<String, Any>> else {
                        return .error
                    }
                    let listOfModels = listOfArray.compactMap({ dictionary -> CharacterModel? in
                        let imageGalleryModel = CharacterModel.parse(from: dictionary)
                        return imageGalleryModel
                    })
                    return .success(listOfModels)
                case .error:
                    return .error
                }
        }
    }
}

private extension Array where Iterator.Element == Dictionary<String, Any> {
    func convert() -> [CharacterModel]? {
        compactMap({ dict -> CharacterModel? in
            guard let model = CharacterModel.parse(from: dict) else {
                assertionFailure("parse failed")
                return nil
            }
            //Code in IntroductionModuleCoordinator relies on bounds never having an empty array <1>
            return model
            })
    }
}
