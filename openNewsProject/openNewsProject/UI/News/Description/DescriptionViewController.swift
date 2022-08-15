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
    // Dependencies
    private let presenter: IDescriptionPresenter
    
    // UI elements
    private let scrollView: UIScrollView = UIScrollView()
    private let stackView: UIStackView = UIStackView()
    private let titleLabel: UILabel = UILabel()
    private let publishedDateLabel: UILabel = UILabel()
    private let titleImage: UIImageView = UIImageView()
    private let descriptionLabel: UILabel = UILabel()
    private lazy var readMoreButton: UIButton = UIButton(type: .system)
    private lazy var saveButton: UIButton = UIButton(type: .system)

    // MARK: - Initialization
    init(
        presenter: IDescriptionPresenter) {
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
    
    // MARK: - Private
    
    private func setup() {
        setupNavigation()
        setupUIElements()
        setupSaveButton()
    }

    private func setupUIElements() {
        let margins: UILayoutGuide = view.layoutMarginsGuide
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(publishedDateLabel)
        stackView.addArrangedSubview(titleImage)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(readMoreButton)
        
        scrollView.backgroundColor = .secondarySystemGroupedBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.setCustomSpacing(10, after: titleLabel)
        stackView.setCustomSpacing(10, after: descriptionLabel)
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        titleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        titleImage.contentMode = .scaleAspectFit
        titleImage.clipsToBounds = true
        
        descriptionLabel.numberOfLines = 0
        
        readMoreButton.setTitle("read more", for: .normal)
        readMoreButton.setTitleColor(.white, for: .normal)
        readMoreButton.setTitleColor(.black, for: .highlighted)
        readMoreButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        readMoreButton.translatesAutoresizingMaskIntoConstraints = false
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
        saveButton.addTarget(self, action: #selector(didTabSaveButton(sender:)), for: .touchUpInside)
    }
    
    @objc private func didTabSaveButton(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        presenter.didTapRightItemButton(isSelected: saveButton.isSelected)
    }
    
    @objc private func didTapReadMoreButton() {
        presenter.didTapDetailScreenButton()
    }
}

extension DescriptionViewController: IDescriptionViewController {
    func setup(viewModel: DescriptionViewModel) {
        titleLabel.text = viewModel.title
        publishedDateLabel.text = viewModel.publishedDate
        descriptionLabel.text = viewModel.abstract
        readMoreButton.addTarget(self, action: #selector(didTapReadMoreButton), for: .touchUpInside)
        titleImage.kf.indicatorType = .activity
        guard let imagePath: String = viewModel.imagePath else {
            return
        }
        titleImage.kf.setImage(with: URL(string: imagePath))
    }
    
    func setButtonState(isSelected: Bool) {
        saveButton.isSelected = isSelected
    }
}
