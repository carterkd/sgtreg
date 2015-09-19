program gedevaluatorva
version 12.0
	args lnf beta sigma p 
	tempvar x s sigmid
	qui gen sigmid = `sigma' / sqrt((exp(lngamma(1/2))^2*(1+3*`lambda'^2)*exp(lngamma(3/`p'))-16^(1/`p')*`lambda'^2*(exp(lngamma(1/2+1/`p')))^2*exp(lngamma(1/`p')))/(exp(lngamma(1/2))^2*exp(lngamma(1/`p'))))
	qui gen double `x' = $ML_y1 - (`beta')
	qui gen double `s' = exp(`sigmid')
	qui replace `lnf' = ln(`p') - abs(`x'/`s')^`p' - ln(2) - `sigma' - lngamma(1/`p')
end
