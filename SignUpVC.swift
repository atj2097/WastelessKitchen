import UIKit
import FirebaseAuth


class SignUpVC: UIViewController {
    
    //MARK: VIEWS
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Wasteless Kitchen"
        label.font = UIFont(name: "PingFang TC", size: 60)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
  
    lazy var signUpButton: UIButton = {
          let button = UIButton(type: .system)
      button.setTitle("SIGN UP", for: .normal)
          button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
          button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
          button.titleLabel?.font = UIFont(name: "PingFang TC", size: 30)
          button.layer.borderWidth = 2
          button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      button.backgroundColor = .clear
          button.addTarget(self, action: #selector(trySignUp), for: .touchUpInside)
          button.isEnabled = true
          return button
      }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: " Enter Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.font = UIFont(name: "PingFang TC", size: 20)
      textField.backgroundColor = .clear
        textField.layer.borderWidth = 2
        textField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textField.autocorrectionType = .no
        textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return textField
    }()

    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: " Enter Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.font = UIFont(name: "PingFang TC", size: 20)
      textField.backgroundColor = .clear
        textField.layer.borderWidth = 2
        textField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return textField
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LOGIN", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "PingFang TC", size: 20)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(showLogIn), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()

  

    //MARK: Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
      self.view.backgroundColor = .white
        setupSubViews()
        passwordTextField.delegate = self
        emailTextField.delegate = self
    }

    //MARK: Obj-C methods

    @objc func validateFields() {
    guard emailTextField.hasText, passwordTextField.hasText else {
        signUpButton.isEnabled = false
        return
    }
      signUpButton.isEnabled = true
      signUpButton.backgroundColor = #colorLiteral(red: 0.06666666667, green: 0.968627451, blue: 0.2235294118, alpha: 1)
      signUpButton.layer.borderWidth = 3
}
  
  @objc func showLogIn() {
         let loginVC = LoginVC()
         print("button pressed")
         loginVC.modalPresentationStyle = .formSheet
         present(loginVC, animated: true, completion: nil)
     }

@objc func trySignUp() {
    guard let email = emailTextField.text, let password = passwordTextField.text else {
        showAlert(with: "Error", and: "Please fill out all fields.")
        return
    }

    guard email.isValidEmail else {
        showAlert(with: "Error", and: "Please enter a valid email")
        return
    }

    guard password.isValidPassword else {
        showAlert(with: "Error", and: "Please enter a valid password. Passwords must have at least 8 characters.")
        return
    }

    FirebaseAuthService.manager.createNewUser(email: email.lowercased(), password: password) { [weak self] (result) in
        self?.handleCreateAccountResponse(with: result)
    }
}

    //MARK: Private methods
  
  private func showAlert(with title: String, and message: String) {
      let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      present(alertVC, animated: true, completion: nil)
  }
  
  private func handleCreateAccountResponse(with result: Result<User, Error>) {
      DispatchQueue.main.async { [weak self] in
          switch result {
          case .success(let user):
              FirestoreService.manager.createAppUser(user: AppUser(from: user)) { [weak self] newResult in
                  self?.handleCreatedUserInFirestore(result: newResult)
              }
          case .failure(let error):
              self?.showAlert(with: "Error creating user", and: "An error occured while creating new account \(error)")
          }
      }
  }
  
  private func handleCreatedUserInFirestore(result: Result<(), Error>) {
      switch result {
      case .success:
          guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
              else {
                  return
          }

          UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                  window.rootViewController = InputVC()
          }, completion: nil)
      case .failure(let error):
          self.showAlert(with: "Error creating user", and: "An error occured while creating new account \(error)")
      }
  }
    
    //MARK: UI Setup
    
    private func setupSubViews() {
      titleLabelSetup()
      loginButtonSetUp()
      emailPasswordStackViewSetUp()
    }
    
    private func titleLabelSetup() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
          titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
          titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
          titleLabel.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
  
  
    private func emailPasswordStackViewSetUp() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        self.view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 180)
        ])
      }
  
private func loginButtonSetUp() {
  view.addSubview(loginButton)
  loginButton.translatesAutoresizingMaskIntoConstraints = false
  NSLayoutConstraint.activate([
    loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
    loginButton.heightAnchor.constraint(equalToConstant: 30),
    loginButton.widthAnchor.constraint(equalToConstant: 100),
    loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
  ])
}
  
}


extension SignUpVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
