import UIKit
import GoogleMaps
import CoreLocation

class HomeContentViewController: UIViewController {
    var screenData: HomeScreen = .mock
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let topContainer = UIView()
    private let titleLabel = UILabel()
    private let customerImage = UIImageView()
    private let tabButtonGroupView = TabButtonGroupView()
    private let titleRowContainer = UIView()
    private let rideBookView = UIView()
    private let sendPackageView = UIView()
    private let searchBarContainer = UIView()
    private let searchIcon = UIImageView()
    private let searchPlaceholder = UILabel()
    private let laterButton = UIButton(type: .system)
    private let pickupInput = SAPAddressInputView()
    private let dropOffInput = SAPAddressInputView()

    private let iconContainerView = UIView()
    private let pickupIcon = UIImageView()
    private let dropOffIcon = UIImageView()
    private let dashedLineView = VerticalDashedLineView()
    let middleGuide = UILayoutGuide()
    
    private let homeButton = AddressButtonView(
        title: "Home",
        detail: "C-223 Alberta Hall, Street 32, California",
        icon: UIImage(named: "home"),
        tapAction: {
            print("home")
        }
    )

    private let officeButton = AddressButtonView(
        title: "Office",
        detail: "Tea Villa Café, 27th main, 4th cross",
        icon: UIImage(named: "office"),
        tapAction: {
            print("office")
        }
    )
    
    private let instructionTitleLabel = UILabel()
    let instructionsContainer = UIStackView()
    private let continueButton = SAPOrangeButton(title: "Select Package Details")

    private var mapView: GMSMapView!
    private let swipeAirGoBanner = UIImageView()
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        applyConstraints()
        setupTabCallback()
        setupLocationManager()
        // Initialize UI state for bookRide tab
        updateUIForTab(.bookRide)
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        topContainer.backgroundColor = UIColor(hex: "#F5F5F5")
        topContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(topContainer)
        
        tabButtonGroupView.translatesAutoresizingMaskIntoConstraints = false
        topContainer.addSubview(tabButtonGroupView)
        
        titleRowContainer.translatesAutoresizingMaskIntoConstraints = false
        topContainer.addSubview(titleRowContainer)
        
        titleLabel.text = "Where are you going today?"
        titleLabel.font = UIFont.jost(.semiBold, size: 23, scaled: true)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleRowContainer.addSubview(titleLabel)
        
        customerImage.image = UIImage(named: "customerImage")
        customerImage.contentMode = .scaleAspectFit
        customerImage.translatesAutoresizingMaskIntoConstraints = false
        titleRowContainer.addSubview(customerImage)
        
        searchBarContainer.backgroundColor = .white
        searchBarContainer.layer.cornerRadius = 22
        searchBarContainer.layer.shadowColor = UIColor.black.cgColor
        searchBarContainer.layer.shadowOpacity = 0.05
        searchBarContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        searchBarContainer.layer.shadowRadius = 4
        searchBarContainer.translatesAutoresizingMaskIntoConstraints = false
        topContainer.addSubview(searchBarContainer)

        searchIcon.image = UIImage.searchIcon
        searchIcon.tintColor = UIColor.grey505050
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        searchBarContainer.addSubview(searchIcon)

        searchPlaceholder.text = "Where to?"
        searchPlaceholder.font = UIFont.jost(.medium, size: 18, scaled: true)
        searchPlaceholder.textColor = UIColor.grey505050
        searchPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        searchBarContainer.addSubview(searchPlaceholder)

        laterButton.setTitle(" Later", for: .normal)
        laterButton.setTitleColor(.black, for: .normal)
        laterButton.titleLabel?.font = UIFont.jost(.medium, size: 16, scaled: true)
        laterButton.setImage(UIImage.dateTimeIcon, for: .normal)
        laterButton.tintColor = .black
        laterButton.backgroundColor = UIColor.greyF5F5F5
        laterButton.layer.cornerRadius = 17
        laterButton.translatesAutoresizingMaskIntoConstraints = false
        
        searchBarContainer.addSubview(laterButton)
        
        // Configure iconContainerView
        iconContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(iconContainerView)

