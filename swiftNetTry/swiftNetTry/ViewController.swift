//
//  ViewController.swift
//  swiftNetTry
//
//  Created by nhl on 2017/9/24.
//  Copyright © 2017年 nhl. All rights reserved.
//

import UIKit
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dataArr.count
   return self.items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
        return 100

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let initIdentifier = "Cell"
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: initIdentifier)
//        cell.imageView?.sd_setImage(with: NSURL(string:dataArr[indexPath.row] as! String)! as URL)
        cell.imageView?.contentMode=UIViewContentMode.scaleAspectFill
        cell.imageView?.sd_setImage(with: NSURL(string:"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3574839942,3799224143&fm=27&gp=0.jpg" )! as URL)
        cell.textLabel?.text="第\(indexPath.row+1)行"
        return cell
    }
    
    fileprivate var dataArr = Array<Any>()
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
   
    @IBOutlet weak var myTableView: UITableView!
    
    
    
    //刷新
    var items:[String]!
//    var tableView:UITableView?
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部加载
    let footer = MJRefreshAutoNormalFooter()
    
    let lastPage:Int =  3
    var currentPage:Int  = 1
    
    
    
    var age:Int = 0{
        willSet {
            print(newValue)
        }
        didSet{
            print(oldValue)
        }
    }
    
    
