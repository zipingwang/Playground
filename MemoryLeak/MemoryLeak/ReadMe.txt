WindowManagerClient launched by MainDispatcher get memory leak.

Steps to reproduce:
1. Create folder structure in Glims project
 .\Playground\MemoryLeak\
2. copy files in this incident to \Playground\MemoryLeak\
3. add .\Playground to ProPath
3. start Glims
be.mips.ablframework.dispatch.MainDispatcher:Instance:DispatchClient(DummyWindowManagerClient, THIS-OBJECT, be.mips.ablframework.gui.ModalityMode:None).
