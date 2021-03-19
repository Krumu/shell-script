첫줄의 #!는 샤뱅
스크립트를 처리할 해석기 정의

주석

프로그램 작업 목적, 스크립트 개발자 정보

중간 중간 기능에 대한 설명


쉘 스크립트 잘 만들 수 있는 방법
시스템 관리 관련 명령을 잘 알아야 함
작업을 위해 사용될 명령들과 명령 순서를 알아야 함
쉘 스트립트 작성 전 사용할 명령들, 실행 순서, 실행 조건을 노트에 미리 적어봄.


리눅스 신규 디스크 인식 쉘 스크립트
 
| 파이프 명령어는 왼쪽 명령의 실행 겨로가를 오른쪽 명령의 입력으로 전달

신규 디스크 인식
 정보 확인: lspci, grep, awk
 파일 검색: find, grep
 디스크 인식: echo, tee
 디스크 확인: lsblk

디스크 컨트롤러 정보 확인
/sys/devices 디렉터리에 디스크 컨트롤러에 관련된 scan 파일 존재 


```linux
lspci | grep 'LSI Loigic'
lspci | grep 'LSI Loigic' |awk '{print $1}' 

```
파일 검색
-- find/sys/devies -name scan | grep 00:10.0

디스크 인식



변수 선언 안함
모든 변수는 문자열로 취급
변수를 대입할 때 = 좌우에 공백이 없어야함
공백 값을 넣고싶으면 " "
 
 변수의 입력과 출력
 $문자가 들어간 글자를 출력하려면 ''로 묶어주거나 앞에 ₩
 ""로 변수를 묶어줘도 된다. 

 #!/bin/sh
 myvar="Hi Woo" # myvar에 Hi Woo가 담김
 echo $myvar # Hi Woo가 출력
 echo "$myvar" # Hi Woo가 출력
 echo '$myvar' #$myvar가 출력
 echo ₩$myvar # $myvar가 출력
 echo 값 입력:
 read myvar # myvar에 넣을 값을 읽어라
 echo '$myvar' = $myvar
 exit 0


숫자 계산 
 변수에 대입된 값은 모두 문자열로 취급
 변수에 들어 있는 값을 숫자로 해서 +,-.*,/ 등의 연산을 하려면 expr을 사용
 수식에 괄호 또는 곱하기(*)는 그 앞에 꼭 역슬래쉬(₩) 붙임

#!/bin/sh
num1 = 100
num2 = $num1 + 200 
echo $num2 # 100+200 출력
num3 = 'expr $num1 + 200'
echo $num3
num4 = 'expr ₩($num1+ 200 ₩)/ 10 ₩* 2'


파라미터 변수
 파라미터 변수는 $0, $1, $2 의 형태를 가짐
 전체 파라미터는 $*로 표현

 #!/bin/sh
 echo "실행파일 이름은 <$0>이다."
 echo "첫번째 파라미터는 <$1>이고, 두번째 파라미터는 <$2>다"
 echo "전체 파라미터는 <$*>다"
 exit 0

 기본 If 문 [ 괄호 사이 띄어야 됨 ]

 #!/bin/sh
 if[ "woo" = "woo" ]
 then
    echo "참입니다."
 fi
 exit 0


if~else 문

 #!/bin/sh
 if[ "woo" != "woo" ]
 then
    echo "참입니다"
 else
    echo "거짓입니다"
 fi
 exit 0

조건문에 들어가는 비교 연산자

문자열 비교

=, !=, -n "문자열"(문자열이 NULL이 아니면 참), -z "문자열" (문자열이 NULL이면 참)

산술 비교
수식1 -eq 수식2 : 두 수식이 같으면 참
수식1 -ne 수식2 : 두 수식이 같지 않으면 참
수식1 -gt 수식2 : 수식1이 크다면 참
수식1 -ge 수식2 : 수식1이 크거나 같은면 참
수식1 -lt 수식2 : 수식 1이 작으면 참
수식1 -le 수식2 : 수식 1이 작거나 같으면 참
!수식: 수식이 거짓이라면 참

#!/bin/sh
if [ 100 -eq 200 ]
then
    echo "100과 200은 같다."
else
    echo "100과 200은 다른다."
fi
exit 0


파일과 관련된 조건

-d 파일이름 : 파일이 디렉터리면 참
-e 파일이름 : 파일이 존재하면 참
-f 파일이름 : 파일이 일반 파일이면 참
-g 파일이름 : 파일에 set-group-id가 설정되면 참
-r 파일이름 : 파일이 읽기 가능하면 참
-s 파일이름 : 파일 크기가 0이 아니면 참
-u 파일이름 : 파일에 set-user-id가 설정되면 참
-w 파일이름 : 파일이 쓰기 가능 상태이면 참
-x 파일이름 :파일이 실행 가능 상태이면 참

#!/bin/sht

fname = /lib/systemd/system/httpd.service
if [ -f $fname]
then
    head -5 $fname
else
    echo "웹 서버가 설치되지 않았습니다."
