#include <windows.h>

extern "C" __declspec(dllexport) void EntryPoint()
{
    MessageBox(NULL, "DLL Injected Successfully!", "Success", MB_OK);
}

// compile with:
//g++ -shared -o harmless.dll harmless.cpp -mwindows

