# 60 nm NMOS SCE Suppression with HKMG and Halo Doping

## Overview

이 프로젝트는 60 nm NMOS에서 나타나는 short-channel effect와 off-state leakage를 줄이기 위해 **HKMG → Halo Doping 최적화** 순서로 구조를 개선한 Sentaurus TCAD 프로젝트입니다.

Baseline에서는 drain-side electric-field 영향으로 leakage가 커지는 문제를 확인했고, HfO₂ 기반 high-k gate stack을 먼저 적용했습니다. 그러나 HKMG 단독 구조에서는 punch-through가 심해 switching 특성이 유지되지 않았고, 이를 보완하기 위해 gate edge 아래에 P-pocket을 형성하는 Halo Doping을 추가했습니다.

![Optimization flow](./figures/project-flow.svg)

## Final Condition

| Parameter | Selected value |
|---|---:|
| Gate length | 60 nm |
| High-k | HfO₂ |
| Halo Dose | `2e13 cm^-2` |
| Halo Energy | `20 keV` |
| Halo Tilt | `25°` |
| Halo dopant | Boron |
| LDD dopant | Arsenic |
| Sidewall spacer | Nitride |

## Key Electrical Results

| Metric | Reported result |
|---|---:|
| Ioff | `1.465e-15 A/µm` |
| Ion/Ioff | `1.41e12` |
| SS | `68–69 mV/dec` |
| HKMG-only Ion/Ioff | `0.89` |

The report does not provide a complete numeric baseline-vs-final table for every extracted metric. Therefore this repository does not invent a percentage improvement for Ion, DIBL, or Vth.

## Optimization Logic

### 1. Baseline

- `Lg = 60 nm`
- `NWell = 1e15 cm^-3`
- `Tox = 0.0026` in the report parameter convention
- `LDD dose = 5e13 cm^-2`
- `LDD energy = 10 keV`

### 2. HKMG

A thin interfacial oxide and HfO₂ high-k layer were introduced with a TiN gate. HKMG alone did not solve the leakage problem; the report records an Ion/Ioff ratio of only `0.89` and states that SS could not be extracted because of severe leakage.

### 3. Halo Doping

Halo implantation was then split by Dose, Energy, and Tilt. The selected condition was:

`Dose = 2e13 cm^-2`, `Energy = 20 keV`, `Tilt = 25°`.

The project interpreted this condition as a balance between stronger electrostatic control and avoiding excessive channel doping that can degrade carrier transport.

### 4. Spacer / S-D Formation

A nitride sidewall spacer was formed before deep Arsenic Source/Drain implantation. Spacer formation is part of the implemented process flow, but the submitted result deck does not show a dedicated spacer-width optimization sweep.

## Simulation & Extraction

SDevice performs Id–Vg sweeps at `Vd = 0.05 V` and `1.0 V`. SVisual extracts Vt, SS, DIBL, and Ion/Ioff from the simulated curves.

See [Project Navigation](./guide/00_navigation.md) for the full documentation path.