//    //顶部下拉刷新
//    @objc func headerRefresh(){
//        print("下拉刷新.")
//        sleep(2)
//        //重现生成数据
//        refreshItemData()
//        //重现加载表格数据
//        self.myTableView!.reloadData()
//        //结束刷新
//        self.myTableView!.mj_header.endRefreshing()
//    }
//
//    //底部上拉加载
    @objc func footerLoad(){
        currentPage += 1
        print("上拉加载.")
        sleep(1)
        //生成并添加数据
        self.loadItemMoreData()
        //重现加载表格数据
        self.myTableView!.reloadData()
        //结束刷新
        self.myTableView!.mj_footer.endRefreshing()
        if currentPage >= lastPage {
            self.myTableView!.mj_footer.endRefreshingWithNoMoreData()
            return
        }
        print(currentPage)
    }
    //加载更多数据
    func loadItemMoreData() {
        for _ in 0...9 {
            items.append("条目\(Int(arc4random()%100))")
        }
    }
    
    //初始化数据
    func refreshItemData() {
        currentPage = 1
        items = []
        for _ in 0...9 {
            items.append("条目\(Int(arc4random()%100))")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.dataSource=self
        self.myTableView.delegate=self
       
//        self.setupRefresh()
        refreshItemData()

        //下拉刷新相关设置
//        header.setRefreshingTarget(self, refreshingAction: #selector(self.headerRefresh))
        self.myTableView!.mj_header = header
        
        
        //下拉刷新相关设置,使用闭包Block
        self.myTableView!.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.myTableView!.mj_footer.resetNoMoreData()
            print("下拉刷新.")
            sleep(1)
            //重现生成数据
            self.refreshItemData()
            //重现加载表格数据
            self.myTableView!.reloadData()
            //结束刷新
            self.myTableView!.mj_header.endRefreshing()
        })
     
        /*
        //上拉加载相关设置,使用闭包Block
        self.myTableView!.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
//            if currentPage >= lastPage {
//            self.myTableView!.mj_footer.endRefreshingWithNoMoreData()
//                return
//            }
            print("上拉加载.")
            sleep(2)
            //生成并添加数据
            self.loadItemMoreData()
            //重现加载表格数据
            self.myTableView!.reloadData()
            //结束刷新
            self.myTableView!.mj_footer.endRefreshing()
//            currentPage += 1
//            print(currentPage)
        })
        
        */
        //上刷新相关设置
        footer.setRefreshingTarget(self, refreshingAction: #selector(self.footerLoad))
        //是否自动加载（默认为true，即表格滑到底部就自动加载）
        footer.isAutomaticallyRefresh = false
        self.myTableView!.mj_footer = footer
        
        
        
        
        
        //MARK:自定义底部样式
        // 底部加载
//        footer = MJRefreshBackGifFooter()
//
//        //上拉过程时的图片集合(根据下拉距离自动改变)
//        var idleImages = [UIImage]()
//        for i in 1...10 {
//            idleImages.append(UIImage(named:"idle\(i)")!)
//        }
//        footer.setImages(idleImages, for: .idle) //idle1，idle2，idle3...idle10
//
//        //上拉到一定距离后，提示松开刷新的图片集合(定时自动改变)
//        var pullingImages = [UIImage]()
//        for i in 1...3 {
//            pullingImages.append(UIImage(named:"pulling\(i)")!)
//        }
//        footer.setImages(pullingImages, for: .pulling)
//
//        //刷新状态下的图片集合(定时自动改变)
//        var refreshingImages = [UIImage]()
//        for i in 1...3 {
//            refreshingImages.append(UIImage(named:"refreshing\(i)")!)
//        }
//        footer.setImages(refreshingImages, for: .refreshing)
//
        
        
        
        
        
        
        
        
        
    
        loadHttpData()
        age=30
    }

    // 下拉刷新
    func setupRefresh() {
        print("setupRefresh -- 下拉刷新");
        let refreshControl:UIRefreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshClick), for: UIControlEvents.valueChanged)
        self.myTableView.addSubview(refreshControl)
        refreshControl.beginRefreshing()
        refreshControl.attributedTitle=NSAttributedString(string:"正在刷新")
        self.refreshClick(refreshControl: refreshControl)
    }
    // 下拉刷新触发，在此获取数据
    @objc func refreshClick(refreshControl:UIRefreshControl) {
        print("refreshClick: -- 刷新触发")
        // 此处添加刷新tableView数据的代码
        refreshControl.endRefreshing()
        self.myTableView.reloadData()// 刷新tableView即可
    }
  
    

    
    
    
    
    
    

    //MARK:---加载数据
    func loadHttpData() {
        
        
        // Do any additional setup after loadreing the view, typically from a nib.
        self.myLabel.text=NSLocalizedString("GOOD_MORNING", comment: "Good Morning")
        //        self.myImageView.sd_setImage(with: NSURL(string:"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3574839942,3799224143&fm=27&gp=0.jpg")! as URL, placeholderImage: #imageLiteral(resourceName: "image14"), options: SDWebImageOptions.transformAnimatedImage) { (image:UIImage?, error:Error?, cacheType:SDImageCacheType, url:NSURL) in
        //
        //        }
        
        //        self.myImageView.sd_setAnimationImages(with: [NSURL(string:"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3574839942,3799224143&fm=27&gp=0.jpg")! as URL ,NSURL(string:"http://img0.imgtn.bdimg.com/it/u=1971161812,301571234&fm=200&gp=0.jpg")! as URL])
        dataArr=["https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3574839942,3799224143&fm=27&gp=0.jpg","http://img5.imgtn.bdimg.com/it/u=603621955,1179636658&fm=27&gp=0.jpg","http://img1.imgtn.bdimg.com/it/u=777168067,886971480&fm=27&gp=0.jpg","https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3574839942,3799224143&fm=27&gp=0.jpg","http://img4.imgtn.bdimg.com/it/u=2710605168,1506484486&fm=27&gp=0.jpg"]
        
        self.myImageView.sd_setImage(with: NSURL(string:"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3574839942,3799224143&fm=27&gp=0.jpg")! as URL)
        
        //        let manager:AFHTTPSessionManager = AFHTTPSessionManager()
        //        manager.responseSerializer.acceptableContentTypes?.insert("text/plain")
        //        manager.responseSerializer.acceptableContentTypes?.insert("text/html")
        //        manager.get("http://121.41.36.161/api_server/web/index.php/ifood/home/get-district", parameters: nil, progress:nil, success: { (task: URLSessionDataTask,json: Any?) in
        //            print(json ?? "")
        //            DispatchQueue.main.async{
        //
        //            }
        //        }) { (task: URLSessionDataTask?, error: Error) in
        //            print(error)
        //            //没网等各种错误提示(把句号替换成空白)
        //            //            MBProgressHUD .showNoNetwork(error.localizedDescription.replacingOccurrences(of: "。", with: ""))
        //        }
        
        //        NetWork.shared.request(requestType: .GET, urlString: "http://121.41.36.161/api_server/web/index.php/ifood/home/get-district", parameters: nil) { (json) in
        //            print(json as Any)
        //        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var clickBtnAction: UIButton!
    
    @IBAction func clickAction(_ sender: Any) {
        age=20
        SVProgressHUD.show()
        NetWork.shared.request(requestType: .GET, urlString: "http://121.41.36.161/api_server/web/index.php/ifood/home/get-district", parameters: nil) { (json) in
//            print(json as Any)
            SVProgressHUD.dismiss()
//            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//            hud.labelText = "这是默认带菊花的提示"
//            //背景渐变效果
//            hud.dimBackground = true
//
//            //延迟隐藏
//            hud.hide(true, afterDelay: 0.8)
        
        
        
            // 快速显示一个提示信息
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.text
            hud.label.text = "这是纯文本提示"
            hud.detailsLabel.text = "这是详细信息内容，会很长很长呢"
            hud.backgroundColor=UIColor.white
        
            //延迟隐藏
            hud.hide(animated: true, afterDelay: 0.8)

        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("scroll高度位移：\(scrollView.contentOffset.y)")
        if scrollView.contentOffset.y < 0 {
//            self.setupRefresh()
        }
    }
    
}

