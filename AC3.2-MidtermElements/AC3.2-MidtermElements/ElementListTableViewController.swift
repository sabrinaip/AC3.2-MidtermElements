//
//  ElementListTableViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Sabrina Ip on 12/8/16.
//  Copyright © 2016 Sabrina. All rights reserved.
//

import UIKit

class ElementListTableViewController: UITableViewController {
    var elements = [Element]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Elements"
        APIRequestManager.manager.getData(endPoint: "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/elements") { (data) in
            if let validData = Element.getElements(data: data!) {
                self.elements = validData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath)
        let thisElement = elements[indexPath.row]
        cell.textLabel?.text = thisElement.name
        cell.detailTextLabel?.text = "\(thisElement.symbol)(\(thisElement.number)) \(thisElement.weight)"
        // loads thumbnail image
        APIRequestManager.manager.getData(endPoint: thisElement.thumbnailImage) { (data) in
            if  let validData = data,
                let validImage = UIImage(data: validData) {
                DispatchQueue.main.async {
                    cell.imageView?.image = validImage
                    /** This is currently commented out because slow internet is slowing down my progress **/
                    //self.tableView.reloadData()
                }
            }
            else {
                cell.imageView?.image = nil
            }
        }
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SegueToElementDetails",
            let dest = segue.destination as? ElementDetailViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = self.tableView.indexPath(for: cell) else { return }
        dest.element = elements[indexPath.row]
    }
}
