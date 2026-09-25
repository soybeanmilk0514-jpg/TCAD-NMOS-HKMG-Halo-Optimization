# 08. Limitations & Next Steps

## Source Consistency

The two submitted PDFs contain a few parameter-presentation inconsistencies:

1. The overview slide lists Halo Energy split values as `10 / 15 / 20`, while the dedicated energy-analysis slide visually labels `10 / 20 / 30`. Both identify `20 keV` as the selected condition.
2. The presentation code appendix shows a default `Halo_tilt` value of `22`, while the dedicated code PDF and final-condition slide use `25°`. This repository uses `25°` for the final selected condition and preserves the dedicated code-PDF source separately.
3. The SProcess header contains parameter defaults that can differ from the final Workbench split selection. Final performance claims therefore follow the final-condition/result slides rather than assuming header defaults equal the selected optimum.

## Interpretation Limits

- A complete baseline-vs-final numeric table for Ion, Ioff, SS, Vth, and DIBL is not provided in the presentation.
- No percentage improvement is reported unless directly calculable from explicit source numbers.
- Halo optimization is a discrete parameter split, not proof of a global optimum.
- Spacer is implemented but not independently optimized in the submitted result deck.
- Simulation results are TCAD outputs, not measured silicon data.

## Next Steps

If the original Sentaurus Workbench project is recovered, the repository can be expanded with raw `.tdr/.plt` outputs, a reproducible parameter sweep table, and baseline-to-final quantitative comparisons using the same extraction script.
