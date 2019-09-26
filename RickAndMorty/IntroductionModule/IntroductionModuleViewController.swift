import RxSwift
import RxCocoa

/// An introduction to my coding challenge
/// - Requires: `RxSwift`, `RxCocoa`
final class IntroductionModuleViewController: AppViewController {
    
    // MARK: Dependencies
    private let viewModel: IntroductionModuleViewModel
    
    // MARK: Rx
    private let viewAction = PublishRelay<IntroductionModuleViewAction>()
    
    // MARK: View components
    private let primaryButton = UIButton()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: Tooling
    private let disposeBag = DisposeBag()

    // MARK: - Life cycle
    
    init(viewModel: IntroductionModuleViewModel) {
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        viewNavigationController.isNavigationBarHidden = false
    }
}

// MARK: - Setup

private extension  IntroductionModuleViewController {

    /// Initializes and configures components in controller.
    func setUpViews() {
        setUpNextButton()
        setUpTitleLable()
        setUpSubtitleLable()
        setUpActivityIndicator()
    }
    
    
    /// Binds controller user events to view model.
    func setUpBinding() {
        viewModel.bind(to: viewAction)
    }
    
    func setUpNextButton() {
        view.addSubview(primaryButton)
        primaryButton.autoAlignAxis(toSuperviewAxis: .vertical)
        primaryButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 50)
        primaryButton.autoSetDimension(.height, toSize: 50)
        primaryButton.autoSetDimension(.width, toSize: 200, relation: .greaterThanOrEqual)
        primaryButton.layer.cornerRadius = 4.0
        
        primaryButton.backgroundColor = ColorTheme.primaryAppColor
        primaryButton.setTitle(
            "Next",
            for: .normal
        )
        
        primaryButton.rx.tap.subscribe(onNext: { [unowned self] _ in
            self.viewAction.accept(.primaryButtonPressed)
        })
        .disposed(by: disposeBag)
    }
    
    func setUpTitleLable() {
        view.addSubview(titleLabel)
        titleLabel.autoCenterInSuperview()
        titleLabel.font = UIFont.systemFont(ofSize: 21)
        titleLabel.text = IntroductionConstants.titleLabelText
    }
    
    /// - Requires: setUpTitleLabel to be called first
    func setUpSubtitleLable() {
        view.addSubview(subtitleLabel)
        subtitleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        subtitleLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 17)
        subtitleLabel.font = UIFont.systemFont(ofSize: 17)
        let subtitleString = "<b><custom>iOS</custom></b> Challenge"
        
        let attributesForBold = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)]
        let attributesForCustom = [NSAttributedString.Key.foregroundColor: ColorTheme.primaryAppColor]

        subtitleLabel.attributedText = AttributedStringManager.convertStringToAttributedString(
            subtitleString,
            attributesForBold: attributesForBold,
            attributesForCustom: attributesForCustom
        )
    }
    
    func setUpActivityIndicator() {
        primaryButton.addSubview(activityIndicator)
        activityIndicator.autoCenterInSuperview()
        activityIndicator.style = .medium
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
    }
    
    func startLoadingAnimations() {
        activityIndicator.startAnimating()
        primaryButton.setTitle(
            "",
            for: .normal
        )
        activityView.showView()
    }
    
    func stopLoadingAnimations() {
        activityIndicator.stopAnimating()
        primaryButton.setTitle(
            "Next",
            for: .normal
        )
        activityView.hideView()
    }
}

// MARK: - Rx

private extension IntroductionModuleViewController {
    
    /// Starts observing view effects to react accordingly.
    func observeViewEffect() {
        viewModel
        .viewEffect
        .subscribe(onNext: { [unowned self] effect in
            switch effect {
            case .success:
                self.stopLoadingAnimations()
            case .loading:
                self.startLoadingAnimations()
            case .error:
                self.stopLoadingAnimations()
            }
        })
        .disposed(by: disposeBag)}
}
