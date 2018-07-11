WindowManagerClient launched by MainDispatcher gets memory leak.
e.g. be.mips.ablframework.dispatch.MainDispatcher:Instance:DispatchClient(DummyWindowManagerClient, THIS-OBJECT, be.mips.ablframework.gui.ModalityMode:None).

Steps to reproduce:
1. Create a folder structure in Glims project
 .\Playground\MemoryLeak\
2. copy files in this incident to \Playground\MemoryLeak\
3. add .\Playground to ProPath
3. start Glims. in run procedure textbox(third textbox in the toolbar): fill in "MemoryLeak/StartTest", press enter, click start test.
4. open task monitor
5. the test program will open 100 times WindowManagerClient in a dummy form, memory is ok, then it will open 100
    times WindowManagerClient by MainDispatcher, memory is increased little by little.

