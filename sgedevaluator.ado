program sgedevaluator
version 13
	args lnf beta sigma lambda p 
	tempvar x s l m
	qui gen double `x' = $ML_y1 - (`beta')
	qui gen double `s' = exp(`sigma')
	qui gen double `l' = (exp(`lambda')-1)/(exp(`lambda')+1)
	qui gen double `m' = (2^(2/`p')*`s'*`l'*exp(lngamma(1/2+1/`p')))/exp(lngamma(1/2))
	qui replace `lnf' = log(`p')-log(2)-log(`s')-lngamma(1/`p')-(abs(`x'+`m')/(`s'*(1+`l'*sign(`x'+`m'))))^`p'
end
