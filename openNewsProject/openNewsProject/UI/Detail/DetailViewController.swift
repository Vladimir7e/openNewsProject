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
//    func setButtonState(isSelected: Bool)
}

class DetailViewController: UIViewController, WKNavigationDelegate {
    // Dependencies
    private let presenter: IDetailPresenter
    
    // MARK: - IBOutlet
    @IBOutlet weak var webView: WKWebView!
    private let saveButton: UIButton = UIButton(type: .system)
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
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        presenter.activityIndicatorDidCommit()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        presenter.activityIndicatorDidFinish()
    }
    
    private func setup() {
//        setupNavigation()
//        setupSaveButton()
        setupWebView()
    }
    
//    private func setupNavigation() {
//        navigationItem.rightBarButtonItem = .init(customView: saveButton)
//    }
    
//    private func setupSaveButton() {
//        saveButton.setTitle(R.string.localizable.save(), for: .normal)
//        saveButton.setTitle(R.string.localizable.delete(), for: .selected)
//        saveButton.titleLabel?.adjustsFontSizeToFitWidth = true
//        saveButton.setTitleColor(.black, for: .normal)
//        saveButton.setTitleColor(.black, for: .selected)
//        saveButton.tintColor = .white
//        saveButton.addTarget(self, action: #selector(favorites), for: .touchUpInside)
//    }
    
    private func setupWebView() {
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
    }
    
//    @objc private func favorites() {
//        saveButton.isSelected = !saveButton.isSelected
//        presenter.didTapRightItemButton(isSelected: saveButton.isSelected)
//    }
}

extension DetailViewController: IDetailViewController {
    func setup(with viewModel: DetailViewModel) {
        showActivityIndicator()
        if let url: URL = .init(string: viewModel.url) {
            webView.load(URLRequest(url: url))
        }
        navigationItem.title = viewModel.title
    }
    
//    func setButtonState(isSelected: Bool) {
//        saveButton.isSelected = isSelected
//    }
}
