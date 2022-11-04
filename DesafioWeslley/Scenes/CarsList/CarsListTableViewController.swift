//
//  CarsListTableViewController.swift
//  DesafioWeslley
//
//  Created by Gabriel Carvalho on 02/11/22.
//

import UIKit

class CarsListTableViewController: UIViewController {
    
    var api = Api()
    var keyC = KeychainManager()
    
    
    
    private var carList = [CarModel]()
    
    lazy var tableView: UITableView = {
       
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        navigationItem.title = "Carros"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(logout))
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        
        let token = try! keyC.getToken(identifier: "teste")

        api.execute(model: [CarModel].self,
                    method: "GET",
                    headers:["Authorization":"Bearer \(token)"] , body: nil,
                    url: "https://carros-springboot.herokuapp.com/api/v2/carros") { result in

            switch result {
            case .success(let response):
                
                self.carList = response
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        cts()
        
    }
    
    @objc func logout() {
        
        try? keyC.deleteToken(identifier: "teste")
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
            return
        }
        
        let nav = UINavigationController(rootViewController: LoginViewController())
        sceneDelegate.window?.rootViewController = nav
        
    }
    
    func cts() {
        NSLayoutConstraint.activate([
            
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),

        ])
    }
   
}

extension CarsListTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    
  

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return carList.count
   }

   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else  { return UITableViewCell() }
        
        api.fetchImage(url: carList[indexPath.row].urlFoto ?? "https://cdn.autopapo.com.br/box/uploads/2020/10/29144818/carro_roubado-732x488.jpg") { image in
            DispatchQueue.main.async {
                cell.image.image = image
            }
        }

        cell.label.text = carList[indexPath.row].nome
        
       return cell
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailViewController(car: carList[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}
