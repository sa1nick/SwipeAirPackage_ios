//
//  SignUpContentViewController.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 03/07/25.
//

import UIKit
import SwiftUI


class SignUpContentViewController: UIViewController {

    var screenData: SignUpScreen = .mock

    private var titleSubtitleView: TitleSubtitleView!
    private let toggleInputModeLabel = UILabel()
    private var toggleInputModeLabelTopForPhone: NSLayoutConstraint!
    private var toggleInputModeLabelTopForEmail: NSLayoutConstraint!
    private var isUsingEmail = false
    private let phoneTextField = SAPPhoneInputView()
    private let emailTextField = SAPTextInputView()
    private let passwordInput = SAPPasswordInputView()
    private let confirmPasswordInput = SAPPasswordInputView()
    private let checkbox = UIButton(type: .custom)
    private let termsLabel = UILabel()
    private let termsStack = UIStackView()
    private var isChecked = false
    private var signUpButton: SAPButton!
    private let loginTextLabel = UILabel()
    private let socialStack = SAPSocialButtons()

    
    private func applyGradientBackground() {
        let gradientHeight: CGFloat = 193
        let gradientView = UIView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(gradientView, at: 0)

        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: gradientHeight)
        ])

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hex: "#FDEBFF").cgColor,
            UIColor.white.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: gradientHeight)

        gradientView.layer.insertSublayer(gradientLayer, at: 0)
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        applyGradientBackground()
        setupUI()
        applyConstraints()
    }
    
    
    @objc private func toggleInputMode() {
        isUsingEmail.toggle()

        phoneTextField.isHidden = isUsingEmail
        emailTextField.isHidden = !isUsingEmail
        toggleInputModeLabel.text = isUsingEmail ? "Use Phone Instead" : "Use Email Instead"

        // Toggle top constraint
        toggleInputModeLabelTopForPhone.isActive = !isUsingEmail
        toggleInputModeLabelTopForEmail.isActive = isUsingEmail

        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }


    
    @objc private func toggleCheckbox() {
        isChecked.toggle()

        if isChecked {
            // Checked: show tick image and remove border
            checkbox.setImage(UIImage(named: "tick-square"), for: .normal)
            checkbox.layer.borderWidth = 0
            checkbox.layer.borderColor = nil
            checkbox.layer.cornerRadius = 0
            checkbox.backgroundColor = .clear
        } else {
            // Unchecked: remove image and show purple border
            checkbox.setImage(nil, for: .normal)
            checkbox.layer.borderWidth = 1
            checkbox.layer.borderColor = UIColor.purple.cgColor
            checkbox.layer.cornerRadius = 2
            checkbox.backgroundColor = .clear
        }
    }
    

    private func isValidPhone(_ phone: String) -> Bool {
        // Basic regex for digits only; customize as needed
        let digitsOnly = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return digitsOnly.count >= 7 && digitsOnly.count <= 15
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }

    
    
    private func validateInputsAndSubmit() {
        // Fetch and validate password
         let password = passwordInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
         let confirmPassword = confirmPasswordInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
         let validationErrorTitle = "Error"
         var inputValue: String?

         // Validate email or phone
         if isUsingEmail {
             let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
             guard !email.isEmpty else {
                 showAlert(validationErrorTitle, "Please enter your email address.")
                 return
             }
             guard isValidEmail(email) else {
                 showAlert(validationErrorTitle, "Please enter a valid email address.")
                 return
             }
             inputValue = email
         } else {
             let phone = phoneTextField.getFullPhoneNumber().trimmingCharacters(in: .whitespacesAndNewlines)
             guard !phone.isEmpty else {
                 showAlert(validationErrorTitle, "Please enter your phone number.")
                 return
             }
             guard isValidPhone(phone) else {
                 showAlert(validationErrorTitle, "Please enter a valid phone number.")
                 return
             }
             inputValue = phone
         }

         // Validate password
         guard password.count >= 6 else {
             showAlert(validationErrorTitle, "Password must be at least 6 characters.")
             return
         }
         guard password == confirmPassword else {
             showAlert(validationErrorTitle, "Passwords do not match.")
             return
         }

         // Validate terms checkbox
         guard isChecked else {
             showAlert(validationErrorTitle, "You must accept the policy and terms.")
             return
         }

         // ✅ Prepare and call API
        let request = SendAndVerifyOtpRequest(emailOrContact: inputValue!, otp: nil)

        AuthService.shared.sendAndVerifyOtp(request: request) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if response.status {
                        let alert = UIAlertController(title: "Success", message: response.message ?? "OTP sent", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            print("✅ OTP sent - navigating to OTP screen")
                            
                            // Navigate to next screen
                            let signupRequest = SignupRequest(
                                emailOrMobile: inputValue!,
                                password: password,
                                confirmPassword: confirmPassword
                            )

                            let nextVC = EnterOTPContentViewController()
                            nextVC.emailOrContact = inputValue!
                            nextVC.password = password
                            nextVC.requestType = "signup"
                            nextVC.signupRequest = signupRequest // ✅ Pass this

                            self?.navigationController?.pushViewController(nextVC, animated: true)
                        })
                        self?.present(alert, animated: true)
                    } else {
                        self?.showAlert("Error", response.message ?? "Failed to send OTP.")
                    }
                case .failure(let error):
                    self?.showAlert("Network Error", "Error: \(error.localizedDescription)")
                }
            }
        }

        
        print("✅ Sign Up Pressed")
        print("emailorMobile: \(inputValue)")

        print("Password: \(password)")
        print("Confirm Password: \(confirmPassword)")
        print("Accepted Terms: \(isChecked)")
    }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationItem.hidesBackButton = true
    }


    
    @objc private func handleLoginTap() {
        let loginVC = UIHostingController(rootView: LoginScreenBridgeView())
                let navVC = UINavigationController(rootViewController: loginVC  )
                navVC.navigationBar.topItem?.hidesBackButton = true
                navVC.modalPresentationStyle = .fullScreen

                present(navVC, animated: true)
        }



    private func setupUI() {
        // Title
        titleSubtitleView = TitleSubtitleView(title: screenData.titleText, subtitle: screenData.subtitleText)
        view.addSubview(titleSubtitleView)
        
        emailTextField.isHidden = true
        emailTextField.placeholder = "Enter Email Address"
        emailTextField.text  = "josbuttler74@yopmail.com"
        
        toggleInputModeLabel.text = "Use Email Instead"
        toggleInputModeLabel.font = UIFont.jost(.medium, size: 16)
        toggleInputModeLabel.textColor = UIColor(hex: "#FF6D09")
        toggleInputModeLabel.textAlignment = .center
        toggleInputModeLabel.isUserInteractionEnabled = true

        let toggleGesture = UITapGestureRecognizer(target: self, action: #selector(toggleInputMode))
        toggleInputModeLabel.addGestureRecognizer(toggleGesture)

        view.addSubview(toggleInputModeLabel)
        
        passwordInput.placeholder = "Enter Password"
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        passwordInput.text = "Swipe@123"
        view.addSubview(passwordInput)
        
        confirmPasswordInput.placeholder = "Re - enter Password"
        confirmPasswordInput.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordInput.text = "Swipe@123"
        view.addSubview(confirmPasswordInput)


        // Set initial state as unchecked (default)
        isChecked = false
        
        // Set up the checkbox with initial unchecked appearance
        checkbox.setImage(nil, for: .normal)
        checkbox.layer.borderWidth = 1
        checkbox.layer.borderColor = UIColor.purple.cgColor
        checkbox.layer.cornerRadius = 2
        checkbox.backgroundColor = .clear
        checkbox.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)

        // Explicit size constraints (12.81pt)
        checkbox.widthAnchor.constraint(equalToConstant: 12.81).isActive = true
        checkbox.heightAnchor.constraint(equalToConstant: 12.81).isActive = true


        termsLabel.text = "I accept the policy and terms"
        termsLabel.font = UIFont.jost(JostFontWeight.regular, size: 14,scaled: true)
        termsLabel.textColor = UIColor.grey909090

        termsStack.axis = .horizontal
        termsStack.spacing = 8
        termsStack.alignment = .center
        termsStack.addArrangedSubview(checkbox)
        termsStack.addArrangedSubview(termsLabel)
        termsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(termsStack)

        signUpButton = SAPButton(title: "Sign Up") { [weak self] in
            self?.validateInputsAndSubmit()
        }

        
        let fullText = "Already have an account? Login"
        let attributedString = NSMutableAttributedString(string: fullText)

        let baseFont = UIFont.jost(JostFontWeight.regular, size: 16)
        let highlightFont = UIFont.jost(JostFontWeight.medium, size: 16)

        // Apply default style
        attributedString.addAttributes([
            .font: baseFont,
            .foregroundColor: UIColor.grey747474
        ], range: NSRange(location: 0, length: fullText.count))

        // Make "Login" tappable
        if let loginRange = fullText.range(of: "Login") {
            let nsRange = NSRange(loginRange, in: fullText)
            attributedString.addAttributes([
                .font: highlightFont,
                .foregroundColor: UIColor.black,
            ], range: nsRange)
        }

        loginTextLabel.attributedText = attributedString
        loginTextLabel.textAlignment = .center
        loginTextLabel.isUserInteractionEnabled = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLoginTap))
        loginTextLabel.addGestureRecognizer(tapGesture)

        view.addSubview(loginTextLabel)
