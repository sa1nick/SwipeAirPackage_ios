    import UIKit

    class EnterOTPContentViewController: UIViewController {
        
        var screenData: EnterOTPScreen = .mock
        var signupRequest: SignupRequest?
        /// Store signup request data
        var emailOrContact: String!
        var password: String!
        var requestType: String!


        private var titleSubtitleView: TitleSubtitleView!
        private var otpInputView: SAPOTPInputView!
        private var otpSupportStack = UIStackView()
        private var notReceivedOtpText: UILabel!
        private var resendButton: UIButton!
        private var continueButton: SAPButton!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            applyGradientBackground()
            setupUI()
            applyConstraints()
        }
        
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
        
        private func setupUI() {
            titleSubtitleView = TitleSubtitleView(title: screenData.titleText, subtitle: screenData.subtitleText)
            view.addSubview(titleSubtitleView)
            
            otpInputView = SAPOTPInputView()
            otpInputView.onOTPEntered = { [weak self] otp in
                print("Entered OTP: \(otp)")
                self?.continueButton.isEnabled = otp.count == 4
            }
            view.addSubview(otpInputView)
            
            // Create horizontal stack for "Didn't receive code? Resend Code"
            otpSupportStack.axis = .horizontal
            otpSupportStack.spacing = 6
            otpSupportStack.alignment = .center
            otpSupportStack.translatesAutoresizingMaskIntoConstraints = false
            
            notReceivedOtpText = UILabel()
            notReceivedOtpText.text = screenData.notReceivedOtpText
            notReceivedOtpText.textColor = .grey7B7B7B
            notReceivedOtpText.font = .jost(.regular, size: 14, scaled: true)
            
            resendButton = UIButton(type: .system)
            resendButton.setTitle(screenData.resendText, for: .normal)
            resendButton.setTitleColor(.orangeFF6D09, for: .normal)
            resendButton.titleLabel?.font = .jost(.medium, size: 14, scaled: true)
            resendButton.addTarget(self, action: #selector(handleResend), for: .touchUpInside)
            
            otpSupportStack.addArrangedSubview(notReceivedOtpText)
            otpSupportStack.addArrangedSubview(resendButton)
            view.addSubview(otpSupportStack)
            
            continueButton = SAPButton(title: screenData.buttonText) { [weak self] in
                self?.handleContinue()
            }
            continueButton.isEnabled = false // Initially disabled until valid OTP
            view.addSubview(continueButton)
            
            [titleSubtitleView, otpInputView, otpSupportStack, continueButton].forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        
        private func applyConstraints() {
            NSLayoutConstraint.activate([
                titleSubtitleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
                titleSubtitleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                titleSubtitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
                titleSubtitleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
                
                otpInputView.topAnchor.constraint(equalTo: titleSubtitleView.bottomAnchor, constant: 30),
                otpInputView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                otpSupportStack.topAnchor.constraint(equalTo: otpInputView.bottomAnchor, constant: 20),
                otpSupportStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                continueButton.topAnchor.constraint(equalTo: otpSupportStack.bottomAnchor, constant: 0),
                continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                continueButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        
        private func handleContinue() {
            let otp = otpInputView.getOTP()

            guard otp.count == 4, otp.allSatisfy({ $0.isNumber }) else {
                showAlert("Error", "Please enter a valid 4-digit OTP")
                return
            }

            print("➡️ Submitting OTP with:")
            print("📩 Email/Contact: \(emailOrContact ?? "nil")")
            print("🔐 Password: \(password ?? "nil")")
            print("🔢 OTP: \(otp)")

            continueButton.isLoading = true

            let request = SendAndVerifyOtpRequest(emailOrContact: emailOrContact, otp: otp)

            AuthService.shared.sendAndVerifyOtp(request: request) { [weak self] result in
                DispatchQueue.main.async {
                    self?.continueButton.isLoading = false

                    switch result {
                    case .success(let response):
                        if response.status {
                            print("✅ OTP verified: \(response.message ?? "")")

                            if self?.requestType == "signup" {
                                // 🔸 SIGNUP flow
                                guard let signupRequest = self?.signupRequest else {
                                    self?.showAlert("Error", "Missing signup request data.")
                                    return
                                }

                                self?.continueButton.isLoading = true
                                AuthService.shared.signup(request: signupRequest) { signupResult in
                                    DispatchQueue.main.async {
                                        self?.continueButton.isLoading = false
                                        switch signupResult {
                                        case .success(let signupResponse):
                                            print("🎉 Signup successful: \(signupResponse)")
                                            self?.showAlert("Success", signupResponse.notification ?? "Signup successful.")
                                            // 👉 Navigate to home/profile if needed
                                        case .failure(let error):
                                            self?.showAlert("Signup Failed", error.localizedDescription)
                                        }
                                    }
                                }
                            } else if self?.requestType == "login" {
                                // 🔸 LOGIN flow
                                self?.showAlert("Success", "Login successful!")
                                // 👉 Navigate to home screen if needed
                            }

                        } else {
                            self?.showAlert("Verification Failed", response.message ?? "Invalid OTP.")
                            self?.otpInputView.clearOTP()
                        }

                    case .failure(let error):
                        self?.showAlert("Error", "Network error: \(error.localizedDescription)")
                    }
                }
            }
        }



        
        @objc private func handleResend() {
            print("🔄 Resend OTP tapped")
            otpInputView.clearOTP()
            continueButton.isEnabled = false

            let request = SendAndVerifyOtpRequest(emailOrContact: emailOrContact, otp: nil)

            AuthService.shared.sendAndVerifyOtp(request: request) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        if response.status {
                            self?.showAlert("OTP Sent", response.message ?? "OTP resent successfully.")
                        } else {
                            self?.showAlert("Error", response.message ?? "Failed to resend OTP.")
                        }
                    case .failure(let error):
                        self?.showAlert("Error", "Network error: \(error.localizedDescription)")
                    }
                }
            }
        }

    }

