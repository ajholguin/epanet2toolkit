#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************

context("get control")
test_that("no crash calling on closed toolkit",{
  expect_false( getOpenflag() )
  expect_error( x <- ENgetcontrol(1) ) 
})
test_that("works for single input (1)",{
  ENopen("Net3.inp","Net3.rpt")
  lidx <- 	ENgetcontrol(1)
  ENclose()
  expect_equal(lidx, list(ctype=2, lindex=118, setting=1, nindex=0, level=3600))
})
test_that("works for single input (2)",{
  ENopen("Net3.inp","Net3.rpt")
  lidx <- 	ENgetcontrol(5)
  ENclose()
  expect_equal(lidx, list(ctype=0, lindex=116, setting=0, nindex=95, level=17.1),
               tolerance=1e-7)
})
test_that("works for multiple input",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(lid <- ENgetcontrol(c(1,2,3)))
  ENclose()
})
test_that("get error 241 on no ID",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetcontrol(7),"241")
  ENclose()
})

context("set control")
test_that("no crash calling on closed toolkit",{
  expect_false( getOpenflag() )
  expect_error( ENsetcontrol(1, ctype=2, lindex=118, setting=1, nindex=0, level=5400) )
})
test_that("works on single input",{
  ENopen("Net3.inp","Net3.rpt")
  ENsetcontrol(1, ctype=2, lindex=118, setting=1, nindex=0, level=5400)		
  x <- ENgetcontrol(1)
  ENclose()
  expect_equal(x, list(ctype=2, lindex=118, setting=1, nindex=0, level=5400), tolerance = 1e-7)
})
test_that("error on multiple indexes",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENsetcontrol(c(1,2), ctype=2, lindex=118, setting=1, nindex=0, level=5400))
  ENclose()
})
test_that("get error on wrong control",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENsetcontrol(7,1,116,1,95,21.5))
  ENclose()
})