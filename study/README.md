# Study Notes

## Why HKMG?

The project introduces an HfO₂-based high-k gate dielectric to retain stronger gate capacitance while using a physically thicker dielectric stack than an aggressively scaled SiO₂-only gate oxide.

## Why Halo Doping?

In the submitted project flow, HKMG alone did not sufficiently suppress the deep leakage path. Boron halo implantation was therefore added near the source/drain-side gate edges to raise the local channel barrier and reduce punch-through/SCE.

## Why Four Rotations?

The SProcess code applies the same Boron halo implant at 0°, 90°, 180°, and 270° rotation, producing a symmetric pocket-engineering step in the 2-D process setup.

## Why a Spacer?

The nitride spacer separates the shallow extension implant from the later deep Source/Drain implant. In this project it is part of the implemented process flow, but the submitted result deck does not show an independent spacer-thickness optimization.
