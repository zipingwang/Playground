/* Copyright ©1994 MIPSYS INTERNATIONAL LIMITED. All rights reserved. */

/*+
.TH $RCSfile$ 3 MIPS
.SH Name
$RCSfile$ - Development Include file
.SH Syntax
{ $RCSfile$ }.
.SH Parameters
.SH Assumptions
The installation script creates an empty file with this name, this ensures
that all defines in this file are undefined at the client site.
.SH Description
This include file defines :
.br
DEBUG 1
.SH Examples
.SH Databases referenced

.SH Author
Carl Verbiest
.SH Creation date
10-Jun-94 11:38
.SH Version
$Revision$ $Date$
-*/

/* no debug */

&GLOBAL-DEFINE DEBUG 1
