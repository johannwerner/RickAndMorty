import RxSwift
import RxCocoa

/// Contains a collection view of main images and displays the selected image
/// - Requires: `RxSwift`
final class CharacterViewController: AppViewController {
    
// MARK: Dependencies
    private let viewModel: CharacterViewModel
    
// MARK: Rx
    private let viewAction = PublishRelay<CharacterViewAction>()
    
// MARK: View components
    private let tableView: UITableView
    
// MARK: Tooling
    private let disposeBag = DisposeBag()

// MARK: - Life cycle
    
    init(viewModel: CharacterViewModel) {
        self.viewModel = viewModel
        tableView = UITableView(frame: .zero, style: .plain)
        
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

// MARK: TableView
extension CharacterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tableViewCount
    }
    
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let type = viewModel.typeForIndex(index: indexPath.row)
      switch type {
      case .mainImage(let url):
          let cell = tableView.dequeueReusableCell(ofType: ImageTableViewCell.self, at: indexPath)!
          cell.fill(with: url)
          return cell
      case .location(let text):
          let cell = tableView.dequeueReusableCell(ofType: TextTableViewCell.self, at: indexPath)!
          cell.fill(with: text)
          return cell
      case .text(let text):
          let cell = tableView.dequeueReusableCell(ofType: TextTableViewCell.self, at: indexPath)!
          cell.fill(with: text)
          return cell
      case .images(let images):
          let cell = tableView.dequeueReusableCell(ofType: ImagesTableViewCell.self, at: indexPath)!
          cell.fill(with: images)
          return cell
      case .episode(let url):
        let cell = tableView.dequeueReusableCell(ofType: TextTableViewCell.self, at: indexPath)!
        cell.fill(with: url)
        return cell
    }
  }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = viewModel.typeForIndex(index: indexPath.row)
        switch type {
        case .mainImage, .images:
            return 400
        case .location, .text, .episode:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = viewModel.typeForIndex(index: indexPath.row)
          switch type {
          case .mainImage, .text, .images, .episode: break
            case .location(let location):
                viewModel.showLocation(location: location.0)
        }
    }
}

// MARK: - Setup

private extension CharacterViewController {

    /// Initializes and configures components in controller.
    func setUpViews() {
        view.addSubview(tableView)
        setUpNavigationBar()
        setUpTableView()
    }
    
    func setUpNavigationBar() {}
    
    func setUpTableView() {
        tableView.backgroundColor = .secondarySystemBackground
        tableView.autoPinEdgesToSuperviewEdges()
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.reuseId)
        tableView.register(TextTableViewCell.self, forCellReuseIdentifier: TextTableViewCell.reuseId)
        tableView.register(ImagesTableViewCell.self, forCellReuseIdentifier: ImagesTableViewCell.reuseId)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    /// Binds controller user events to view model.
    func setUpBinding() {
        viewModel.bind(to: viewAction)
    }
}

// MARK: - Private

private extension CharacterViewController {}

// MARK: - Rx

private extension CharacterViewController {

    /// Starts observing view effects to react accordingly.
    func observeViewEffect() {
        viewModel
            .viewEffect
            .subscribe(onNext: { [unowned self] effect in
                switch effect {
                case .success:
                    self.activityView.hideView()
                case .error:
                    self.activityView.hideView()
                case .loading:
                    self.activityView.showView()
                }
            })
            .disposed(by: disposeBag)
    }
}
