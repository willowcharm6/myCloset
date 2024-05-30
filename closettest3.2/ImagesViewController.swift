//
//  ImagesViewController.swift
//  closettest3.2
//
//  Created by Charmaine_Guo on 11/8/23.
//

import UIKit

class ImagesViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
//    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let imagePicker = UIImagePickerController()
    var uploadedImages: [UIImage] = [] // Array to hold the uploaded images
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        imagePicker.allowsEditing = false // You can set this to true to enable editing
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
    }
    
    // MARK: UICollectionViewDataSource
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return uploadedImages.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell

            // Set the image for the cell            cell.imageView.image = uploadedImages[indexPath.item]
            
            return cell
        }
    

    @IBAction func uploadButtonTapped(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    // Delegate method to handle the image selection
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            uploadedImages.append(pickedImage)
            collectionView.reloadData()
            // Do something with the selected image (e.g., display it in imageView or upload it to a server)
        }

        dismiss(animated: true, completion: nil)
    }

    // Delegate method for canceling image picking
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    // Other cell setup or configurations
}