//        socialStack.axis = .horizontal
//        socialStack.spacing = 20
//        socialStack.alignment = .center
//        socialStack.distribution = .equalSpacing
//        socialStack.addArrangedSubview(meta)
//        socialStack.addArrangedSubview(apple)
//        socialStack.addArrangedSubview(google)

        [
            titleSubtitleView,phoneTextField, emailTextField,toggleInputModeLabel,
            passwordInput, confirmPasswordInput,
            checkbox, termsLabel, signUpButton, loginTextLabel, socialStack
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

    }
    private func applyConstraints() {
        // 1. Create constraints
        toggleInputModeLabelTopForPhone = toggleInputModeLabel.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 8)
        toggleInputModeLabelTopForEmail = toggleInputModeLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8)

        // 2. Activate initial layout (phone input visible by default)
        NSLayoutConstraint.activate([
            titleSubtitleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 59),
            titleSubtitleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            phoneTextField.topAnchor.constraint(equalTo: titleSubtitleView.bottomAnchor, constant: 50),
            phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            phoneTextField.heightAnchor.constraint(equalToConstant: 50),

            emailTextField.topAnchor.constraint(equalTo: titleSubtitleView.bottomAnchor, constant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            toggleInputModeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            // ✅ Only one of these two is activated initially
            toggleInputModeLabelTopForPhone,

            passwordInput.topAnchor.constraint(equalTo: toggleInputModeLabel.bottomAnchor, constant: 10),
            passwordInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordInput.heightAnchor.constraint(equalToConstant: 50),

            confirmPasswordInput.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 10),
            confirmPasswordInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            confirmPasswordInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            confirmPasswordInput.heightAnchor.constraint(equalToConstant: 50),

            checkbox.topAnchor.constraint(equalTo: confirmPasswordInput.bottomAnchor, constant: 19),
            checkbox.leadingAnchor.constraint(equalTo: phoneTextField.leadingAnchor),
            checkbox.widthAnchor.constraint(equalToConstant: 20),
            checkbox.heightAnchor.constraint(equalToConstant: 20),

            termsLabel.centerYAnchor.constraint(equalTo: checkbox.centerYAnchor),
            termsLabel.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: 8),

            signUpButton.topAnchor.constraint(equalTo: termsLabel.bottomAnchor, constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: phoneTextField.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: phoneTextField.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),

            loginTextLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 16),
            loginTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            socialStack.topAnchor.constraint(equalTo: loginTextLabel.bottomAnchor, constant: 16),
            socialStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}
