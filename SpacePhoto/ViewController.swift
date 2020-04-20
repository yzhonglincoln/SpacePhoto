//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Soft Dev on 3/2/20.
//  Copyright © 2020 Alice Zhong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // set labels
        descriptionLabel.text = ""
        copyrightLabel.text = ""
        
        // send network request
        photoInfoController.fetchPhotoInfo { (photoInfo) in
            if let photoInfo = photoInfo {
                self.updateUI(with: photoInfo)
            }
        }
    }

    // outlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    let photoInfoController = PhotoInfoController()
    
    func updateUI(with photoInfo: PhotoInfo) {
        let task = URLSession.shared.dataTask(with: photoInfo.url, completionHandler: {(data, response, error) in
            guard let data = data,
                let image = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                self.title = photoInfo.title
                self.photoImageView.image = image
                self.descriptionLabel.text = photoInfo.description
                
                if let copyright = photoInfo.copyright {
                    self.copyrightLabel.text = "Copyright \(copyright)"
                } else {
                    self.copyrightLabel.isHidden = true
                }
            }
        })
        task.resume()
    }
    
}

