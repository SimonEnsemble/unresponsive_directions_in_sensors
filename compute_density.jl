using Xtals
set_path_to_crystals(joinpath(pwd(), "data", "xtals"))

mof_to_cif = Dict(
    "HKUST-1" => "FIQCEN_clean.cif",
    "Co-MOF-74" => "ORIWAP_clean.cif"
)

for mof in keys(mof_to_cif)
    xtal = Crystal(mof_to_cif[mof])
    strip_numbers_from_atom_labels!(xtal)
    println("density of ", mof, " = ", crystal_density(xtal))
end
