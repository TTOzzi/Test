# Test
온라인 테스트

어떻게 작성해야할지 몰라 코드의 순서대로 설명을 작성하였습니다.

# 1단계

Score 클래스를 만들어 내부에 각각의 점수들을 저장할 변수와 아웃일때 점수를 초기화하는 함수, 현재 점수를 출력하는 함수를 선언해주었습니다.

클래스 내 변수에 property observer 로 값이 변동될 때 마다 알맞은 동작을 하도록 해주었습니다.
* strike 가 변동될때마다 "스트라이크" 멘트를 출력합니다.
    * strike 가 3이 되면 out 을 1 추가합니다.
    * ball 도 strike 와 동일한 로직을 가집니다.
    * out 은 늘어난 out 이 3보다 작을땐 다음타자 멘트, 3아웃일땐 아웃멘트만 출력합니다.
    * out 이 변동되면 scoreInit 함수를 호출하여 strike 와 ball 을 초기화해줍니다.
    * hit 도 out 과 동일한 로직을 가집니다. 볼넷으로 인해 hit 가 변동될때는 안타멘트가 아닌 볼넷멘트를 출력합니다.

strike 와 ball 을 초기화해주기위한 scoreInit 함수를 선언해주었습니다. 
* scoreInit 함수가 동작할때도 strike 와 ball 의 property observer 가 동작합니다. strike 와 ball 이 0으로 변동되었을땐 멘트를 출력하지 않게 예외처리를 해주었습니다.

game 함수를 선언하여 게임 실행에 필요한 코드들을 작성하였습니다.
* 점수를 담을 score 클래스를 선언해주었습니다.
    * while 문을 사용하여 out이 3이 될때까지 같은 동작을 반복합니다.
    * throwBall 함수를 호출하여 1부터 4까지의 무작위 정수값과 score 클래스를 매개변수로 줍니다.
    * 점수를 출력하기위해 score 내부의 printScore 함수를 호출해주었습니다.
    * out 의 값이 3이 되어 반복문이 종료되면 최종안타수를 출력합니다.

1~4 까지의 무작위 정수값과 score 클래스를 매개변수로 받아 score 내부의 변수값을 변경해주는 throwBall 함수를 선언해주었습니다.
* 각각의 숫자마다 스트라이크, 볼, 안타, 아웃 을 임의로 지정하여주었습니다.



# 2단계

### **2단계에서 입력을 받기위해 readLine() 을 사용하였는데 한글이 깨져서 입력되는 문제가 발생하였습니다. 코드가 실행은 되지만 한글이 정상적으로 출력되지 않습니다. 영어로 입력해주시면 감사하겠습니다.**

### **2단계에서 데이터 입력을 받을 때의 에러처리를 하지 못하였습니다. 타자 정보를 입력할때 꼭 쉼표+띄어쓰기 한개로 타율과 선수이름을 구분해주세요. ex) Jisoo Yoon, 0.499**

string 을 array 로 잘라주는 components 를 사용해주기위해 Foundation 을 import 해주었습니다.

선수의 번호, 이름, 타율을 저장하는 Hitter 구조체를 선언해주었습니다.

팀 이름, 선수들을 저장할 배열, 팀의 점수를 저장할 Team 구조체를 선언해주었습니다.

1단계에서의 Score 클래스를 그대로 가져왔습니다.
* 선수의 순서를 저장하기위한 order 변수와 점수를 저장하기위한 s 변수를 추가해주었습니다.
    * 다음 이닝으로 넘어갈때 out 과 hit 를 초기화해주기위한 nextInning 함수를 선언해주었습니다. 스트라이크, 볼과 같이 초기화할 때 멘트출력을 하지 않기위한 예외처리를 해주었습니다.

메인 로직을 담당하는 main 함수를 선언해주었습니다.
* 두 팀을 저장할 teams 배열을 선언해주었습니다.
* 무한루프를 만들어주었습니다. 시합 시작을 선택하여 시합이 진행 된 후 종료됩니다.
    * readLine 을 사용하여 사용자로부터 1 ~ 3 까지의 숫자를 입력받습니다.
    * switch 로 각 숫자마다 동작을 나눠주었습니다.
    * 1 을 입력했을 때 데이터가 입력되지않은 상태라면 inputData 함수를 호출하고 이미 입력되있다면 멘트를 출력합니다.
    * 2 를 입력했을 때 데이터가 입력되지않은 상태라면 멘트를 출력하고 입력되어있다면 printData 함수를 호출합니다.
    * 3 을 입력했을 때 데이터가 입력되지 않은 상태라면 멘트를 출력하고 입력되어있다면 game 함수를 호출한 후 return 으로 함수를 종료합니다.
    * 1, 2, 3 을 제외한 다른 값이 입력되면 오류멘트를 출력해줍니다.

사용자로부터 정보를 입력받는 inputData 함수를 선언해주었습니다. 두 팀의 정보를 입력받아 배열에 담은 후 리턴해줍니다.
* 반복문으로 두 팀을 입력받도록 하였습니다.
    * 타자 정보를 입력받을 때 components 를 사용하여 ", " 를 기준으로 입력받은 string 을 잘라 배열에 담고, Hitter 구조체의 기본 initializer를 사용해 잘린 정보를 Hitter 에 맞게 바꿔주었고 append를 사용해 players 배열에 담아주었습니다.

Team 구조체가 담긴 배열을 매개변수로 받아 구조체안의 정보를 출력해주는 printData 함수를 선언해주었습니다.
* forEach 를 활용해 각 팀의 모든 정보를 출력해주도록 하였습니다.

두 팀을 매개변수로 받아 게임을 진행하는 game 함수를 선언해주었습니다.
* for문으로 6회까지 진행하도록 해주었습니다.
    * 각 이닝을 inning 함수로 나누어주었습니다.
    * 이닝이 끝날때 마다 scoreBoard 함수로 점수를 출력해줍니다.
    * 6회까지 마무리되면 반복문이 종료되고 경기의 결과를 출력합니다.
    
점수를 출력해주는 scoreBoard 함수입니다.

팀을 매개변수로 받아 한 이닝을 진행하는 inning 함수를 선언해주었습니다.
* out 이 3이 될때까지 throwBall 함수를 호출해줍니다. 여기서 throwBall 함수에게 선수의 타율과 팀을 매개변수로 줍니다.
    * 공이 던져질때마다 printScore 함수로 점수를 출력해줍니다.
    * 한 이닝이 끝나면 nextInning 함수를 호출하여 out과 hit를 초기화해줍니다.

선수의 타율에 맞는 결과를 리턴해주는 battingAverage 함수를 선언해주었습니다.
* 선수를 매개변수로 받아 선수의 타율에 맞는 결과를 리턴해줍니다.

1단계에서 만들었던 throwBall 함수입니다.
* 2단계에선 두 팀이 진행하기에 팀을 매개변수로 추가하였습니다. 선수가 바뀔때마다 선수번호와 선수이름을 출력해줍니다.