        // Configure pickupIcon
        pickupIcon.image = UIImage(named: "pickupIcon") // Replace with your pickup icon name
        pickupIcon.contentMode = .scaleAspectFit
        pickupIcon.translatesAutoresizingMaskIntoConstraints = false
        iconContainerView.addSubview(pickupIcon)

        // Configure dropOffIcon
        dropOffIcon.image = UIImage(named: "dropoffIcon") // Replace with your drop-off icon name
        dropOffIcon.contentMode = .scaleAspectFit
        dropOffIcon.translatesAutoresizingMaskIntoConstraints = false
        iconContainerView.addSubview(dropOffIcon)

        // Configure dashedLineView
        dashedLineView.translatesAutoresizingMaskIntoConstraints = false
        iconContainerView.addSubview(dashedLineView)
        
        pickupInput.placeholder = "Collect from"
        topContainer.addSubview(pickupInput)
        dropOffInput.placeholder = "Drop off"
        topContainer.addSubview(dropOffInput)
        topContainer.addLayoutGuide(middleGuide)

        
        instructionTitleLabel.text = "Important Instructions"
        instructionTitleLabel.font = UIFont.jost(.semiBold, size: 18)
        instructionTitleLabel.textColor = .black
        instructionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(instructionTitleLabel)
        
        instructionsContainer.axis = .vertical
        instructionsContainer.spacing = 10
        instructionsContainer.translatesAutoresizingMaskIntoConstraints = false

        let instructionTexts = [
            "Do not send illegal, dangerous goods.",
            "Valuable items are not recommended.",
            "Use Secure packaging for your parcel.",
            "Share OTP only with the delivery partner.",
        ]

        for text in instructionTexts {
            let bulletImageView = UIImageView(image: UIImage(named: "bulletpoint"))
            bulletImageView.translatesAutoresizingMaskIntoConstraints = false
            bulletImageView.contentMode = .scaleAspectFit
            bulletImageView.widthAnchor.constraint(equalToConstant: 11).isActive = true
            bulletImageView.heightAnchor.constraint(equalToConstant: 11).isActive = true

            let label = UILabel()
            label.text = text
            label.font = UIFont.jost(.regular, size: 18, scaled: true)
            label.textColor = .grey7B7B7B
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false

            let hStack = UIStackView(arrangedSubviews: [bulletImageView, label])
            hStack.axis = .horizontal
            hStack.alignment = .center // Changed from .top to .center for vertical alignment
            hStack.spacing = 14
            hStack.translatesAutoresizingMaskIntoConstraints = false

            instructionsContainer.addArrangedSubview(hStack)
        }

        contentView.addSubview(instructionsContainer)
        
