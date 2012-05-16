# File util.r
#
# __author__ = "Dan Knights"
# __copyright__ = "Copyright 2011, The QIIME Project"
# __credits__ = ["Dan Knights"]
# __license__ = "GPL"
# __version__ = "1.4.0"
# __maintainer__ = "Dan Knights"
# __email__ = "daniel.knights@colorado.edu"
# __status__ = "Release"

# Hide warnings
"hide.warnings" <- function(hide=TRUE){
    if(hide) {
        sink(file('/dev/null',open='w'),type='message')
    } else {
        sink(NULL,type='message')
    }
}

# Get probability of mislabeling by several measures
# returns matrix of p(alleged), max(p(others)), p(alleged) - max(p(others))
"get.mislabel.scores" <- function(y,y.prob){
    result <- matrix(0,nrow=length(y),ncol=3)
    # get matrices containing only p(other classes), and containing only p(class)
    mm <- model.matrix(~0 + y)
    y.prob.other.max <- apply(y.prob * (1-mm),1,max)
    y.prob.alleged <- apply(y.prob * mm, 1, max)
    result <- cbind(y.prob.alleged, y.prob.other.max, y.prob.alleged - y.prob.other.max)
    rownames(result) <- rownames(y.prob)
    colnames(result) <- c('P(alleged label)','P(second best)','P(alleged label)-P(second best)')
    return(result)
}

"balanced.folds" <- function(y, nfolds=10){
    # Get balanced folds where each fold has close to overall class ratio
    folds = rep(0, length(y))
    classes = levels(y)
    # size of each class
    Nk = table(y)
    # -1 or nfolds = len(y) means leave-one-out
    if (nfolds == -1 || nfolds == length(y)){
        invisible(1:length(y))
    }
    else{
    # Can't have more folds than there are items per class
    nfolds = min(nfolds, max(Nk))
    # Assign folds evenly within each class, then shuffle within each class
        for (k in 1:length(classes)){
            ixs <- which(y==classes[k])
            folds_k <- rep(1:nfolds, ceiling(length(ixs) / nfolds))
            folds_k <- folds_k[1:length(ixs)]
            folds_k <- sample(folds_k)
            folds[ixs] = folds_k
        }
        invisible(folds)
    }
}


