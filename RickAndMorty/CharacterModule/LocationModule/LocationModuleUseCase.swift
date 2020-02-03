import RxSwift

///
/// - Requires: `RxSwift`, `Async`
class LocationModuleUseCase {
    
    // MARK: Dependencies
    private let interactor: LocationModuleInteractor
    
    // MARK: - Life cycle
    
    init(interactor: LocationModuleInteractor) {
        self.interactor = interactor
    }
}

// MARK: - Public functions

extension LocationModuleUseCase {
    
    func getCharacters(locationModel: LocationModel) -> Observable<LocationModuleStatus> {

        interactor.getCharacters(url: url(locationModel: locationModel))
            .map { (result: Async<Any>) -> LocationModuleStatus in
                switch result {
                case .loading:
                    return .loading
                case .success(let data):
                    guard let listOfArray = data as? Array<Dictionary<String, Any>>  else {
                        guard let character = CharacterModel.parse(from: data) else {
                            return .error
                        }
                        return .success([character])
                    }
                    
                    let listOfCharcters = listOfArray.compactMap({ dict -> CharacterModel? in
                            CharacterModel.parse(from: dict)
                    })
                    return .success(listOfCharcters)
                case .error:
                    return .error
                }
        }
    }
}

private extension LocationModuleUseCase {
    func url(locationModel: LocationModel) -> String {
        let array = locationModel.residents.compactMap { url -> Character? in
            url.last
        }
        let substring = array.reduce("https://rickandmortyapi.com/api/character/") { (result, character) -> Substring in
            "\(result)\(character),"
        }
        
        let index = substring.index(substring.endIndex, offsetBy: -1)

        return String(substring[..<index])
    }
}
