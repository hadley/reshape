testSuite <- defineTestSuite(
  name=paste("reshape unit tests"),
  testFileRegexp = "\\.runit$",
  dirs=path
)
tests <- runTestSuite(testSuite)
printTextProtocol(tests, showDetails=TRUE)

## Return stop() to cause R CMD check stop in case of
##  - failures i.e. FALSE to unit tests or
##  - errors i.e. R errors
tmp <- getErrors(tests)
if(tmp$nFail > 0 | tmp$nErr > 0) {
  stop(paste("\n\nunit testing failed (#test failures: ", tmp$nFail,
             ", #R errors: ",  tmp$nErr, ")\n\n", sep=""))
}
