#{ 
==================================
Costa Rica Institute of Technology
==================================

Algorithm Prototype 'uint8_mult'
Computer Arquitecture IC-3101
Authors: Eric Alpizar
         Rodrigo Espinach
         Jimmy Salas       
#}

res = 0
cont = 0

# temporary variables used in the algorithm are instantiated above

num_1 = 7
num_2 = 4

# Numbers to multiply (num_1 * num_2)


while(num_2)                              # while num_2 > 0 

  if(bitand(num_2,1) == 1)                # calculates the modulo of num_2 and 2 (num_2 % 2)
  
    res += bitshift(num_1, cont)          # shift in num_1 'cont' times to the left
    
  endif

  cont += 1                               # adds 1 to cont for each iteration
 
  num_2 = bitshift(num_2, -1)             # a bitshift to the right is applied to num_2 (num_2 / 2)
  
endwhile        

disp('The result is: '), disp(res)        # the result is displayed in console

