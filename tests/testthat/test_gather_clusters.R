library(testthat)
context("test gather_clusters function")

test_that(
  "function stops when input is not a character vector", 
  {
    test_input <- c(1, 2, 3)
    expect_error(gather_clusters(test_input), 
                 "input is not a character vector")
})

test_that(
  "function stops when file does not contain any cluster name starting with '>'", 
  {
    test_input <- c("cluster1", "proteinA", "proteinB", "cluster2", "proteinC")
    expect_error(
      gather_clusters(test_input), 
      paste("input doesn't seem to contain any cluster",
            "lines with clusters should contain '>' as a first character in each row"))
})

test_that(
  "function doesn't stop when file contain at least one cluster name starting with '>'", 
  {
    test_input <- c(">cluster1", "proteinA", "proteinB", "cluster2", "proteinC")
    
    output <- gather_clusters(test_input)
    
    expect_true(!is.null(output))
  })

test_that(
  "function produces desired output when one cluster identified", 
  {
    test_input <- c(">cluster1", "proteinA", "proteinB", "cluster2", "proteinC")
    
    output <- gather_clusters(test_input)
    
    ref_output <- list(
      `>cluster1` = c("proteinA", "proteinB", "cluster2", "proteinC")
    )
    expect_identical(output, ref_output)
  })

test_that(
  "function produces desired output when two clusters identified", 
  {
    test_input <- c(">cluster1", "proteinA", "proteinB", ">cluster2", "proteinC")
    
    output <- gather_clusters(test_input)
    
    ref_output <- list(
      `>cluster1` = c("proteinA", "proteinB"),
      `>cluster2` = "proteinC")
    
    expect_identical(output, ref_output)
  })

test_that(
  "function skips proteins without preceeding cluster name", 
  {
    test_input <- c("proteinA", "proteinB", ">cluster2", "proteinC")
    
    output <- gather_clusters(test_input)
    
    ref_output <- list(
      `>cluster2` = "proteinC")
    
    expect_identical(output, ref_output)
  })
