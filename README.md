# AhkVimLike

AhkVimLike 는 Windows UI 에서 VIM 스타일의 키 맵핑을 사용할 수 있도록 해줍니다.</br>
이를 통해 VI/VIM 이 아닌 편집기, 또는 탐색기에서도 VIM 을 쓰는 것과 비슷하게 키보드를 사용할 수 있습니다.

물론 편집기에 VIM 플러그인을 얹어 쓰거나,
VIMIUM 과 같은 웹 브라우저 extension 을 쓰는 것이 바람직하겠지만,
AhkVimLike 는 그마저도 곤란하고 난감한 상황에서 쓰기 위하여 만든 키 맵핑 프로그램입니다.

## 모드 전환

### INSERT to NORMAL
![INSERT](https://raw.githubusercontent.com/johngrib/johngrib.github.io/master/AhkVimLike/img/stat_insert.png) 
to 
![NORMAL](https://raw.githubusercontent.com/johngrib/johngrib.github.io/master/AhkVimLike/img/stat_normal.png)

화면 하단에 -- INSERT -- 상태 막대가 있다면, INSERT 모드입니다.
INSERT 모드일 때에는 Windows 의 기본 상태 키 맵핑을 사용할 수 있습니다.

INSERT 모드에서 Capslock 을 누르거나, Esc 를 두 번 연속으로 누르면 NORMAL 모드가 됩니다.

### NORMAL to INSERT
![NORMAL](https://raw.githubusercontent.com/johngrib/johngrib.github.io/master/AhkVimLike/img/stat_normal.png)
to
![INSERT](https://raw.githubusercontent.com/johngrib/johngrib.github.io/master/AhkVimLike/img/stat_insert.png)

화면 하단에 -- NORMAL -- 상태 막대가 있다면, NORMAL 모드입니다.
NORMAL 모드일 때에는 hjkl, "y, "p, m, ' 등 VIM 과 유사한 기능들을 Windows UI 에서 사용할 수 있고,
: 을 입력한 이후 명령어를 작성하여 command function 을 호출할 수도 있습니다.

NORMAL 모드에서 Capslock 을 누르거나 i, shift + i, o, shift + o, shift + a 을 누르면 INSERT 모드가 됩니다.

### INSERT to CAPSLOCK
![INSERT](https://raw.githubusercontent.com/johngrib/johngrib.github.io/master/AhkVimLike/img/stat_insert.png)
to
![CAPSLOCK](https://raw.githubusercontent.com/johngrib/johngrib.github.io/master/AhkVimLike/img/stat_capslock.png)

Capslock 키를 모드 전환 키 중 하나로 사용하다보니 Capslock 본래의 기능을 사용할 수 없는 문제가 있습니다.
CAPSLOCK 모드는 INSERT 모드와 똑같지만, 알파벳을 입력하면 대문자가 입력된다는 점만 다릅니다.

INSERT 모드에서 shift + Capslock 을 누르면 CAPSLOCK 모드가 됩니다.

## 기능 설명

### NORMAL

NORMAL 모드에서는 예약된 키 스트로크를 입력하는 것으로 특정 기능을 호출할 수 있습니다.</br>
가령 여러 개의 탭이 있는 응용 프로그램에서 AhkVimLike 를 실행하고 gt 를 입력한다면, 
^TAB 입력을 보내게 되어 다음 탭으로 이동하는 효과를 기대할 수 있습니다.

예약된 키 스트로크는 모두 KeyMaps.ahk 에 key_keystrokes(input_number) { } 의 형태로 정의되어 있습니다.
즉, 새로운 키 스트로크로 gb 를 추가하고 싶다면 KeyMaps.ahk 파일에 다음과 같은 함수를 추가해주면 됩니다.

````autohotkey
key_gb(input_number) {
  ; do something
}
````

위와 같이 새로운 함수를 추가했다면, NORMAL 모드에서 gb 를 입력하여 호출할 수 있습니다.</br>
물론 두 개의 키 스트로크 뿐 아니라 하나나 셋 이상의 키 스트로크도 추가할 수 있습니다.

#### keyboard control
* __hjkl__ : LEFT, DOWN, UP, RIGHT 입니다. 숫자 키와 조합하여 사용하는 것도 가능합니다. 
즉, 30J 를 입력하면 DOWN 키를 30 번 입력한 것과 같은 효과를 냅니다.

* __i__ : INSERT 모드로 전환합니다.

* __I__ : INSERT 모드로 전환한 다음, HOME 키를 입력합니다.

* __o__ : INSERT 모드로 전환하고 ENTER 를 입력합니다.

* __O__ : INSERT 모드로 전환하고 윗줄에 ENTER 를 입력하여 빈 라인을 추가합니다.

* __0__ : HOME. 숫자 조합 가능.

* __$__ : END. 숫자 조합 가능.

* __^b__ : PAGE UP. 숫자 조합 가능.

* __^f__ : PAGE DOWN. 숫자 조합 가능.

* __x__ : DELETE. 숫자 조합 가능. </br>
단, Windows UI 상에서 그냥 x 를 입력하여 DELETE 입력이 되는 것은 위험하므로 숫자키와 조합해야만 사용 가능합니다.
(AhkVimLike 를 모르는 다른 사람이 자리에 앉아 무심코 키보드를 사용하다가 x 를 눌렀고, 탐색기에 DELETE 입력을 보내 파일이 지워진 적이 있음)

* __X__ : BACKSPACE. 숫자 조합 가능.

* __gt__ : ^TAB 입력을 보냅니다. </br>
즉, 여러 탭이 있는 응용 프로그램에서 gt 를 입력하면 다음 탭으로 이동할 수 있습니다. 숫자 조합 가능.

* __gr__ : shift + ^TAB 입력을 보냅니다. </br>
즉, 여러 탭이 있는 응용 프로그램에서 gr 을 입력하면 이전 탭으로 이동할 수 있습니다. 숫자 조합 가능.

#### mouse control
* __q__ : 마우스 왼쪽 버튼 클릭. 숫자 조합 가능. 100q : 100 번 클릭.

* __^q__ : 마우스 왼쪽 버튼 클릭 후 홀드

* __Q__ : 마우스 왼쪽 버튼 홀드 놓아주기 

* __e__ : 마우스 오른쪽 버튼 클릭. 숫자 조합 가능.

* __^e__ : 마우스 오른쪽 버튼 클릭 후 홀드

* __E__ : 마우스 오른쪽 버튼 홀드 놓아주기

* __r__ : 마우스 휠 위로 굴리기. 숫자 조합 가능.

* __f__ : 마우스 휠 아래로 굴리기. 숫자 조합 가능.

* __wasd__ : 마우스 포인터를 UP, LEFT, DOWN, RIGHT 방향으로 70 pixel 씩 움직입니다. </br>
FPS 게임에서 사용하는 방향키 맵핑과 같습니다. </br>
숫자 조합 가능. 즉, 3w : 210 pixel 만큼 마우스 포인터가 위로 움직입니다.

* __m + wasd__ : wasd 키를 n 키와 조합하면 마우스 포인터를 10 pixel 씩 움직입니다. 숫자 조합 가능.

* __, + wasd__ : wasd 키를 , 키와 조합하면 마우스 포인터를 1 pixel 씩 움직입니다. 숫자 조합 가능.

* __gq__ : 마우스 포인터를 현재 활성화된 윈도우의 왼쪽 위 모서리로 이동시킵니다.

* __gw__ : 마우스 포인터를 현재 활성화된 윈도우의 위쪽 가운데 모서리로 이동시킵니다.

* __ge__ : 마우스 포인터를 현재 활성화된 윈도우의 오른쪽 위 모서리로 이동시킵니다.

* __ga__ : 마우스 포인터를 현재 활성화된 윈도우의 왼쪽 가운데 모서리로 이동시킵니다.

* __gs__ : 마우스 포인터를 현재 활성화된 윈도우의 정 중앙으로 이동시킵니다.

* __gd__ : 마우스 포인터를 현재 활성화된 윈도우의 오른쪽 가운데 모서리로 이동시킵니다.

* __gz__ : 마우스 포인터를 현재 활성화된 윈도우의 왼쪽 아래 모서리로 이동시킵니다.

* __gx__ : 마우스 포인터를 현재 활성화된 윈도우의 아래쪽 가운데 모서리로 이동시킵니다.

* __gc__ : 마우스 포인터를 현재 활성화된 윈도우의 오른쪽 아래 모서리로 이동시킵니다.

#### window control
* __m숫자__ : 윈도우를 북마크합니다. </br>
0 ~ 9 의 숫자를 사용할 수 있으며, 북마크한 윈도우는 :mark ENTER 로 확인할 수 있습니다.

* __'숫자__ : 북마크한 윈도우로 이동합니다.

* __zq__ : 윈도우를 모니터 1/4 사이즈로 조절 후, 왼쪽 위로 이동시킵니다. </br>
숫자 조합 가능하며, 숫자와 조합할 경우 해당 인덱스 모니터의 왼쪽 위로 이동시킵니다.</br>
zq : primary 모니터의 왼쪽 위로 이동. (일반적으로 1zq 와 같음)</br>
1zq : 1번 모니터의 왼쪽 위로 이동.</br>
2zq : 2번 모니터의 왼쪽 위로 이동.</br>
10zq : 10번 모니터의 왼쪽 위로 이동.</br>

* __zw__ : 윈도우를 모니터 1/2 사이즈로 조절 후, 위쪽으로 이동시킵니다. 숫자 조합 가능.

* __ze__ : 윈도우를 모니터 1/4 사이즈로 조절 후, 오른쪽 위로 이동시킵니다. 숫자 조합 가능.

* __za__ : 윈도우를 모니터 1/2 사이즈로 조절 후, 왼쪽으로 이동시킵니다. 숫자 조합 가능.

* __zs__ : 윈도우를 maximize 합니다. 숫자 조합 가능.

* __zd__ : 윈도우를 모니터 1/2 사이즈로 조절 후, 오른쪽으로 이동시킵니다. 숫자 조합 가능.

* __zz__ : 윈도우를 모니터 1/4 사이즈로 조절 후, 왼쪽 아래로 이동시킵니다. 숫자 조합 가능.

* __zx__ : 윈도우를 모니터 1/2 사이즈로 조절 후, 아래쪽으로 이동시킵니다. 숫자 조합 가능.

* __zc__ : 윈도우를 모니터 1/4 사이즈로 조절 후, 오른쪽 아래로 이동시킵니다. 숫자 조합 가능.

#### clipboard control

* __^c__ : control + c. 본래의 기능과 똑같이 작동합니다.</br>
단, 사용할 때마다 AhkVimLike 의 0 번 레지스터에 클립보드 내용이 저장됩니다.

* __"y__ : 레지스터로 복사한다.</br>
:reg 명령을 사용하면 레지스터 목록을 볼 수 있습니다.</br>
레지스터는 0~29, a~z (hjkl, io 제외) 전부 52 개가 존재하며, 숫자는 히스토리이므로 복사할 때마다 하나씩 밀려납니다.
알파벳 레지스터는 사용자 임의로 입력하고 꺼내 쓰면 됩니다.</br>
"3y : 3 번 레지스터로 복사한다.</br>
"ay : a 레지스터로 복사한다.

* __"p__ : 레지스터에서 가져와 붙여넣는다.</br>
"3p : 3번 레지스터 값을 붙여넣는다.</br>
"ap : a 레지스터 값을 붙여넣는다.

#### COMMAND

NORMAL 모드에서 : 를 입력하면 명령어를 입력하는 작은 창이 하나 나타납니다.</br>
이 창에 명령어를 입력하여 예약된 기능을 사용할 수 있습니다.</br>
예약된 기능들은 모두 Commands.ahk 파일에 command_functionName(args) { } 형태로 정의돼 있고,
functionName 을 입력하고 args 를 입력하면 사용할 수 있도록 되어 있습니다.

즉, 새로운 명령어를 추가하고 싶다면 Commands.ahk 파일에 다음과 같은 함수를 추가해주면 됩니다.

````autohotkey
command_newfunction(args) {
  ; do something
}
````

위와 같이 새로운 함수를 추가했다면, NORMAL 모드에서 :newfunction 으로 호출할 수 있습니다.

````text
input 명령어를 입력하는 창에서 TAB 키를 입력하면 자동 완성 기능을 사용할 수 있습니다.
자동 완성 기능은 ini 파일의 [INPUT_COMMAND] 섹션을 참고하므로,
새로운 함수를 추가하면 [INPUT_COMMAND] 섹션에도 해당 명령어를 추가해 주어야
자동 완성 기능을 사용할 수 있습니다.
````

* __:color__ : 마우스 포인터가 있는 곳의 RGB 컬러 값을 조사하여 출력한다.

* __:edit__ : ahk 스크립트를 편집한다.

* __:kill__ : 현재 활성화된 윈도우의 프로세스를 강제로 종료한다.

* __:log__ : 키 로그를 본다.

* __:mark__ : 북마크된 윈도우 목록을 본다.

* __:max__ : 현재 활성화된 윈도우를 최대화한다.

* __:min__ : 현재 활성화된 윈도우를 최소화한다.

* __:reg__ : 클립보드 레지스터 목록을 본다.

* __:time__ : 날짜/시간 문자열을 리턴한다.</br>
:time (현재 날짜/시간 문자열)</br>
:time date (오늘 날짜 문자열)</br>
:time `[format]` (지금 시간을 입력한 포맷 문자열로 리턴한다.)</br>
:time help (날짜/시간 포맷 도움말 보기)

* __:title__ : 현재 활성화된 윈도우의 타이틀 문자열을 리턴한다.

* __:trans__ : 현재 활성화된 윈도우의 투명도를 설정한다 (0~255)</br>
:trans 0 (완전 투명. 안 보임)</br>
:trans 255 (불투명. Windows 기본값)

* __:notrans__ : 현재 활성화된 윈도우의 투명도를 255 로 복구한다.

* __:w__ : control + s 를 입력한다.

* __:stattrans__ : 모드 표시 바의 투명도를 변경한다 (0 ~ 255)

* __:open__ : op 명령과 같다.

* __:op__ : ahkvimlike.ini 파일의 OP_ADDRESS 에 정의된 주소 명령을 실행한다.</br>
:op doc (내 문서 폴더를 연다)</br>
:op inetcpl (인터넷 옵션을 연다)</br>
:op c (c 드라이브 탐색기를 연다)</br>
:op google (기본 웹 브라우저로 google.com 에 접속한다)
(그 외 다수. 자세한 목록은 ini 파일을 참조할 것.)

##### OP 명령에 대하여

op, open 명령은 해당 웹 주소나 폴더를 open 하는 명령입니다.</br>
autohotkey 의 run 명령어를 사용하므로, 웹 브라우저나 폴더를 열 수도 있으며 bat 파일이나 exe 파일을 실행할 수도 있습니다.

op 명령어로 open 할 수 있는 경로를 추가하려면
ahkvimlike.ini 파일의 `[OP_ADDRESS]` 섹션에 alias 와 address 값을 정의해 주면 됩니다.

````ini
gh = http://github.com
````

위와 같이 ini 파일에 github 주소를 추가하였다면, 
:op gh 를 입력하였을 때 웹 브라우저로 http://github.com 페이지가 열리게 됩니다.

op 명령어는 ini 파일의 [INPUT_COMMAND] 섹션에 추가해주지 않아도 TAB 자동완성 기능을 사용할 수 있습니다.
