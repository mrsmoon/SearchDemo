//
//  SearchTableViewCell.swift
//  Demo
//
//  Created by Seher Aytekin on 12/28/23.
//

import UIKit

protocol ViewConfigurable {
    associatedtype Item
    func configure(with model: Item)
}

class SearchTableViewCell: UITableViewCell, ViewConfigurable {
    lazy var rentalLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        addSubview(rentalLabel)
        rentalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rentalLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            rentalLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            rentalLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            rentalLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: Rental) {
        rentalLabel.text = model.attributes.name
    }

}
