//
//  KeychainManager.swift
//  DesafioWeslley
//
//  Created by Gabriel Carvalho on 02/11/22.
//

import UIKit

final class KeychainManager {
    
    // MARK: Usei keyChain para o accessToken devido ser uma informação mais sensivel,
    // MARK: com o keyChain conseguimos trata-lo com mais segurança, diferente do userDefault ou CoreData. -
    
    enum KeychainError: LocalizedError {
        case itemNotFound
        case duplicateItem
        case unexpectedStatus(OSStatus)
    }

    func saveToken(token: Data, identifier: String) throws {
       let attributes = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: identifier,
            kSecValueData: token
        ] as CFDictionary

        let status = SecItemAdd(attributes, nil)
        guard status == errSecSuccess else {
            if status == errSecDuplicateItem {
                throw KeychainError.duplicateItem
            }
            throw KeychainError.unexpectedStatus(status)
        }
        
    }
    
    func getToken(identifier: String) throws -> String {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: identifier,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: true
        ] as CFDictionary

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)

        guard status == errSecSuccess else {
            if status == errSecItemNotFound {

                throw KeychainError.itemNotFound
            }
            throw KeychainError.unexpectedStatus(status)
        }
        
        return String(data: result as! Data, encoding: .utf8)!
    }
    
    func updateToken(_ token: Data, identifier: String) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: identifier
        ] as CFDictionary

        let attributes = [
            kSecValueData: token
        ] as CFDictionary

        let status = SecItemUpdate(query, attributes)
        guard status == errSecSuccess else {
            if status == errSecItemNotFound {
                throw KeychainError.itemNotFound
            }
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    func deleteToken(identifier: String) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: identifier
        ] as CFDictionary

        let status = SecItemDelete(query)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
}

