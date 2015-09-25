//
//  PatientViewController.swift
//  HiDoctor
//
//  Created by Rajesh on 10/09/15.
//  Copyright © 2015 Swaas Systems. All rights reserved.
//

import Foundation
import UIKit

class PatientViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var patientSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var patientView: UIView!
    
    @IBOutlet weak var patientQueryView: UIView!
    
    @IBOutlet weak var thirdSegmentView: UIView!
    
    @IBOutlet weak var fourthsegmentView: UIView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for var i = 0; i <= 3; i++ {
            
            (patientSegmentedControl.subviews[i] as UIView).tintColor = navigationBarBg
        }
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        loadFirstSegmentView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addPatientName(sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "AddPatientViewController", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("addPatientvcID") 
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    //MARK: - Gesture Recognizer

    func respondToSwipeGesture(gestureReconizer: UISwipeGestureRecognizer) {
        
        loadSecondSegmentView()
    }
    
    //MARK: - Segmented Control
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            loadFirstSegmentView()
        case 1:
            loadSecondSegmentView()
        case 2:
            loadThirdSegmentView()
        case 3:
            loadFourthSegmentView()
        default:
            break;
        }
    }
    
    func loadFirstSegmentView() {
        
        patientView.hidden = false
        patientQueryView.hidden = true
        thirdSegmentView.hidden = true
        fourthsegmentView.hidden = true
    }
    
    func loadSecondSegmentView() {
        
        patientQueryView.hidden = false
        patientView.hidden = true
        thirdSegmentView.hidden = true
        fourthsegmentView.hidden = true
    }
    
    func loadThirdSegmentView() {
        
        patientQueryView.hidden = true
        thirdSegmentView.hidden = false
        patientView.hidden = true
        fourthsegmentView.hidden = true
    }
    
    func loadFourthSegmentView() {
        
        thirdSegmentView.hidden = true
        fourthsegmentView.hidden = false
        patientView.hidden = true
        patientQueryView.hidden = true
    }
    
    //MARK: - TableView Datasource
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 100
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell",
            forIndexPath: indexPath)
        
        if tableView.tag == 1 {

        cell.textLabel?.text = "Patients"
        } else {
            
            cell.textLabel?.text = "Patient Queries"
        }
        
        return cell
    }
    
}