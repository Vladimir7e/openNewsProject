//
//  DetailViewController.swift
//  openNewsProject
//
//  Created by Developer on 30.05.2022.
//

import UIKit
import WebKit

protocol IDetailViewController: AnyObject {
    func setup(with viewModel: DetailViewModel)

}

class DetailViewController: UIViewController, WKNavigationDelegate {
    
    // Dependencies
    private let presenter: IDetailPresenter

    // MARK: - IBOutlet
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - Initialization
    init(
        presenter: IDetailPresenter
    ) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setup()
        presenter.viewDidLoad()
    }
    
    private func setup() {
        setupWebView()
    }
    
    private func setupWebView() {
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
    }
}

extension DetailViewController: IDetailViewController {
    func setup(with viewModel: DetailViewModel) {
        if let url: URL = .init(string: viewModel.url) {
            webView.load(URLRequest(url: url))
        }
        navigationItem.title = viewModel.title
    }
}
