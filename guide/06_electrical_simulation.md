# 06. Electrical Simulation & Extraction

## SDevice Bias Conditions

| Parameter | Value |
|---|---:|
| Gate work function | 4.6 eV |
| Linear drain bias | 0.05 V |
| Saturation drain bias | 1.0 V |
| Gate sweep stop | 2.0 V |

Mobility includes PhuMob, HighFieldSaturation, and Enormal terms. SRH recombination uses doping dependence.

## SVisual Extraction

The provided script extracts or records:

- threshold voltage using `ExtractVtgm` with fallback logic
- subthreshold swing
- maximum/minimum drain current
- DIBL from Vt at `Vd = 0.05 V` and `1.0 V`
- Ion/Ioff ratio

The report does not present final numeric values for every extracted variable, so only explicitly reported numbers are summarized in `results/final_results.csv`.
