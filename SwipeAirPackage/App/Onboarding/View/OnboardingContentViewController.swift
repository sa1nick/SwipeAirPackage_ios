import UIKit

class OnboardingContentView: UIViewController {

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    var screen: OnboardingScreen?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        configureContent()
    }

    private func configureContent() {
        guard let screen = screen else { return }
        imageView.image = UIImage(named: screen.imageName)
        titleLabel.text = screen.title
        subtitleLabel.text = screen.subtitle
    }

    private func setupLayout() {
        imageView.contentMode = .scaleAspectFit
        titleLabel.font = UIFontMetrics.default.scaledFont(for: UIFont(name: "Rubik-Medium", size: 22)!)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1

        subtitleLabel.font = UIFontMetrics.default.scaledFont(for: UIFont(name: "Rubik-Regular", size: 18)!)
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.textColor = .grey8A8A8A
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 2

        [imageView, titleLabel, subtitleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([

            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200.14),
            imageView.widthAnchor.constraint(equalToConstant: 400.19),
            imageView.heightAnchor.constraint(equalToConstant: 250.96),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: -60),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])

    }

}
