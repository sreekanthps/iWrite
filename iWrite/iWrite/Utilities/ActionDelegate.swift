//
//  ActionDelegate.swift
//  iWrite
//
//  Created by Swetha Sreekanth on 24/4/21.
//


import Foundation
public protocol DelegateAction {}
public protocol ActionDelegate: class {
    func actionSender(didReceiveAction action: DelegateAction)
}
