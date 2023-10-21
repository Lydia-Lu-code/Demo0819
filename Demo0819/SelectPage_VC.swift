//
//  SelectPage_VC.swift
//  Demo0819
//
//  Created by 維衣 on 2023/8/19.
//

import UIKit

class SelectPage_VC: UIViewController, UIScrollViewDelegate {
    
    var scrollView: UIScrollView!

    var imageFileNames: [UIView: String] = [:]
    var initialContentOffsetX: CGFloat = 0.0
    
    var label: UILabel = UILabel()
    var horizontalScrollView: UIScrollView!
    var verticalScrollView: UIScrollView!
    var currentPageIndex: Int = 0
    
    var imageView: UIImageView!
    var penGesture: UIPanGestureRecognizer!
    
    var pageControl: UIPageControl!
    
    var currentMainImageIndex: Int = 0
    
    let escapeRoomIntroductions = [
        ["title": "神秘的海盜寶藏", "description": "想像一下，你被關進了一個神秘的海盜寶藏密室，充滿了古老的地圖、海盜寶藏和謎題。你和你的隊友必須合作，找到寶藏的線索，解開謎題，並最終逃脫出這個令人興奮的密室。"],
        ["title": "未來科技實驗室", "description": "這個密室是一個充滿未來科技的實驗室，充滿了高科技裝置和令人驚奇的發明。你的任務是阻止一個科技瘋狂科學家的邪惡計劃，解開電子謎題，找到暗藏的線索，並在時間耗盡之前完成任務。"],
        ["title": "古代文明之謎", "description": "你和你的隊友被囚禁在一個古代文明的神秘神殿內。這個密室充滿了古老的文物、符號和謎語。你們必須解開這個古老文明的謎題，找到通往自由之路的關鍵。"],
        ["title": "幽靈小屋", "description": "這個密室是一個古老的幽靈小屋，據說被鬼魂所佔據。你和你的隊友必須面對恐怖的挑戰，解開幽靈小屋的秘密，找到逃脫的出口。但要小心，不要讓幽靈抓住你！"]
    ]
    
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    
    lazy var viewController: Reservation_VC? = {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "Reservation_Segue") as? Reservation_VC {
            // 在這裡設定 B 的視圖控制器的資料屬性
            viewController.dataToReceive = "\(label.text!)"
        return viewController
        }
            return nil
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        // 增加垂直平移手勢到 verticalScrollView
//        let verticalPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handleVerticalPan(_:)))
        
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
        
        if let navigationBar = navigationController?.navigationBar {
            
            let verticalAdjustment: CGFloat = 10.0    // 調整的垂直偏移值
            let titleAttributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24),     // 設定您想要的字體
                NSAttributedString.Key.foregroundColor: UIColor.black      // 設定您想要的字體顏色            ]
            ]
            navigationBar.titleTextAttributes = titleAttributes

            if let navigationBar = navigationController?.navigationBar {
                let titleText = "Title"
                navigationItem.title = titleText
                
                let titleAttributes: [ NSAttributedString.Key: Any] = [
                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17),
                    NSAttributedString.Key.foregroundColor: UIColor.black,
                    NSAttributedString.Key.verticalGlyphForm: 1
                ]
                
                navigationBar.titleTextAttributes = titleAttributes
            }
            
            if let titleLabel = navigationBar.subviews
                .compactMap({ $0 as? UILabel })
                
                .first(where: { $0.textAlignment == .center }) {
                var frame = titleLabel.frame
                frame.origin.y = verticalAdjustment
                titleLabel.frame = frame

                print("**titleLabel.frame == \(titleLabel.frame)")
            }
            
        }
        
//        scrollViewDidScroll(horizontalScrollView)
//        setupPageContent()
        
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
//        pageControl.backgroundColor = UIColor.red
        view.addSubview(pageControl)
        view.bringSubviewToFront(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: horizontalScrollView.topAnchor, constant:  190) // 距離水平滾動視圖的底部距離

        ])

    }
    
    
    @objc func handleHorizontalPan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: horizontalScrollView)
        horizontalScrollView.contentOffset.x -= translation.x
        gesture.setTranslation(.zero, in: horizontalScrollView)
        
        let pageIndex = Int(horizontalScrollView.contentOffset.x / horizontalScrollView.frame.size.width)
        
        pageControl.currentPage = pageIndex
    }
    
    @objc func handleVerticalPan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: verticalScrollView)
        verticalScrollView.contentOffset.y -= translation.y
        gesture.setTranslation(.zero, in: verticalScrollView)
    }
    
    
    
    func setupPageContent() {
        label.text = escapeRoomIntroductions[currentPageIndex]["description"]

        label.numberOfLines = 0 //允許多行
        label.lineBreakMode = .byWordWrapping //自動換行
        label.text = "Title\nThis is a long description that will wrap to the next line if it's too long for the label's width."
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
////        if scrollView == horizontalScrollView {
////            let pageIndex = Int(scrollView.contentOffset.x / view.frame.width)
////        }
//    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 在用戶開始拖動時，紀錄初始 contentOffset 的 x 值
        // 這將用於後面比較是否水平平移
        initialContentOffsetX = scrollView.contentOffset.x
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == horizontalScrollView {
            let pageIndex = Int(scrollView.contentOffset.x / view.frame.width)
            
            // 檢查索引是否有效
            if pageIndex >= 0 && pageIndex < escapeRoomIntroductions.count {
                titleLabel.text = escapeRoomIntroductions[pageIndex]["title"] ?? "未知標題"
                descriptionLabel.text = escapeRoomIntroductions[pageIndex]["description"] ?? "未知描述"
            } else {
                // 处理索引无效的情况，可以设置默认文本或采取其他适当的措施
                titleLabel.text = "未知標题"
                descriptionLabel.text = "未知描述"
            }
            
            

        }
    }
    

    
    @objc func addButtonTapped() {
        let vc = Reservation_VC()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func setImageView(_ fileName: String, for view: UIView) {
        imageFileNames[view] = fileName
    }
    
    func getImageFileName(for view: UIView) -> String? {
        return imageFileNames[view]
    }
    
    

    
}
