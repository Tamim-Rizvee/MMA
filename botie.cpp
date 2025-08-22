#include <bits/stdc++.h>
#define Onii_chan ios_base::sync_with_stdio(0), cin.tie(0), cout.tie(0)
#define iint long long
#define uwu '\n'
using namespace std;
int main()
{
    int n;
    cout << "Enter n : ";
    cin >> n;
    int k = n + (n - 1);
    int space = k - 2;
    int star = 1;
    for (int i = 1; i <= n - 1; i++)
    {
        for (int j = 1; j <= star; j++)
            cout << "*";
        for (int m = 1; m <= space; m++)
            cout << " ";
        for (int j = 1; j <= star; j++)
            cout << "*";
        cout << endl;
        space -= 2;
        star += 1;
    }
    for (int i = 1; i <= k; i++)
        cout << "*";
    cout << endl;
    star = n - 1;
    space = 1;
    for (int i = 1; i <= n - 1; i++)
    {
        for (int j = 1; j <= star; j++)
            cout << "*";
        for (int m = 1; m <= space; m++)
            cout << " ";
        for (int j = 1; j <= star; j++)
            cout << "*";
        cout << endl;
        space += 2;
        star -= 1;
    }
    return 0;
}