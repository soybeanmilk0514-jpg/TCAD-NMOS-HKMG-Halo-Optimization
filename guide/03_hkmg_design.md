# 03. HKMG Design

## Gate Stack

The SProcess source forms the gate dielectric/electrode stack as:

1. thin Oxide interfacial layer (`IL_tox`)
2. HfO₂ high-k layer (`HK_tox`)
3. TiN gate electrode
4. PolySilicon layer used in the process definition

Default code parameters shown in the source PDF are `IL_tox = 0.0006`, `HK_tox = 0.0020`, and `HK_mat = HfO2`.

## HKMG-only Result

The submitted presentation reports that HKMG alone produced severe punch-through through the substrate region. The transistor lost useful switching behavior:

- `Ion/Ioff = 0.89`
- SS could not be extracted from the Id–Vg curve because of severe leakage.

This result motivated adding Halo Doping instead of interpreting high-k introduction alone as sufficient for SCE suppression.
