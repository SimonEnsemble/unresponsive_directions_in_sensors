using Xtals
set_path_to_crystals(pwd())

mof_to_cif = Dict(
    "Mg-MOF-74" => "VOGTIV_clean_h.cif",
    "HKUST-1" => "FIQCEN_clean.cif"
)

for mof in ["Mg-MOF-74", "HKUST-1"]
    xtal = Crystal(mof_to_cif[mof])
    strip_numbers_from_atom_labels!(xtal)
    println("density of ", mof, " = ", crystal_density(xtal))
end
