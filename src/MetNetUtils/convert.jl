import Base.convert

## ------------------------------------------------------------------
# MetNet
Base.convert(::Type{MetNet}, net::MetNet) = net

## ------------------------------------------------------------------
function Base.convert(::Type{MetNet}, cobxa_model::COBREXA.A.AbstractFBCModel)

    net = Dict()
    net[:S] = COBREXA.A.stoichiometry(cobxa_model)
    net[:b] = COBREXA.A.balance(cobxa_model)
    net[:lb], net[:ub] = COBREXA.A.bounds(cobxa_model)
    net[:c] = COBREXA.A.objective(cobxa_model)
    net[:rxns] = COBREXA.A.reactions(cobxa_model)
    net[:mets] = COBREXA.A.metabolites(cobxa_model)

    net[:metNames] = COBREXA.A.metabolite_name.(Ref(cobxa_model), COBREXA.A.metabolites(cobxa_model))
    net[:rxnNames] = COBREXA.A.reaction_name.(Ref(cobxa_model), COBREXA.A.reactions(cobxa_model))
    net[:metFormulas] = COBREXA.A.metabolite_formula.(Ref(cobxa_model), COBREXA.A.metabolites(cobxa_model))
    net[:genes] = COBREXA.A.genes(cobxa_model)
    # net[:grRules] = COBREXA.A.reaction_gene_association.(Ref(cobxa_model), COBREXA.A.reactions(cobxa_model))
    # TODO: Up to COBREXA 2
    # net[:subSystems] = COBREXA.A.reaction_subsystem.(Ref(cobxa_model), COBREXA.A.reactions(cobxa_model))

    return MetNet(;net...)
end

# lep interface
# TODO: Up to COBREXA 2
Base.convert(::Type{COBREXA.A.AbstractFBCModel}, lep::LEPModel) = error("No implemented")

# Base.convert(::Type{COBREXA.CoreModel}, lep::LEPModel) = COBREXA.CoreModel(
#     isnothing(lep.S) ? Float64[;;] : lep.S,
#     isnothing(lep.b) ? Float64[] : lep.b,
#     isnothing(lep.c) ? Float64[] : lep.c,
#     isnothing(lep.lb) ? Float64[] : lep.lb,
#     isnothing(lep.ub) ? Float64[] : lep.ub,
#     isnothing(lep.colids) ? String[] : lep.colids,
#     isnothing(lep.rowids) ? String[] : lep.rowids,
# )

# net interface
# TODO: Up to COBREXA 2
# TODO: add convert for Standard Models (Add more info, like subSystems, stc)
# Base.convert(::Type{COBREXA.CoreModel}, model) = convert(COBREXA.CoreModel, lepmodel(model))
