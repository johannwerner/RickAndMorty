import RxSwift
import RxCocoa

/// To show users an error view
/// - Requires: `RxSwift`
final class ErrorModuleViewController: UIViewController {
    
    // MARK: Dependencies
    private let viewModel: ErrorModuleViewModel
    
    // MARK: Rx
    private let viewAction = PublishRelay<ErrorModuleViewAction>()
    
    // MARK: View components
    private let primaryButton = UIButton()
    private let titleLabel = UILabel()

    // MARK: Tooling
    private let disposeBag = DisposeBag()

    // MARK: - Life cycle
    
    init(viewModel: ErrorModuleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        setUpBinding()
        
        observeViewEffect()
    }
}

// MARK: - Setup

private extension ErrorModuleViewController {

    /// Initializes and configures components in controller.
    func setUpViews() {
        setUpPrimaryButton() 
        setUpTitleLable()
    }
    
    func setUpPrimaryButton() {
        view.addSubview(primaryButton)
        primaryButton.autoAlignAxis(toSuperviewAxis: .vertical)
        primaryButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 50)
        primaryButton.autoSetDimension(.height, toSize: 50)
        primaryButton.autoSetDimension(.width, toSize: 200, relation: .greaterThanOrEqual)
        primaryButton.layer.cornerRadius = 4.0
        
        primaryButton.backgroundColor = ColorTheme.primaryAppColor
        primaryButton.setTitle(
            "error_primary_button".localizedString(),
            for: .normal
        )
        
        primaryButton.rx.tap.subscribe(onNext: { [unowned self] _ in
            self.viewAction.accept(.primaryButtonPressed)
        })
        .disposed(by: disposeBag)
    }
    
    func setUpTitleLable() {
        view.addSubview(titleLabel)
        titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 21)
        titleLabel.text = "error_title".localizedString()
    }
    
    /// Binds controller user events to view model.
    func setUpBinding() {
        viewModel.bind(to: viewAction)
    }
}

// MARK: - Rx

private extension ErrorModuleViewController {
    
    /// Starts observing view effects to react accordingly.
    func observeViewEffect() {
        viewModel
            .viewEffect
            .subscribe(onNext: { effect in
                switch effect {
                case .someEffect: break
                }
            })
            .disposed(by: disposeBag)
    }
}
