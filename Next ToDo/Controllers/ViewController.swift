//
//  ViewController.swift
//  Next ToDo
//
//  Created by Marco Mascorro on 6/4/22.
//

import UIKit
import CoreData


private let reuseID = "reuseId"

class ViewController: UITableViewController {

    //MARK: - Properties
    
    var itemArray = ["Find Mjmike","Buy eggos","Destroy demogorgons"]
    var task: [NSManagedObject]? {
        didSet{
            tableView.reloadData()
        }
    }
    
    
    
    
    private lazy var addTaskButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .darkGray
        button.setDimensions(width: 60, height: 60)
        button.layer.cornerRadius = 60 / 2
        button.addTarget(self, action: #selector(handleAddTaskButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var editTaskButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .darkGray
        button.setDimensions(width: 60, height: 60)
        button.layer.cornerRadius = 60 / 2
        button.addTarget(self, action: #selector(handleEditTaskButton), for: .touchUpInside)
        return button
    }()
    
    
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchData()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewDidLoad()
        tableView.separatorStyle = .none
        tableView.register(ToDoCategoryCell.self, forCellReuseIdentifier: reuseID)
      
        if task!.count == 0 {
            editTaskButton.isHidden = true
        } else {
            editTaskButton.isHidden = false
        }
   
    }

    
    //MARK: - Selectors
    @objc func handleAddTaskButton(){
        let vc = UINavigationController(rootViewController: AddTaskController())
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
        
        
        
    }
    
    @objc func handleEditTaskButton(){
        if tableView.isEditing {
            tableView.isEditing = false
            
        } else {
            
            tableView.isEditing = true
        }
    }
    
    
    
    //MARK: - Helpers
    private func configureUI(){
        view.backgroundColor = .darkGray
        navigationItem.title = "Next Do"
        
        let stack = UIStackView(arrangedSubviews: [editTaskButton, addTaskButton])
        stack.axis = .vertical
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor , right: view.safeAreaLayoutGuide.rightAnchor, paddingBottom: 12 , paddingRight: 20)
        
        
    }

    private func fetchData(){
        CoreDataModel.shared.fetchData { items in
            self.task = items
        }
    }

}

extension ViewController {

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! ToDoCategoryCell
        if let item = task {
            cell.categoryLabel.text = item[indexPath.row].value(forKeyPath: "title") as? String
        }
        cell.selectionStyle = .none
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if let item = task {
                CoreDataModel.shared.deleteItem(for: item[indexPath.row])
                task?.remove(at: indexPath.row)
            }
            
            if task!.count == 0 {
                editTaskButton.isHidden = true
            } else {
                editTaskButton.isHidden = false
            }
            
        }
    }
}

