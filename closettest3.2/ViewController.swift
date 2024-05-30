import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    let imagesGallery1 = ["top1", "top2", "top3"] // Replace with your image names for gallery 1
    let imagesGallery2 = ["bottom1", "bottom2", "bottom3"] // Replace with your image names for gallery 2
    let imagesGallery3 = ["shoes1", "shoes2", "shoes3"] // Replace with your image names for gallery 3
    
    var currentImageIndex1 = 0
    var currentImageIndex2 = 0
    var currentImageIndex3 = 0
    var topSavedNum = 0
    var bottomSavedNum = 0
    var shoesSavedNum = 0
    
    var initialCenter = CGPoint()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show the first images when the view loads
        imageView1.image = UIImage(named: imagesGallery1[currentImageIndex1])
        imageView2.image = UIImage(named: imagesGallery2[currentImageIndex2])
        imageView3.image = UIImage(named: imagesGallery3[currentImageIndex3])
        
        addSwipeGesture(to: imageView1, gallery: 1)
        addSwipeGesture(to: imageView2, gallery: 2)
        addSwipeGesture(to: imageView3, gallery: 3)
        
    }
    
    func addSwipeGesture(to imageView: UIImageView, gallery: Int) {
            let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
            swipeGesture.maximumNumberOfTouches = 1
            swipeGesture.minimumNumberOfTouches = 1
            imageView.isUserInteractionEnabled = true
            imageView.tag = gallery
            imageView.addGestureRecognizer(swipeGesture)
        }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        topSavedNum = currentImageIndex1
        bottomSavedNum = currentImageIndex2
        shoesSavedNum = currentImageIndex3
        }
    @IBAction func outfit1ButtonTapped(_ sender: UIButton) {
        currentImageIndex1 = topSavedNum
        currentImageIndex2 = bottomSavedNum
        currentImageIndex3 = shoesSavedNum
        imageView1.image = UIImage(named: imagesGallery1[currentImageIndex1])
        imageView2.image = UIImage(named: imagesGallery2[currentImageIndex2])
        imageView3.image = UIImage(named: imagesGallery3[currentImageIndex3])
    }
    
    @IBAction func openNewViewControllerButtonTapped(_ sender: UIButton) {
            performSegue(withIdentifier: "ShowNewViewController", sender: self)
        }
    
    @objc func handleSwipe(_ sender: UIPanGestureRecognizer) {
            guard let imageView = sender.view as? UIImageView else { return }
            let gallery = imageView.tag
            
            switch sender.state {
            case .began:
                initialCenter = imageView.center
            case .changed:
                let translation = sender.translation(in: imageView)
                imageView.center = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y)
            case .ended:
                let translation = sender.translation(in: imageView)
                let distance = translation.x
                if distance > 50 {
                    showNextImage(for: gallery)
                } else if distance < -50 {
                    showPreviousImage(for: gallery)
                } else {
                    UIView.animate(withDuration: 0.3) {
                        imageView.center = self.initialCenter
                    }
                }
            default:
                break
            }
        }
        
        func showNextImage(for gallery: Int) {
            switch gallery {
            case 1:
                currentImageIndex1 = (currentImageIndex1 + 1) % imagesGallery1.count
                imageView1.image = UIImage(named: imagesGallery1[currentImageIndex1])
            case 2:
                currentImageIndex2 = (currentImageIndex2 + 1) % imagesGallery2.count
                imageView2.image = UIImage(named: imagesGallery2[currentImageIndex2])
            case 3:
                currentImageIndex3 = (currentImageIndex3 + 1) % imagesGallery3.count
                imageView3.image = UIImage(named: imagesGallery3[currentImageIndex3])
            default:
                break
            }
        }
        
        func showPreviousImage(for gallery: Int) {
            switch gallery {
            case 1:
                currentImageIndex1 = (currentImageIndex1 - 1 + imagesGallery1.count) % imagesGallery1.count
                imageView1.image = UIImage(named: imagesGallery1[currentImageIndex1])
            case 2:
                currentImageIndex2 = (currentImageIndex2 - 1 + imagesGallery2.count) % imagesGallery2.count
                imageView2.image = UIImage(named: imagesGallery2[currentImageIndex2])
            case 3:
                currentImageIndex3 = (currentImageIndex3 - 1 + imagesGallery3.count) % imagesGallery3.count
                imageView3.image = UIImage(named: imagesGallery3[currentImageIndex3])
            default:
                break
            }
        }
    
    
//    @IBAction func nextButtonTappedForGallery1(_ sender: UIButton) {
//        // Display the next image for Gallery 1 when the button is tapped
//        if currentImageIndex1 < imagesGallery1.count - 1 {
//            currentImageIndex1 += 1
//        } else {
//            currentImageIndex1 = 0 // Loop back to the first image
//        }
//        imageView1.image = UIImage(named: imagesGallery1[currentImageIndex1])
//    }
//
//    @IBAction func nextButtonTappedForGallery2(_ sender: UIButton) {
//        // Display the next image for Gallery 2 when the button is tapped
//        if currentImageIndex2 < imagesGallery2.count - 1 {
//            currentImageIndex2 += 1
//        } else {
//            currentImageIndex2 = 0 // Loop back to the first image
//        }
//        imageView2.image = UIImage(named: imagesGallery2[currentImageIndex2])
//    }
//
//    @IBAction func nextButtonTappedForGallery3(_ sender: UIButton) {
//        // Display the next image for Gallery 3 when the button is tapped
//        if currentImageIndex3 < imagesGallery3.count - 1 {
//            currentImageIndex3 += 1
//        } else {
//            currentImageIndex3 = 0 // Loop back to the first image
//        }
//        imageView3.image = UIImage(named: imagesGallery3[currentImageIndex3])
//    }
}
