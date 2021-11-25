//
//  WebViewController.swift
//  NewsApiOrg
//
//  Created by edgars.vasiljevs on 20/11/2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController,
                         WKNavigationDelegate { // to navigate on web-application

    var urlString = String()
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Web"
        guard let url = URL(string: urlString) else {return}
        
        webView.load(URLRequest(url: url)) // don't forget to load!!!!!
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish navigation")
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
    }
    
}
