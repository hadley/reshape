#include <R.h>
#include <Rinternals.h>

#include <R_ext/Rdynload.h>

SEXP reshape2_melt_dataframe(SEXP dataSEXP, SEXP id_vars_SEXP, SEXP measure_vars_SEXP, SEXP variable_nameSEXP, SEXP value_nameSEXP);

R_CallMethodDef callMethods[]  = {
  {"C_melt_dataframe", (DL_FUNC) &reshape2_melt_dataframe, 5},
  {NULL, NULL, 0}
};

void R_init_reshape2(DllInfo *info) {
  R_registerRoutines(info, NULL, callMethods, NULL, NULL);
  R_useDynamicSymbols(info, FALSE);
}

