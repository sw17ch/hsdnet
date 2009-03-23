{-# LANGUAGE ForeignFunctionInterface, RecordWildCards #-}

module Network.DNet.ARP.Base (
    arpHdrLen,
    arpEthIpLen,
    arpHrdEth,
    arpHrdIEEE802,
    arpProIp,
    ArpEntry(..),
    ArpHandle,
    arpOpen,
) where

import Control.Monad

import Data.Word
import Foreign.Storable
import Foreign.ForeignPtr
import Foreign.C.String
import Foreign.Ptr
import Foreign.Marshal.Utils

import Network.DNet.Ethernet.Base
import Network.DNet.IP.Base
import Network.DNet.Addressing.Base

#include "dnet.h"
#include "arp_base.h"

arpHdrLen :: Int
arpHdrLen = #const ARP_HDR_LEN

arpEthIpLen :: Int
arpEthIpLen = #const ARP_ETHIP_LEN


data ArpHdr = ArpHdr {
    hrd :: Word16, -- format of hardware address
    pro :: Word16, -- format of protocol address
    hln :: Word8,  -- length of hardware address (ETH_ADDR_LEN)
    pln :: Word8,  -- length of protocol address (IP_ADDR_LEN)
    op  :: Word16  -- operation
} deriving (Show)

instance Storable ArpHdr where
    sizeOf _ = #{size struct arp_hdr}
    alignment _ = #{const __alignof__(struct arp_hdr)}
    peek ptr = do
        hrd' <- (#peek struct arp_hdr, ar_hrd) ptr
        pro' <- (#peek struct arp_hdr, ar_pro) ptr
        hln' <- (#peek struct arp_hdr, ar_hln) ptr
        pln' <- (#peek struct arp_hdr, ar_pln) ptr
        op'  <- (#peek struct arp_hdr, ar_op ) ptr
        return $ ArpHdr { hrd = hrd', pro = pro', hln = hln', pln = pln', op = op' }
    poke ptr ah = do
        (#poke struct arp_hdr, ar_hrd) ptr (hrd ah)
        (#poke struct arp_hdr, ar_pro) ptr (pro ah)
        (#poke struct arp_hdr, ar_hln) ptr (hln ah)
        (#poke struct arp_hdr, ar_pln) ptr (pln ah)
        (#poke struct arp_hdr, ar_op ) ptr (op  ah)

arpHrdEth :: Int
arpHrdEth = #const ARP_HRD_ETH

arpHrdIEEE802 :: Int
arpHrdIEEE802 = #const ARP_HRD_IEEE802

arpProIp :: Int
arpProIp = #const ARP_PRO_IP

data ArpOperation = REQUEST
                  | REPLY
                  | REVREQUEST
                  | REVREPLY
    deriving (Show)

instance Enum ArpOperation where
    toEnum #{const ARP_OP_REQUEST} = REQUEST
    toEnum #{const ARP_OP_REPLY} = REPLY
    toEnum #{const ARP_OP_REVREQUEST} = REVREQUEST
    toEnum #{const ARP_OP_REVREPLY} = REVREPLY
    toEnum _ = error "No corresponding ArpOperation"

    fromEnum REQUEST = #{const ARP_OP_REQUEST}
    fromEnum REPLY = #{const ARP_OP_REPLY}
    fromEnum REVREQUEST = #{const ARP_OP_REVREQUEST}
    fromEnum REVREPLY = #{const ARP_OP_REVREPLY}

newtype SndHrdAddr = SndHrdAddr { unSHA :: ForeignPtr () }
    deriving (Show)

newtype SndPrtAddr = SndPrtAddr { unSPA :: ForeignPtr () }
    deriving (Show)

newtype TrgHrdAddr = TrgHrdAddr { unTHA :: ForeignPtr () }
    deriving (Show)

newtype TrgPrtAddr = TrgPrtAddr { unTPA :: ForeignPtr () }
    deriving (Show)

data ArpEthIP = ArpEthIP {
    sha :: SndHrdAddr,
    spa :: SndPrtAddr,
    tha :: TrgHrdAddr,
    tpa :: TrgPrtAddr
} deriving (Show)

instance Storable ArpEthIP where
    sizeOf _    = #{size struct arp_ethip}
    alignment _ = #{const __alignof__(struct arp_hdr)}
    peek ptr = do
        sha' <- mallocForeignPtrBytes ethAddrLen
        spa' <- mallocForeignPtrBytes ipAddrLen
        tha' <- mallocForeignPtrBytes ethAddrLen
        tpa' <- mallocForeignPtrBytes ipAddrLen

        let cpyEth d s = copyBytes d s ethAddrLen
            cpyIp  d s = copyBytes d s ipAddrLen

        withForeignPtr sha' $ \p -> cpyEth p $ (#ptr struct arp_ethip, ar_sha) ptr
        withForeignPtr spa' $ \p -> cpyIp  p $ (#ptr struct arp_ethip, ar_spa) ptr
        withForeignPtr tha' $ \p -> cpyEth p $ (#ptr struct arp_ethip, ar_tha) ptr
        withForeignPtr tpa' $ \p -> cpyIp  p $ (#ptr struct arp_ethip, ar_tpa) ptr

        return $ ArpEthIP { sha = SndHrdAddr sha', spa = SndPrtAddr spa',
                            tha = TrgHrdAddr tha', tpa = TrgPrtAddr tpa' }

data ArpEntry = ArpEntry {
    pa :: Address,
    ha :: Address
} deriving (Show)

-- void arp_pack_hdr_ethip_wrapper(struct arp_hdr * hdr,
--                                 uint16_t op,
--                                 uint8_t * sha,
--                                 uint8_t * spa,
--                                 uint8_t * tha,
--                                 uint8_t * tpa);
foreign import ccall "base.h arp_pack_hdr_ethip_wrapper"
    arpPackHdrEthIp :: (Ptr ArpHdr) -- | The arp/ip header to pack
                    -> Word16       -- | Operation
                    -> CString      -- | Sender hardware address
                    -> CString      -- | Sender protocol address
                    -> CString      -- | Target hardware address
                    -> CString      -- | Target protocol address
                    -> IO ()

newtype ArpHandle = ArpHandle (Ptr ArpHandle)

-- TODO: Need arp_handler callback

foreign import ccall "dnet.h arp_open"
    arpOpen_FFI :: IO (Ptr ArpHandle)

arpOpen :: IO ArpHandle
arpOpen = liftM ArpHandle arpOpen_FFI
