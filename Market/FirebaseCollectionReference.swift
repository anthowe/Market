//
//  FirebaseCollectionReference.swift
//  Market
//
//  Created by Anthony Howe on 3/17/20.
//  Copyright © 2020 Anthony Howe. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String{
    case User
    case Category
    case Items
    case Basket
}

func FirebaseReference(_ collectionReference: FCollectionReference)
    -> CollectionReference{
        return Firestore.firestore().collection(collectionReference.rawValue)
}
