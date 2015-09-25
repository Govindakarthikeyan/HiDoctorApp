//
//  AppConstants.swift
//  HiDoctor
//
//  Created by Rajesh on 10/09/15.
//  Copyright © 2015 Swaas Systems. All rights reserved.
//

import UIKit
import Foundation

let debugType : Int = 1

//-- Screen Measurements
let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height

//-- Color Values
let windowBg = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
let navigationBarBg = UIColor(red: 15.0/255.0, green: 103.0/255.0, blue: 169.0/255.0, alpha: 1.0)
let navigationBarText = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)

// -- Font Names
let fontRegular: String = "SourceSansPro-Regular"
let fontSemibold : String = "SourceSansPro-Semibold"
let fontBold : String = "SourceSansPro-Bold"

//-- UserDefaults Key
let userName: String = "userName"
let userEmail: String = "userEmail"
let userId: String = "userId"

//-- Webservice Url
let wsRootUrl : String = "http://icoxswain.hidoctor.me/CustomerApi/"

let wsGetSpecialityUrl : String = "GetCustomerSpeciality/swaas.kangle.me"
let wsCreateAccountUrl : String = "CheckCustomerExist/swaas.kangle.me"
let wsGetAssetsUrl : String = "GetCustomerAssetsForApp/swaas.kangle.me"

//-- StoryBoard
let xibSignUp : String = "SignupView"
let sbMain : String = "Main"
let sbHome : String = "HomeViewController"
let sbPatient : String = "PatientViewController"
let sbDrug : String = "DrugIndexViewController"
let sbAlert : String = "AlertViewController"
let sbMore : String = "MoreViewController"
let sbProfile : String = "ProfileViewController"
let sbPatientAppoinment : String = "PatientAppoinmentViewController"
let sbPatientQueries : String = "PatientQueriesViewController"
let sbPharmaCompanies : String = "PharmaCompaniesViewController"
let sbInsights : String = "InsightsViewController"

//-- ViewController Identifier
let vcMain : String = "landingVcID"
let vcHome : String = "homeVcID"
let vcPatient : String = "patientVcID"
let vcDrug : String = "drugVcID"
let vcAlert : String = "alertVcID"
let vcMore : String = "moreVcID"
let vcProfile : String = "profileVcID"
let vcPatientAppoinment : String = "PatientAppoinmentVcID"
let vcPatientQueries : String = "PatientQueriesVcID"
let vcPharmaCompanies : String = "PharmeCompaniesVcID"
let vcInsights : String = "InsightsVcID"



