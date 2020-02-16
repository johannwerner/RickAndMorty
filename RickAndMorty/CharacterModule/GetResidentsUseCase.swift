//
//  GetResidentsUseCase.swift
//  RickAndMorty
//
//  Created by Johann Werner on 02.02.20.
//  Copyright © 2020 Johann Werner. All rights reserved.
//

import RxSwift
/// An introduction to the app
/// - Requires:
final class GetResidentsUseCase {
    
    // MARK: Dependencies
    private let interactor:  CharacterInteractor
    
    // MARK: - Life cycle
    
    init(interactor:  CharacterInteractor) {
        self.interactor = interactor
    }
}

// MARK: - Public functions

extension GetResidentsUseCase {
    func getLocation(url: String) -> Observable<CharacterStatus> {
        interactor.getLocation(url: url)
            .map { (result: Async<Any>) -> CharacterStatus in
                switch result {
                case .loading:
                    return .loading
                case .success(let data):
                    guard let responseModel = LocationModel.parse(from: data) else {
                        return .error
                    }   
                    return .success(responseModel)
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
            return model
            })
    }
}
