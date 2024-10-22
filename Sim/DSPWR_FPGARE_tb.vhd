LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY DSPWR_FPGARE_tb IS 
END DSPWR_FPGARE_tb;

ARCHITECTURE TESTBENCH_ARCH OF DSPWR_FPGARE_tb IS

COMPONENT DSPWR_FPGARE_CTRL
PORT (
        SYS_CLK     : IN     STD_LOGIC;
--		SYS_RST_N   : IN     STD_LOGIC;
        XA          : IN     STD_LOGIC_VECTOR(11 DOWNTO 0);
        XZCS_7      : IN     STD_LOGIC;
        XWE         : IN     STD_LOGIC;

        RDEN_B      : BUFFER STD_LOGIC;
        WREN_B      : BUFFER STD_LOGIC;
		ADDRESS_B   : BUFFER STD_LOGIC_VECTOR(11 DOWNTO 0);

        RAMB_FULL   : IN     STD_LOGIC
    );
END COMPONENT;

SIGNAL SYS_CLK      : STD_LOGIC;
--SIGNAL SYS_RST_N    : STD_LOGIC := '1';
SIGNAL XA           : STD_LOGIC_VECTOR(11 DOWNTO 0) := "100000000000";
SIGNAL XZCS_7       : STD_LOGIC := '1';
SIGNAL XWE          : STD_LOGIC := '1';
SIGNAL RDEN_B       : STD_LOGIC := '1';
SIGNAL WREN_B       : STD_LOGIC := '0';
SIGNAL ADDRESS_B    : STD_LOGIC_VECTOR(11 DOWNTO 0) := "100000000000";
SIGNAL RAMB_FULL    : STD_LOGIC := '0';

SIGNAL COUNTER_A    : STD_LOGIC_VECTOR(11 DOWNTO 0) := "000000000000";
--SIGNAL XA_DELAY     : STD_LOGIC_VECTOR(11 DOWNTO 0) := "100000000000";
--SIGNAL XZCS_7_DELAY : STD_LOGIC := '0';
--SIGNAL XWE_DELAY    : STD_LOGIC := '0';

CONSTANT CLK_PERIOD : TIME := 40 NS;

BEGIN

INSTANT: DSPWR_FPGARE_CTRL PORT MAP
	(
        SYS_CLK     =>SYS_CLK,
--        SYS_RST_N   =>SYS_RST_N,
		XA          =>XA,
		XZCS_7		=>XZCS_7,
		XWE			=>XWE,
        RDEN_B		=>RDEN_B,
        WREN_B	    =>WREN_B,
        ADDRESS_B   =>ADDRESS_B,
        RAMB_FULL	=>RAMB_FULL
	);
									 
CLK_IN: PROCESS
BEGIN
    SYS_CLK <= '0';
	WAIT FOR CLK_PERIOD/2;
    SYS_CLK <= '1';
	WAIT FOR CLK_PERIOD/2;
END PROCESS;

PROCESS
BEGIN
    XZCS_7 <= '1';
    XWE    <= '1';
	WAIT FOR 200 NS;
    XZCS_7 <= '0';
    XWE    <= '0';
    WAIT FOR 200 NS;
END PROCESS;

PROCESS(XWE)
BEGIN
--    IF(XZCS_7='0') THEN
		IF(XWE'EVENT AND XWE = '0') THEN
    	    IF(XA="111111111111") THEN
                XA <= "101111111111";
    	    ELSE
                XA <= XA + '1';
            END IF;
		END IF;
--	END IF;
END PROCESS;












--PROCESS(SYS_CLK)
--BEGIN
--    IF(SYS_RST_N='0') THEN 
--        COUNTER_A <= "000000000000";
--    ELSIF(SYS_CLK'EVENT AND SYS_CLK='1') THEN
--    	IF(COUNTER_A="111111111111") THEN
--            COUNTER_A <= "000000000000";
--    	ELSE
--            COUNTER_A <= COUNTER_A + '1';
--    	END IF;
--    END IF;
--END PROCESS;

--PROCESS(SYS_CLK)
--BEGIN
--    IF(SYS_RST_N='0') THEN 
--        XZCS_7 <= '1';
--        XWE    <= '1';
--    ELSIF(SYS_CLK'EVENT AND SYS_CLK='1') THEN
--    	IF((COUNTER_A>="100000000000")AND(COUNTER_A<="111111111111")) THEN
--            XZCS_7 <= '0';
--            XWE    <= '0';
--    	ELSE
--            XZCS_7 <= '1';
--            XWE    <= '1';
--    	END IF;
--    END IF;
--END PROCESS;

--PROCESS(SYS_CLK)
--BEGIN
--    IF(SYS_RST_N='0') THEN 
--        XA <= "100000000000";
--    ELSIF(SYS_CLK'EVENT AND SYS_CLK='1') THEN
--    	IF((COUNTER_A>="100000000000")AND(COUNTER_A<="111111111111")) THEN
--    	    IF(XA="111111111111") THEN
--                XA <= "100000000000";
--    	    ELSE
--                XA <= XA + '1';
--            END IF;
--    	END IF;
--    END IF;
--END PROCESS;

--因为XA传给ADDRESS_B有一个周期的延时，让XA_DELAY与ADDRESS_B同步
--PROCESS(SYS_CLK)
--BEGIN
--    IF(SYS_RST_N='0') THEN 
--        XA_DELAY <= "100000000000";
--    ELSIF(SYS_CLK'EVENT AND SYS_CLK='1') THEN
--    	IF((COUNTER_A>="100000000000")AND(COUNTER_A<="111111111111")) THEN
--            XA_DELAY <= XA ;
--        ELSE
--            XA_DELAY <= "100000000000";
--    	END IF;
--    END IF;
--END PROCESS;

--PROCESS(SYS_CLK)
--BEGIN
--    IF(SYS_RST_N='0') THEN 
--        RAMB_FULL <= '0';
--    ELSIF(SYS_CLK'EVENT AND SYS_CLK='1') THEN 
--    	IF(XA="111111111111") THEN
--            RAMB_FULL <= '1';
--    	ELSE
--            RAMB_FULL <= '0';
--    	END IF;
--    END IF;
--END PROCESS;

END TESTBENCH_ARCH;