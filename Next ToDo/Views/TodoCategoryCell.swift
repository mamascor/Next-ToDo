//
//  TodoCategoryCell.swift
//  Next ToDo
//
//  Created by Marco Mascorro on 6/4/22.
//

import UIKit



class ToDoCategoryCell: UITableViewCell {

    
    
    //MARK: - Properties
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont (ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    let isDoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    //MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
       configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    
    //MARK: - Helpers
    private func configureUI(){
        backgroundColor = .clear
        addSubview(categoryLabel)
        categoryLabel.anchor(top: topAnchor, left:leftAnchor,right: rightAnchor,paddingTop: 12, paddingRight: 12)
        categoryLabel.textAlignment = .right
        
       
    }
    
    
}
