/*------------------------------------------------------------------------
    File        : _idestartup.p
    Purpose     : Subscribe to Progress Developer Studio for
                  OpenEdge events, call event_alert.p
  ----------------------------------------------------------------------*/
DEFINE VARIABLE mySubscribehandle AS HANDLE  NO-UNDO.
RUN OeIdeEvent/event_alert.p PERSISTENT SET mySubscribeHandle. /*message in PROCEDURE oeide_event. not shown, because it is in a subprocedure.
                                                                the procedure itself has nothing.
                                                                it was a little confusing, because the procedure has only one subprocedure.*/
SUBSCRIBE PROCEDURE mySubscribeHandle TO "oeide_event" ANYWHERE. /*expect mySubscribeHandle procedure has a subprocedrue called oeide_event
                                                                   correct signature */

/*When you open a Progress Developer Studio for OpenEdge project, the OpenEdge Runtime searches the project's PROPATH 
for a file named _idestartup.p. If that file is found, any procedures that it contains are automatically executed. 
Therefore, you can implement a custom startup routine by creating the _idestartup.p. procedure.*/

/*When want to use _idestartup.p, move it to Playground folder(because it is in propath), then restart AVM.
event_alert.p shows message, the message could be behind the OE Editor(it block the AVM, use alt+tab to switch the Message box, close it)
If want to disable _idestartup.p, move it to /Playground/OeideEvent/
*/

/*list of events*/
/*https://documentation.progress.com/output/ua/OpenEdge_latest/index.html#page/pdsoe%2Fsubscribing-to-openedge-architect-events.html%23wwID0E3YN4*/
