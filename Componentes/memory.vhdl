library ieee;
use ieee.std_logic_1164.all;

entity memory is
    generic (
        addr_width: natural := 16; -- Memory Address Width (in bits)
        data_width: natural := 8 -- Data Width (in bits)
);
    port (
        clock: in std_logic; -- Clock signal; Write on Falling-Edge

        data_read : in std_logic; -- When '1', read data from memory
        data_write: in std_logic; -- When '1', write data to memory
        -- Data address given to memory
        data_addr : in std_logic_vector(addr_width-1 downto 0);
        -- Data sent from memory when data_read = '1' and data_write = '0'
        data_in : out std_logic_vector((data_width*4)-1 downto 0);
        -- Data sent to memory when data_read = '0' and data_write = '1'
        data_out : out std_logic_vector(data_width-1 downto 0)
 );
end entity;

architecture Behavioral of memory is 

begin
    process(clock,data_read,data_write)
        --cria matriz de 2^16 pos com cara uma de tamanho 8 bits--
        type mem_t is array (2^addr_width) of std_logic_vector(data_width-1 downto 0);
        signal mem : mem_t;
 
    begin
        loop
            wait on clock;
            if data_read = '1' then 
                data_out <= mem(data_addr);
            end if;
            if data_write = '1' then
                mem(data_addr) := data_in;
            end if ;
        end loop;
    end process;
end;