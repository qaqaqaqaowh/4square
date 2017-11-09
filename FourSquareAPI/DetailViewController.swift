//
//  DetailViewController.swift
//  FourSquareAPI
//
//  Created by NEXTAcademy on 11/8/17.
//  Copyright © 2017 asd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var addressTextView: UITextView!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var urlTextView: UITextView!
    
    var selectedLocation = Location()

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = selectedLocation.name
        categoryLabel.text = selectedLocation.category
        var string = ""
        for line in selectedLocation.adress {
            string += "\(line)\n"
        }
        addressTextView.text = string
        if selectedLocation.phone != "" {
            phoneLabel.text = selectedLocation.phone
        } else {
            phoneLabel.text = "Nil"
        }
        if selectedLocation.url != "" {
            urlTextView.text = selectedLocation.url
        } else {
            urlTextView.text = "Nil"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
