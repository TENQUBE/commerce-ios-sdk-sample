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
let layer = "dev"   // 서비스 레이어 구분 (dev/prod)
let logger = true   // 로그유무
let demoApiKey = "문의" // api Key

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
      
<table>
  <tr>
    <th width="30%">사용 예시</th>
    <th width="30%">스크린샷</th>
  </tr>
  <tr>
    <td>ViewController 공통 적용</td>
    <th rowspan="9"></th>
  </tr>
  <tr>
    <td><div class="highlight highlight-source-swift"><pre>
scrapService?.setWebViewController(vc: self, 
                                   frame: self.view.bounds) 
  </tr>
  <tr>
    <td>설명</td>
  </tr>
  <tr>
    <td width="30%"><div class="highlight highlight-source-swift"><pre>
      api 호출 전 scrapService를 사용하는 ViewController를       
      설정하도록 합니다.
    </pre></div></td>
  </tr>
</table>
      
<table>
  <tr>
    <th width="30%">사용 예시</th>
    <th width="30%">스크린샷</th>
  </tr>
  <tr>
    <td></td>
    <th rowspan="9"><img src="https://user-images.githubusercontent.com/3009734/226299486-ae0a1f42-5280-43bf-9431-3f80bb1109a0.png"></th>
  </tr>
  <tr>
    <td><div class="highlight highlight-source-swift"><pre>
scrapService?.signUp(
      clientId: "testClientid", // 등록할 아이디
      birth: 1990,              // 태어난 해
      gender: .Female,          // 성별 (.Male/.Female)
      completion: { err in
    if err != nil {

    } else {

    }
  })
  </tr>
  <tr>
    <td>설명</td>
  </tr>
  <tr>
    <td width="30%"><div class="highlight highlight-source-swift"><pre>
      아이디, 태어난 해, 성별을 입력합니다.                          
    </pre></div></td>
  </tr>
</table>

    
<table>
  <tr>
    <th width="30%">사용 예시</th>
    <th width="30%">스크린샷</th>
  </tr>
  <tr>
    <td></td>
    <th rowspan="9"><img src="https://user-images.githubusercontent.com/3009734/226293561-f95a3d3f-3e4b-46bb-9e0e-e801f75ab1ac.png"></th>
  </tr>
  <tr>
    <td><div class="highlight highlight-source-swift"><pre>
scrapService?.getCommerces(completion: { err, items in
    if err != nil {

    } else {
      print(items ?? [])        
    }
  })    
  </tr>
  <tr>
    <td>설명</td>
  </tr>
  <tr>
    <td width="30%"><div class="highlight highlight-source-swift"><pre>    
      커머스 목록을 가져옵니다.                                   
    </pre></div></td>
  </tr>
</table>

      
    
<table>
  <tr>
    <th width="30%">사용 예시</th>
    <th width="30%">스크린샷</th>
  </tr>
  <tr>
    <td></td>
    <th rowspan="9"><img src="https://user-images.githubusercontent.com/3009734/226293755-81ced1fa-83f5-4f2b-9499-397561ee38d8.png"></th>
  </tr>
  <tr>
    <td><div class="highlight highlight-source-swift"><pre>
scrapService?.startScrapingOrder(id: "testId", // 사용자 아이디
                     pwd: "testPwd", // 사용자패스워드
                     commerceId: "commerceId", // 커머스 아이디
                     completion: { err, result in
    if err != nil {

    } else {

    }
  })    
  </tr>
  <tr>
    <td>설명</td>
  </tr>
  <tr>
    <td width="30%"><div class="highlight highlight-source-swift"><pre>
      startLogin() -> startScrapingOrder() 순서로 호출하여      
      커머스 주문내역 스크랩을 합니다.
    </pre></div></td>
  </tr>
</table>

      
    
<table>
  <tr>
    <th width="30%">사용 예시</th>
    <th width="30%">스크린샷</th>
  </tr>
  <tr>
    <td></td>
    <th rowspan="9"><img src="https://user-images.githubusercontent.com/3009734/226295209-f685b9df-b72b-4c6f-b024-4f66b7ca052d.png"></th>
  </tr>
  <tr>
    <td><div class="highlight highlight-source-swift"><pre>
scrapService?.getScrapingUsers(completion: { err, rst in
    if err != nil {

    } else {

    }
  })    
  </tr>
  <tr>
    <td>설명</td>
  </tr>
  <tr>
    <td width="30%"><div class="highlight highlight-source-swift"><pre>
      로그인 정보가 저장된 커머스 목록을 가져옵니다.                   
    </pre></div></td>
  </tr>
</table>

      
    
<table>
  <tr>
    <th width="30%">사용 예시</th>
    <th width="30%">스크린샷</th>
  </tr>
  <tr>
    <td></td>
    <th rowspan="9"><img src="https://user-images.githubusercontent.com/3009734/226296569-d2c9cd3b-15c0-4a19-949f-888101c03f41.png"></th>
  </tr>
  <tr>
    <td><div class="highlight highlight-source-swift"><pre>
scrapService?.getOnlineOrders(
          commerceIds: ["commerceId"], // 커머스 아이디 목록
          completion: { err, rst in
    if err != nil {

    } else {

    }
  })
  </tr>
  <tr>
    <td>설명</td>
  </tr>
  <tr>
    <td width="30%"><div class="highlight highlight-source-swift"><pre>
      스크랩된 주문 목록을 가져옵니다.                              
    </pre></div></td>
  </tr>
</table>
