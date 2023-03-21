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
  let demoApiKey = "문의"
        
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
## Usage

<table>
  <tr>
    <th width="30%">사용 예시</th>
    <th width="30%">스크린샷</th>
  </tr>
  <tr>
    <td>초기화</td>
    <th rowspan="9"><img src="https://user-images.githubusercontent.com/3009734/226293234-da0638eb-7f0a-4c24-8c40-4a8e0febcb0d.png"></th>
  </tr>
  <tr>
    <td><div class="highlight highlight-source-swift"><pre>
     var scrapService: ScrapService?
     let layer = "dev"
     let logger = true
     let demoApiKey = "문의"
        
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
  </tr>
  <tr>
    <td>설명</td>
  </tr>
  <tr>
    <td width="30%"><div class="highlight highlight-source-swift"><pre>
      전달받은 apiKey 정보를 입력하새 Builder를 이용해 객체를 생성합니다.
    </pre></div></td>
  </tr>
</table>


# Sample Test
1. 기능 목록

![image](https://user-images.githubusercontent.com/3009734/226293234-da0638eb-7f0a-4c24-8c40-4a8e0febcb0d.png)


2. SignUp
- 아이디, 태어난 해, 성별을 입력합니다.

![image](https://user-images.githubusercontent.com/3009734/226299486-ae0a1f42-5280-43bf-9431-3f80bb1109a0.png)


3. GetCommerces
- 커머스 목록을 가져옵니다.

![image](https://user-images.githubusercontent.com/3009734/226293561-f95a3d3f-3e4b-46bb-9e0e-e801f75ab1ac.png)


4. Scrap
- startLogin -> startScrapingOrder 순서로 호출하여 커머스 주문내역 스크랩을 합니다.

![image](https://user-images.githubusercontent.com/3009734/226293755-81ced1fa-83f5-4f2b-9499-397561ee38d8.png)


5. GetScrapingUsers
- 로그인 정보가 저장된 커머스 목록을 가져옵니다.

![image](https://user-images.githubusercontent.com/3009734/226295209-f685b9df-b72b-4c6f-b024-4f66b7ca052d.png)


6. GetOrders
- 스크랩된 주문 목록을 가져옵니다.

![image](https://user-images.githubusercontent.com/3009734/226296569-d2c9cd3b-15c0-4a19-949f-888101c03f41.png)

