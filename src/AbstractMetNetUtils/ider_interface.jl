# -------------------------------------------------------------------
# ider interface
export metindex
metindex(model, ider) = _getindex(model, metabolites, ider)

export rxnindex
rxnindex(model, ider) = _getindex(model, reactions, ider)

export geneindex
geneindex(model, ider) = _getindex(model, genes, ider)