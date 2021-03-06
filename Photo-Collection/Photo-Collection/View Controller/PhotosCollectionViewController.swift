//
//  PhotosCollectionViewController.swift
//  Photo-Collection
//
//  Created by Ilgar Ilyasov on 9/13/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoCollectionCell"

class PhotosCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    let photoController = PhotoController()
    let themeHelper = ThemeHelper()

    // MARK: - Functions
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
        setTheme()
    }

    // MARK: - Set theme
    
    func setTheme() {
        
        if let currentTheme = themeHelper.themePreference {
            if currentTheme == "Aqua" {
                self.collectionView?.backgroundColor = .blue
            } else if currentTheme == "Dark" {
                self.collectionView?.backgroundColor = .gray
            }
        }
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CollectionCellSegue" {
            guard let destionationVC = segue.destination as? PhotoDetailViewController else { return }
            
            destionationVC.themeHelper = themeHelper
            destionationVC.photoController = photoController
            
            guard let cell = sender as? PhotosCollectionViewCell,
                  let index = collectionView?.indexPath(for: cell) else { return }
            
            let thePhoto = photoController.photos[index.item]
            destionationVC.photo = thePhoto
            
        } else if segue.identifier == "AddButtonSegue" {
            guard let destionationVC = segue.destination as? PhotoDetailViewController else { return }
            destionationVC.themeHelper = themeHelper
            destionationVC.photoController = photoController
            
        } else if segue.identifier == "SelectThemeSegua"{
            guard let destionationVC = segue.destination as? ThemeSelectionViewController else { return }
            destionationVC.themeHelper = themeHelper
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoController.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        let thePhoto = photoController.photos[indexPath.item]
        
        cell.photoTextLabel.text = thePhoto.title
        cell.photoImageView.image = UIImage(data: thePhoto.imageData)
        
        return cell
    }
}
