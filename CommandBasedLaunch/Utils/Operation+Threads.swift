//
//  Operation+Threads.swift
//  CommandBasedLaunch
//
//  Created by Andrew Romanov on 27.01.2022.
//

import Foundation

extension Operation {
    func asyncOnMain(_ block: @escaping ( )-> Void ) {
        DispatchQueue.main.async {
            block()
        }
    }

    func syncOnMain(_ block: @escaping () -> Void) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.sync {
                block()
            }
        }
    }
}

