//
//  CustomTableViewCell.swift
//  DesafioWeslley
//
//  Created by Gabriel Carvalho on 02/11/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // MARK: Componentes de view ------------------
    
    lazy var carNameLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = ""
       
        return label
    }()

    lazy var carImage: UIImageView = {
       
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    // MARK: Lógica ------------------
    
    static let identifier = "CustomCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(carNameLabel)
        contentView.addSubview(carImage)
        
        cts()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: constraints ------------------
    
    func cts() {
        
        NSLayoutConstraint.activate([
        
            self.carNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            self.carNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            self.carImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            self.carImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            self.carImage.bottomAnchor.constraint(equalTo: self.carNameLabel.topAnchor, constant: -15),
            self.carImage.widthAnchor.constraint(equalToConstant: 200),
        ])
        
    }
    
}
