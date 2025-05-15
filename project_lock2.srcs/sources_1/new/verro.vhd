library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DigitalLock_Multiplier is
    Port (
        CLK : in STD_LOGIC;
        RESET : in STD_LOGIC;
        INPUT_BITS : in STD_LOGIC_VECTOR(3 downto 0);
        VALIDATE : in STD_LOGIC;
        SEL_OP : in STD_LOGIC;
        CALCULATE : in STD_LOGIC;
        MULT_A : in STD_LOGIC_VECTOR(3 downto 0);
        MULT_B : in STD_LOGIC_VECTOR(3 downto 0);
        UNLOCKED : out STD_LOGIC;
        BLOCKED : out STD_LOGIC;
        LOCKED : out STD_LOGIC;
        SEGMENTS : out STD_LOGIC_VECTOR(6 downto 0);
        ANODE : out STD_LOGIC_VECTOR(3 downto 0)
    );
end DigitalLock_Multiplier;

architecture Behavioral of DigitalLock_Multiplier is
    signal attempt_count : integer := 0;
    signal locked_state : STD_LOGIC := '1';
    signal blocked_state : STD_LOGIC := '0';
    signal unlocked_state : STD_LOGIC := '0';
    signal mult_result : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal display_value : STD_LOGIC_VECTOR(3 downto 0);
    signal seg7 : STD_LOGIC_VECTOR(6 downto 0);
    signal anode_active : STD_LOGIC_VECTOR(3 downto 0) := "1110";
    
    constant SECRET_CODE : STD_LOGIC_VECTOR(3 downto 0) := "1011";
    constant MAX_ATTEMPTS : integer := 3;
    
begin
    process(CLK, RESET)
    begin
        if RESET = '1' then
            attempt_count <= 0;
            locked_state <= '1';
            blocked_state <= '0';
            unlocked_state <= '0';
            mult_result <= (others => '0');
        elsif rising_edge(CLK) then
            if SEL_OP = '0' then
                if VALIDATE = '1' then
                    if INPUT_BITS = SECRET_CODE then
                        unlocked_state <= '1';
                        locked_state <= '0';
                        blocked_state <= '0';
                        attempt_count <= 0;
                    else
                        attempt_count <= attempt_count + 1;
                        if attempt_count >= MAX_ATTEMPTS then
                            blocked_state <= '1';
                            locked_state <= '0';
                            unlocked_state <= '0';
                        else
                            locked_state <= '1';
                            unlocked_state <= '0';
                            blocked_state <= '0';
                        end if;
                    end if;
                end if;
            else
                if CALCULATE = '1' then
                    mult_result <= MULT_A * MULT_B;
                end if;
                display_value <= mult_result(3 downto 0);
                case display_value is
                    when "1000" => seg7 <= "1000000";
                    when "0001" => seg7 <= "1111001";
                    when "0010" => seg7 <= "0100100";
                    when "0011" => seg7 <= "0110000";
                    when "0100" => seg7 <= "0011001";
                    when "0101" => seg7 <= "0010010";
                    when "0110" => seg7 <= "0000010";
                    when "0111" => seg7 <= "1111000";
                    when "0000" => seg7 <= "0000000";
                    when "1001" => seg7 <= "0010000";
                    when others => seg7 <= "1111111";
                end case;
                SEGMENTS <= seg7;
                ANODE <= anode_active;
            end if;
        end if;
    end process;

    UNLOCKED <= unlocked_state;
    BLOCKED <= blocked_state;
    LOCKED <= locked_state;
end Behavioral;

    
