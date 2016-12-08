//
//  ElementDetailViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Sabrina Ip on 12/8/16.
//  Copyright © 2016 Sabrina. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    var element: Element!
    var userName = "Sabrina"
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var elementImageView: UIImageView!

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = element.name
        loadDetailsText()
        loadImage()
        loadSquareFormatText()
    }
    
    func loadSquareFormatText() {
        self.numberLabel.text = String(element.number)
        self.symbolLabel.text = element.symbol
        self.nameLabel.text = element.name
        self.weightLabel.text = String(element.weight)
    }
    
    func loadDetailsText() {
        var detailsText = ""
/*
        // The following lines are not needed because they are accounted for
        detailsText = "Name: \(element.name)"
        detailsText += "\nSymbol: \(element.symbol)"
        detailsText += "\nNumber: \(element.number)"
        detailsText += "\nWeight: \(element.weight)"
*/
        // If data is null, show null.
        if let meltingPoint = element.meltingPoint {
            detailsText += "Melting Point: \(meltingPoint)"
        } else {
            detailsText += "Melting Point: Null"
        }
        if let boilingPoint = element.boilingPoint {
            detailsText += "\nBoiling Point: \(boilingPoint)"
        } else {
            detailsText += "\nBoiling Point: Null"
        }
        if let density = element.density {
            detailsText += "\nDensity: \(density)"
        } else {
            detailsText += "\nDensity: Null"
        }
        if let crustPercent = element.crustPercent {
            detailsText += "\nCrust Percent: \(crustPercent)"
        } else {
            detailsText += "\nCrust Percent: Null"
        }
        detailsText += "\nDiscovery Year: \(element.discoveryYear)"
        detailsText += "\nGroup: \(element.group)"
        if let electrons = element.electrons {
            detailsText += "\nElectrons: \(electrons)"
        } else {
            detailsText += "\nElectrons: Null"
        }
        if let ionEnergy = element.ionEnergy {
            detailsText += "\nIon Energy: \(ionEnergy)"
        } else {
            detailsText += "\nIon Energy: Null"
        }
 
        self.detailsLabel.text = detailsText
    }
    
    func loadImage() {
        APIRequestManager.manager.getData(endPoint: self.element.largeImage) { (data) in
            if  let validData = data,
                let validImage = UIImage(data: validData) {
                DispatchQueue.main.async {
                    self.elementImageView.image = validImage
                }
            }
        }
    }
    
    @IBAction func favoritesButtonTapped(_ sender: UIButton) {
        APIRequestManager.manager.postRequest(endPoint: "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/favorites", data: [
            "my_name" : self.userName,
            "favorite_element" : element.name
            ])
    }
}
