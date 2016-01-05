//
//  MemoizedSelector.swift
//  MemoizedSelector
//
//  Created by Shinya Takahashi on 2016/01/05.
//  Copyright © 2016年 Shinya Takahashi. All rights reserved.
//

public class MemoizedSelector<Arg,Result> {
    
    private let checkChanged: (Arg, Arg) -> Bool
    private let selector: Arg -> Result
    private var lastArg: Arg? = nil
    private var lastResult: Result? = nil
    
    init(checkChanged: (Arg, Arg) -> Bool, selector: Arg -> Result) {
        self.checkChanged = checkChanged
        self.selector = selector
    }
    
    func exec(arg: Arg) -> Result {
        if shouldExec(arg) {
            lastArg = arg
            lastResult = selector(arg)
        }
        return lastResult!
    }
    
    private func shouldExec(arg: Arg) -> Bool {
        return (lastResult == nil || lastArg == nil || !checkChanged(lastArg!, arg))
    }
}

