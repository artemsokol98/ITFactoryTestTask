//
//  SectionHeaderLabel.swift
//  ITFactoryTestTask
//
//  Created by Артем Соколовский on 23.01.2023.
//

import UIKit

class SectionHeaderLabel: UITableViewHeaderFooterView {
    
    static let identifier = "SectionHeaderLabel"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Default text"
        label.font = .systemFont(ofSize: Constants.fontSizeForSection, weight: .bold)
        return label
    }()
    
    func configureHeader(text: String) {
        label.text = text
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundColor = Constants.appBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let labelConstraints = [
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spaceFromEdge),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.spaceFromEdge),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor)
        ]
        
        NSLayoutConstraint.activate(labelConstraints)
    }
}
