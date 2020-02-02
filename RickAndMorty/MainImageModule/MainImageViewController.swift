import RxSwift
import RxCocoa

/// Contains a collection view of main images and displays the selected image
/// - Requires: `RxSwift`
final class MainImageViewController: UIViewController {
    
// MARK: Dependencies
    private let viewModel: MainImageViewModel
    
// MARK: Rx
    private let viewAction = PublishRelay<MainImageViewAction>()
    
// MARK: View components
    private let collectionView: UICollectionView
    private let showMoreButton: UIButton
    
// MARK: Tooling
    private let disposeBag = DisposeBag()

// MARK: - Life cycle
    
    init(viewModel: MainImageViewModel) {
        self.viewModel = viewModel
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        
        showMoreButton = UIButton(type: .custom)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollToItem(index: viewModel.selectedIndex)
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

private extension MainImageViewController {

    /// Initializes and configures components in controller.
    func setUpViews() {
        view.addSubview(collectionView)
        view.addSubview(showMoreButton)
        
        setUpNavigationBar()
        setUpCollectionView()
        setUpShowMoreButton()
    }
    
    func setUpNavigationBar() {
        let favoriteButton = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(favorite))
        self.navigationItem.rightBarButtonItem  = favoriteButton
    }
    
    func setUpCollectionView() {
        
        collectionView.autoPinEdge(toSuperviewEdge: .leading)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing)
        collectionView.autoAlignAxis(toSuperviewAxis: .horizontal)
        collectionView.autoSetDimension(.height, toSize: 400)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.register(MainImageCollectionViewCell.self, forCellWithReuseIdentifier: MainImageCollectionViewCell.reuseId)
              
        collectionView.isHidden = true
    }
    
    func setUpShowMoreButton() {
        showMoreButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        showMoreButton.autoAlignAxis(toSuperviewAxis: .vertical)
        
        showMoreButton.setTitle("Show more", for: .normal)
        showMoreButton.setTitleColor(.systemBlue, for: .normal)
        showMoreButton.rx.tap.subscribe({ [unowned self] _ in
            self.viewAction.accept(.showMorePressed(self.selectedIndex))
        })
        .disposed(by: disposeBag)
    }
    
    /// Binds controller user events to view model.
    func setUpBinding() {
        viewModel.bind(to: viewAction)
    }
}

// MARK: - Private

private extension MainImageViewController {
    
    var selectedIndex: Int {
        guard let indexPath = collectionView.indexPathsForVisibleItems.first else {
            assertionFailure("no index paths visible")
            return 0
        }
        return indexPath.row
    }
    
    func scrollToItem(index: Int) {
        collectionView.isHidden = false
        let selectedIndexPath = IndexPath(
            item: index,
            section: 0
        )
        collectionView.scrollToItem(
            at: selectedIndexPath,
            at: .centeredHorizontally,
            animated: true
        )
    }
    
    @objc func favorite() {
        viewAction.accept(.favoriteIndex(selectedIndex))
    }
    
}

// MARK: - Rx

private extension MainImageViewController {

    /// Starts observing view effects to react accordingly.
    func observeViewEffect() {
        viewModel
            .viewEffect
            .subscribe(onNext: { effect in
                switch effect {
                case .character(let model):
                    let isFavorite = model.isFavorite
                    let favoriteText = "main_image_model_favorite".localizedString()
                    let unfavoriteText = "main_image_model_unfavorite".localizedString()
                    self.navigationItem.rightBarButtonItem?.title = isFavorite ? unfavoriteText: favoriteText
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - CollectionView
extension MainImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfModels
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainImageCollectionViewCell.reuseId, for: indexPath)
            guard let model = viewModel.modelForIndex(index: indexPath.row) else {
                assertionFailure("model is nil")
                return cell
            }
            guard let mainImageCell = cell as? MainImageCollectionViewCell else {
                assertionFailure("cell is not type MainImageCollectionViewCell")
                return cell
            }
            mainImageCell.fill(with: model)
            return mainImageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.navigationItem.rightBarButtonItem?.title = viewModel.favoriteButtonText(index: indexPath.row)
        let model = viewModel.modelForIndex(index: indexPath.row)
        title = model?.name
    }
}

extension MainImageViewController: UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: collectionView.frame.size.width - 10,
            height: collectionView.frame.size.height
        )
    }
}
