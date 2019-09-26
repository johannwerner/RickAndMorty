import RxCocoa
import RxSwift

final class MainImageConfigurator {
    
    // MARK: Dependencies
    
    let mainImageInteractor: MainImageInteractor
    
    init(mainImageInteractor: MainImageInteractor) {
        self.mainImageInteractor = mainImageInteractor
    }
}
