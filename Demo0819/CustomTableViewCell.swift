//
//  CustomTableViewCell.swift
//  Demo0819
//
//  Created by 維衣 on 2023/9/29.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    var label: UILabel!
//    var customButton: UIButton!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    private func setupUI() {
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "預約"
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12)
        ])
        
    }
        
    @objc private func customButtonTapped() {
        
    }

}
