using CSV
using DataFrames

myData= CSV.File("EEG.machinelearing_data_BRMH.csv") |> DataFrame
