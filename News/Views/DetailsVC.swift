//
//  DetailsVC.swift
//  News
//
//  Created by Sonata Girl on 04.02.2023.
//

import UIKit

class DetaislVC: UIViewController {

//
//    При нажатии на каждую новость должен открываться новый экран и показывать ее краткое содержимое:
//    заголовок,
//    картинку,
//    описание,
//    дату публикации,
//    источник публикации,
//    кликабельную ссылку на полный текст новости.
//    Полный текст новости должен открываться с использованием WebKit.
//    Данные о новостях (заголовок, краткое содержание, ссылка на полную версию и тд.) и счетчик просмотров необходимо кэшировать каким-либо образом.
//    Закэшированные данные отображаются перед отправлением запроса на обновление данных.
//    Закэшированные данные доступны и после перезапуска приложения.
    
    private let newsTitleLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.black.withAlphaComponent(1)
        label.font = .systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let newsImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    private let descriptionNews: UITextView = {
        var textView = UITextView()
        textView.textColor = UIColor.black.withAlphaComponent(1)
        textView.font = .systemFont(ofSize: 40)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let newsDateLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.black.withAlphaComponent(1)
        label.font = .systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let newsSourceLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.black.withAlphaComponent(1)
        label.font = .systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let newsLinkLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.black.withAlphaComponent(1)
        label.font = .systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.onClick ={
                // TODO}

        label.numberOfLines = 0
        return label
    }()
//
//    private let labelViewsCount: UILabel = {
//        var label = UILabel()
//        label.textColor = UIColor.brown.withAlphaComponent(1)
//        label.font = .systemFont(ofSize: 10)
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        return label
//    }()
//
//    var newsTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
//        newsImageView.image = UIImage(named: newsTitle)
//        labelNewsTitle.text = newsTitle
//        labelViewsCount.numberOfLines = 0
    }
    
}
