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
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    func configureHeader(text: String) {
        label.text = text
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(label)
        contentView.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let labelConstraints = [
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentView.bounds.width * 0.1),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -contentView.bounds.width * 0.1),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -contentView.bounds.height * 0.1),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.bounds.height * 0.1)
        ]
        
        NSLayoutConstraint.activate(labelConstraints)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
