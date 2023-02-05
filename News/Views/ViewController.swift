//
//  ViewController.swift
//  News
//
//  Created by Sonata Girl on 04.02.2023.

import UIKit

final class ViewController: UIViewController {
    
    var listOfTopNews = [NewsDetails]()
    
    private let tableView: UITableView = {
            let tableView = UITableView()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 130
        
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
//        
//        DispatchQueue.main.async {
//            NetworkService.shared.loadResults(params: ["query": "pasta", "maxFat": "25", "number": "10"]) { [weak self] (_ result: Result<ReceptsSearch, Error>) in
//                switch result {
//                case .success(let search):
//                    self?.object = search
//                    print(self?.object as Any)
//                case .failure(let error):
//                    print("Error: \(error.localizedDescription)")
//                }
//            }
//        }
        
        var description = "Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger. The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKitCore/UIView.h> may also be helpful."
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        let dateString = formatter.string(from: date)
        
        listOfTopNews.append(NewsDetails(title: "NEWS 1", imageName: "imageFirst", description: description, Date: dateString, link: "www.news1.com", SourceName: "Google",viewsCount: 4))
        listOfTopNews.append(NewsDetails(title: "NEWS 2", imageName: "imageFirst", description: description, Date: dateString, link: "www.news2.com", SourceName: "NYTime",viewsCount: 45))
        listOfTopNews.append(NewsDetails(title: "NEWS 3", imageName: "imageFirst", description: description, Date: dateString, link: "www.news3.com", SourceName: "RBK",viewsCount: 54))
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfTopNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}

        let newsData = listOfTopNews[indexPath.row]
        
        cell.configure(newsDetails: newsData)
                   
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataCell = listOfTopNews[indexPath.row]
        let detailsVC = DetaislVC()
        detailsVC.newsDetail = dataCell
        self.navigationController?.pushViewController(detailsVC, animated: true)
        
    }
}






