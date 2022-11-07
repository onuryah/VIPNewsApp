//
//  FirebaseWorker.swift
//  NewsApp
//
//  Created by admin on 6.11.2022.
//

import Foundation
import FirebaseAnalytics

protocol EventsGetter {
    func getSelectedIndexForFirebase(title: String)
}

struct FirebaseWorker : EventsGetter {
    func getSelectedIndexForFirebase(title: String) {
        Analytics.logEvent("tapped_index", parameters: ["tapped_title" : title])
    }
}
