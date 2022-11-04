//
//  ViewController.swift
//  DesafioWeslley
//
//  Created by Gabriel Carvalho on 31/10/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Instancias -

    var api = Api()
    var keyC = KeychainManager()
    var cars = CarsListTableViewController()
    
    // MARK: Componentes de view -
    
    lazy var backGroundImage: UIImageView = {
        
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "BackGroundImage")
        
        return image
    }()
    
    lazy var carLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Carros"
        label.font = .systemFont(ofSize: 25)
        label.textColor = .white
        
        return label
    }()
    
    lazy var loginLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .gray
        
        return label
    }()
    
    lazy var passwordLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Senha"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .gray
        
        return label
    }()
    
    
    lazy var loginTextFiled: UITextField = {
        
        let text = UITextField()
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "Digite o login"
        text.backgroundColor = .white
        text.borderStyle = .roundedRect
        
        return text
    }()
    
    lazy var passWordTextFiled: UITextField = {
        
        let text = UITextField()
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "Digite a senha"
        text.backgroundColor = .white
        text.isSecureTextEntry = true
        text.borderStyle = .roundedRect
        
        return text
    }()
    
    lazy var keepLoggedLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "manter logado"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemBlue
        
        return label
    }()
    
    lazy var keepLoggedSwitch: UISwitch = {
        
        let staySwitch = UISwitch()
        staySwitch.onTintColor = UIColor(named: "darkBlue")
        staySwitch.translatesAutoresizingMaskIntoConstraints = false
        
        return staySwitch
    }()
    
    lazy var loginButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "darkBlue")
        
        return button
    }()
    
    lazy var rememberPasswordButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Esqueci a senha", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    
    lazy var signUpLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .gray
        label.text = "Ainda não tem uma conta? "
       
        return label
    }()
    
    lazy var signUpButton: UIButton = {
       
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Cadastre-se", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        
        return button
    }()
    
    lazy var backGroundWhiteView: UIView = {
        
        let viiew = UIView()
        viiew.translatesAutoresizingMaskIntoConstraints = false
        viiew.backgroundColor = .white
        viiew.roundCorners(cornerRadiuns: 15.0, typeCorners: [.downRight,.downLeft,.upperRight,.upperLeft])
        
       return viiew
    }()
    
    lazy var backGroundGrayView: UIView = {
        
        let viiew = UIView()
        viiew.translatesAutoresizingMaskIntoConstraints = false
        viiew.backgroundColor = UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1.0)
        viiew.roundCorners(cornerRadiuns: 15.0, typeCorners: [.upperRight,.upperLeft])
        
       return viiew
    }()
    
    // MARK: Lógica -

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        view.addSubview(backGroundImage)
        view.addSubview(backGroundWhiteView)
        view.addSubview(backGroundGrayView)
        view.addSubview(carLabel)
        view.addSubview(loginLabel)
        view.addSubview(loginTextFiled)
        view.addSubview(passwordLabel)
        view.addSubview(passWordTextFiled)
        view.addSubview(keepLoggedLabel)
        view.addSubview(keepLoggedSwitch)
        view.addSubview(loginButton)
        view.addSubview(rememberPasswordButton)
        view.addSubview(signUpLabel)
        view.addSubview(signUpButton)

        MakeConstraints()
    }
    
   @objc func didTapLoginButton() {
        
        let userData = isValidateLoginFields()
        if !userData.isEmpty {
            
            makeLogin(userData: userData)
           
            
        } else {
            
            showAlert(title: "Preencha todos os campos!!")
            
        }
        
    }
    
  func makeLogin(userData:[String:String]) {
        let data = try? JSONSerialization.data(withJSONObject: userData)
        api.execute(model: LoginResponse.self,
                    method: "POST",
                    headers: ["Content-Type":"application/json"],
                    body: data,
                    url: "https://carros-springboot.herokuapp.com/api/v2/login") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let token = response.token {
                    let acToken = Data(token.utf8)

                    do {
                        try self.keyC.saveToken(token: acToken, identifier: "accessToken")
                        self.navigationController?.pushViewController(self.cars, animated: true)
                        UserDefaults.standard.set(self.keepLoggedSwitch.isOn, forKey: "logSwitch")
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                } else {
                    self.showAlert(title: "Login ou senha incorretos")
                }
            case .failure( _):
                self.showAlert(title: "Ops! ocorreu um erro, tente novamente.")

            }
            
        }
    }
    
   func isValidateLoginFields() -> [String:String] {
        
        guard let user = loginTextFiled.text, !user.isEmpty, let pass = passWordTextFiled.text, !pass.isEmpty else { return [:] }
        
        return ["username":user,"password":pass]
    }
    
    func showAlert(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okButton)
        self.present (alertController, animated: true, completion: nil)
    }
    
    // MARK: Constraints -
    
    func MakeConstraints() {
        
        NSLayoutConstraint.activate([
        
            self.backGroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.backGroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.backGroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            self.backGroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.backGroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.backGroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         
            self.carLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.carLabel.centerYAnchor.constraint(equalTo: self.backGroundGrayView.centerYAnchor),
            
            self.loginLabel.leadingAnchor.constraint(equalTo: self.loginTextFiled.leadingAnchor),
            self.loginLabel.topAnchor.constraint(equalTo: self.carLabel.bottomAnchor, constant: 30),
            
            self.loginTextFiled.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.loginTextFiled.topAnchor.constraint(equalTo: self.loginLabel.bottomAnchor, constant: 10),
            self.loginTextFiled.leadingAnchor.constraint(equalTo: self.backGroundWhiteView.leadingAnchor, constant: 8),
            self.loginTextFiled.trailingAnchor.constraint(equalTo: self.backGroundWhiteView.trailingAnchor, constant: -8),
            
            self.passwordLabel.leadingAnchor.constraint(equalTo: self.passWordTextFiled.leadingAnchor),
            self.passwordLabel.topAnchor.constraint(equalTo: self.loginTextFiled.bottomAnchor, constant: 10),
            
            self.passWordTextFiled.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.passWordTextFiled.topAnchor.constraint(equalTo: self.passwordLabel.bottomAnchor, constant: 10),
            self.passWordTextFiled.leadingAnchor.constraint(equalTo: self.loginTextFiled.leadingAnchor),
            self.passWordTextFiled.trailingAnchor.constraint(equalTo: self.loginTextFiled.trailingAnchor),
            
            self.keepLoggedLabel.leadingAnchor.constraint(equalTo: self.passWordTextFiled.leadingAnchor),
            self.keepLoggedLabel.topAnchor.constraint(equalTo: self.passWordTextFiled.bottomAnchor, constant: 40),
            
            self.keepLoggedSwitch.leadingAnchor.constraint(equalTo: self.keepLoggedLabel.trailingAnchor, constant: 5),
            self.keepLoggedSwitch.centerYAnchor.constraint(equalTo: self.keepLoggedLabel.centerYAnchor),
            
            self.loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.loginButton.topAnchor.constraint(equalTo: self.keepLoggedSwitch.bottomAnchor, constant: 15),
            self.loginButton.leadingAnchor.constraint(equalTo: self.loginTextFiled.leadingAnchor),
            self.loginButton.trailingAnchor.constraint(equalTo: self.loginTextFiled.trailingAnchor),
            
            self.rememberPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.rememberPasswordButton.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 10),
            
            self.backGroundWhiteView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.backGroundWhiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            self.backGroundWhiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            self.backGroundWhiteView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -260),
            self.backGroundWhiteView.bottomAnchor.constraint(equalTo: self.signUpButton.bottomAnchor, constant: 20),
            
            self.backGroundGrayView.topAnchor.constraint(equalTo: self.backGroundWhiteView.topAnchor),
            self.backGroundGrayView.leadingAnchor.constraint(equalTo: self.backGroundWhiteView.leadingAnchor),
            self.backGroundGrayView.trailingAnchor.constraint(equalTo: self.backGroundWhiteView.trailingAnchor),
            self.backGroundGrayView.bottomAnchor.constraint(equalTo: self.backGroundWhiteView.topAnchor, constant: 40),
            
            self.signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.signUpLabel.topAnchor.constraint(equalTo: self.rememberPasswordButton.bottomAnchor, constant: 70),
            
            self.signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.signUpButton.topAnchor.constraint(equalTo: self.signUpLabel.bottomAnchor, constant: 1)
            
        ])
        
    }


}



