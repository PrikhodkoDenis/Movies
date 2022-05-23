//
//  SectionHeader.swift
//  Movies
//
//  Created by Denis on 22.05.2022.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    static let reusedId = "SectionHeader"
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeElements()
        setupConstraints()
    }
    
    private func customizeElements() {
        title.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
