------------------------------------------------------------------------
--  MulRun: machine language program for the Sigma16 architecture
------------------------------------------------------------------------

{- A machine language program for the Sigma16 architecture that
performs a number of multiplications using the mul instruction. -}

module Main where
import M1driver

main :: IO ()
main = run_Sigma16_program multest 10000

------------------------------------------------------------------------

multest :: [String]
multest =
-- Machine Language  Addr    Assembly Language     Comment
-- ~~~~~~~~~~~~~~~~  ~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 [
                    -- 0000 ; Mul is used to multiply two numbers together 
                    -- 0000 ; and the results are stored into registers 3 to 6.
                    -- 0000
                    -- 0000 
                    -- 0000 ; R1 and R2 are the registers used for the numbers being multiplied together
                    -- 0000 ; R3 to R6 are the registers which the results are stored into
                    -- 0000
                    -- 0000
                    -- 0000 ; Multiplying two small numbers
    "f100", "0002", -- 0000 lea R1,2[R0]     ; R1 = 2
    "f200", "0002", -- 0002 lea R2,2[R0]     ; R2 = 2
    "2321",         -- 0004 mul R3,R2,R1     ; R3 = 2*2 = 4        
                    -- 0005
                    -- 0005 ; Multiplying a +ve with a -ve number
    "f100", "0003", -- 0005 lea R1,3[R0]     ; R1 = 3
    "f200", "fffd", -- 0007 lea R2,ffff[R0]  ; R2 = -3
    "2421",         -- 0009 mul R4,R2,R1     ; R4 = 3*(-3) = -9    
                    -- 000a
                    -- 000a ; Multiplying two negative numbers
    "f100", "fffa", -- 000a lea R1,fffb[R0]  ; R1 = -6
    "f200", "fffe", -- 000c lea R2,ffff[R0]  ; R2 = -2
    "2521",         -- 000e mul R5,R2,R1     ; R5 = (-6)*(-2) = 12  
                    -- 000f
                    -- 000f ; Multiplying two quite large numbers
    "f100", "00c8", -- 000f lea R1,7f[R0]    ; R1 = 200
    "f200", "00c8", -- 0011 lea R2,101[R0]   ; R2 = 200
    "2621",         -- 0013 mul R6,R2,R1     ; R6 = 200 * 200 = 40000 
                    -- 0019 ; R3 = 0004
                    -- 0019 ; R4 = fff7
                    -- 0019 ; R5 = 000c
                    -- 0019 ; R6 = 9c40
                    -- 0019
    "d000"          -- 0019 trap
 ]

 ------------------------------------------------------------------------
