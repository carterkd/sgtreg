program gedevaluator
version 12.0
	args lnf beta sigma p 
	tempvar x s
	qui gen double `x' = $ML_y1 - (`beta')
	qui gen double `s' = exp(`sigma')
	qui replace `lnf' = ln(`p') - abs(`x'/`s')^`p' - ln(2) - `sigma' - lngamma(1/`p')
end
