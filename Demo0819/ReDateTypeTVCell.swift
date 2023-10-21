//
//  ReDateTypeTableViewCell.swift
//  Demo0819
//
//  Created by 維衣 on 2023/9/29.
//

import UIKit

class ReDateTypeTVCell: UITableViewCell {
    
    var cellDataTyoe: CellDataType
    
    enum CellDataType {
        case cellDataTextField
        case cellDataPickView
        case cellDataDatePicker
        case cellDataLabel
        case cellDataTextView
    }
    
    init(cellType: CellDataType, reuseIdentifier: String?) {
        self.cellDataTyoe = cellType
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        switch cellType {
        case .cellDataTextField:
            let textField = UITextField()
            contentView.addSubview(textField)
            
        case .cellDataPickView:
            let pickerView = UIPickerView()
            contentView.addSubview(pickerView)
            
        case .cellDataDatePicker:
            let datePicker = UIDatePicker()
            contentView.addSubview(datePicker)
            
        case .cellDataLabel:
            let label = UILabel()
            contentView.addSubview(label)
            
        case .cellDataTextView:
            let textView = UITableView()
            contentView.addSubview(textView)
            
        }
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(soader:) has not been implemented")
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
