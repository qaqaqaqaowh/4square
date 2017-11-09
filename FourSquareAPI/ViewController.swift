//
//  ViewController.swift
//  FourSquareAPI
//
//  Created by NEXTAcademy on 11/8/17.
//  Copyright © 2017 asd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var queryResults : [Location] = []
    
    @IBOutlet weak var foodTextField: UITextField!

    @IBOutlet weak var locationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func queryButton(_ sender: Any) {
        queryResults = []
        guard var foodText = foodTextField.text,
        var locationText = locationTextField.text
            else {return}
        var urlString = "https://api.foursquare.com/v2/venues/search/?client_id=1ZOLEEVANSVMBDEJP4CYJIBFDRUC42FYEIPY0TH2TK0I2WSO&client_secret=UAVHO3RD53GDBGX1CWUMQYLFKIR1RWZUHW0TMUPJJ1BSCIIX&v=20170101"
        foodText = foodText.components(separatedBy: " ").joined(separator: "+")
        locationText = locationText.components(separatedBy: " ").joined(separator: "+")
        urlString += "&query=\(foodText)&near=\(locationText)"
        guard let url = URL(string: urlString)
            else {return}
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let validError = error {
                print(validError.localizedDescription)
            }
            if let validData = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: validData, options: []) as? [String:Any]
                        else {return}
                    guard let result = json["response"] as? [String:Any],
                        let venues = result["venues"] as? [[String:Any]]
                        else {return}
                    self.populateLocations(venues)
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
                    vc.results = self.queryResults
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                } catch {
                    
                }
            }
        }
        task.resume()
    }
    
    func populateLocations(_ venues:[[String:Any]]) {
        for location in venues {
            let newLocation = Location()
            guard let name = location["name"] as? String,
            let id = location["id"] as? String,
            let address = location["location"] as? [String:Any],
            let category = location["categories"] as? [[String:Any]],
            let formattedAddress = address["formattedAddress"] as? [String],
            let validCategory = category[0]["name"] as? String
                else {return}
            newLocation.name = name
            newLocation.id = id
            newLocation.adress = formattedAddress
            newLocation.category = validCategory
            if let contact = location["contact"] as? [String:Any],
                let formattedContact = contact["formattedPhone"] as? String {
                newLocation.phone = formattedContact
            }
            if let urlString = location["url"] as? String {
                newLocation.url = urlString
            }
            queryResults.append(newLocation)
        }
    }
    
}

