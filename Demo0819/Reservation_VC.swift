//
//  Reservation_VC.swift
//  Demo0819
//
//  Created by 維衣 on 2023/8/19.
//

import UIKit


class Reservation_VC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var dataToReceive: String?
    var scrollView: UIScrollView!
    let tableView = UITableView()
    
    let pickerView = UIPickerView()
    let spacePickerView = UIPickerView()
    let headcountPickerView = UIPickerView()
    let startTimePickerView = UIPickerView()
    
    let datePicker = UIDatePicker()
    
    var reservationArray: [String] = [
                "username",
                "phoneNumber",
                "Space",
                "Headcount",
                "Date",
                "startTime",
                "endTime"
    ]
    
    var customUIElements: [CustomCellUIType] = [
        .pickerView(data: ["神秘的海盜寶藏", "未來科技實驗室", "古代文明之謎", "幽靈小屋"]),
        .pickerView(data: ["﻿1","﻿2","﻿3","﻿4","﻿5","6","﻿7","﻿8"]),
        .pickerView(data: ["10:00","12:00","14:00","16:00","18:00","20:00"])
    ]
    
    
    enum CustomCellUIType {
        case pickerView(data: [String]?)

        var pickerViewData: [String]? {
            switch self {
            case .pickerView(let data):
                return data
            }
        }
    }

    var textField: UITextField?
    var spacePickerViewHeightConstraint﻿: NSLayoutConstraint!
    var headcountPickerViewHeightConstraint﻿: NSLayoutConstraint!
    var startTimePickerViewHeightConstraint﻿: NSLayoutConstraint!
    var pickerHeightMultiplier: CGFloat = 1.0
    
    var isEndTimeTitleLabelHidden = false
    
    var endTimeLabel: UILabel!
    var endTimeTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spacePickerView.dataSource = self
        spacePickerView.delegate = self
        spacePickerView.tag = 1
        
        headcountPickerView.dataSource = self
        headcountPickerView.delegate = self
        headcountPickerView.tag = 2
        
        startTimePickerView.dataSource = self
        startTimePickerView.delegate = self
        startTimePickerView.tag = 3
        
        spacePickerViewHeightConstraint﻿ = spacePickerView.heightAnchor.constraint(equalToConstant: 0)
        headcountPickerViewHeightConstraint﻿ = headcountPickerView.heightAnchor.constraint(equalToConstant: 0)
        startTimePickerViewHeightConstraint﻿ = startTimePickerView.heightAnchor.constraint(equalToConstant: 0)
        
        spacePickerViewHeightConstraint﻿.isActive = true
        headcountPickerViewHeightConstraint﻿.isActive = true
        startTimePickerViewHeightConstraint﻿.isActive = true
        
        setupScrollView()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customTableViewCell")
        tableView.register(PaymentTableViewCell.self, forCellReuseIdentifier: "paymentTableViewCell")

        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44

        if let receivedData = dataToReceive {
            print("**Received data: \(receivedData)")
        } else {
            print("**No data received")
        }

            // 初始化 scrollView
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 80, width: view.frame.width, height: view.frame.width / 4 * 3))

        view.addSubview(scrollView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        let topConstraiont = tableView.topAnchor.constraint(equalTo: view.topAnchor)
        let leadingConstraiont = tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingConstraiont = tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let heightConstraiont = tableView.heightAnchor.constraint(equalToConstant: 60) // 設定所需高度

        NSLayoutConstraint.activate([topConstraiont, leadingConstraiont, trailingConstraiont, heightConstraiont])
        
        
        let tapGesturn = UITapGestureRecognizer(target: self, action: #selector(hendleTap))
        view.addGestureRecognizer(tapGesturn)
        
        tableView.rowHeight = 44.0
        
//        if spacePickerView.superview != nil {
//            // spacePickerView 已经添加到视图上
//            print("**spacePickerView 已经添加到视图上")
//        } else {
//            // spacePickerView 尚未添加到视图上
//            print("**spacePickerView 尚未添加到视图上")
//        }
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
    return 2
}

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
        // 第一个Section用于显示预订，返回reservationArray的数量
        return reservationArray.count
    } else if section == 1 {
        // 第二个Section用于标题，返回1表示只有一个标题行
        return 1
    }
        return 0
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCell", for: indexPath) as! CustomTableViewCell
            let labelText = reservationArray[indexPath.row]
            cell.label.text = labelText
            
            switch labelText {

            case "username":
                let textField = UITextField()
                textField.placeholder = "請輸入\(labelText)"
                textField.delegate = self
                textField.keyboardType = .default
                textField.borderStyle = .roundedRect
                textField.tag = 0
                textField.translatesAutoresizingMaskIntoConstraints = false
                cell.contentView.addSubview(textField)
                
                NSLayoutConstraint.activate([
                    textField.leadingAnchor.constraint(equalTo: cell.label.trailingAnchor, constant: 8),
                    textField.centerYAnchor.constraint(equalTo: cell.label.centerYAnchor),
                    textField.widthAnchor.constraint(equalToConstant: 200),
                    textField.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16)
                ])
                print("**case username")
                
            case "phoneNumber":
                let textField = UITextField()
                textField.placeholder = "請輸入\(labelText)"
                textField.delegate = self
                textField.keyboardType = .numberPad
                textField.borderStyle = .roundedRect
                textField.tag = 1
                textField.translatesAutoresizingMaskIntoConstraints = false
                cell.contentView.addSubview(textField)
                
                textField.addTarget(self, action: #selector(phoneNumberTextFieldDidChange(_:)), for: .editingChanged)
                
                NSLayoutConstraint.activate([
                    textField.leadingAnchor.constraint(equalTo: cell.label.trailingAnchor, constant: 8),
                    textField.centerYAnchor.constraint(equalTo: cell.label.centerYAnchor),
                    textField.widthAnchor.constraint(equalToConstant: 200),
                    textField.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16)
                
                ])
                print("**case phoneNumber")
                

            case "Space":
                
                spacePickerView.transform = CGAffineTransform(translationX: cell.bounds.size.width, y: 0)
                spacePickerView.translatesAutoresizingMaskIntoConstraints = false
                cell.contentView.addSubview(spacePickerView)
                
                spacePickerViewHeightConstraint﻿?.isActive = false
                spacePickerViewHeightConstraint﻿ = spacePickerView.heightAnchor.constraint(equalTo: cell.contentView.heightAnchor, multiplier: pickerHeightMultiplier)
                spacePickerViewHeightConstraint﻿?.isActive = true
                NSLayoutConstraint.activate([
                    spacePickerView.widthAnchor.constraint(equalToConstant: 200),
                    spacePickerView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant:  -16)
                ])
                
                UIView.animate(withDuration: 0.5) {
                    self.spacePickerView.transform = .identity
                }
                
                spacePickerView.reloadComponent(0)
                               
                print("**Space")
            case "Headcount":
                headcountPickerView.transform = CGAffineTransform(translationX: cell.bounds.size.width, y: 0)
                headcountPickerView.translatesAutoresizingMaskIntoConstraints = false
                cell.contentView.addSubview(headcountPickerView)
                
                headcountPickerViewHeightConstraint﻿?.isActive = false
                headcountPickerViewHeightConstraint﻿ = headcountPickerView.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: pickerHeightMultiplier)
                headcountPickerViewHeightConstraint﻿?.isActive = true
                
                
                NSLayoutConstraint.activate([
                    headcountPickerView.widthAnchor.constraint(equalToConstant: 200),
                    headcountPickerView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant:  -16)
                ])
                
                UIView.animate(withDuration: 0.5) {
                    self.headcountPickerView.transform = .identity
                }
                
                headcountPickerView.reloadComponent(0)
                
                print("**Headcount")
            case "startTime":
                startTimePickerView.transform = CGAffineTransform(translationX: cell.bounds.size.width, y: 0)
                startTimePickerView.translatesAutoresizingMaskIntoConstraints = false
                cell.contentView.addSubview(startTimePickerView)
                
                startTimePickerViewHeightConstraint﻿?.isActive = false
                startTimePickerViewHeightConstraint﻿ = startTimePickerView.heightAnchor.constraint(equalTo: cell.contentView.heightAnchor, multiplier: pickerHeightMultiplier)
                startTimePickerViewHeightConstraint﻿?.isActive = true
                
                NSLayoutConstraint.activate([
                    startTimePickerView.widthAnchor.constraint(equalToConstant: 200),
                    startTimePickerView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16)
                    

                ])
                
                UIView.animate(withDuration: 0.5) {
                    self.startTimePickerView.transform = .identity
                }
                
                startTimePickerView.reloadComponent(0)
                
                print("**startTime")
            case "Date":
                let datePicker = UIDatePicker()
                    datePicker.datePickerMode = .date
