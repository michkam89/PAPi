library(testthat)
context("test append_proteins function")

test_that(
  "function stops when input is not a character vector", 
  {
    test_input <- c(1, 2, 3)
    expect_error(append_proteins(test_input), 
                 "input is not a character vector")
})

test_that(
  "function stops when file does not contain any cluster name starting with '>'", 
  {
    test_input <- c("cluster1", "proteinA", "proteinB", ">cluster2", "proteinC")
    expect_error(
      append_proteins(test_input), 
      paste("first element is not a cluster name as does not contain '>' as first character",
            "lines with clusters should contain '>' as a first character in each row"))
})

test_that(
  "function doesn't stop when file contain at least one cluster name starting with '>'", 
  {
    test_input <- c(">cluster1", "proteinA", "proteinB", "cluster2", "proteinC")
    
    output <- append_proteins(test_input)
    
    expect_true(!is.null(output))
  })

test_that(
  "function produces desired output when one cluster identified", 
  {
    test_input <- c(">cluster1", "proteinA", "proteinB", "cluster2", "proteinC")
    
    output <- append_proteins(test_input)
    
    ref_output <- c("proteinA", "proteinB", "cluster2", "proteinC")
    
    expect_identical(output, ref_output)
  })

test_that(
  "output contains only data for first cluster analysed when two clusters identified", 
  {
    test_input <- c(">cluster1", "proteinA", "proteinB", ">cluster2", "proteinC")
    
    output <- append_proteins(test_input)
    
    ref_output <- c("proteinA", "proteinB")
    
    expect_identical(output, ref_output)
  })
