//
//  JPNetworkTools.swift
//  AlamofireDemo
//
//  Created by 张俊平 on 2021/4/30.
//

//Alamofire 封装
import Foundation
import Alamofire

typealias finishedCallback = (_ result:AnyObject)->(Void)

class NetWork {
	class func requestData(type:HTTPMethod, URLString:String,parameters:[String:String]?=nil, success: @escaping finishedCallback) {

		AF.request(URL(string: URLString)!, method: type, parameters: parameters).responseString { (responses) in

//			let ste:String = responses.value ?? ""
//			print("dddd:\(ste)")
//			let statusCode = responses.response?.statusCode
//			debugPrint("statusCode:\(String(describing: statusCode))")

			switch responses.result {

			case .success:
				//let json = String(data: responses.data!, encoding: String.Encoding.utf8)
				let resultDic = responses.value as AnyObject
				success(resultDic)
			case .failure:
				//let statusCode = responses.response?.statusCode
				debugPrint(responses.error ?? "" )

			}
		}

	}

}

