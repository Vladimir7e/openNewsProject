//
//  EmailedViewController.swift
//  openNewsProject
//
//  Created by Developer on 08.05.2022.
//

import UIKit

class EmailedViewController: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate {
    
    let itemsPerRov: CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Most emailed"
        
//        collectionView.register(EmailedCollectionViewCell.self, forCellWithReuseIdentifier: "EmailedCollectionViewCell")

        let nibCell = UINib(nibName: "EmailedCollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "EmailedCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self

  }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmailedCollectionViewCell", for: indexPath) as! EmailedCollectionViewCell
//        let imageName = photos[indexPath.item]
//        let image = UIImage(named: imageName)
//        cell.imageView.image = image
//        cell.descriptionTF.text = "Hello "

//        cell.backgroundColor = .gray
        return cell
    }
}

extension EmailedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddinWidth = sectionInserts.left * (itemsPerRov + 1)
        let availableWidht = collectionView.frame.width - paddinWidth
        let widthPerItem = availableWidht / itemsPerRov
        return CGSize(width: widthPerItem, height: 80)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
