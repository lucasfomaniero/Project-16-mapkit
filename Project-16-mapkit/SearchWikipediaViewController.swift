//
//  SearchWikipediaViewController.swift
//  Project-16-mapkit
//
//  Created by Lucas Maniero on 02/04/22.
//

import UIKit
import WebKit

class SearchWikipediaViewController: UIViewController {
    
    var stringToSearch: String? {
        didSet {
            title = stringToSearch
            stringToSearch = stringToSearch?.replacingOccurrences(of: " ", with: "_")
        }
    }
    var webView: WKWebView!
    
    var wikipediaURL: URL?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadURL()
    }
    
    func loadURL() {
        guard let text = stringToSearch, let url = URL(string: "https://en.wikipedia.org/wiki/\(text)") else {return}
        webView.load(URLRequest(url: url))
    }

}
