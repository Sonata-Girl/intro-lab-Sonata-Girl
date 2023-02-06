//
//  NewsTableViewCell.swift
//  News
//
//  Created by Sonata Girl on 03.02.2023.
//

import UIKit

class NewsTableViewCellModel {
    let title: String
    let description: String?
    let imageURL: URL?
    var imageData : Data? = nil
//    var viewsCount: Int
   
    init(title: String, description: String?, imageURL: URL?) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
//        self.imageData = imageData
//        self.viewsCount = viewsCount
    }
}

final class NewsTableViewCell: UITableViewCell {
    
    private let newsImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let contentNewsStackleft: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
//        stack.contentMode = .scaleToFill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let contentNewsStackRight: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.contentMode = .scaleToFill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let newsTitleLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private let newsDescriptionLabel: UILabel = {
        var label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        return label
    }()
   
    private let viewsCountLabel: UILabel = {
        var label = UILabel()
        label.textColor = .brown.withAlphaComponent(1)
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
        
        contentView.addSubview(contentNewsStackleft)
        NSLayoutConstraint.activate([
            contentNewsStackleft.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentNewsStackleft.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideConstant)
        ])
        
        contentNewsStackleft.addArrangedSubview(newsTitleLabel)
        contentNewsStackleft.addArrangedSubview(newsDescriptionLabel)

        contentView.addSubview(contentNewsStackRight)
        NSLayoutConstraint.activate([
            contentNewsStackRight.leadingAnchor.constraint(equalTo: contentNewsStackleft.trailingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentNewsStackRight.trailingAnchor, constant: 6),
            contentView.bottomAnchor.constraint(equalTo: contentNewsStackRight.bottomAnchor),
        ])
        
        contentNewsStackRight.addArrangedSubview(newsImageView)
        contentNewsStackRight.addArrangedSubview(viewsCountLabel)

        NSLayoutConstraint.activate([
            newsImageView.widthAnchor.constraint(equalToConstant: 100),
            newsImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    
    }
    
    func configure(with viewModel: NewsTableViewCellModel) {
            
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
        newsTitleLabel.text = viewModel.title
        newsDescriptionLabel.text = viewModel.description
//        viewsCountLabel.text = "👁️ " + String(viewModel.viewsCount)
//        viewsCountLabel.text = "👁️ " + String(55)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        newsImageView.image = nil
        viewsCountLabel.text = nil
        newsDescriptionLabel.text = nil
    }
}

extension NewsTableViewCell {
    static var identifier: String{
        return String(describing: self)
    }
}
