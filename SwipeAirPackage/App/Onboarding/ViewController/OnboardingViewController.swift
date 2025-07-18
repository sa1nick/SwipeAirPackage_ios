import UIKit
import SwiftUI

class OnboardingViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    private var pages: [OnboardingScreen] = [
        OnboardingScreen(imageName: "onboarding1", title: "Bike and Car Rides at Doorstep", subtitle: "Enjoy your ride with Swipe Air Cab Service"),
        OnboardingScreen(imageName: "onboarding2", title: "Send your Package with us", subtitle: "Get it delivered instantly through Swipe Air"),
        OnboardingScreen(imageName: "onboarding3", title: "Earn Coins and Exciting offers", subtitle: "Earn money by delivering goods, courier and packages.")
    ]

    private lazy var pageControllers: [UIViewController] = {
        return pages.map { screen in
            let vc = OnboardingContentView()
            vc.screen = screen
            return vc
        }
    }()
    private let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SKIP >", for: .normal)
        button.setTitleColor(UIColor(hex: "#FF6D09"), for: .normal)

        if let rubikFont = UIFont(name: "Rubik-Regular", size: 14) {
            button.titleLabel?.font = rubikFont
        } else {
            print("⚠️ Rubik-Regular font not found. Check if it's added and registered correctly.")
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        }

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = UIColor(hex: "#FF6D09")
        pc.pageIndicatorTintColor = UIColor(hex: "#CECECE")
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.transform = CGAffineTransform(scaleX: 0.8    , y: 0.8) // Customize dot size
        return pc
    }()

    private let bottomContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self

        setViewControllers([pageControllers[0]], direction: .forward, animated: true)

        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)

        setupBottomContainer()
    }

    private func setupBottomContainer() {
        view.addSubview(bottomContainer)
        bottomContainer.addSubview(skipButton)
        bottomContainer.addSubview(pageControl)

        NSLayoutConstraint.activate([
            bottomContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomContainer.heightAnchor.constraint(equalToConstant: 60),

            skipButton.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor, constant: 20),
            skipButton.centerYAnchor.constraint(equalTo: bottomContainer.centerYAnchor),

            pageControl.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor),
            pageControl.centerYAnchor.constraint(equalTo: bottomContainer.centerYAnchor)
        ])

        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
    }

    @objc private func skipTapped() {
        print("Skip tapped – navigate to welcome screen")

        let welcomeVC = UIHostingController(rootView: WelcomeScreenBridgeView())
        let navVC = UINavigationController(rootViewController: welcomeVC)
        navVC.navigationBar.topItem?.hidesBackButton = true
        navVC.modalPresentationStyle = .fullScreen

        present(navVC, animated: true)
    }

    @objc private func pageControlTapped(_ sender: UIPageControl) {
        let index = sender.currentPage
        let direction: UIPageViewController.NavigationDirection = index > currentIndex ? .forward : .reverse
        setViewControllers([pageControllers[index]], direction: direction, animated: true)
        currentIndex = index
    }

    // MARK: - Page Control Sync on Swipe
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if completed,
           let visibleVC = viewControllers?.first,
           let index = pageControllers.firstIndex(of: visibleVC) {
            currentIndex = index
            pageControl.currentPage = index
        }
    }

    // MARK: - Required Data Source Methods
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pageControllers.firstIndex(of: viewController), index > 0 else { return nil }
        return pageControllers[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pageControllers.firstIndex(of: viewController), index < pageControllers.count - 1 else { return nil }
        return pageControllers[index + 1]
    }
}
