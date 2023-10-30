//
//  ContentViewController.swift
//  Demo0819
//
//  Created by 維衣 on 2023/10/23.
//

import UIKit

class ContentViewController: UIViewController {
    
    var imageName: String = ""
    var titleText: String = ""
    var descriptionText: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
        imageView.image = UIImage(named: imageName)
        view.addSubview(imageView)

        let titleLabel = UILabel(frame: CGRect(x: 20, y: 140, width: 200, height: 30))
        titleLabel.text = titleText
        view.addSubview(titleLabel)
        
        let descriptionLabel = UILabel(frame: CGRect(x: 20, y: 180, width: 280, height: 100))
        descriptionLabel.text = descriptionText
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        view.addSubview(descriptionLabel)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
