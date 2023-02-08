//
//  FullPageNews.swift
//  News
//
//  Created by Sonata Girl on 05.02.2023.
//

import UIKit
import WebKit

final class FullPageNews: UIViewController {
    
    var adressURL: String = "www.google.com"
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        webView.frame = view.frame
        
        let adress = adressURL
        guard let url = URL(string: adress) else{ return}
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
    

}
