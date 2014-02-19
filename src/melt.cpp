#include <Rcpp.h>
using namespace Rcpp;

// A debug macro -- change to 'debug(x) x' for debug output
#define debug(x)

// for printing a message out to the R console in interactive sessions
Function message("message");

// convert the 'variable' column to factor
Function as_factor("as.factor");

// helper for the id.vars, measure.vars passed -- we match
// character vectors to the names (getting an integer index);
// or coerce to integer otherwise

// ensure that we index in the column range of the data
void check_indices(IntegerVector ind, int ncol, std::string msg) {
  int n = ind.size();
  for (int i=0; i < n; ++i) {
    if (ind[i] < 0) {
      stop(msg + "index less than zero");
    }
    if (ind[i] >= ncol) {
      stop(msg + "index > number of columns");
    }
    if (ind[i] == NA_INTEGER) {
      stop(msg + "no match found");
    }
  }
}

// returns a 0-based index
IntegerVector match_helper(SEXP x, CharacterVector names) {
  if (TYPEOF(x) == STRSXP or Rf_isFactor(x)) {
    return match( as<CharacterVector>(x), names ) - 1;
  } else {
    return as<IntegerVector>(x) - 1;
  }
}

// a concatenate helper macro
#define DO_CONCATENATE(CTYPE) { \
  memcpy( \
    (char*) dataptr(output) + i * nrow * sizeof(CTYPE), \
    (char*) dataptr(tmp), \
    nrow * sizeof(CTYPE) \
  ); \
  break; \
}

// Concatenate vectors for the 'value' column
// Note: we convert factors to characters if necessary
SEXP concatenate(const DataFrame& x, IntegerVector ind) {
  int nrow = x.nrows();
  int n_ind = ind.size();
  
  // We coerce up to the 'max type' if necessary
  int max_type = 0;
  int ctype = 0;
  for (int i=0; i < n_ind; ++i) {
    if (Rf_isFactor( x[ ind[i] ])) {
      ctype = STRSXP;
    } else {
      ctype = TYPEOF( x[ ind[i] ] );
    }
    max_type = ctype > max_type ? ctype : max_type;
  }
  
  debug( printf("Max type of value variables is %s\n", Rf_type2char(max_type) ));
  
  SEXP tmp;
  Shield<SEXP> output( Rf_allocVector(max_type, nrow * n_ind) );
  for (int i=0; i < n_ind; ++i) {
    
    // a 'tmp' pointer to the current column being iterated over, or 
    // a coerced version if necessary
    if (TYPEOF( x[ ind[i] ] ) == max_type) {
      tmp = PROTECT(x[ ind[i] ]);
    } else if (Rf_isFactor( x[ ind[i] ] )) {
      tmp = PROTECT(Rf_asCharacterFactor( x[ ind[i] ] ));
    } else {
      tmp = PROTECT(Rf_coerceVector( x[ ind[i] ], max_type ));
    }
    
    switch (max_type) {
    case INTSXP: DO_CONCATENATE(int);
    case REALSXP: DO_CONCATENATE(double);
    case LGLSXP: DO_CONCATENATE(int);
    case CPLXSXP: DO_CONCATENATE(Rcomplex);
    case STRSXP: {
      for (int j=0; j < nrow; ++j) {
        SET_STRING_ELT(output, i*nrow+j, STRING_ELT(tmp, j));
      }
      break;
    }
    }
    
    UNPROTECT(1);
    
  }
  
  return output;
    
}

