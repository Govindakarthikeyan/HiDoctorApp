//
//  SpecialityViewController.swift
//  HiDoctor
//
//  Created by chandramouli venkatesan on 9/23/15.
//  Copyright © 2015 Swaas Systems. All rights reserved.
//

import UIKit

class SpecialityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var specialityArray: NSMutableArray = ["ENT", "Dentist"]
    var valueToPass : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITableView Datasource and Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return specialityArray.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("specialityCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = (self.specialityArray.objectAtIndex(indexPath.row) as! String)
        
        return cell
        
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        print("You selected cell #\(indexPath.row)!")
//        
//        // Get Cell Label
//        let indexPath = tableView.indexPathForSelectedRow!
//        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!;
//        
//        valueToPass = currentCell.textLabel!.text
//        // your new view controller should have property that will store passed value
//        self.navigationController!.popViewControllerAnimated(true)
//    }
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if (segue.identifier == "specialitySegue") {
//            
//            // initialize new view controller and cast it as your view controller
//            let viewController = segue.destinationViewController as! ProfileViewController
//            // your new view controller should have property that will store passed value
//            viewController.passedValue = valueToPass
//            print(viewController.passedValue)
//        }
//        
//    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("You selected cell #\(indexPath.row)!")
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow;
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!;
        let storyboard = UIStoryboard(name: "ProfileViewController", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("profileVcID") as! ProfileViewController
        valueToPass = currentCell.textLabel!.text
        print(valueToPass)
        viewController.passedValue = valueToPass
        print(viewController.passedValue)
        navigationController!.popViewControllerAnimated(true)

//        self.presentViewController(viewController, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
