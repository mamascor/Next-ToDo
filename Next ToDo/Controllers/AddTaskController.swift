//
//  AddTaskController.swift
//  Next ToDo
//
//  Created by Marco Mascorro on 6/4/22.
//

import UIKit


class AddTaskController: UIViewController {
    //MARK: - Properties
    var placeholderLabel : UILabel!
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(saveTaskData), for: .touchUpInside)
        
        
        return button
    }()
    
    private let titleField: UITextField = {
        let tf = UITextField()
        
        tf.placeholder = "Task Title"
        tf.textAlignment = .center
        
        return tf
    }()
    
    
    private let noteTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return tv
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTextView.delegate = self
        configureUIBar()
        configureUI()
        configureTextViewPlaceholder()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .default
    }
    
    
    //MARK: - Selectors
    @objc func saveTaskData(){
        guard let title = titleField.text, !title.isEmpty  else { return }
        
        CoreDataModel.shared.saveData(title: title, titledesc: noteTextView.text)
        
        self.dismiss(animated: true)
        
    }
    
    @objc func handleDimiss(){
        self.dismiss(animated: true)
    }
    
    //MARK: - Helpers
    private func configureUI(){
        view.backgroundColor = .darkGray
        
        view.addSubview(titleField)
        titleField.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 12,paddingRight: 12, height: 30)
        titleField.backgroundColor = .clear
        titleField.layer.cornerRadius = 4
        
        
        
        
        
    }
    
    private func configureUIBar(){
        navigationItem.title = "Add a Task"
        
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleDimiss), for: .touchUpInside)
        button.tintColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
    }
    
    private func configureTextViewPlaceholder(){
        placeholderLabel = UILabel()
        placeholderLabel.text = "Tasks..."
        placeholderLabel.font = .systemFont(ofSize: 17, weight: .regular)
        placeholderLabel.sizeToFit()
        noteTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (noteTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = .init(white: 1, alpha: 0.2)
        placeholderLabel.isHidden = !noteTextView.text.isEmpty
    }
    
    
    
}

extension AddTaskController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !noteTextView.text.isEmpty
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 580
        
    }
}


class CustomAlertBox {
    
    struct Constants {
        static let backGroundAlpha: CGFloat = 0.0
    }
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    private let alertView: UIView = {
        let view = UIView()
        
        
        return view
    }()
    
    
    func showAlert(with title: String, message: String, on viewController: UIViewController){
        guard let targetView = viewController.view else { return }
        
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        
        targetView.addSubview(alertView)
        alertView.frame = CGRect(x: 40, y: -300, width: targetView.frame.size.width - 80, height: 300)
        
        let titlelabel = UILabel(frame: CGRect(x: 0, y: 0, width: alertView.frame.size.width, height: 80))
        titlelabel.text = title
        titlelabel.textAlignment = .center
        
        alertView.addSubview(titlelabel)
        
    }
    
    
    
    
    
}
