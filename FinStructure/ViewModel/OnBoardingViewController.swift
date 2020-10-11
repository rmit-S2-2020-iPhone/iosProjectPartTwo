//
//  OnBoardingViewController.swift
//  FinStructure
//
//  Created by Louis An on 11/10/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var getStarted: UIButton!
    
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    
    //data for the slides
    var titles = ["WELCOME","DISCOVER","NOTE-TAKING"]
    var descs = ["Welcome to the most accurate weather app","Make a personalised list of locations you want to track","Add stuck notes of your upcoming plan that are dependent on the weather forecast"]
    var imgs = ["onboard1","onboard2","onboard3"]
    
    //get dynamic width and height of scrollview and save it
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        //to call viewDidLayoutSubviews() and get dynamic width and height of scrollview
        
        self.scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        //crete the slides and add them
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        for index in 0..<titles.count {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)
            
            let slide = UIView(frame: frame)
            
            //subviews
            let imageView = UIImageView.init(image: UIImage.init(named: imgs[index]))
            let SizeOfScreen: CGRect = UIScreen.main.bounds
            let HeightOfScreen = SizeOfScreen.height
            let WidthOfScreen = SizeOfScreen.width
            imageView.frame = CGRect(x:0,y:0,width:WidthOfScreen,height:HeightOfScreen)
            imageView.contentMode = .scaleAspectFit
            imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 50)
            
            let title = UILabel.init(frame: CGRect(x:35,y:HeightOfScreen/1.5,width:scrollWidth-64,height:50))
            title.textAlignment = .center
            title.font = UIFont.boldSystemFont(ofSize: 50.0)
            title.textColor = #colorLiteral(red: 0.409467876, green: 0.691973269, blue: 0.6691761613, alpha: 1)
            title.text = titles[index]
            
            let subtitle = UILabel.init(frame: CGRect(x:32,y:title.frame.maxY+10,width:scrollWidth-64,height:50))
            subtitle.textAlignment = .center
            subtitle.numberOfLines = 3
            subtitle.textColor = #colorLiteral(red: 0.4078431373, green: 0.6901960784, blue: 0.6705882353, alpha: 1)
            subtitle.font = UIFont.systemFont(ofSize: 14.0)
            subtitle.text = descs[index]
            
            
            slide.addSubview(imageView)
            slide.addSubview(title)
            slide.addSubview(subtitle)
            
            scrollView.addSubview(slide)
           
            
        }
        
        //set width of scrollview to accomodate all the slides
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)
        
        //disable vertical scroll/bounce
        self.scrollView.contentSize.height = 1.0
        
        //initial state
        pageControl.numberOfPages = titles.count
        pageControl.currentPage = 0
        
    }
    
    //indicator
    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }
    
    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
    }
    
}
