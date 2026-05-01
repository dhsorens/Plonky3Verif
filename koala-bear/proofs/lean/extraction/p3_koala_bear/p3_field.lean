import Hax

class p3_field.field.PrimeCharacteristicRing.AssociatedTypes (R : Type) where

class p3_field.field.PrimeCharacteristicRing (R : Type)
  [associatedTypes : outParam
    (p3_field.field.PrimeCharacteristicRing.AssociatedTypes R)]
  where
  double (R) (val : R) : RustM R

-- copied from p3_field
namespace p3_field.field

class Algebra.AssociatedTypes (Self : Type) (F : Type) where

class Algebra (Self : Type) (F : Type)
  [associatedTypes : outParam (Algebra.AssociatedTypes (Self : Type) (F : Type))]
  where

end p3_field.field

namespace p3_field.exponentiation

-- copied from p3_field
def exp_1420470955
    (R : Type)
    [trait_constr_exp_1420470955_associated_type_i0 :
      p3_field.field.PrimeCharacteristicRing.AssociatedTypes
      R]
    [trait_constr_exp_1420470955_i0 : p3_field.field.PrimeCharacteristicRing R ]
    (val : R) :
    RustM R := pure val

end p3_field.exponentiation
