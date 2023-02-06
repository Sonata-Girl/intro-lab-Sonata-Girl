//
//  DetailsVC.swift
//  News
//
//  Created by Sonata Girl on 04.02.2023.
//

import UIKit

final class DetaislVC: UIViewController {
    
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
    var newsDetail: NewsTableViewCellModel? = nil
    
    private let scrollView: UIScrollView = {
        var scroll = UIScrollView()
        scroll.contentMode = .scaleToFill
        
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.contentInsetAdjustmentBehavior = .never
        return scroll
    }()
    
    private let mainView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let newsTitleLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
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
        textView.textColor = .black
        textView.font = .systemFont(ofSize: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let newsDateLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let newsSourceLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black.withAlphaComponent(1)
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let newsLink: UIButton = {
        var button = UIButton()
        
        button.setTitle("To full news", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
//    init(newsDetail: NewsDetails?) {
//        super.init(coder: <#T##NSCoder#>)
//        self.newsDetail = newsDetail
//    }
    
//    @available(*,unavailable)
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        loadNewsDetails()
        setupUI()
    }
    
    private func setupUI() {
//        scrollView.contentSize = view.frame.size
        
        let horizontalConstant: CGFloat = 20
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: CGFloat(100))
        ])
    
        scrollView.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            mainView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor)
        ])
        
        mainView.addSubview(newsTitleLabel)
        NSLayoutConstraint.activate([
            newsTitleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            newsTitleLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            newsTitleLabel.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.15),
            newsTitleLabel.widthAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.5),
        ])
        
        mainView.addSubview(newsImageView)
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: horizontalConstant),
            newsImageView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            newsImageView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.3),
            newsImageView.widthAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.5)
        ])
        
        mainView.addSubview(descriptionNews)
        NSLayoutConstraint.activate([
            descriptionNews.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 20),
            descriptionNews.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            descriptionNews.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.3),
            descriptionNews.widthAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.5),
        ])
        
        mainView.addSubview(newsLink)
        NSLayoutConstraint.activate([
            mainView.bottomAnchor.constraint(equalTo: newsLink.bottomAnchor, constant: horizontalConstant),
            mainView.trailingAnchor.constraint(equalTo: newsLink.trailingAnchor, constant: horizontalConstant)
        ])
        newsLink.addTarget(self, action: #selector(openFullPage), for: .touchUpInside)
        
        mainView.addSubview(newsSourceLabel)
        NSLayoutConstraint.activate([
            newsLink.topAnchor.constraint(equalTo: newsSourceLabel.bottomAnchor, constant: 10),
            mainView.trailingAnchor.constraint(equalTo: newsSourceLabel.trailingAnchor, constant: horizontalConstant),
        ])
   
        mainView.addSubview(newsDateLabel)
        NSLayoutConstraint.activate([
            newsLink.topAnchor.constraint(equalTo: newsDateLabel.bottomAnchor, constant: 10),
            newsDateLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: horizontalConstant),
            newsDateLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor)
        ])
 
    }
        
    private func loadNewsDetails() {

        newsTitleLabel.text = newsDetail?.title
        newsImageView.image = UIImage(data: newsDetail?.imageData ?? Data())
        descriptionNews.text = newsDetail?.description
//        newsDateLabel.text = newsDetail?.
//        newsLink.setTitle(newsDetail?.url, for: .normal)
//        newsSourceLabel.text = newsDetail?.source.name
    }
    
    @objc private func openFullPage(sender: UIButton) {
        let vc = FullPageNews()
        vc.adressURL = sender.currentTitle ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
