with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Maximum_Positive_Segment is
   type Int_Array is array (Natural range <>) of Integer;
   Data : constant Int_Array := (3, 5, -2, 4, 6, -1, 2, 8, 0, 100, 7);

   Max_Sum : Integer := 0;
   Max_Start : Integer := -1;
   Max_End : Integer := -1;

   Current_Sum : Integer := 0;
   Current_Start : Integer := -1;
begin
   for I in Data'Range loop
      if Data(I) = 0 then
         exit; -- Sentinel: stop before processing later values.
      end if;

      if Data(I) > 0 then
         if Current_Start = -1 then
            Current_Start := I;
            Current_Sum := 0;
         end if;

         Current_Sum := Current_Sum + Data(I);

         if Current_Sum > Max_Sum then
            Max_Sum := Current_Sum;
            Max_Start := Current_Start;
            Max_End := I;
         end if;
      else
         Current_Start := -1;
         Current_Sum := 0;
      end if;
   end loop;

   Put("max_sum = ");
   Put(Max_Sum, Width => 0);
   New_Line;
   Put("start = ");
   Put(Max_Start, Width => 0);
   New_Line;
   Put("end = ");
   Put(Max_End, Width => 0);
   New_Line;
end Maximum_Positive_Segment;
