# AhkVimLike

AhkVimLike 는 Windows 에서 VIM 스타일의 키 맵핑을 사용할 수 있도록 해줍니다.

## 모드 전환

### INSERT to NORMAL
화면 하단에 -- INSERT -- 상태 막대가 있다면, INSERT 모드입니다.
INSERT 모드일 때에는 Windows 의 기본 상태 키 맵핑을 사용할 수 있습니다.

INSERT 모드에서 Capslock 을 누르거나, Esc 를 두 번 연속으로 누르면 NORMAL 모드가 됩니다.

### NORMAL to INSERT
화면 하단에 -- NORMAL -- 상태 막대가 있다면, NORMAL 모드입니다.
NORMAL 모드일 때에는 HJKL, "Y, "P, M, ' 등 VIM 과 유사한 기능들을 Windows UI 에서 사용할 수 있고,
: 을 입력한 이후 명령어를 작성하여 command function 을 호출할 수도 있습니다.

NORMAL 모드에서 Capslock 을 누르거나 i, shift + i, o, shift + o, shift + a 을 누르면 INSERT 모드가 됩니다.

### INSERT to CAPSLOCK
Capslock 키를 모드 전환 키 중 하나로 사용하다보니 Capslock 본래의 기능을 사용할 수 없는 문제가 있습니다.
CAPSLOCK 모드는 INSERT 모드와 똑같지만, 알파벳을 입력하면 대문자가 입력된다는 점만 다릅니다.

INSERT 모드에서 shift + Capslock 을 누르면 CAPSLOCK 모드가 됩니다.
