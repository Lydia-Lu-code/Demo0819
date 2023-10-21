//
//  SelectPage_VC.swift
//  Demo0819
//
//  Created by 維衣 on 2023/8/19.
//

import UIKit

class SelectPage_VC: UIViewController, UIScrollViewDelegate, UIPageViewControllerDataSource {
    
    var scrollView: UIScrollView!
    var imageFileNames: [UIView: String] = [:]
    var label: UILabel = UILabel()
    var horizontalScrollView: UIScrollView!
    var imageView: UIImageView!
    var pageControl: UIPageControl!
    var escapeRoomIntroductions = [
            ["title": "神秘的海盜寶藏", "description": "想像一下，你被關進了一個神秘的海盜寶藏密室，充滿了古老的地圖、海盜寶藏和謎題。你和你的隊友必須合作，找到寶藏的線索，解開謎題，並最終逃脫出這個令人興奮的密室。"],
            ["title": "未來科技實驗室", "description": "這個密室是一個充滿未來科技的實驗室，充滿了高科技裝置和令人驚奇的發明。你的任務是阻止一個科技瘋狂科學家的邪惡計劃，解開電子謎題，找到暗藏的線索，並在時間耗盡之前完成任務。"],
            ["title": "古代文明之謎", "description": "你和你的隊友被囚禁在一個古代文明的神秘神殿內。這個密室充滿了古老的文物、符號和謎語。你們必須解開這個古老文明的謎題，找到通往自由之路的關鍵。"],
            ["title": "幽靈小屋", "description": "這個密室是一個古老的幽靈小屋，據說被鬼魂所佔據。你和你的隊友必須面對恐怖的挑戰，解開幽靈小屋的秘密，找到逃脫的出口。但要小心，不要讓幽靈抓住你！"]
        ]
    var textField: UITextField!
    var navigationBar: UINavigationBar!
    var verticalAdjustment: CGFloat = 10.0
    var currentIndex: Int = 0
    var viewModel: Select﻿PageViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        textField = UITextField()
        
        viewModel = Select﻿PageViewModel(introductions: escapeRoomIntroductions)
        
        if let titleLabel = self.navigationItem.titleView as? UILabel {
            var frame = titleLabel.frame
            frame.origin.y = verticalAdjustment
            titleLabel.frame = frame
            
            print("**titleLabel.frame == \(titleLabel.frame)")
        }
        
        if label.text == nil {
            if let firstTitle = escapeRoomIntroductions.first?["title"] as? String {
                label.text = firstTitle
            }
        }
        
        // 創建左右翻頁的 UIScrollView
        horizontalScrollView = UIScrollView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 200))
        horizontalScrollView.contentSize = CGSize(width: view.frame.width * 4, height: 200)
        horizontalScrollView.isPagingEnabled = true
        horizontalScrollView.delegate = self
        view.addSubview(horizontalScrollView)
        
        // 加入圖片到 horizontalScrollView
        for i in 0..<4 {
            let imageView = UIImageView(frame: CGRect(x: CGFloat(i) * view.frame.width , y: 0, width: view.frame.width, height: 200))
            imageView.image = UIImage(named: "escapeImg\(i + 1).png")
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            horizontalScrollView.addSubview(imageView)
            
            // 調整 Z 軸位置，使圖片位於 verticalScrollView 上方
            imageView.layer.zPosition = 1.0
        }
        
        // 增加水平平移手勢到 horizontalScrollView
        let horizontalPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handleHorizontalPan(_:)))
        horizontalScrollView.addGestureRecognizer(horizontalPanGesture)

        //左下角“＋”按鈕
        let addButton = UIButton(type: .custom)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.backgroundColor = UIColor.black
        addButton.layer.cornerRadius = 50
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        view.addSubview(addButton)
        
        // 設置 auto layout 約束
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 100),
            addButton.heightAnchor.constraint(equalToConstant: 100),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        
        guard let horizontalScrollView = horizontalScrollView else {
            return
        }
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.delegate = self
                
        imageView = UIImageView(image: UIImage(named: "theImageName"))
        imageView.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 350)
        
        pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        view.bringSubviewToFront(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: horizontalScrollView.topAnchor, constant:  190) // 距離水平滾動視圖的底部距離

        ])

        descriptionText()
        
        
    }
    
    func descriptionText() {
        let descriptionTextView = UITextView()
        descriptionTextView.text = "文字內容"
        descriptionTextView.isEditable = false
        descriptionTextView.textAlignment = .left
        descriptionTextView.textColor = .black
        descriptionTextView.backgroundColor = .blue
        descriptionTextView.font = UIFont.systemFont(ofSize: 16)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionTextView)
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor, constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
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
        
        if let contentVC = viewController as? ContentViewController {
            if let index = escapeRoomIntroductions.firstIndex(where: { $0["title"] == contentVC.titleText }), index < escapeRoomIntroductions.count - 1 {
                return viewControllerAtIndex(index + 1)
            }
        }
        return nil
    }

    @objc func addButtonTapped() {
        
        let title = viewModel?.currentIntrodution()["title"] ?? "未知標題"
        let vc = Reservation_VC()
        vc.dataToReceive = title
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func handleHorizontalPan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: horizontalScrollView)
        horizontalScrollView.contentOffset.x -= translation.x
        gesture.setTranslation(.zero, in: horizontalScrollView)

        let pageIndex = Int(horizontalScrollView.contentOffset.x / horizontalScrollView.frame.size.width)
            viewModel!.currentIndex = pageIndex
        
            pageControl.currentPage = pageIndex
            print("**Current Page Index: \(pageIndex)")
        
        
    }

    
}

