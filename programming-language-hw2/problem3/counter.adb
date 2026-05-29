with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Counter is
   package Counter_Types is
      type Base_Counter is tagged private;
      procedure Increment(C : in out Base_Counter);
      procedure Decrement(C : in out Base_Counter);
      procedure Reset(C : in out Base_Counter);
      function Get_Value(C : Base_Counter) return Integer;
      procedure Print_Info(C : Base_Counter);

      type Bounded_Counter is new Base_Counter with private;
      procedure Set_Max(C : in out Bounded_Counter; Max : Integer);
      overriding procedure Increment(C : in out Bounded_Counter);
      overriding procedure Print_Info(C : Bounded_Counter);

      type Step_Counter is new Base_Counter with private;
      procedure Set_Step(C : in out Step_Counter; Step : Integer);
      overriding procedure Increment(C : in out Step_Counter);
      overriding procedure Decrement(C : in out Step_Counter);
      overriding procedure Print_Info(C : Step_Counter);

   private
      type Base_Counter is tagged record
         Value : Integer := 0;
      end record;

      type Bounded_Counter is new Base_Counter with record
         Max_Value : Integer := 0;
      end record;

      type Step_Counter is new Base_Counter with record
         Step : Integer := 1;
      end record;
   end Counter_Types;

   package body Counter_Types is
      procedure Increment(C : in out Base_Counter) is
      begin
         C.Value := C.Value + 1;
      end Increment;

      procedure Decrement(C : in out Base_Counter) is
      begin
         C.Value := C.Value - 1;
      end Decrement;

      procedure Reset(C : in out Base_Counter) is
      begin
         C.Value := 0;
      end Reset;

      function Get_Value(C : Base_Counter) return Integer is
      begin
         return C.Value;
      end Get_Value;

      procedure Print_Info(C : Base_Counter) is
      begin
         Put("Counter value = ");
         Put(C.Value, Width => 0);
         New_Line;
      end Print_Info;

      procedure Set_Max(C : in out Bounded_Counter; Max : Integer) is
      begin
         C.Max_Value := Max;
      end Set_Max;

      overriding procedure Increment(C : in out Bounded_Counter) is
      begin
         if C.Value < C.Max_Value then
            C.Value := C.Value + 1;
         end if;
      end Increment;

      overriding procedure Print_Info(C : Bounded_Counter) is
      begin
         Put("BoundedCounter value = ");
         Put(C.Value, Width => 0);
         Put(", max = ");
         Put(C.Max_Value, Width => 0);
         New_Line;
      end Print_Info;

      procedure Set_Step(C : in out Step_Counter; Step : Integer) is
      begin
         C.Step := Step;
      end Set_Step;

      overriding procedure Increment(C : in out Step_Counter) is
      begin
         C.Value := C.Value + C.Step;
      end Increment;

      overriding procedure Decrement(C : in out Step_Counter) is
      begin
         C.Value := C.Value - C.Step;
      end Decrement;

      overriding procedure Print_Info(C : Step_Counter) is
      begin
         Put("StepCounter value = ");
         Put(C.Value, Width => 0);
         Put(", step = ");
         Put(C.Step, Width => 0);
         New_Line;
      end Print_Info;
   end Counter_Types;

   use Counter_Types;

   type Counter_Access is access all Base_Counter'Class;
   type Counter_List is array (Positive range <>) of Counter_Access;

   Normal : aliased Base_Counter;
   Bounded : aliased Bounded_Counter;
   Stepped : aliased Step_Counter;
   Counters : Counter_List := (Normal'Access, Bounded'Access, Stepped'Access);
begin
   Set_Max(Bounded, 1);
   Set_Step(Stepped, 5);

   Increment(Normal);
   Increment(Bounded);
   Increment(Bounded);
   Increment(Stepped);
   Decrement(Stepped);

   for C of Counters loop
      Increment(C.all);
      Print_Info(C.all); -- Dispatching call selects the actual tagged type.
   end loop;
end Counter;
