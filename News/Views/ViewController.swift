//
//  ViewController.swift
//  News
//
//  Created by Sonata Girl on 04.02.2023.

import UIKit

class ViewController: UIViewController {
    
    var listOfTopNews = [NewsDetails]()
    
    private let tableView: UITableView = {
            let tableView = UITableView()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNews()
        setupNavBar()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 75
        
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
        label.text = "Main NEWS of " + formatter.string(from: date)
        label.font = .systemFont(ofSize: 25)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func loadNews() {
        listOfTopNews.append(NewsDetails(title: "NEWS 1", imageName: "imageFirst", viewsCount: 4))
        listOfTopNews.append(NewsDetails(title: "NEWS 2", imageName: "imageFirst", viewsCount: 45))
        listOfTopNews.append(NewsDetails(title: "NEWS 3", imageName: "imageFirst", viewsCount: 54))
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfTopNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}

        let newsData = listOfTopNews[indexPath.row]
        
        cell.configure(newsTitle: newsData.title, imageNews: UIImage(named: newsData.imageName), viewsCount: newsData.viewsCount)
                   
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetaislVC()
        self.navigationController?.pushViewController(detailsVC, animated: true)
        
    }
}






