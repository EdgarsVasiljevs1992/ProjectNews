//
//  PickTitle.swift
//  ProjectNews
//
//  Created by edgars.vasiljevs on 22/11/2021.
//

import Foundation

struct Title {
    let title: String
    let poster: String
    
    
//    static func createTitle() -> [Title]{
//        var titles: [Title] = []
//
//        let articles = DataManager.shared.article
//        let posters = DataManager.shared.poster
//
//        for index in 0..<articles.count{
//            let news = Title(title: articles[index], poster: posters[index])
//            titles.append(news)
//        }
//
//        return titles
//    }
    
    static func createTitle() -> [Title]{
        var titles: [Title] = []
        
        let articles = DataManager.shared.article
        let posters = DataManager.shared.poster
        
        for index in 0...2{
            let news = Title(title: articles[index], poster: posters[index])
            titles.append(news)
        }
        
        return titles
    }
    
    static func createTitle2() -> [Title]{
        var titles: [Title] = []
        
        let articles = DataManager.shared.article
        let posters = DataManager.shared.poster
        
        for index in 3...5{
            let news = Title(title: articles[index], poster: posters[index])
            titles.append(news)
        }
        
        return titles
    }
    
    static func createTitle3() -> [Title]{
        var titles: [Title] = []
        
        let articles = DataManager.shared.article
        let posters = DataManager.shared.poster
        
        for index in 6...8{
            let news = Title(title: articles[index], poster: posters[index])
            titles.append(news)
        }
        
        return titles
    }
    
}
