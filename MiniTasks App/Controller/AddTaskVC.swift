//
//  AddTaskVC.swift
//  MiniTasks App
//
//  Created by Mohamed on 1/30/18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import UIKit

class AddTaskVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var addTaskbutton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var tasks = ["Select Task","Go to dentist","Meet friends","Iron my clothes","Call parents","Pay bills","Paint desk","Call insurance company","Cook dinner","Buy gifts","Take kids out","Go For swiming lesson","Play Tennis","Clean the house","Track package"]
    
    var dateFormatter = DateFormatter()
    var selectedTask = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        pickerView.dataSource = self
        pickerView.delegate = self
        
        addTaskbutton.isEnabled = false
        
        datePicker.minimumDate = Date()
        
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy HH:mm"
        
        addTaskbutton.layer.cornerRadius = 25
        addTaskbutton.layer.borderColor = UIColor.white.cgColor
        addTaskbutton.layer.borderWidth = 1.0
        addTaskbutton.clipsToBounds = true
        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tasks.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tasks[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if row == 0{
        }else{
            addTaskbutton.isEnabled = true
            selectedTask = tasks[row]
        }
        
    }
    
    @IBAction func addTaskPressed(_ sender: UIButton) {
        let date = datePicker.date
        let dateStr = dateFormatter.string(from: date)

        tasksArray.append(selectedTask)
        dateArray.append(dateStr)
        
       UserDefaults.standard.set(tasksArray, forKey: "Tasks")
       UserDefaults.standard.set(dateArray, forKey: "Dates")
      
        dismiss(animated: true, completion: nil)
    }
    
  
    @IBAction func closePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
