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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = element.name
        loadDetailsText()
        loadImage()
    }
    
    func loadDetailsText() {
        var detailsText = "Name: \(element.name)"
        detailsText += "\nSymbol: \(element.symbol)"
        detailsText += "\nNumber: \(element.number)"
        detailsText += "\nWeight: \(element.weight)"
        
        // If data is null, show null.
        if let meltingPoint = element.meltingPoint {
            detailsText += "\nMelting Point: \(meltingPoint)"
        } else {
            detailsText += "\nMelting Point: Null"
        }
        if let boilingPoint = element.boilingPoint {
            detailsText += "\nBoiling Point: \(boilingPoint)"
        } else {
            detailsText += "\nBoiling Point: Null"
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
