//
//  ViewController.swift
//  DesafioWeslley
//
//  Created by Gabriel Carvalho on 03/11/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    let car: CarModel
    var api = Api()

    
    lazy var carImage: UIImageView = {
        
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
         
      return image
 }()
     
     lazy var carNameLabel: UILabel = {
        
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = " "
         
         return label
     }()

    lazy var modelLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Modelo"
        label.textColor = .red
        
       return label
    }()
    
    lazy var descriptionLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Descrição"
        label.textColor = .red
        
        return label
    }()
    
    lazy var carDescription: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = " "
        
        return label
    }()
    
    init(car: CarModel) {
        
        self.car = car
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        api.fetchImage(url: car.urlFoto ?? "https://cdn.autopapo.com.br/box/uploads/2020/10/29144818/carro_roubado-732x488.jpg") { image in
            DispatchQueue.main.async {
                self.carImage.image = image
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "Detalhes"
        
        self.carNameLabel.text = car.nome
        self.carDescription.text = car.descricao

        view.addSubview(modelLabel)
        view.addSubview(carImage)
        view.addSubview(carNameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(carDescription)
        
        makeConstraints()
    }
    
        func makeConstraints() {
      
      NSLayoutConstraint.activate([
      
        self.carImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        self.carImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        self.carImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        self.carImage.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
          
        self.modelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        self.modelLabel.topAnchor.constraint(equalTo: self.carImage.bottomAnchor, constant: 30),
        
        self.carNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        self.carNameLabel.topAnchor.constraint(equalTo: self.modelLabel.bottomAnchor, constant: 10),
        
        self.descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        self.descriptionLabel.topAnchor.constraint(equalTo: self.carNameLabel.bottomAnchor, constant: 20),
        
        self.carDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        self.carDescription.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 10),
        self.carDescription.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 5),
        self.carDescription.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: 5)
        
      ])
      
      
  }

}
