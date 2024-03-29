module 
    MonadBad 
        where

import Test.QuickCheck
import Test.QuickCheck.Checkers 
import Test.QuickCheck.Classes

data CountMe a = 
    CountMe Integer a 
    deriving (Eq, Show)

instance Functor CountMe 
    where
        fmap f (CountMe i a) = CountMe (i + 1) (f a)

instance Applicative CountMe 
    where
        pure = CountMe 0
        CountMe i f <*> CountMe i' a = CountMe (i + i') (f a)

instance Monad CountMe 
    where 
        return = pure
        CountMe n a >>= f = 
            let CountMe _ b = f a 
            in CountMe (n + 1) b

instance Arbitrary a => Arbitrary (CountMe a) 
    where 
        arbitrary = CountMe <$> arbitrary <*> arbitrary

instance Eq a => EqProp (CountMe a) 
    where (=-=) = eq

main = do
    let trigger = undefined :: CountMe (Int, String, Int) 
    quickBatch $ functor trigger
    quickBatch $ applicative trigger
    quickBatch $ monad trigger