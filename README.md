# commerce-ios-sdk-sample

# Requirements
- Swift 5.5 / Xcode 13.2 / iOS 15.0+

Installation

- CocoaPods
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '15.0'
use_frameworks!

target 'MyApp' do
  pod 'Commerce', :git => "https://github.com/TENQUBE/commerce-ios-sdk.git"
end
```



# Use-case
1. 초기화
```
  var scrapService: ScrapService?
  let layer = "dev"
  let logger = true
  let demoApiKey = "Nrcoz4wo1Z8mvEuyZzcFt3QUu3cCKpjC4TtijITZ"
        
  do {
    scrapService = try ServiceBuilder()
          .setApiKey(demoApiKey)
          .setLayer(layer)
          .setLogger(logger)
          .build()
            
    scrapService?.initialize(completion: { err in
            
          })
        } catch {
            
        }
```


2. 사용할 ViewController에 SDK 웹뷰 설정
- api 호출 전 scrapService를 사용하는 ViewController를 설정하도록 합니다.
```
scrapService?.setWebViewController(vc: self, frame: self.view.bounds)
```


3. 사용자 등록
```
  scrapService?.signUp(clientId: "uuidString", birth: 1990, gender: .Female, completion: { err in
        if err != nil {

        } else {
          print("signUp done")
        }
      })
```


4. 커머스 목록 가져오기
```
  scrapService?.getCommerces(completion: { err, items in
        if err != nil {

        } else {
          print(items ?? [])        
        }
      })
```


5. 커머스 로그인
```
  scrapService?.startLogin(id:  "testId", pwd: "testPwd", commerceId: "commerceId", completion: { err in          
        if err != nil {
        
        } else {
        
        }
      })
        
```

6. 커머스 스크랩
```
  scrapService?.startScrapingOrder(id: "testId", pwd: "testPwd", commerceId: "commerceId", completion: { err, scrapingResut in
        if err != nil {
        
        } else {

        }
      })
```


7. 커머스 로그인계정 목록 가져오기
```
  scrapService?.getScrapingUsers(completion: { err, rst in
        if err != nil {
        
        } else {

        }
      })
```


8. 주문내역 가져오기
```
  scrapService?.getOnlineOrders(commerceIds: ["commerceId"], completion: { err, rst in
        if err != nil {

        } else {

        }
    })
```
