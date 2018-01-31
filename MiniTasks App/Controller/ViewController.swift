//
//  ViewController.swift
//  MiniTasks App
//
//  Created by Mohamed on 1/30/18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import UIKit



var tasksArray = [String]()
var dateArray = [String]()
var completedTasks = [String]()
var completedDates = [String]()
var deletedTasks = [String]()
var deletedDates = [String]()




class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var segmentControlTasks: UISegmentedControl!
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var wrongMark: UIImageView!
    @IBOutlet weak var correctMark: UIImageView!
    
    
    
    
    let defaults = UserDefaults.standard
  
    
    var completedTask = ""
    var completedDate = ""
    var deletedTask = ""
    var deletedDate = ""
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        tableView.reloadData()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        plusButton.layer.cornerRadius = 25
        plusButton.clipsToBounds = true
        
        trashButton.layer.cornerRadius = 5
        trashButton.clipsToBounds = true
        
        if let savedTasks = UserDefaults.standard.array(forKey: "Tasks"){
            tasksArray =  savedTasks as! Array
        }
        
        if let savedDates = UserDefaults.standard.array(forKey: "Dates"){
            dateArray = savedDates  as! Array
        }
        
        if let savedCompleted = UserDefaults.standard.array(forKey: "completedTasks"){
            completedTasks = savedCompleted as! Array
        }

        if let savedDates = UserDefaults.standard.array(forKey: "completedDates"){
            completedDates = savedDates as! Array
        }
        
        if let savedDeletedTasks = UserDefaults.standard.array(forKey: "deletedTasks"){
            deletedTasks = savedDeletedTasks as! Array
        }
        
        if let savedDeletedDates = UserDefaults.standard.array(forKey: "deletedDates"){
            deletedDates = savedDeletedDates as! Array
        }
        
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowsCount = 0
        switch(segmentControlTasks.selectedSegmentIndex)
        {
        case 0:
            rowsCount = tasksArray.count
            break
        
        case 1:
            rowsCount = completedTasks.count
            break
         
        case 2:
            rowsCount = deletedTasks.count
            break
        default:
            break
        }
      return rowsCount
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
       
        switch(segmentControlTasks.selectedSegmentIndex){
        case 0:
            cell.textLabel?.text = "\(indexPath.row + 1). \(tasksArray[indexPath.row])"
            cell.detailTextLabel?.text = dateArray[indexPath.row]
            break
         
        case 1:
            cell.textLabel?.text = "\(indexPath.row + 1). \(completedTasks[indexPath.row])"
            cell.detailTextLabel?.text = completedDates[indexPath.row]
            
            break
            
        case 2:
            cell.textLabel?.text = "\(indexPath.row + 1). \(deletedTasks[indexPath.row])"
            cell.detailTextLabel?.text = deletedTasks[indexPath.row]
            break
        
        default:
            break
        }
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if segmentControlTasks.selectedSegmentIndex == 0{
        
        let alert = UIAlertController(title: "", message: "Do you want to put your task into completed or just delete it?!", preferredStyle: .alert)
        
        let addToCompletedAction = UIAlertAction(title: "Add to Completed", style: .default) { (action) in
            
            self.completedTask = tasksArray[indexPath.row]
            self.completedDate = dateArray[indexPath.row]

            completedTasks.append(self.completedTask)
            completedDates.append(self.completedDate)
            
            UserDefaults.standard.set(completedTasks, forKey: "completedTasks")
            UserDefaults.standard.set(completedDates, forKey: "completedDates")
            
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (action) in
            self.deletedTask = tasksArray[indexPath.row]
            self.deletedDate = dateArray[indexPath.row]
            
            deletedTasks.append(self.deletedTask)
            deletedDates.append(self.deletedDate)
            
            UserDefaults.standard.set(deletedTasks, forKey: "deletedTasks")
            UserDefaults.standard.set(deletedDates, forKey: "deletedDates")
        }
        
        alert.addAction(addToCompletedAction)
        alert.addAction(deleteAction)
        
        present(alert,animated: true)
        }
    }
    
  
    
    
    
    
    @IBAction func segmentControlPressed(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    
    @IBAction func trashButtonPressed(_ sender: UIButton) {
        removeAll()
        
    }
    
    
    func removeAll(){
        
          switch(segmentControlTasks.selectedSegmentIndex)
          {
          case 0:
            UserDefaults.standard.removeObject(forKey: "Tasks")
            UserDefaults.standard.removeObject(forKey: "Dates")
            tasksArray.removeAll()
            dateArray.removeAll()
            tableView.reloadData()
            break
            
          case 1:
            UserDefaults.standard.removeObject(forKey: "completedTasks")
            UserDefaults.standard.removeObject(forKey: "completedDates")
            completedTasks.removeAll()
            completedDates.removeAll()
            tableView.reloadData()
            break
            
          case 2:
            UserDefaults.standard.removeObject(forKey: "deletedTasks")
            UserDefaults.standard.removeObject(forKey: "deletedDates")
            deletedTasks.removeAll()
            deletedDates.removeAll()
            tableView.reloadData()
            break
        
          default:
            tableView.reloadData()
            break
        }
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
       performSegue(withIdentifier: "toAddTaskVC", sender: self)
    }
    
}

