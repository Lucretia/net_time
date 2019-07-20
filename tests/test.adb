with Ada.Calendar;            use Ada.Calendar;
with Ada.Calendar.Formatting; use Ada.Calendar.Formatting;
with Ada.Calendar.Time_Zones; use Ada.Calendar.Time_Zones;
with Ada.Text_IO;             use Ada.Text_IO;
with Net_Times;

procedure Test is
   -- use type Time_Offset;

   Now : Time := Clock;
   PST : Net_Times.Net_Time := Net_Times.Net_Time'(2019, 7, 20, 16, 6, 21,
     Sub_Second => 0.0, TZ_Valid => True, Time_Zone => -8 * 60);
   EST : Net_Times.Net_Time := Net_Times.Net_Time'(2019, 7, 20, 16, 6, 21,
     Sub_Second => 0.0, TZ_Valid => True, Time_Zone => -5 * 60);
begin
   Put ("Now: ");
   Put_Line (Net_Times.Image (Now));

   Put ("PST: ");
   Put_Line (Net_Times.Image (PST));

   Put ("EST: ");
   Put_Line (Net_Times.Image (EST));
end Test;