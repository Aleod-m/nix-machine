{pkgs, ...}: {
    bashrcExtra = ''
        up() {
            local d=""
            limit=$1    
	        for ((i=1 ; i <= limit ; i++)) do
	    		d=$d/..
		    done
	        d=$(echo $d | sed 's/^\///')
	        if [ -z "$d" ]; then
		        d=..
	        fi
	        cd $d
        }
        
        mkcd() {
            mkdir $1
            cd $1
        }
    '';
}
