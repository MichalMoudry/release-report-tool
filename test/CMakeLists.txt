function(ReleaseReportToolTests op)
  add_test(
    NAME ${op}
    COMMAND rrt ${op}
  )
endfunction()
