import Base.convert

## ------------------------------------------------------------------
# MetNet
convert(::Type{MetNet}, net::MetNet) = net

## ------------------------------------------------------------------
# COBREXA
function convert(::Type{MetNet}, cobxa_model::COBREXA.MetabolicModel)
    net = Dict()
    net[:S] = COBREXA.stoichiometry(cobxa_model)
    net[:b] = COBREXA.balance(cobxa_model)
    net[:lb], net[:ub] = COBREXA.bounds(cobxa_model)
    net[:c] = COBREXA.objective(cobxa_model)
    net[:rxns] = COBREXA.reactions(cobxa_model)
    net[:mets] = COBREXA.metabolites(cobxa_model)

    net[:metNames] = COBREXA.metabolite_name.([cobxa_model], COBREXA.metabolites(cobxa_model))
    net[:rxnNames] = COBREXA.reaction_name.([cobxa_model], COBREXA.reactions(cobxa_model))
    net[:metFormulas] = COBREXA.metabolite_formula.([cobxa_model], COBREXA.metabolites(cobxa_model))
    net[:genes] = COBREXA.genes(cobxa_model)
    # net[:grRules] = COBREXA.reaction_gene_association.([cobxa_model], COBREXA.reactions(cobxa_model))
    net[:subSystems] = COBREXA.reaction_subsystem.([cobxa_model], COBREXA.reactions(cobxa_model))

    return MetNet(;net...)
end

# lep interface
convert(::Type{COBREXA.CoreModel}, lep::LEPModel) = COBREXA.CoreModel(
    isnothing(lep.S) ? Float64[;;] : lep.S,
    isnothing(lep.b) ? Float64[] : lep.b,
    isnothing(lep.c) ? Float64[] : lep.c,
    isnothing(lep.lb) ? Float64[] : lep.lb,
    isnothing(lep.ub) ? Float64[] : lep.ub,
    isnothing(lep.colids) ? String[] : lep.colids,
    isnothing(lep.rowids) ? String[] : lep.rowids,
)

# net interface
# TODO: add convert for Standard Models (Add more info, like subSystems, stc)
convert(::Type{COBREXA.CoreModel}, model) = convert(COBREXA.CoreModel, lepmodel(model))
