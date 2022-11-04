//
//  CustomTableViewCell.swift
//  DesafioWeslley
//
//  Created by Gabriel Carvalho on 02/11/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    lazy var label: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = ""
       
        return label
    }()

    lazy var image: UIImageView = {
       
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
     
        
        return image
    }()

    
    
    static let identifier = "CustomCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(label)
        contentView.addSubview(image)
        
        cts()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cts() {
        
        NSLayoutConstraint.activate([
        
            self.label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            self.label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            self.image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            self.image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            self.image.bottomAnchor.constraint(equalTo: self.label.topAnchor, constant: -15),
            self.image.widthAnchor.constraint(equalToConstant: 200),
        ])
        
    }
    
}
