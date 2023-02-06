//
//  ViewController.swift
//  News
//
//  Created by Sonata Girl on 04.02.2023.

import UIKit

final class ViewController: UIViewController {
    
    var listOfTopNews = [NewsTableViewCellModel]()
    var listOfNewsDetails = [NewsDetails]()
    
    private let tableView: UITableView = {
            let tableView = UITableView()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
       
        loadNews()
        setupNavBar()
       
        view.addSubview(tableView)
    }
    
    private func setupNavBar() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EE d MMMM"

        navigationItem.titleView?.backgroundColor = .red
        navigationItem.backButtonTitle = "To main news"
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        let label = UILabel()
        label.text = "News"
        label.font = .boldSystemFont(ofSize: 35)
        label.textColor = .systemTeal
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        
        let labelRight = UILabel()
        labelRight.text = formatter.string(from: date)
        labelRight.font = .systemFont(ofSize: 20)
        labelRight.textColor = .systemTeal
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: labelRight)
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func loadNews() {
        
        APIRequest.shared.getTopNews { [weak self] result in
            switch result {
            case .success(let articles):
                self?.listOfTopNews = articles.compactMap({
                    NewsTableViewCellModel(
                        title: $0.title,
                        description: $0.description ?? "No description",
                        imageURL: URL(string: $0.urlToImage ?? "")
                    )
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
                
            }
        }
        
        //        var description = "Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger. The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKitCore/UIView.h> may also be helpful."
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd/MM/YYYY"
//        let dateString = formatter.string(from: date)
//
//
//        listOfTopNews.append(NewsDetails(title: "NEWS 1", publishedAt: dateString, description: description, urlToImage: "imageFirst", url: "www.news1.com", source: Source(name: "Google")))
//        listOfTopNews.append(NewsDetails(title: "NEWS 2", publishedAt: dateString, description: description, urlToImage: "imageFirst", url: "www.news2/com", source: Source(name: "Google")))
////        listOfTopNews.append(NewsDetails(title: "NEWS 3", publishedAt: dateString, description: description, urlToImage: "imageFirst", url: "www.news3.com", source: Source(name: "Google"), viewsCount: 26))
//        listOfTopNews.append(NewsDetails(title: "NEWS 3", publishedAt: dateString, description: description, urlToImage: "imageFirst", url: "www.news3.com", source: Source(name: "Google")))
//
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfTopNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}

        cell.configure(with: listOfTopNews[indexPath.row])            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetaislVC()
        detailsVC.newsDetail = listOfTopNews[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}






