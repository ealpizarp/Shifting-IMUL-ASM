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
num_2 = 3

# Numbers to multiply (num_1 * num_2)


while(num_2)                           # while num_2 > 0 

  if(mod(num_2,2) == 1)                # checks if the number is even or not
  
    res += bitshift(num_1, cont)       # shift in num_1 'cont' times to the left
    
  endif

  cont += 1                            # adds 1 to cont for each iteration
 
  num_2 = idivide(num_2, 2, "fix")     # a whole division is applied to num_2
  
endwhile        

disp('The result is: '), disp(res)     # The result is displayed in console