//
//  ViewController.swift
//  News
//
//  Created by Sonata Girl on 04.02.2023.

import UIKit

final class ViewController: UIViewController {
    
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
                self?.listOfNewsDetails = articles.compactMap({
                    NewsDetails(title: $0.title,
                                description: $0.description ?? "No description",
                                url: $0.url,
                                publishedAt: self?.convertIosDateToFormat(jsonDate: $0.publishedAt) ?? "",
                                urlToImage: URL(string: $0.urlToImage ?? ""),
                                viewsCount: 0,
                                source: $0.source
                    )
                })
        
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func convertIosDateToFormat(jsonDate: String) -> String {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let oldDate = olDateFormatter.date(from: jsonDate)
        
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "MMM dd yyyy h:mm a"

        guard let oldDate else {
            return convertDateFormatter.string(from: Date())
        }
        return convertDateFormatter.string(from: oldDate)
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfNewsDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}

        cell.configure(with: listOfNewsDetails[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetaislVC()
        detailsVC.newsDetail = listOfNewsDetails[indexPath.row]
        detailsVC.newsDetail?.viewsCount = (detailsVC.newsDetail?.viewsCount ?? 0) + 1
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {return}
        cell.configure(with: listOfNewsDetails[indexPath.row])
       
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}






