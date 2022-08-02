//
//  DescriptionViewController.swift
//  openNewsProject
//
//  Created by Developer on 27.07.2022.
//

import UIKit
import Kingfisher
import CoreData

protocol IDescriptionViewController: AnyObject {
    func setup(viewModel: DescriptionViewModel)
    func setButtonState(isSelected: Bool)
}

class DescriptionViewController: UIViewController {
    
    private let presenter: IDescriptionPresenter
    
    private let scrollView: UIScrollView = {
        let view: UIScrollView = UIScrollView()
        view.backgroundColor = .secondarySystemGroupedBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let saveButton: UIButton = UIButton(type: .system)
    
    private let stackView: UIStackView = {
        let view: UIStackView = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fill
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view: UILabel = UILabel()
        view.numberOfLines = 0
        view.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        return view
    }()
    
    private let publishedDateLabel: UILabel = {
        let view: UILabel = UILabel()
        return view
    }()
    
    private let imageView: UIImageView = {
        let view: UIImageView = UIImageView()
        return view
    }()
    
    private let abstractLabel: UILabel = {
        let view: UILabel = UILabel()
        view.numberOfLines = 0
        return view
    }()
    
    private var button: UIButton = {
        let view: UIButton = UIButton()
        view.setTitle("read more", for: .normal)
        view.backgroundColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(
        presenter: IDescriptionPresenter) {
            self.presenter = presenter
            super.init(nibName: nil, bundle: nil)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.viewDidLoad()
        setupScrollView()
    }
    
    private func setupScrollView() {
        let margins: UILayoutGuide = view.layoutMarginsGuide
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(publishedDateLabel)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(abstractLabel)
        stackView.addArrangedSubview(button)
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        stackView.setCustomSpacing(10, after: titleLabel)
        stackView.setCustomSpacing(10, after: abstractLabel)
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
    }
    
    private func setup() {
        setupNavigation()
        setupSaveButton()
    }
    
    private func setupNavigation() {
        navigationItem.rightBarButtonItem = .init(customView: saveButton)
    }
    
    private func setupSaveButton() {
        saveButton.setTitle(R.string.localizable.save(), for: .normal)
        saveButton.setTitle(R.string.localizable.delete(), for: .selected)
        saveButton.titleLabel?.adjustsFontSizeToFitWidth = true
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.setTitleColor(.black, for: .selected)
        saveButton.tintColor = .white
        saveButton.addTarget(self, action: #selector(favorites), for: .touchUpInside)
    }
    
    @objc private func favorites() {
        saveButton.isSelected = !saveButton.isSelected
        presenter.didTapRightItemButton(isSelected: saveButton.isSelected)
    }
}

extension DescriptionViewController: IDescriptionViewController {
    func setup(viewModel: DescriptionViewModel) {
        titleLabel.text = viewModel.title
        publishedDateLabel.text = viewModel.publishedDate
        abstractLabel.text = viewModel.abstract
        button.addTarget(self, action: #selector(some), for: .touchUpInside)
        imageView.kf.indicatorType = .activity
        guard let imagePath: String = viewModel.imagePath else {
            return
        }
        imageView.kf.setImage(with: URL(string: imagePath))
    }
    
    func setButtonState(isSelected: Bool) {
        saveButton.isSelected = isSelected
    }
    
    @objc func some() {
        presenter.some1()
    }
}
