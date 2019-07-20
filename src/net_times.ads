------------------------------------------------------------------------------------------------------------------------
--  Copyright © 2019, Luke A. Guest
--
--  See LICENCE file.
------------------------------------------------------------------------------------------------------------------------
--  Internet time (RFC3339) shared library.
------------------------------------------------------------------------------------------------------------------------
with Ada.Calendar;
with Ada.Calendar.Formatting;
with Ada.Calendar.Time_Zones;
with Ada.Strings.UTF_Encoding;
-- with Ada.Text_IO.Text_Streams;

package Net_Times is
   -- type Net_Time is private;

   package Strings renames Ada.Strings;
   package UTF renames Strings.UTF_Encoding;
   package Cal renames Ada.Calendar;
   package Formatting renames Cal.Formatting;
   package TZ renames Cal.Time_Zones;

   type Net_Time is
      record
         Year       : Cal.Year_Number;
         Month      : Cal.Month_Number;
         Day        : Cal.Day_Number;
         Hour       : Formatting.Hour_Number;
         Minute     : Formatting.Minute_Number;
         Second     : Formatting.Second_Number;
         Sub_Second : Formatting.Second_Duration;
         Time_Zone  : TZ.Time_Offset;
         TZ_Valid   : Boolean;
      end record;

   function Is_Well_Formed (Time : in UTF.UTF_String) return Boolean;

   function Image (Time : in Cal.Time) return UTF.UTF_String;
   function Image (Time : in Net_Time) return UTF.UTF_String;
   function Value (Time : in UTF.UTF_String) return Cal.Time;

   -- function Parse (Stream : in Ada.Text_IO.Text_Streams.Stream_Access) return Ada.Strings.UTF_Encoding.UTF_String;

   -- function To_Time (Self : in Net_Time) return Ada.Calendar.Time;
   -- function To_Net_Time (Time : in Ada.Calendar.Time) return Net_Time;
-- private
   -- type Net_Time is
   --    record
   --       Year       : Cal.Year_Number;
   --       Month      : Cal.Month_Number;
   --       Day        : Cal.Day_Number;
   --       Hour       : Formatting.Hour_Number;
   --       Minute     : Formatting.Minute_Number;
   --       Second     : Formatting.Second_Number;
   --       Sub_Second : Formatting.Second_Duration;
   --       Time_Zone  : TZ.Time_Offset;
   --    end record;
end Net_Times;