        contentView.addSubview(continueButton)

       
        let camera = GMSCameraPosition.camera(withLatitude: 37.7749, longitude: -122.4194, zoom: 15)
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.layer.cornerRadius = 10
        mapView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mapView)

        swipeAirGoBanner.image = UIImage(named: "swipeairgobanner")
        swipeAirGoBanner.contentMode = .scaleAspectFit
        swipeAirGoBanner.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(swipeAirGoBanner)

        contentView.addSubview(homeButton)
        contentView.addSubview(officeButton)
    }

    private func applyConstraints() {
        // Updated constraint for iconContainerView with 37pt top margin
        iconContainerView.topAnchor.constraint(equalTo: tabButtonGroupView.bottomAnchor, constant: 57).isActive = true
        iconContainerView.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor, constant: 26).isActive = true
        iconContainerView.trailingAnchor.constraint(equalTo: pickupInput.leadingAnchor, constant: -20).isActive = true
        iconContainerView.trailingAnchor.constraint(equalTo: dropOffInput.leadingAnchor, constant: -20).isActive = true
        iconContainerView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        // Constraints for pickupIcon (top of the dashed line)
        // Correct: pickup icon should be ABOVE the dashed line
        pickupIcon.bottomAnchor.constraint(equalTo: dashedLineView.topAnchor, constant: -5).isActive = true

                pickupIcon.centerXAnchor.constraint(equalTo: dashedLineView.centerXAnchor).isActive = true // Center on the dashed line
                pickupIcon.widthAnchor.constraint(equalToConstant: 14).isActive = true // 14x14 icon
                pickupIcon.heightAnchor.constraint(equalToConstant: 14).isActive = true // 14x14 icon

                // Constraints for dropOffIcon (bottom of the dashed line)
                dropOffIcon.bottomAnchor.constraint(equalTo: iconContainerView.bottomAnchor, constant: -10).isActive = true // 10-point bottom padding
                dropOffIcon.centerXAnchor.constraint(equalTo: dashedLineView.centerXAnchor).isActive = true // Center on the dashed line
                dropOffIcon.widthAnchor.constraint(equalToConstant: 16).isActive = true // 14x14 icon
                dropOffIcon.heightAnchor.constraint(equalToConstant: 16).isActive = true // 14x14 icon

                // Constraints for dashedLineView
                dashedLineView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor).isActive = true
                dashedLineView.topAnchor.constraint(equalTo: pickupIcon.bottomAnchor, constant: 5).isActive = true // Start below pickupIcon with 5-point gap
                dashedLineView.bottomAnchor.constraint(equalTo: dropOffIcon.topAnchor, constant: -5).isActive = true // End above dropOffIcon with 5-point gap
                dashedLineView.widthAnchor.constraint(equalToConstant: 1).isActive = true // Width of dashed line
                // Constraints for dashedLineView
                dashedLineView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor).isActive = true
                dashedLineView.topAnchor.constraint(equalTo: iconContainerView.topAnchor).isActive = true
                dashedLineView.bottomAnchor.constraint(equalTo: iconContainerView.bottomAnchor).isActive = true
                dashedLineView.widthAnchor.constraint(equalToConstant: 1).isActive = true // Width of dashed line
                
                // Remove: searchBarContainer.bottomAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: -20).isActive = true

        // Updated constraints for instructionTitleLabel
        instructionTitleLabel.topAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: 12).isActive = true
        instructionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        instructionTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16).isActive = true

        // Updated constraints for instructionsContainer
        instructionsContainer.topAnchor.constraint(equalTo: instructionTitleLabel.bottomAnchor, constant: 10).isActive = true
        instructionsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        instructionsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        continueButton.topAnchor.constraint(equalTo: instructionsContainer.bottomAnchor, constant: 20).isActive = true
        continueButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            topContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            topContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            // Add dynamic bottom constraint for topContainer
            topContainer.bottomAnchor.constraint(greaterThanOrEqualTo: dropOffInput.bottomAnchor, constant: 20),
            topContainer.bottomAnchor.constraint(greaterThanOrEqualTo: searchBarContainer.bottomAnchor, constant: 20),
            
            tabButtonGroupView.topAnchor.constraint(equalTo: topContainer.topAnchor, constant: 26),
            tabButtonGroupView.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor),
            tabButtonGroupView.trailingAnchor.constraint(equalTo: topContainer.trailingAnchor),
            tabButtonGroupView.heightAnchor.constraint(equalToConstant: 69),
            
            titleRowContainer.topAnchor.constraint(equalTo: tabButtonGroupView.bottomAnchor, constant: 16.5),
            titleRowContainer.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor, constant: 16),
            titleRowContainer.trailingAnchor.constraint(equalTo: topContainer.trailingAnchor, constant: -16),
            titleRowContainer.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.leadingAnchor.constraint(equalTo: titleRowContainer.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleRowContainer.centerYAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: customerImage.leadingAnchor, constant: -8),
            
            customerImage.trailingAnchor.constraint(equalTo: titleRowContainer.trailingAnchor),
            customerImage.centerYAnchor.constraint(equalTo: titleRowContainer.centerYAnchor),
            customerImage.widthAnchor.constraint(equalToConstant: 30),
            customerImage.heightAnchor.constraint(equalToConstant: 30),
            
            searchBarContainer.topAnchor.constraint(equalTo: titleRowContainer.bottomAnchor, constant: 20),
            searchBarContainer.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor, constant: 16),
            searchBarContainer.trailingAnchor.constraint(equalTo: topContainer.trailingAnchor, constant: -16),
            searchBarContainer.heightAnchor.constraint(equalToConstant: 45),
            
            searchIcon.leadingAnchor.constraint(equalTo: searchBarContainer.leadingAnchor, constant: 12),
            searchIcon.topAnchor.constraint(equalTo: searchBarContainer.topAnchor, constant: 12),
            searchIcon.widthAnchor.constraint(equalToConstant: 18),
            searchIcon.heightAnchor.constraint(equalToConstant: 18),
            
            searchPlaceholder.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 8),
            searchPlaceholder.centerYAnchor.constraint(equalTo: searchIcon.centerYAnchor),
            
            laterButton.trailingAnchor.constraint(equalTo: searchBarContainer.trailingAnchor, constant: -6),
            laterButton.topAnchor.constraint(equalTo: searchBarContainer.topAnchor, constant: 5),
            laterButton.widthAnchor.constraint(equalToConstant: 80),
            laterButton.heightAnchor.constraint(equalToConstant: 34),

            pickupInput.topAnchor.constraint(equalTo: tabButtonGroupView.bottomAnchor, constant: 20),
            pickupInput.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor, constant: 16),
            pickupInput.trailingAnchor.constraint(equalTo: topContainer.trailingAnchor, constant: -16),
            pickupInput.heightAnchor.constraint(equalToConstant: 50),
            
            dropOffInput.topAnchor.constraint(equalTo: pickupInput.bottomAnchor, constant: 14),
            dropOffInput.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor, constant: 16),
            dropOffInput.trailingAnchor.constraint(equalTo: topContainer.trailingAnchor, constant: -16),
            dropOffInput.heightAnchor.constraint(equalToConstant: 50),
            
            // Layout guide between pickupInput and dropOffInput
                middleGuide.topAnchor.constraint(equalTo: pickupInput.bottomAnchor),
                middleGuide.bottomAnchor.constraint(equalTo: dropOffInput.topAnchor),


            homeButton.topAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: 10),
            homeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            homeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            officeButton.topAnchor.constraint(equalTo: homeButton.bottomAnchor, constant: 10),
            officeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            officeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            mapView.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 20),
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mapView.heightAnchor.constraint(equalToConstant: 230),
            
            swipeAirGoBanner.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 20),
            swipeAirGoBanner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            swipeAirGoBanner.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            swipeAirGoBanner.heightAnchor.constraint(equalToConstant: 140),
            swipeAirGoBanner.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }

    private func setupTabCallback() {
        tabButtonGroupView.onTabChanged = { [weak self] selectedTab in
            guard let self = self else { return }
            self.updateUIForTab(selectedTab)
        }
    }

    
    private func updateUIForTab(_ selectedTab: TabButtonGroupView.TabType) {
        switch selectedTab {
        case .bookRide:
            rideBookView.isHidden = false
            sendPackageView.isHidden = true
            titleRowContainer.isHidden = false
            searchBarContainer.isHidden = false
            homeButton.isHidden = false
            officeButton.isHidden = false
            dashedLineView.isHidden = false
            searchIcon.isHidden = false
            searchPlaceholder.isHidden = false
            laterButton.isHidden = false
            instructionTitleLabel.isHidden = true
            instructionsContainer.isHidden = true
            continueButton.isHidden = true
            pickupInput.isHidden = true
            dropOffInput.isHidden = true
            iconContainerView.isHidden = true // Hide in bookRide
        case .sendPackage:
            rideBookView.isHidden = true
            sendPackageView.isHidden = false
            titleRowContainer.isHidden = true
            searchBarContainer.isHidden = true
            homeButton.isHidden = true
            officeButton.isHidden = true
            dashedLineView.isHidden = false
            searchIcon.isHidden = true
            searchPlaceholder.isHidden = true
            laterButton.isHidden = true
            instructionTitleLabel.isHidden = false
            instructionsContainer.isHidden = false
            continueButton.isHidden = false
            pickupInput.isHidden = false
            dropOffInput.isHidden = false
            iconContainerView.isHidden = false // Show in sendPackage
        }
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension HomeContentViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let camera = GMSCameraPosition.camera(
            withLatitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude,
            zoom: 15.0
        )
        mapView.animate(to: camera)
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            print("Location access denied or restricted")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
}
