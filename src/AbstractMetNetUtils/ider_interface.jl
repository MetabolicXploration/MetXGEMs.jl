# -------------------------------------------------------------------
# ider interface
hasmetid(model, ider) = _hasid(model, metabolites, ider)
metindex(model, ider) = _getindex(model, metabolites, ider)

hasrxnid(model, ider) = _hasid(model, reactions, ider)
rxnindex(model, ider) = _getindex(model, reactions, ider)

hasgeneid(model, ider) = _hasid(model, genes, ider)
geneindex(model, ider) = _getindex(model, genes, ider)