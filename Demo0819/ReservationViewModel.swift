//
//  ReservationViewModel.swift
//  Demo0819/Users/lydia/Desktop/Demo0819/.git/COMMIT_EDITMSG
//
//  Created by 維衣 on 2023/10/21.
//

import Foundation
import Firebase


class ReservationViewModel {
    
    // Firebase 資料庫的參照
    let databaseRef = Database.database().reference()

    // 建立函數以新增預約
    func addReservation(_ reservation: Reservation) {
        // 將預約轉為字典
        let reservationDict: [String: Any] = [
            "username": reservation.userName,
            "phoneNumber": reservation.phoneNumber,
            "space": reservation.space,
            "headcount": reservation.headcount,
            "date": reservation.date.timeIntervalSince1970,
            "startTime": reservation.startTime,
            "endTime": reservation.endTime
        ]
        
        let reservationsRef = databaseRef.child("reservations")
        let reservationRef = reservationsRef.childByAutoId()
        
        reservationRef.setValue(reservationDict) {(error, reference) in
            if let error = error {
                print("**寫入數據庫錯誤: \(error.localizedDescription)")
            } else {
                print("**寫入數據成功")
            }
        }
    }
}
