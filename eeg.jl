using CSV, DataFrames, StatsPlots, Plots

# Read data, treating "NA" as missing, then remove missing
myData = CSV.File("EEG.machinelearing_data_BRMH.csv", missingstrings=["NA"]) |> DataFrame
dropmissing!(myData, [:IQ, :education])

# Get the unique levels of main.disorder and clean up the names
main_disorders = unique(myData[!, "main.disorder"])
main_disorders_clean = replace.(main_disorders, "." => " ")

# Create the violin plot
plt = plot(figsize=(14, 10))
for (i, disorder) in enumerate(main_disorders)
    violin!(plt, myData[myData[!, "main.disorder"] .== disorder, :IQ], 
           label=main_disorders_clean[i], color=i)
end
xlabel!(plt, "Main Disorder")
ylabel!(plt, "IQ")
title!(plt, "IQ Distributions by Main Disorder", fontsize=16)

# Add legend with disorder names and colors
plot!(legend=:topright, legendtitle="Main Disorder", legendfontsize=12, legendtitlefontsize=14, 
      framealpha=0.5)
