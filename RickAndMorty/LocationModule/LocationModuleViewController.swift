import RxSwift
import RxCocoa
import PureLayout

/// 
/// - Requires: `RxSwift`
final class LocationModuleViewController: AppViewController {
    
    // MARK: Dependencies
    private let viewModel: LocationModuleViewModel
    
    // MARK: Rx
    private let viewAction = PublishRelay<LocationModuleViewAction>()
    
    // MARK: View components
    private let primaryButton = UIButton()
    private let collectionView: UICollectionView
    
    // MARK: Tooling
    private let disposeBag = DisposeBag()

    // MARK: - Life cycle
    
    init(viewModel: LocationModuleViewModel) {
        self.viewModel = viewModel
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = 0
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }

    override func loadView() {
        view = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        setUpBinding()
        
        observeViewEffect()
    }
}

// MARK: - Setup

private extension LocationModuleViewController {

    /// Initializes and configures components in controller.
    func setUpViews() {
        view.backgroundColor = .systemBackground
        title = viewModel.title
        
        setUpCollectionView()
    }

    
    func setUpCollectionView() {
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            MainImageCollectionViewCell.self,
            forCellWithReuseIdentifier: MainImageCollectionViewCell.reuseId
        )
    }
    
    /// Binds controller user events to view model.
    func setUpBinding() {
        viewModel.bind(to: viewAction)
    }
}

// MARK: - Rx

private extension LocationModuleViewController {

    /// Starts observing view effects to react accordingly.
    func observeViewEffect() {
        viewModel
            .viewEffect
            .subscribe(onNext: { [unowned self] effect in
                switch effect {
                case .success:
                    self.collectionView.reloadData()
                    self.activityView.hideView()
                case .loading:
                    self.activityView.showView()
                case .error:
                    self.activityView.hideView()
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - CollectionView
extension LocationModuleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfModels
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainImageCollectionViewCell.reuseId, for: indexPath)
            guard let model = viewModel.modelForIndex(index: indexPath.row) else {
                assertionFailure("model is nil")
                return cell
            }
            guard let imageGalleryCell = cell as? MainImageCollectionViewCell else {
                assertionFailure("cell is not type imageGalleryCell")
                return cell
            }
            imageGalleryCell.fill(with: model)
            return imageGalleryCell
        }
}

extension LocationModuleViewController: UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(
            width: collectionView.frame.size.width / 3,
            height: 200
        )
    }
}
