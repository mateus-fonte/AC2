#include <detpic32.h>
#include <math.h>

unsigned int cnt1, cnt5, cnt10 = 0;

void delay(unsigned int ms);

int main(void){

   

    while(1){

        putChar('\r');
        printInt(cnt1, 10 | 5 << 16);
        putChar('\t');
        printInt(cnt5, 10 | 5 << 16);
        putChar('\t');
        printInt(cnt10, 10 | 5 << 16);
        delay(100);
        

    }



    return 0;
}

void delay(unsigned int ms)
{
    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
    cnt10++;

    if(cnt10 % 2 == 0){
        cnt5++;
        if(cnt10 % 10 == 0){
            cnt1++;
        }
    }


}