//                datePicker.transform = CGAffineTransform(translationX: cell.bounds.size.width, y: 0)
                    datePicker.translatesAutoresizingMaskIntoConstraints = false
                
                cell.contentView.addSubview(datePicker)
                
                NSLayoutConstraint.activate([
                    datePicker.leadingAnchor.constraint(equalTo: cell.label.trailingAnchor, constant: 8),
                    datePicker.centerYAnchor.constraint(equalTo: cell.label.centerYAnchor),
                    datePicker.widthAnchor.constraint(equalToConstant: 200),
                    datePicker.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant:  -16)
                ])
                print("**Date")
            case "endTime":
                
                if cell.viewWithTag(6) == nil {
                let endTimeTitleLabel = UILabel()
                endTimeTitleLabel.text = "endTime"
                endTimeTitleLabel.tag = 6
                endTimeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
                cell.contentView.addSubview(endTimeTitleLabel)
                
                endTimeLabel = UILabel()
                endTimeLabel.tag = 7
                    endTimeLabel.textAlignment = .center
                    endTimeLabel.contentMode = .center
                    endTimeLabel.font = UIFont.systemFont(ofSize: 20)
                endTimeLabel.translatesAutoresizingMaskIntoConstraints = false
                cell.contentView.addSubview(endTimeLabel)
                    
                    NSLayoutConstraint.activate([
                        endTimeTitleLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
                        endTimeTitleLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                        
                        endTimeLabel.leadingAnchor.constraint(equalTo: endTimeTitleLabel.trailingAnchor, constant: 8),
                        endTimeLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                        endTimeLabel.widthAnchor.constraint(equalToConstant: 200),
                        endTimeLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16)
                        
                    ])
                
                    
                } else {
                    endTimeTitleLabel = (cell.viewWithTag(6) as! UILabel)
                    endTimeLabel = cell.contentView.viewWithTag(7) as? UILabel
                }
                
                let selectedRow = startTimePickerView.selectedRow(inComponent: 0)
                let selectdTime = customUIElements[2].pickerViewData?[selectedRow]
                
                let dateFormtter = DateFormatter()
                dateFormtter.dateFormat = "HH:mm"
                
                if let selectedDate = dateFormtter.date(from: selectdTime!) {
                    if let endTime = Calendar.current.date(byAdding: .minute, value: 90, to: selectedDate) {
                        reservationArray[6] = dateFormtter.string(from: endTime)
                        
                        endTimeLabel.text = reservationArray[6]
                    }
                }
               
                
            default:
                break
            }
            return cell
            
            
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "paymentTableViewCell", for: indexPath) as! PaymentTableViewCell
            cell.selectionStyle = .none
            
            let label = UILabel()
            label.text = "繳費金額"
            label.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(label)
            
            let paymentTextField = UITextField()
            paymentTextField.placeholder = "請輸入金額"
            paymentTextField.borderStyle = .roundedRect
            paymentTextField.keyboardType = .numberPad
            paymentTextField.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(paymentTextField)
            
            let confirmButton = UIButton(type: .system)
            confirmButton.setTitle("確定", for: .normal)
            confirmButton.translatesAutoresizingMaskIntoConstraints = false
            confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
            cell.contentView.addSubview(confirmButton)
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
                label.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 12),
                
                paymentTextField.leadingAnchor.constraint(equalTo: label.trailingAnchor , constant: 8),
                paymentTextField.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
                paymentTextField.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8),
                paymentTextField.trailingAnchor.constraint(equalTo: confirmButton.leadingAnchor, constant: -8),
                
                confirmButton.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
                confirmButton.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                confirmButton.widthAnchor.constraint(equalToConstant: 80)
  
            ])
            
            return cell
        }
        
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 {
        // 返回标题Section的标题为"預約"
        return "預約"
    } else {
        return "繳費"
    }
}

    
    func numberOfComponents(in UIPickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == spacePickerView {
            return customUIElements[0].pickerViewData?.count ?? 0
        } else if pickerView == headcountPickerView {
            return customUIElements[1].pickerViewData?.count ?? 1
        } else if pickerView == startTimePickerView {
            return customUIElements[2].pickerViewData?.count ?? 2
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let pickerData: [String]?
        switch pickerView.tag {
        case 1:
            pickerData = customUIElements[0].pickerViewData
        case 2:
            pickerData = customUIElements[1].pickerViewData
        case 3:
            pickerData = customUIElements[2].pickerViewData
        default:
            pickerData = nil
            }

        if let data = pickerData, row < data.count {
            return data[row]
        }
        print("**pickerView / titleForRow")
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedRow = startTimePickerView.selectedRow(inComponent: 0)
        let selectdTime = customUIElements[2].pickerViewData?[selectedRow]

        let dateFormtter = DateFormatter()
        dateFormtter.dateFormat = "HH:mm"

        if let selectedDate = dateFormtter.date(from: selectdTime!) {
            if let endTime = Calendar.current.date(byAdding: .minute, value: 90, to: selectedDate) {
                reservationArray[6] = dateFormtter.string(from: endTime)

                endTimeLabel.text = reservationArray[6]
            }
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textAlignment = .center
        pickerLabel.text = customUIElements[pickerView.tag - 1].pickerViewData?[row]
        pickerLabel.font = UIFont.systemFont(ofSize: 20)
        return pickerLabel
    }
    
       
    func setupScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 80, width: view.frame.width, height: view.frame.width / 4 * 3))
        
        guard let scrollView = scrollView else {
            return
        }
        
        let pageIndex = 3
        let rect = CGRect(x: CGFloat(pageIndex) * scrollView.frame.width, y: 0, width: scrollView.frame.height, height: scrollView.frame.height)
        
        scrollView.scrollRectToVisible(rect, animated: true)
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height)
        scrollView.isUserInteractionEnabled = false
    }
    
    
    func showAlertWithTitle(_ title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
            )
        
        let okAction = UIAlertAction(
            title: "Enter",
            style: .default
//            handler: nil
        )
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showInvalidCharacterAlert() {
        showAlertWithTitle("Invalid Input", message: "只能輸入中文和英文")
    }
    
    func showInvalidPhoneNumberAlert() {
        showAlertWithTitle("Tip", message: "需輸入09開頭的手機號碼")


    }
    
    func showNumberTooLongAlert() {
        showAlertWithTitle("Tip", message: "phoneNumber too long")

    }
        
    
    private func textField(_ textField: UITextField, shouldCangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789你好您好您好嗨")
        
        for scalar in string.unicodeScalars {
            if !allowedCharacterSet.contains(scalar) {
                showInvalidPhoneNumberAlert()
                return false
            }
        }
        return true
    }
    
    @objc func phoneNumberTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if text.count == 10 {
            if text.hasPrefix("09") {
                print("**phomeNumder is true")
            } else {
                showInvalidPhoneNumberAlert()
                print("**phoneNumder is false")
            }
        } else if text.count > 10 {
                print("**number too long")
                showNumberTooLongAlert()
            }
        }
    }
   
    @objc func confirmButtonTapped() {
        if let indexPath = tableView.indexPathForSelectedRow {
            let cell = tableView.cellForRow(at: indexPath)
            if let paymentTextField = cell?.subviews.first(where: { $0 is UITextField }) as? UITextField {
                if let amount = paymentTextField.text {
                    print("**confirmButtonTapped 繳費金額:\(amount)")
                }
            }
        }
    }
    
    @objc func hendleTap() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
}
