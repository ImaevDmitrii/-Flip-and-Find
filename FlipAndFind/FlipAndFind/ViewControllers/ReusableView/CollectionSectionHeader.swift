//
//  CollectionHeader.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 27.04.2024.
//

import UIKit

final class CollectionSectionHeader: UICollectionReusableView {
    private var sectionHeader: SectionHeader
    
    override init(frame: CGRect) {
        sectionHeader = SectionHeader()
        super.init(frame: frame)
        setupSectionHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSectionHeader() {
        sectionHeader.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sectionHeader)
        
        NSLayoutConstraint.activate([
            sectionHeader.topAnchor.constraint(equalTo: topAnchor),
            sectionHeader.bottomAnchor.constraint(equalTo: bottomAnchor),
            sectionHeader.leadingAnchor.constraint(equalTo: leadingAnchor),
            sectionHeader.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configure(title: String) {
        sectionHeader.configure(title: title)
    }
}
