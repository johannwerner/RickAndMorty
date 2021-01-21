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
final class EpisodeUseCase {
    
    // MARK: Dependencies
    private let interactor:  EpisodeInteractor
    
    // MARK: - Life cycle
    
    init(interactor: EpisodeInteractor) {
        self.interactor = interactor
    }
}

// MARK: - Public functions

extension EpisodeUseCase {
    func getEpisode(url: URL) -> Observable<EpisodeStatus> {
        interactor.getModel(url: url)
            .map { (result: Async<Any>) -> EpisodeStatus in
                switch result {
                case .loading:
                    return .loading
                case .success(let data):
                    guard let responseModel = EpisodeModel.parse(from: data) else {
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
    func convert() -> [EpisodeModel]? {
        compactMap({ dict -> EpisodeModel? in
            guard let model = EpisodeModel.parse(from: dict) else {
                assertionFailure("parse failed")
                return nil
            }
            return model
            })
    }
}
