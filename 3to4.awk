#!/usr/bin/gawk -f

##########################################
# Set initial things
##########################################
BEGIN {

      #-- Variables
      ind = 0      

      #-- For reading .gro-format
      FIELDWIDTHS = "5 5 5 5 8 8 8 8 8 8"
}

##########################################
# Read .gro file into memory line by line
##########################################
{
      #-- First line: comment
    if(NR == 1) {
         COMMENT=$0
         next
    }
 
      #-- Second line: number of atoms
    if(NR == 2) {
	  NATOMS=$0
         next
    }

      #-- Last line: box dimensions 
    if(NR == NATOMS+3) {
	boxx = substr($0,  1, 10) + 0.0
	boxy = substr($0, 11, 20) + 0.0
	boxz = substr($0, 21, 30) + 0.0
         next
    }

      #-- Other lines: atom coordinates
      ind++
      MOLNUM[ind] = $1 
      MOLNAME[ind] = $2 
      ATOMNAME[ind] = $3 
      ATOMNUM[ind] = $4 
      X[ind] = $5 
      Y[ind] = $6 
      Z[ind] = $7 

}

##########################################
# Write .gro file
##########################################
END {
    
    
    
    #-- Print header
    print COMMENT    
    print NATOMS 
    #-- Print atoms 
    run_num = 0

    for(ind = 1; ind <= NATOMS; ind++) {
	run_num++

	if(run_num == 100000){
	        run_num=0
	}
	
	if (trim(ATOMNAME[ind]) == "OH2" ) {
	        
	    printf("%5d%5s%5s%5d", MOLNUM[ind], MOLNAME[ind], ATOMNAME[ind], run_num)
	    printf("%8.3f%8.3f%8.3f\n", X[ind], Y[ind], Z[ind])

	    run_num++

	    printf("%5d%5s%5s%5d", MOLNUM[ind], MOLNAME[ind], "OD", run_num)
	    printf("%8.3f%8.3f%8.3f\n", X[ind]+0.03, Y[ind]+0.03, Z[ind]+0.03)
	}
	else{
	    printf("%5d%5s%5s%5d", MOLNUM[ind], MOLNAME[ind], ATOMNAME[ind], run_num)
	    printf("%8.3f%8.3f%8.3f\n", X[ind], Y[ind], Z[ind])
	}
    }   
    
    #-- Print box dimensions
    printf("%10.5f%10.5f%10.5f\n", boxx, boxy, boxz)      
    
}

function ltrim(s) { sub(/^ +/, "", s); return s }
function rtrim(s) { sub(/ +$/, "", s); return s }
function trim(s)  { return rtrim(ltrim(s)); }  
