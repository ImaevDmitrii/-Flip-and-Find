//
//  TableSectionHeader.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 27.04.2024.
//

import UIKit

final class TableSectionHeader: UITableViewHeaderFooterView {
    private var sectionHeader: SectionHeader
    
    override init(reuseIdentifier: String?) {
        sectionHeader = SectionHeader()
        super.init(reuseIdentifier: reuseIdentifier)
        setupSectionHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSectionHeader() {
        sectionHeader.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sectionHeader)
        
        NSLayoutConstraint.activate([
            sectionHeader.topAnchor.constraint(equalTo: contentView.topAnchor),
            sectionHeader.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            sectionHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sectionHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func configure(title: String) {
        sectionHeader.configure(title: title)
    }
}
