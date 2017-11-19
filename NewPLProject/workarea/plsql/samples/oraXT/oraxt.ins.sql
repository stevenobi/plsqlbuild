----------------------------------------------------------------------------------
--
-- Title: DBXT.INS.SQL
--
-- Description: SQL script to install DB Extensions Management Packs
--
--
-- History:      13.10.2013  Obermeyer: created
--                   29.03.2013 Obermeyer: updated to DBXT
--
----------------------------------------------------------------------------------
set line 200
set pages 9999
set timing off

prompt
prompt *** oraxtglobal ***
@@oraxt.global.pkg

prompt
prompt *** oraxtsys ***
@@oraxt.xtsys.pkg

prompt
prompt *** oraxtver ***
@@oraxtver.pkg

prompt
prompt *** oraxtprn ***
@@oraxt.prn.pkg


