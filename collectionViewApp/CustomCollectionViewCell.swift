//
//  CustomCollectionViewCell.swift
//  collectionViewApp
//
//  Created by Ruslan Baigeldiyev on 21.01.2023.
//

import Foundation

class CustomCollectionViewCell: UICollectionViewCell {
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(button)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        // Add constraints for the button
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func buttonTapped() {
        self.backgroundColor = .red
    }
}
