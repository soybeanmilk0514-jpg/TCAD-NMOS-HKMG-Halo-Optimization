# 02. Baseline & Short-Channel Effect

## Baseline

| Parameter | Value |
|---|---:|
| Gate length | 60 nm |
| NWell / background parameter | `1e15` |
| Tox | `0.0026` |
| LDD dose | `5e13 cm^-2` |
| LDD energy | `10 keV` |
| Spacer width in reference slide | `0.05` |

The presentation identifies an increase in off-state current at 60 nm and attributes the behavior to DIBL/SCE.

## Interpretation Used in This Repository

The baseline is used as the starting structure for evaluating electrostatic-control improvements. Because the submitted deck does not provide a full numeric baseline table for Vth, DIBL, SS, Ion, and Ioff, this repository does not fabricate exact baseline improvement percentages.