// [[Rcpp::export]]
List melt_dataframe(const DataFrame& data,
                         SEXP id_vars_,
                         SEXP measure_vars_,
                         String variable_name,
                         String value_name) {
                           
  int nrow = data.nrows();
  int ncol = data.size();
  
  // we only melt data.frames that contain only atomic elements
  for (int i=0; i < ncol; ++i) {
    if (!Rf_isVectorAtomic( data[i] )) {
      stop("Can't melt data.frames with non-atomic columns");
    }
  }
  
  // if id_vars or measure_vars is character, we match it to the names of data
  CharacterVector data_names = as<CharacterVector>( data.attr("names") );
  
  IntegerVector id_ind;
  IntegerVector measure_ind;
  IntegerVector all_indices = seq(0, ncol-1);
  
  // if id_vars_ is NULL, we check and see if measure_vars_ was supplied
  if (Rf_isNull(id_vars_)) {
    
    if (Rf_isNull(measure_vars_)) {
      
      debug( Rprintf("Trying to guess id.vars, value.vars...\n") );
      
      // the id variables are the ones that are factors, characters, or logical
      std::vector<int> id_ind_tmp;
      for (int i=0; i < ncol; ++i) {
        if (Rf_isFactor( data[i] ) or
            TYPEOF( data[i] ) == STRSXP or
            TYPEOF( data[i] ) == LGLSXP) {
              debug( Rprintf("Adding variable at index %i\n", i) );
              id_ind_tmp.push_back(i);
            }
      }
      id_ind = as<IntegerVector>(wrap(id_ind_tmp));
      measure_ind = setdiff(all_indices, id_ind);
      
      // print a message for the user
      if (id_ind.size() > 0) {
        std::stringstream ss;
        ss << "Using ";
        for (int i=0; i < id_ind.size()-1; ++i) {
          ss << data_names[ id_ind[i] ] << ", ";
        }
        ss << data_names[ id_ind[ id_ind.size()-1 ] ] <<
          " as id variables";
        message(ss.str().c_str());
      } else {
        message("Using all variables as value vars");
      }
    } else {
      measure_ind = match_helper(measure_vars_, data_names);
      id_ind = setdiff( all_indices, measure_ind );
    }
    
  } else {
    
    id_ind = match_helper(id_vars_, data_names);
    
    if (Rf_isNull(measure_vars_)) {
      measure_ind = setdiff( all_indices, id_ind );
    } else {
      measure_ind = match_helper(measure_vars_, data_names);
    }
    
  }
  
  debug( 
    Rprintf("id_ind:\n");
    Rf_PrintValue(id_ind); 
  );
  
  debug(
    Rprintf("measure_ind:\n");
    Rf_PrintValue(measure_ind); 
  );
  
  check_indices(id_ind, data.size(), "Invalid id variable index: ");
  check_indices(measure_ind, data.size(), "Invalid measure variable index: ");
  
  // make sure there is no overlap
  if (intersect(id_ind, measure_ind).size() > 0) {
    stop("Overlapping indices for id.variables and measure.variables");
  }
  
  int n_id = id_ind.size();
  debug( Rprintf("n_id == %i\n", n_id) );
  
  int n_measure = measure_ind.size();
  debug( Rprintf("n_measure == %i\n", n_measure) );
  
  // The output should be a data.frame with:
  // number of columns == number of id vars + 'variable' + 'value',
  // with number of rows == data.nrow() * number of value vars
  List output = no_init(n_id + 2);
  
  // First, allocate the ID variables
  // we repeat each ID vector n_measure times
  
  // A define to handle the different possible types
  #define REP(RTYPE) \
  case RTYPE: { \
    output[i] = rep( as< Vector<RTYPE> >(data[ id_ind[i] ]), n_measure); \
    Rf_copyMostAttrib( data[ id_ind[i] ], output[i] ); \
    break; \
  } \
  
  for (int i=0; i < n_id; ++i) {
    switch( TYPEOF(data[id_ind[i]]) ) {
    REP(LGLSXP);
    REP(INTSXP);
    REP(REALSXP);
    REP(STRSXP);
    REP(CPLXSXP);
    default: {
      stop("Error: Unhandled vector type");
    }
    }
  }
  
  // Now, we assign the 'variable' and 'value' columns
  
  // 'variable' is made up of repeating the names of the 'measure' variables,
  // each nrow times. We want this to be a factor as well.
  CharacterVector id_names = no_init(n_measure);
  for (int i=0; i < n_measure; ++i) {
    id_names[i] = data_names[ measure_ind[i] ];
  }
  output[n_id] = as_factor( rep_each(id_names, nrow) );
  
  // 'value' is made by concatenating each of the 'value' variables
  
  // TODO: handle in a cleaner fashion
  SET_VECTOR_ELT(output, n_id + 1, concatenate(data, measure_ind));
  
  // Make the List more data.frame like
  output.attr("row.names") = seq(1, nrow * n_measure);
  
  CharacterVector out_names = no_init(n_id + 2);
  for (int i=0; i < n_id; ++i) {
    out_names[i] = data_names[ id_ind[i] ];
  }
  out_names[n_id] = variable_name;
  out_names[n_id+1] = value_name;
  output.attr("names") = out_names;
  
  output.attr("class") = "data.frame";
  
  return output;
  
}
