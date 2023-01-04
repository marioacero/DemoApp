//
//  Mapper.swift
//  SampleAppDemo
//
//  Created by Mario Acero on 2023-01-02.
//

import Foundation

class Mapper {
    
    func mapPosts(dataResponse: Data)-> [Post] {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        do {
            let entitie = try jsonDecoder.decode([Post].self, from: dataResponse)
            return entitie
        } catch {
            return []
        }
    }
    
    func mapUser(dataResponse: Data) -> User? {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        do {
            let entitie = try jsonDecoder.decode(User.self, from: dataResponse)
            return entitie
        } catch {
            return nil
        }
    }
    
    func mapComments(dataResponse: Data)-> [Comment] {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        do {
            let entitie = try jsonDecoder.decode([Comment].self, from: dataResponse)
            return entitie
        } catch {
            return []
        }
    }
}