fi
exit 0


case~case 문

#!/bin/sh

case "$1" in
    start)
        echo "시작~~";;
    stop)
        echo "중지~~";;
    restart)
        echo "다시 시작~~";;
    *)
        echo "뭔지 모름~~";;
esac
exit 0


#!/bin/sh
echo "리눅스가 재미있나요? (yes/no)"
read answer
case $answer in
    yes|y|Y|Yese|YES)
        echo "다행입니다."
        echo "더욱 열심히 하세요 ^^";;
    [nN]*)
        echo "안타깝네요. ㅠㅠ";;
    *)
        echo "yes 아니면 no만 입력했어야죠"
        exit 1;;
esac
exit 0
 
AND, OR 관계 연산자

and는 '-a'또는 '&&를 사용
orsms '-o' 또는 '||'사용


#!/bin/sh
echo "보고 싶은 파일명을 입력하세요."
read filename
if [ -f $fname ] && [ -s $fname ] 
then
    head -5 $fname
else
    echo "파일이 없거나, 크기가 0입니다."
fi
exit 0

반복문 for문

3행은 for((i=1;i=<10;i++))또는 for i in 'seq 1 10'로 변경 할 수 있음



#!/bin/sh
hap = 0
for i in 1 2 3 4 5 6 7 8 9 10
do 
    hap='expr $hap + $i'
done
echo "1부터 10까지의 합: " $hap
exit 0


현재 디렉터리에 있는 셸 스크립트 파일(*.sh)의 파일명과 앞 3줄을 출력하는 프로그램

#!/bin/sh

for fname in $(ls *.sh)
do
    echo "-----$fname------"
    head -3 $fname
done
exit 0

반복문 while문 
[ 1 ] 또는 [ : ]가 오면 항상 참이 됨.

#!/bin/sh
while [ 1 ]  
do
    echo "CentOS 7"
done
exit 0


while문을 이용해서 1에서 10까지의 합계를 출력

#!/bin/sh
hap=0
i=1
while[ i -le 10 ]
do
    hap = 'expr $hap + $i'
    i = 'expr $i +1'
done
echo "1부터 10까지의 합: " $hap
exit 0 

while문을 이용해서 비밀번호를 입력받고, 비밀번호가 맞을 때까지 계속 입력받는 스크립트

#!/bin/sh
password="qlqjsdldi"
echo "비밀번호를 입력하세요: "
read input
while [ $input != "qlalfqjsghdi"]
do
    echo "틀렸음. 다시 입력하세요"
    read input
done
echo "통과~~"
exit 0

사용자 정의 함수

#!/bin/sh
myFunction(){
    echo "함수 안으로 들어 왔음"
    return
}

echo "프로그램을 시작합니다."
myFunction
echo "프로그램을 종료합니다."
exit 0


함수의 파라미터 사용

#!/bin/sh
hap (){
    echo 'expr $1 + $2'
}
echo "10 더하기 20을 실행합니다."
hap 10 20
exit 0 

eval 
문자열을 명령문으로 인식하고 실행


#!/bin/sh
str = "ls -l anaconda-ks.cfg"
echo $str
eval $str
exit 0 

export 
외부 변수로 선언해 준다. 즉, 선언한 변수를 다른 프로그램에서도 사용할 수 있도록 해줌

exp1.sh
#!/bin/sh
echo $var1
echo $var2
exit 0

exp2.sh
#!/bin/sh
var1="지역 변수"
export var2="외부 변수"
sh exp1.sh # 외부 변수만 출력
exit 0

printf
c언의 printf()함수와 비슷하게 형식을 지정해서 출력

#!/bin/sh
var1=100.5
var2="재미있는 리눅스~~"
printf "%5.2f \n\n \t %s \n" $var1 "$var2"
exit

 
set과 $(명령어)
리눅스 명령어를 결과로 사용하기 위해서는 $(명령어)형식을 사용
결과를 파라미터로 사용하고자 할 때는 set과 함께 사용

#!/bin/sh
echo "오늘 날짜는 $(date) 입니다."
set $(date)
echo "오늘은 $4 요일 입니다."
exit 0


shift

파라미터 변수르 왼쪽으로 한 단계씩 아래로 쉬프트시킴
10개가 넘는 파라미터 변수에 접근할 때 사용
단, $0 파라미터 변수는 변경되지 않음

원하지 않는 결과의 소스
#!/bin/sh
myfunc(){
    echo $1 $2 $3 $4 $5 $6 $7 $8 $9 $10 $11
}
myfunc AAA BBB CCC DDD EEE FFF GGG HHH III JJJ KKK # ... AAA0 AAA1 출력
exit 0

shift 사용을 통한 앞 문제점 해결

#!/bin/sh
myfunc(){
    str=""
    while[ "$1" != "" ]; do
        str= "$str $1"
        shift
    done
    echo $str
}
myfunc AAA BBB CCC DDD EEE FFF GGG HHH III JJJ KKK
exit 0

실습은 https://5log.tistory.com/65 참고