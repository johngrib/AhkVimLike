# AhkVimLike

AhkVimLike 는 Windows UI 에서 VIM 스타일의 키 맵핑을 사용할 수 있도록 해줍니다.
이를 통해 VI/VIM 이 아닌 편집기, 또는 탐색기에서도 VIM 을 쓰는 것과 비슷하게 키보드를 사용할 수 있습니다.

물론 편집기에 VIM 플러그인을 얹어 쓰거나, VIMIUM 과 같은 웹 브라우저 extension 을 쓰는 것이 바람직하겠지만,
AhkVimLike 는 그마저도 곤란하고 난감한 상황에서 쓰기 위하여 만든 키 맵핑 프로그램입니다.

## 모드 전환

### INSERT to NORMAL
화면 하단에 -- INSERT -- 상태 막대가 있다면, INSERT 모드입니다.
INSERT 모드일 때에는 Windows 의 기본 상태 키 맵핑을 사용할 수 있습니다.

INSERT 모드에서 Capslock 을 누르거나, Esc 를 두 번 연속으로 누르면 NORMAL 모드가 됩니다.

### NORMAL to INSERT
화면 하단에 -- NORMAL -- 상태 막대가 있다면, NORMAL 모드입니다.
NORMAL 모드일 때에는 hjkl, "y, "p, m, ' 등 VIM 과 유사한 기능들을 Windows UI 에서 사용할 수 있고,
: 을 입력한 이후 명령어를 작성하여 command function 을 호출할 수도 있습니다.

NORMAL 모드에서 Capslock 을 누르거나 i, shift + i, o, shift + o, shift + a 을 누르면 INSERT 모드가 됩니다.

### INSERT to CAPSLOCK
Capslock 키를 모드 전환 키 중 하나로 사용하다보니 Capslock 본래의 기능을 사용할 수 없는 문제가 있습니다.
CAPSLOCK 모드는 INSERT 모드와 똑같지만, 알파벳을 입력하면 대문자가 입력된다는 점만 다릅니다.

INSERT 모드에서 shift + Capslock 을 누르면 CAPSLOCK 모드가 됩니다.

## 기능 설명

### NORMAL

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

* __x__ : DELETE. 숫자 조합 가능. 
단, Windows UI 상에서 그냥 x 를 입력하여 DELETE 입력이 되는 것은 위험하므로 숫자키와 조합해야만 사용 가능합니다.
(AhkVimLike 를 모르는 다른 사람이 자리에 앉아 무심코 키보드를 사용하다가 x 를 눌렀고, 탐색기에 DELETE 입력을 보내 파일이 지워진 적이 있음)

* __X__ : BACKSPACE. 숫자 조합 가능.

* __q__ : 마우스 왼쪽 버튼 클릭. 숫자 조합 가능. 100q : 100 번 클릭.

* __^q__ : 마우스 왼쪽 버튼 클릭 후 홀드

* __Q__ : 마우스 왼쪽 버튼 클릭 홀드 놓아주기 



