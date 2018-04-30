LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TEMP_SINCRONO IS
	PORT(
		CLK, CLR, INPUT: IN STD_LOGIC;
		UNI: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		DEC: OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);

	ATTRIBUTE PIN_NUMBERS OF TEMP_SINCRONO : ENTITY IS
		"CLK:1     "	   	&
		"CLR:13    "	   	&
    		"INPUT:4   "		&
		"DEC(2):20 "		&
		"DEC(1):19 "		&
		"DEC(0):18 "		&
		"UNI(3):17 "		&
		"UNI(2):16 "		&
		"UNI(1):15 "		&
		"UNI(0):14 ";
END TEMP_SINCRONO;

ARCHITECTURE BEHAVE OF TEMP_SINCRONO IS
SIGNAL EN, D1, D2: STD_LOGIC;
BEGIN
	EN <= D1 XOR D2;
	PROCESS(CLK, CLR)
	BEGIN
		IF CLR = '1' THEN
			INPUT<= '0';
			D1 <= 	'0';
			D2 <= 	'0';
		ELSIF RISING_EDGE(CLK) THEN
			INPUT<=INPUT;
			D2 <= INPUT;
			D1 <= INPUT;
		END IF;
	END PROCESS;

	COUNTER_DECADA: PROCESS(CLK, CLR)
	BEGIN
		IF CLR = '1' THEN
			UNI <= (OTHERS => '0');
			DEC <= (OTHERS => '0');
		ELSIF RISING_EDGE(CLK) THEN
			IF EN = '1' THEN
				UNI <= UNI + 1;
				IF UNI = "1001" THEN
					UNI <= "0000";
					DEC <= DEC + 1;
				END IF;
			END IF;
		END IF;
	END PROCESS COUNTER_DECADA;
END BEHAVE;
