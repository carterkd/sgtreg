program sgtevaluatorva
version 13
	args lnf beta sigma lambda p q
	tempvar x s l m 
	qui gen double `x' = $ML_y1 - (`beta')
	qui gen double `l' = (exp(`lambda')-1)/(exp(`lambda')+1)
	qui gen double `s' = exp(`sigma') / (`q'^(1/`p')*sqrt((3*`l'^2+1)*(exp(lngamma(3/`p') + lngamma(`q'-2/`p') - lngamma(`q' + 1/`p'))/exp(lngamma(1/`p') + lngamma(`q') - lngamma(`q' + 1/`p')))-4*`l'^2*(exp(lngamma(2/`p') + lngamma(`q'-1/`p') - lngamma(`q' + 1/`p'))/exp(lngamma(1/`p') + lngamma(`q') - lngamma(`q' + 1/`p')))^2))
	qui gen double `m' = (2 * `s' * `l' * `q'^(1/`p') * exp(lngamma(2/`p') + lngamma(`q' - 1/`p') - lngamma(1/`p' + `q')))/exp(lngamma(1/`p') + lngamma(`q') - lngamma(1/`p' + `q'))
	qui replace `lnf' = ln(`p') - ln(2) - `sigma' - (ln(`q')/`p') - (lngamma(1/`p') + lngamma(`q') - lngamma(1/`p' + `q')) - (1/`p' + `q') * ln(1 + abs(`x' + `m')^`p'/(`q' * `s'^`p' * (1 + `l' * sign(`x' + `m'))^`p'))
end
