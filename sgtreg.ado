program sgtreg, eclass
version 12.0
	if replay() {
		display "Replay not implemented"
	}
	else {
		syntax varlist(min=1) [if] [in] [, QINFinite VARADJust GCONSonly gamma(varlist) DCONSonly delta(varlist) INITial(numlist) DIFficult TECHnique(passthru) ITERate(passthru) nolog TRace GRADient showstep HESSian SHOWTOLerance TOLerance(passthru) LTOLerance(passthru) NRTOLerance(passthru)] 
		local depvar: word 1 of `varlist'
		local regs: list varlist - depvar
		local gammavars `regs'
		local deltavars `regs'
		if "`gamma'" != "" {
			local gammavars `gamma'
		}
		if "`delta'" != "" {
			local deltavars `delta'
		}
		if "`gconsonly'" != "" {
			local gammavars
		}
		if "`dconsonly'" != "" {
			local deltavars
		}
		local nregs: word count `regs'
		local ngamma: word count `gammavars'
		local ndelta: word count `deltavars'
		local ndelta = `ndelta' + 1
		marksample touse
		if ("`initial'" == "") {
			local initial
			qui reg `depvar' `regs'
			foreach vari in `regs' _cons {
				local temp = _b[`vari']
				local initial `initial' `temp'
			}
			forval i = 1/`ngamma' {
				local initial `initial' 0 
			}
			local temp = ln(e(rmse)) + ln(2)/2
			local initial `initial' `temp'
			forval i = 1/`ndelta' {
				local initial `initial' 0 
			}
			local initial `initial' 2 
			if "`qinfinite'" == "" {
				local initial `initial' 10
			}
		}
		local initiallen: word count `initial'
		if ("`qinfinite'" == "" & `initiallen' != `nregs'+`ngamma'+`ndelta'+4) {
			di as err "initial does not have the correct amount of numbers"
			exit 503
		}
		if ("`qinfinite'" != "" & `initiallen' != `nregs'+`ngamma'+`ndelta'+3) {
			di as err "initial does not have the correct amount of numbers"
			exit 503
		}
		if "`qinfinite'" == "" {
			local evaluator sgtevaluator
			if "`varadjust'" != "" {
				local evaluator sgtevaluatorva
			}
			ml model lf `evaluator' (beta: `depvar' = `regs') (gamma: `gammavars') (delta: `deltavars') /p /q if `touse', maximize `technique' init(`initial', copy) `difficult' `iterate' `log' `trace' `gradient' `showstep' `hessian' `showtolerance' `tolerance' `ltolerance' `nrtolerance'
		}
		else {
			local evaluator gedevaluator
			if "`varadjust'" != "" {
				local evaluator gedevaluatorva
			}
			ml model lf `evaluator' (beta: `depvar' = `regs') (gamma: `gammavars') (delta: `deltavars') /p if `touse', maximize `technique' init(`initial', copy) `difficult' `iterate' `log' `trace' `gradient' `showstep' `hessian' `showtolerance' `tolerance' `ltolerance' `nrtolerance'			
		}
		ml display, showeqns
		qui ereturn list
	}
end
