------------------------------------------------------------------------------------------------------------------------
--  Copyright © 2019, Luke A. Guest
--
--  See LICENCE file.
------------------------------------------------------------------------------------------------------------------------
with Ada.Strings;
with Ada.Strings.Fixed;

package body Net_Times is
   package Fixed renames Strings.Fixed;

   generic
      type Num is range <>;
   function To_String_2 (Value : in Num) return String;

   function To_String_2 (Value : in Num) return String is
      Result : String := Fixed.Trim (Num'Image (Value), Strings.Both);
   begin
      if Value < 10 then
         return "0" & Result;
      end if;

      return Result;
   end To_String_2;

   function Is_Well_Formed (Time : in UTF.UTF_String) return Boolean is
   begin
      return True;
   end Is_Well_Formed;

   function To_Time_Offset is new To_String_2 (Num => TZ.Time_Offset);

   function Get_UTC_Offset (Offset : in TZ.Time_Offset) return UTF.UTF_String is
      use type TZ.Time_Offset;

      Hours    : TZ.Time_Offset  := abs (Offset / 60);
      Minutes  : TZ.Time_Offset  := Offset rem 60;
      Hour_Str : String (1 .. 2) := To_Time_Offset (Hours);
      Min_Str  : String (1 .. 2) := To_Time_Offset (Minutes);
      Prefix   : String (1 .. 1) := (if Offset < 0 then "-" else "+");
   begin
      return Prefix & Hour_Str & ":" & Min_Str;
   end Get_UTC_Offset;

   function To_Month is new To_String_2 (Num => Cal.Month_Number);
   function To_Hours is new To_String_2 (Num => Formatting.Hour_Number);
   function To_Minutes is new To_String_2 (Num => Formatting.Minute_Number);
   function To_Seconds is new To_String_2 (Num => Formatting.Second_Number);

   --  With TZ.
   function Image
     (Year       : Cal.Year_Number;
      Month      : Cal.Month_Number;
      Day        : Cal.Day_Number;
      Hour       : Formatting.Hour_Number;
      Minute     : Formatting.Minute_Number;
      Second     : Formatting.Second_Number;
      Sub_Second : Formatting.Second_Duration;
      Time_Zone  : TZ.Time_Offset) return UTF.UTF_String is

      Year_Str   : UTF.UTF_String (1 .. 4) := Fixed.Trim (Cal.Year_Number'Image (Year), Strings.Both);
      Month_Str  : UTF.UTF_String (1 .. 2) := To_Month (Month);
      Day_Str    : UTF.UTF_String (1 .. 2) := Fixed.Trim (Cal.Day_Number'Image (Day), Strings.Both);
      Hour_Str   : UTF.UTF_String (1 .. 2) := To_Hours (Hour);
      Minute_Str : UTF.UTF_String (1 .. 2) := To_Minutes (Minute);
      Second_Str : UTF.UTF_String (1 .. 2) := To_Seconds (Second);
   begin
      return Year_Str & "-" & Month_Str & "-" & Day_Str & "T" &
        Hour_Str & ":" & Minute_Str & ":" & Second_Str & Get_UTC_Offset (Time_Zone);
   end Image;

   --  Without TZ.
   function Image
     (Year       : Cal.Year_Number;
      Month      : Cal.Month_Number;
      Day        : Cal.Day_Number;
      Hour       : Formatting.Hour_Number;
      Minute     : Formatting.Minute_Number;
      Second     : Formatting.Second_Number;
      Sub_Second : Formatting.Second_Duration) return UTF.UTF_String is

      Year_Str   : UTF.UTF_String (1 .. 4) := Fixed.Trim (Cal.Year_Number'Image (Year), Strings.Both);
      Month_Str  : UTF.UTF_String (1 .. 2) := To_Month (Month);
      Day_Str    : UTF.UTF_String (1 .. 2) := Fixed.Trim (Cal.Day_Number'Image (Day), Strings.Both);
      Hour_Str   : UTF.UTF_String (1 .. 2) := To_Hours (Hour);
      Minute_Str : UTF.UTF_String (1 .. 2) := To_Minutes (Minute);
      Second_Str : UTF.UTF_String (1 .. 2) := To_Seconds (Second);
   begin
      return Year_Str & "-" & Month_Str & "-" & Day_Str & "T" &
        Hour_Str & ":" & Minute_Str & ":" & Second_Str & "-00:00";
   end Image;

   function Image (Time : in Cal.Time) return UTF.UTF_String is
      Year       : Cal.Year_Number;
      Month      : Cal.Month_Number;
      Day        : Cal.Day_Number;
      Hour       : Formatting.Hour_Number;
      Minute     : Formatting.Minute_Number;
      Second     : Formatting.Second_Number;
      Sub_Second : Formatting.Second_Duration;
      Time_Zone  : TZ.Time_Offset;
   begin
      Formatting.Split (Time, Year, Month, Day, Hour, Minute, Second, Sub_Second, Time_Zone);

      Time_Zone := TZ.UTC_Time_Offset (Time); -- Can raise TZ.Unknown_Zone_Error.

      return Image (Year, Month, Day, Hour, Minute, Second, Sub_Second, Time_Zone);
   exception
      when TZ.Unknown_Zone_Error =>
         return Image (Year, Month, Day, Hour, Minute, Second, Sub_Second);
   end Image;

   function Image (Time : in Net_Time) return UTF.UTF_String is
   begin
      if Time.TZ_Valid then
         return Image (Time.Year, Time.Month, Time.Day,
           Time.Hour, Time.Minute, Time.Second, Time.Sub_Second, Time.Time_Zone);
      end if;

         return Image (Time.Year, Time.Month, Time.Day, Time.Hour, Time.Minute, Time.Second, Time.Sub_Second);
   end Image;


   function Value (Time : in UTF.UTF_String) return Cal.Time is
   begin
      return Cal.Clock;
   end Value;

   -- function Read (Stream : in Ada.Text_IO.Text_Streams.Stream_Access) return Ada.Strings.UTF_Encoding.UTF_String is
   -- begin
   --    return "";
   -- end Parse;

   -- function To_Time (Self : in Net_Time) return Ada.Calendar.Time is
   -- begin
   -- end To_Time;

   -- function To_Net_Time (Time : in Ada.Calendar.Time) return Net_Time is
   -- begin
   -- end To_Net_Time;
end Net_Times;
