{-# LANGUAGE CPP, ForeignFunctionInterface #-}

module Network.DNet.Addressing.Base where

import Foreign.ForeignPtr
import Foreign.Storable
import Foreign.Marshal.Utils

#include "dnet.h"
#include "addressing_base.h"

data AddressType = None
                 | Eth
                 | IP
                 | IP6
    deriving (Read,Show,Eq)

instance Enum AddressType where
    succ None = Eth
    succ Eth  = IP
    succ IP   = IP6
    succ IP6  = error "Nothing follows IP6."

    pred IP6  = IP
    pred IP   = Eth
    pred Eth  = None
    pred None = error "Nothing before None."

    fromEnum None = #{const ADDR_TYPE_NONE}
    fromEnum Eth  = #{const ADDR_TYPE_ETH}
    fromEnum IP   = #{const ADDR_TYPE_IP}
    fromEnum IP6  = #{const ADDR_TYPE_IP6}

    toEnum #{const ADDR_TYPE_NONE} = None
    toEnum #{const ADDR_TYPE_ETH}  = Eth
    toEnum #{const ADDR_TYPE_IP}   = IP
    toEnum #{const ADDR_TYPE_IP6}  = IP6
    toEnum _ = error "No corresponding AddressType."

data Address = Address {
    addr_type :: AddressType,
    addr_bits :: Int,
    addr_u    :: AddrU
} deriving (Show)

instance Storable Address where
    sizeOf _ = #{size struct addr}
    alignment _ = #{const __alignof__(struct addr)}
    peek ptr = do
        t' <- (#peek struct addr, addr_type) ptr
        b' <- (#peek struct addr, addr_bits) ptr
        u' <- (#peek struct addr, __addr_u)  ptr
        return $ Address { addr_type = toEnum t',
                           addr_bits = b',
                           addr_u    = u' }
    poke ptr a = do
        (#poke struct addr, addr_type) ptr (fromEnum $ addr_type a)
        (#poke struct addr, addr_bits) ptr (addr_bits a)
        (#poke struct addr, __addr_u ) ptr (addr_u    a)

newtype AddrU = AddrU (ForeignPtr AddrU)
    deriving (Show)

instance Storable AddrU where
    -- SIZEOF__ADDR_U and ALIGNOF__ADDR_U are found in
    -- addressing_base.h.
    sizeOf _ = (#const SIZEOF__ADDR_U)
    alignment _ = (#const ALIGNOF__ADDR_U)
    peek ptr = do
        u' <- mallocForeignPtrBytes (#const SIZEOF__ADDR_U)
        withForeignPtr u' $ \p ->
            copyBytes p ptr (#const SIZEOF__ADDR_U)
        return $ AddrU u'
    poke ptr (AddrU u) = do
        withForeignPtr u $ \p ->
            copyBytes ptr p (#const SIZEOF__ADDR_U)

