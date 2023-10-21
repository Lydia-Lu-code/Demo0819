//
//  SelectPage_VC.swift
//  Demo0819
//
//  Created by 維衣 on 2023/10/28.
//

import UIKit

class SelectPage_VC2: UIViewController, UIScrollViewDelegate, UIPageViewControllerDataSource {

    var collectionView: UICollectionView?
    var escapeRoomIntroductions: [[String: String]] = [
            ["title": "神秘的海盜寶藏", "description": "想像一下，你被關進了一個神秘的海盜寶藏密室，充滿了古老的地圖、海盜寶藏和謎題。你和你的隊友必須合作，找到寶藏的線索，解開謎題，並最終逃脫出這個令人興奮的密室。"],
            ["title": "未來科技實驗室", "description": "這個密室是一個充滿未來科技的實驗室，充滿了高科技裝置和令人驚奇的發明。你的任務是阻止一個科技瘋狂科學家的邪惡計劃，解開電子謎題，找到暗藏的線索，並在時間耗盡之前完成任務。"],
            ["title": "古代文明之謎", "description": "你和你的隊友被囚禁在一個古代文明的神秘神殿內。這個密室充滿了古老的文物、符號和謎語。你們必須解開這個古老文明的謎題，找到通往自由之路的關鍵。"],
            ["title": "幽靈小屋", "description": "這個密室是一個古老的幽靈小屋，據說被鬼魂所佔據。你和你的隊友必須面對恐怖的挑戰，解開幽靈小屋的秘密，找到逃脫的出口。但要小心，不要讓幽靈抓住你！"]
        ]
    
    var currentIndex: Int
    
    init() {
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView = nil
        escapeRoomIntroductions = []
        currentIndex = 0
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
        currentIndex = 0
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView!.delegate = self
        collectionView!.dataSource = self
        collectionView!.isPagingEnabled = true
        collectionView!.showsHorizontalScrollIndicator = false
        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        if let collectionView = collectionView {
            view.addSubview(collectionView)
        }
    }
    
}

extension SelectPage_VC2: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return escapeRoomIntroductions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let intro = escapeRoomIntroductions[indexPath.item]
        
        let imageView = UIImageView(frame: cell.contentView.bounds)
        imageView.image = UIImage(named: "escapeImg\(indexPath.item + 1).png")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        cell.contentView.addSubview(imageView)
        
        let descriptionLabel = UILabel(frame: CGRect(x: 20, y: 300, width: cell.contentView.bounds.width - 40, height: 100))
        descriptionLabel.text = intro["description"]
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .black
        descriptionLabel.backgroundColor = .blue
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        
        cell.contentView.addSubview(descriptionLabel)
        
        return cell
    }
    
    func viewControllerAtIndex(_ index: Int) -> ContentViewController? {
        if index >= 0 && index < escapeRoomIntroductions.count {
            let contentVC = ContentViewController()
            contentVC.imageName = "escapeImg\(index + 1).png"
            contentVC.titleText = escapeRoomIntroductions[index]["title"] ?? ""
            contentVC.descriptionText = escapeRoomIntroductions[index]["description"] ?? ""
//            contentVC.index = index
            return contentVC
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let contentVC = viewController as? ContentViewController {
            if let index = contentVC.index as? Int, index > 0 {
                return viewControllerAtIndex(index - 1)
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let contentVC = viewController as? ContentViewController {
            if let index = escapeRoomIntroductions.firstIndex(where: { $0["title"] == contentVC.titleText }), index < escapeRoomIntroductions.count - 1 {
                return viewControllerAtIndex(index + 1)
            }
        }
        return nil
    }
    
    
}
