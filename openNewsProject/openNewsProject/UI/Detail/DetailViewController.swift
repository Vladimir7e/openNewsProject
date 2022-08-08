//
//  DetailViewController.swift
//  openNewsProject
//
//  Created by Developer on 30.05.2022.
//

import UIKit
import WebKit
import CoreData

protocol IDetailViewController: AnyObject, ActivityIndicatorProtocol, ErrorAlertProtocol {
    func setup(with viewModel: DetailViewModel)
}

class DetailViewController: UIViewController, WKNavigationDelegate {
    // Dependencies
    private let presenter: IDetailPresenter
    
    // MARK: - IBOutlet
    @IBOutlet weak var webView: WKWebView!
    
    // UI elements
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
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

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!,
                 withError error: Error) {
        presentErrorAlert(item: NetworkError.server(.init(errorDescription: error.localizedDescription)))
        presenter.activityIndicatorDidFinish()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        presenter.activityIndicatorDidCommit()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        presenter.activityIndicatorDidFinish()
    }
    
    private func setup() {
        setupWebView()
        setupRefreshControl()
    }
    
    private func setupRefreshControl() {
        let refreshControl: UIRefreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(reloadWebView(_:)), for: .valueChanged)
            webView.scrollView.addSubview(refreshControl)
    }
    
    @objc private func reloadWebView(_ sender: UIRefreshControl) {
        presenter.refreshData()
        sender.endRefreshing()
    }
    
    private func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    private func setupWebView() {
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
    }
}

extension DetailViewController: IDetailViewController {
    func setup(with viewModel: DetailViewModel) {
        showActivityIndicator()
        if let url: URL = .init(string: viewModel.url) {
            webView.load(URLRequest(url: url))
        }
        navigationItem.title = viewModel.title
    }
}
