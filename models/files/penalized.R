modelInfo <- list(label = "Penalized Linear Regression",
                  library = "penalized",
                  type = c('Regression'),
                  parameters = data.frame(parameter = c('lambda1', 'lambda2'),
                                          class = c('numeric', 'numeric'),
                                          label = c('L1 Penalty', 'L2 Penalty')),
                  grid = function(x, y, len = NULL) 
                    expand.grid(lambda1 = 2^((1:len) -1),
                                lambda2 = 2^((1:len) -1)),
                  loop = NULL,
                  fit = function(x, y, wts, param, lev, last, classProbs, ...) {
                    penalized(y, x,
                              model = "linear",
                              lambda1 = param$lambda1,
                              lambda2 = param$lambda2,
                              ...) 
                  },
                  predict = function(modelFit, newdata, submodels = NULL) {
                    out <- predict(modelFit, newdata)
                    out <- if(is.vector(out)) out["mu"] else out[,"mu"]
                    out
                  },
                  prob = NULL,
                  predictors = function(x, ...) {
                    out <- coef(x, "all")
                    out <- names(out)[out != 0]
                    out[out != "(Intercept)"]
                  },
                  tags = c("Implicit Feature Selection", 
                           "L1 Regularization", "L2 Regularization",
                           "Linear Regression"),
                  sort = function(x) x[order(x$lambda1, x$lambda2),])
