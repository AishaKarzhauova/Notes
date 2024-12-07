//
//  NoteCell.swift
//  Notes
//
//  Created by Aisha Karzhauova on 07.12.2024.
//

import UIKit
import SnapKit

class NoteCell: UITableViewCell {
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let contentLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(contentLabel)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .gray
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textColor = .darkGray
        contentLabel.numberOfLines = 2
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalTo(titleLabel)
        }
    }
    
    func configure(with note: Note) {
        titleLabel.text = note.title
        contentLabel.text = note.content
        
        if let date = note.date {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            dateLabel.text = formatter.string(from: date)
        }
    }
}

