//
//  DriversInfoViewController.swift
//  CoreLocationApp
//
//  Created by Maria Teresa Rojo on 1/18/18.
//  Copyright © 2018 Song. All rights reserved.
//

import UIKit
import CoreData

class DriversInfoViewController: UIViewController {
    
    var driverInfo: [DriversInfoItem] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var dateAndTime: UIDatePicker!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var driversLicense: UITextField!
    @IBOutlet weak var insuranceCompany: UITextField!
    @IBOutlet weak var policyNumber: UITextField!
    @IBOutlet weak var licensePlateNumber: UITextField!
    @IBOutlet weak var color: UITextField!
    @IBOutlet weak var make: UITextField!
    @IBOutlet weak var model: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        driverInfo = fetch()
        fullName.text = driverInfo[0].fullName
        
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    func fetch() ->[DriversInfoItem] {
        let driversInfoItemRequest:NSFetchRequest<DriversInfoItem> = DriversInfoItem.fetchRequest()
        do {
            let fetchedMissions = try context.fetch(driversInfoItemRequest)
            return fetchedMissions
        }
        catch {
            print("fetch error: ")
            print(error)
            return []
        }
    }
    
    func missionSave(){
        do{
            try context.save()
        } catch{
            print("core data save error: ")
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        print("submit")
//        let newDriver = DriversInfoItem(context: context)
        let newDriver = NSEntityDescription.insertNewObject(forEntityName: "DriversInfoItem", into: context) as! DriversInfoItem
        newDriver.fullName = fullName.text
        missionSave()
        performSegue(withIdentifier: "unwindToThisViewController", sender: self)
        
    }
    
//    func fetchAllItems() {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DriversInfoItem")
//        do {
//            let result = managedObjectContext.fetch(request)
//            let item = result as! [DriversInfoItem]
//        } catch {
//            print("\(error)")
//        }
//    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
//        let destination = segue.destination as! ViewController
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
