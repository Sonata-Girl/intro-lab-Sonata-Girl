//
//  NewsTableViewCell.swift
//  News
//
//  Created by Sonata Girl on 03.02.2023.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
    
    private let newsImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let contentNewsStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.contentMode = .scaleToFill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let newsTitleLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.black.withAlphaComponent(1)
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
   
    private let viewsCountLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.brown.withAlphaComponent(1)
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
        configureCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        let sideConstant: CGFloat = 16
        
        contentView.addSubview(newsTitleLabel)
        NSLayoutConstraint.activate([
            newsTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            newsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideConstant)
        ])
        
        contentView.addSubview(contentNewsStack)
        NSLayoutConstraint.activate([
            contentView.trailingAnchor.constraint(equalTo: contentNewsStack.trailingAnchor, constant: 6),
            contentView.bottomAnchor.constraint(equalTo: contentNewsStack.bottomAnchor),
        ])
        
        contentNewsStack.addArrangedSubview(newsImageView)
        contentNewsStack.addArrangedSubview(viewsCountLabel)

        NSLayoutConstraint.activate([
            newsImageView.widthAnchor.constraint(equalToConstant: 60),
            newsImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    

    }
    
    func configure(newsTitle: String, imageNews: UIImage?, viewsCount: Int) {
        
        let imageNews = imageNews ?? UIImage(named: "NoImage")
        
        newsTitleLabel.text = newsTitle
        newsImageView.image = imageNews
        viewsCountLabel.text = "👁️ " + String(viewsCount)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        newsImageView.image = nil
        viewsCountLabel.text = nil
    }
}

extension NewsTableViewCell {
    static var identifier: String{
        return String(describing: self)
    }
}
