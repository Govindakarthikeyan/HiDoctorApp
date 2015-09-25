//
//  HomeViewConroller.swift
//  HiDoctor
//
//  Created by Rajesh on 10/09/15.
//  Copyright © 2015 Swaas Systems. All rights reserved.
//
import Foundation
import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UISearchBarDelegate
{

    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var searchView : UIView!
    @IBOutlet weak var searchViewHgtContraint: NSLayoutConstraint!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var searchViewYoffsetConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainViewYoffsetConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet var filterWrap: UIView!
        
    var data = NSMutableData()
    var scrollPoint : CGFloat = 0
    var searchViewHgt : CGFloat = 0
    var searchViewYoffset : CGFloat = 0
    var navigationBarHgt : CGFloat = 0
    var mainViewYoffset : CGFloat = 0
    
    let articleList : NSMutableArray! = []
    var articleSearchedList : NSMutableArray! = []
    var isArticleSearching: Bool! = false
    var readTableArray : NSMutableArray = []
    
    //MARK: - Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        homeTableView.rowHeight = 112.0
        searchViewYoffset = self.searchView.frame.origin.y - self.searchView.frame.size.height
        navigationBarHgt = self.mainView.frame.origin.y - self.searchView.frame.size.height
        mainViewYoffset = self.mainView.frame.origin.y
        
        searchBar.barTintColor = navigationBarBg
        
//        let topBorder = UIView()
//        topBorder.frame = CGRectMake(0.0, 0.0, searchBar.frame.size.width, 2.0)
//        topBorder.backgroundColor = navigationBarBg
//        searchBar.addSubview(topBorder)
        
        getArticleData()
    }
    
    func getArticleData()
    {
        ActivityIndicator.showActivityIndicator()
        
        let customerId:Int
        let custId = NSUserDefaults.standardUserDefaults().objectForKey(userId)
        if custId != nil
        {
            customerId = custId as! Int
        } else {
            customerId = 0
        }
        let wsUrl = String(format: "%@%@/%d/%d", wsRootUrl, wsGetAssetsUrl, customerId, Validation.getUTCOffset())
        
        let webService = WebService()
        webService.getWebServiceResponse(wsUrl, requestType: "GET", postData: nil)
            {(jsonResponse, error) -> Void in
                if error != nil
                {
                    AlertView.showAlertView("Alert", message: error!, delay: false
                    )
                } else {
                    print(jsonResponse)
                    self.articleList.addObjectsFromArray(jsonResponse as! [AnyObject])
                    print("Article list \(self.articleList)")
                    self.homeTableView.reloadData()
                }
                
                ActivityIndicator.hideActivityIndicator()
            }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Tableview Delegate & Datasource
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        if isArticleSearching == true
        {
            return (articleSearchedList.count != 0 ) ? articleSearchedList.count : 0
        } else {
            return (articleList.count != 0 ) ? articleList.count : 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("homeCell") as! HomeTableViewCell
        
        if isArticleSearching == true
        {
            cell.textLbl.text = articleSearchedList[indexPath.row].objectForKey("DA_Name") as? String
        } else {
            cell.textLbl.text = articleList.objectAtIndex(indexPath.row).objectForKey("DA_Name") as? String
        }

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
//        let selectedId :Int = (self.homeTableArray.objectAtIndex(
//            indexPath.row).objectForKey(
//                "Preference_Value_Id") as! Int)
//       
//        for listId in self.readTableArray
//        {
//            if(listId as!Int != selectedId)
//            {
//                self.readTableArray.removeObject(self.homeTableArray.objectAtIndex(
//                    indexPath.row).objectForKey(
//                        "Preference_Value_Id")!)
//            }
//        }
//        self.readTableArray.addObject(self.homeTableArray.objectAtIndex(
//            indexPath.row).objectForKey(
//                "Preference_Value_Id")! as!Int)
//
//        NSUserDefaults.standardUserDefaults().setObject(readTableArray, forKey: "kReadList")
//        let list = NSUserDefaults.standardUserDefaults().objectForKey("kReadList")
//        NSUserDefaults.standardUserDefaults().synchronize()
//        print("\n\n Total Read Array = \(list)")
    }

    //MARK: -- Tabelcell Edit
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    {
        let like = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "LIKE" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            let alertView = UIAlertController(title: "Like Action", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alertView, animated: true, completion: nil)
            
        })
        like.backgroundColor = UIColor.grayColor()
        
        
        let rate = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "RATE" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            let alertView = UIAlertController(title: "Rate Action", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alertView, animated: true, completion: nil)
        })
        rate.backgroundColor = UIColor.lightGrayColor()
        
        return [like, rate]
    }
    
    //MARK: Scrollview Delegate
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        scrollPoint = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        if scrollPoint < scrollView.contentOffset.y
        {
            //-- Tableview moving upwards
            
            UIView.animateWithDuration(0.5, animations:
            {
                self.searchViewYoffsetConstraint.constant = self.searchViewYoffset
                self.mainViewYoffsetConstraint.constant = 0
                self.searchView.frame.origin.y = self.searchViewYoffset
                self.mainView.frame.origin.y = self.navigationBarHgt
            })
        }
        else if scrollPoint > scrollView.contentOffset.y
        {
            //-- Tableview moving upwards
            
            UIView.animateWithDuration(0.5, animations:
            {
                self.searchViewYoffsetConstraint.constant = self.navigationBarHgt
                self.mainViewYoffsetConstraint.constant = self.searchView.frame.size.height
                self.searchView.frame.origin.y = self.navigationBarHgt
                self.mainView.frame.origin.y = self.mainViewYoffset
            })
        }
    }
    
    //MARK: --SearchBar Delegates
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 0
        {
            isArticleSearching = true
            getArticleSearched()
        } else {
            filterWrap.hidden = false
            homeTableView.hidden = false
            isArticleSearching = false
            let delay = 0.3 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), {
                searchBar.resignFirstResponder()
            })
        }
        
        homeTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.resignFirstResponder()
        return true
    }
    
    func getArticleSearched() {
        articleSearchedList.removeAllObjects()
        let searchPredicate = NSPredicate(format: "SELF['DA_Name'] CONTAINS[c] %@", searchBar.text!)
        let array:NSArray! = articleList.filteredArrayUsingPredicate(searchPredicate)
        articleSearchedList.addObjectsFromArray(array as [AnyObject])
        if articleSearchedList.count > 0
        {
            filterWrap.hidden = false
            homeTableView.hidden = false
        } else {
            filterWrap.hidden = true
            homeTableView.hidden = true
        }
        homeTableView.reloadData()
    }
}
