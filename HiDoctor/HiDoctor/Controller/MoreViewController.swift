//
//  MoreView.swift
//  HiDoctor
//
//  Created by Narayan Srivathsan on 9/13/15.
//  Copyright © 2015 Swaas Systems. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController, UITableViewDelegate {
    
    var settings = [ ["USER", "Profile"],
        
        ["PATIENT", "Patient Appoinments", "Patient Queries"],
        
        ["PHARMA", "Pharma Companies"],
        
        ["INSIGHTS", "Insights"],
        
        ["APP", "Refer this app to doctors", "Rate this app"]]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return settings.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return settings[section].count - 1
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = settings[indexPath.section][indexPath.row + 1]
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    
        return 30;
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1;
    }
    

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
        return settings[section][0]
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cellSection = String(indexPath.section)
        let cellRow = String(indexPath.row)
        let selectedCell = cellSection + cellRow
        
        print (selectedCell)
        
        switch selectedCell {
        
        case  "00":
        
            let profile_sb = UIStoryboard(name: sbProfile, bundle: nil)
            let profile_vc = profile_sb.instantiateViewControllerWithIdentifier(vcProfile) as UIViewController
            self.navigationController!.pushViewController(profile_vc, animated: true)
        
        break
            
        case  "10":
            
            let patientAppoinment_sb = UIStoryboard(name: sbPatientAppoinment, bundle: nil)
            let patientAppoinment_vc = patientAppoinment_sb.instantiateViewControllerWithIdentifier(vcPatientAppoinment) as UIViewController
            self.navigationController!.pushViewController(patientAppoinment_vc, animated: true)
            
        break
            
        case  "11":
            
            let patientQueries_sb = UIStoryboard(name: sbPatientQueries, bundle: nil)
            let patientQueries_vc = patientQueries_sb.instantiateViewControllerWithIdentifier(vcPatientQueries) as UIViewController
            self.navigationController!.pushViewController(patientQueries_vc, animated: true)
            
        break
            
        case  "20":
            
            let pharmaCompanies_sb = UIStoryboard(name: sbPharmaCompanies, bundle: nil)
            let pharmaCompanies_vc = pharmaCompanies_sb.instantiateViewControllerWithIdentifier(vcPharmaCompanies) as UIViewController
            self.navigationController!.pushViewController(pharmaCompanies_vc, animated: true)
            
        break
            
        case  "30":
            
            let insights_sb = UIStoryboard(name: sbInsights, bundle: nil)
            let insights_vc = insights_sb.instantiateViewControllerWithIdentifier(vcInsights) as UIViewController
            self.navigationController!.pushViewController(insights_vc, animated: true)
            
            break
            
        default:
        
        
        break
        }
        
    
    }
    

    
    
    
}