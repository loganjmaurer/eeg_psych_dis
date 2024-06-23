using CSV, DataFrames, StatsPlots, Plots

# Read data, treating "NA" as missing, then remove missing
myData = CSV.File("EEG.machinelearing_data_BRMH.csv", missingstrings=["NA"]) |> DataFrame
dropmissing!(myData, [:IQ, :education])

# Get the unique levels of main.disorder
main_disorders = unique(myData[!, "main.disorder"])

# Create the violin plot
plt = plot(figsize=(12, 8), palette=:auto)
violin!(plt, [myData[myData[!, "main.disorder"] .== disorder, :IQ] for disorder in main_disorders], 
       label=nothing)
xlabel!(plt, "Main Disorder")
ylabel!(plt, "IQ")
title!(plt, "IQ Distributions by Main Disorder")
plot!(legend=main_disorders, title="Main Disorder", legendposition=:outertop)
