import p3_koala_bear
import CompPoly.Fields.KoalaBear

/-!
Minimal field specification: relate Plonky3/Hax extraction constants
(`p3_koala_bear.koala_bear`) to the mathematical Koala Bear prime and
two-adic parameters in `CompPoly.Fields.KoalaBear`.
-/

open p3_koala_bear.koala_bear
open p3_monty_31.data_traits

/-- The Monty instance's `PRIME` bitpattern is exactly `KoalaBear.fieldSize`. -/
theorem monty_prime_eq_fieldSize :
    (MontyParameters.PRIME KoalaBearParameters).toNat = KoalaBear.fieldSize := by
  simp [KoalaBear.fieldSize, MontyParameters.PRIME]

/-- Two-adicity declared for FFT / NTT matches `KoalaBear.twoAdicity` (24). -/
theorem two_adicity_eq_spec :
    (TwoAdicData.TWO_ADICITY KoalaBearParameters).toNat = KoalaBear.twoAdicity := by
  simp [KoalaBear.twoAdicity, TwoAdicData.TWO_ADICITY]

/-- Montgomery representation uses 32-bit limbs (Plonky3 `MontyField31`). -/
theorem monty_bits_eq_thirtyTwo :
    (MontyParameters.MONTY_BITS KoalaBearParameters).toNat = 32 := by
  simp [MontyParameters.MONTY_BITS]

/-- The cube map is a unit-group automorphism: `gcd(3, p − 1) = 1`
(Poseidon / `RelativelyPrimePower` layer). -/
theorem coprime_three_pred_prime :
    Nat.Coprime 3 ((MontyParameters.PRIME KoalaBearParameters).toNat - 1) := by
  simp [MontyParameters.PRIME]
  lia

/-- Factorization of `p − 1` into `2^twoAdicity · 127` (additive FFT domain size). -/
theorem fieldSize_sub_one_factorization' :
    (MontyParameters.PRIME KoalaBearParameters).toNat - 1 =
      2 ^ (TwoAdicData.TWO_ADICITY KoalaBearParameters).toNat * 127 := by
  simp [MontyParameters.PRIME, TwoAdicData.TWO_ADICITY]
