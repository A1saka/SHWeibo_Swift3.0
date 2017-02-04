//
//  HomeViewController.swift
//  SHWeibo
//
//  Created by LustXcc on 21/12/2016.
//  Copyright © 2016 LustXcc. All rights reserved.
//

import UIKit
import AFNetworking
import SDWebImage
import MJRefresh

class HomeViewController: BaseViewController {

    var isPresented : Bool = false
    // MARK:- 懒加载属性
    fileprivate lazy var titleBtn : TitleButton = TitleButton()

    fileprivate lazy var viewModels : [StatusViewModel] = [StatusViewModel]()
    
    fileprivate lazy var tipLabel : UILabel = UILabel()
    
    // MARK:- 系统调用函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.addAnimation()
        
        // 没有登录时设置的内容
        if  !isLogin {
            return
        }

        // 设置导航栏
        setupNaviBar()
        

        // 设置cell高度
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        // 布局header
        setupHeaderView()
        setupFooterView()
        
        setupTipLabel()
    }
  
}

// MARK:- 设置UI界面
extension HomeViewController{

    fileprivate func setupNaviBar() {
    
        // 设置左边的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        
        // 设置右边的item
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        // 设置titleView
        titleBtn.setTitle("A1saka", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick(titleBtn:)), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    
    }
    fileprivate func setupHeaderView() {
        // 创建header
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadNewStatuses))
        
        header?.setTitle("下拉刷新", for: .idle)
        header?.setTitle("释放更新", for: .pulling)
        header?.setTitle("加载中...", for: .refreshing)
        
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()
    }
    fileprivate func setupFooterView() {
        tableView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreStatuses))
    
    }
    fileprivate func setupTipLabel() {
        view.addSubview(tipLabel)
        tipLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 32)
        tipLabel.backgroundColor = UIColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 0.7)
    }
}

// MARK:- 事件监听
extension HomeViewController{

    @objc fileprivate func titleBtnClick(titleBtn: TitleButton){
        
        // 改变按钮状态
        titleBtn.isSelected = !titleBtn.isSelected
        
        // 设置顶部弹出控制器
        let Popvc = PopoverViewController()
        Popvc.modalPresentationStyle = .custom
        Popvc.transitioningDelegate = self
        present(Popvc, animated: true, completion: nil)
        
    }

}

// MARK:- 顶部导航栏自定义动画
extension HomeViewController : UIViewControllerTransitioningDelegate{
    
    // 改变弹出view的大小
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PopoverPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    // 自定义弹出view的动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    // 自定义消失的动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        titleBtn.isSelected = !titleBtn.isSelected
        return self
    }
}

extension HomeViewController : UIViewControllerAnimatedTransitioning{
    
    
    // 动画时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        isPresented ? animationForPresentedView(using: transitionContext) : animationForDismissView(using: transitionContext)
    }
    
    
    /// 自定义弹出动画
    fileprivate func animationForPresentedView(using transitionContext: UIViewControllerContextTransitioning){
        
        // 获取弹出的View
        let presenetdView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        
        // 将弹出的View添加到containerView中
        transitionContext.containerView.addSubview(presenetdView!)
        
        // 执行动画
        presenetdView?.transform = CGAffineTransform(scaleX: 1.0, y: 0)
        presenetdView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            presenetdView?.transform = CGAffineTransform.identity
        }) { (_) in
            transitionContext.completeTransition(true)
            
        }
    }
    
    /// 自定义消失动画
    fileprivate func animationForDismissView(using transitionContext: UIViewControllerContextTransitioning){
        
        
        let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        
        // 执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            dismissView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.0001)
        }) { (_) in
            dismissView?.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}

// MARK:- 请求数据
extension HomeViewController {
    // 加载新数据（刷新）
    @objc fileprivate func loadNewStatuses(){
        loadWeiboData(isNewData: true)
    }
    @objc fileprivate func loadMoreStatuses(){
        loadWeiboData(isNewData: false)
    }
    //  加载微博数据
    fileprivate func loadWeiboData(isNewData : Bool){
        // 获取since_ID 和 max_ID
        var since_id = 0
        var max_id = 0
        
        if isNewData {
            since_id = viewModels.first?.status?.mid ?? 0
        } else {
            max_id = viewModels.last?.status?.mid ?? 0
            max_id = max_id == 0 ? 0 : (max_id - 1)
        }
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let accessToken =  UserAccountViewModel.shareIntance.account?.access_token
        let parameters = ["access_token": accessToken, "since_id" : "\(since_id)", "max_id" : "\(max_id)"]
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes?.insert("text/html")
        manager.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        manager.get(urlString, parameters: parameters, progress: nil, success: {(operation, responseObject) in
//            print(responseObject!)
            guard let responseObjectDict = responseObject as? [String : AnyObject] else{
                return
            }
            guard let resultArrary = responseObjectDict["statuses"] as? [[String : AnyObject]] else{
                return
            }
            var tempViewModel = [StatusViewModel]()
            for statusesDict in resultArrary{
                let status = Status(dict : statusesDict)
                let viewModels = StatusViewModel(status: status)
                tempViewModel.append(viewModels)
            }
            // 将数据放入成员变量数组中
         
            
            if isNewData {
                self.viewModels = tempViewModel + self.viewModels
            } else {
                self.viewModels += tempViewModel
            }
            // 缓存图片
            self.cacheImage(viewModels: tempViewModel)
            
        }) { (operation, error) in
            print(error)
        }
    
    }
    fileprivate func cacheImage(viewModels: [StatusViewModel]){
        // 创建group
        let dispatchGroup = DispatchGroup()
        // 缓存图片
        
        for viewmodel in viewModels {
            for picURL in viewmodel.picURLs{
                dispatchGroup.enter()
                SDWebImageManager.shared().downloadImage(with: picURL, options: [], progress: nil, completed: { (_, _, _, _, _) in
                    //             print("-------")
                    dispatchGroup.leave()
                })
            }
        }
        // 刷新表格
        dispatchGroup.notify(queue: DispatchQueue.main){
            
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            //            print("刷新表格")
        }
    }


}


// MARK:- tableView的数据源方法
extension HomeViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 创建cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeViewCell
        
        // 设置cell数据
        cell.viewModel = viewModels[indexPath.row]

        return cell
        
    }

}
