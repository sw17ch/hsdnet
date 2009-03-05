{-# LANGUAGE ForeignFunctionInterface #-}

module Network.DNet.Ethernet.Base where

#include "dnet.h"

ethAddrLen :: Int
ethAddrLen = #const ETH_ADDR_LEN

ethAddrBits :: Int
ethAddrBits = #const ETH_ADDR_BITS

ethTypeLen :: Int
ethTypeLen = #const ETH_TYPE_LEN

ethCrcLen :: Int
ethCrcLen = #const ETH_CRC_LEN

ethHdrLen :: Int
ethHdrLen = #const ETH_HDR_LEN

ethMTU :: Int
ethMTU = #const ETH_MTU

ethMin :: Int
ethMin = #const ETH_MIN

-- typedef struct eth_addr

data EthType = PUP
             | IP
             | ARP
             | REVARP
             | IEEE8021Q
             | IPV6
             | MPLS
             | MPLS_MCAST
             | PPPOEDISC
             | PPPOE
             | LOOPBACK
    deriving (Read,Show)

instance Enum EthType where
    toEnum #{const ETH_TYPE_PUP} = PUP
    toEnum #{const ETH_TYPE_IP} = IP
    toEnum #{const ETH_TYPE_ARP} = ARP
    toEnum #{const ETH_TYPE_REVARP} = REVARP
    toEnum #{const ETH_TYPE_8021Q} = IEEE8021Q
    toEnum #{const ETH_TYPE_IPV6} = IPV6
    toEnum #{const ETH_TYPE_MPLS} = MPLS
    toEnum #{const ETH_TYPE_MPLS_MCAST} = MPLS_MCAST
    toEnum #{const ETH_TYPE_PPPOEDISC} = PPPOEDISC
    toEnum #{const ETH_TYPE_PPPOE} = PPPOE
    toEnum #{const ETH_TYPE_LOOPBACK} = LOOPBACK
    toEnum _ = error "No corresponding EthType."

    fromEnum PUP = #{const ETH_TYPE_PUP}
    fromEnum IP = #{const ETH_TYPE_IP}
    fromEnum ARP = #{const ETH_TYPE_ARP}
    fromEnum REVARP = #{const ETH_TYPE_REVARP}
    fromEnum IEEE8021Q = #{const ETH_TYPE_8021Q}
    fromEnum IPV6 = #{const ETH_TYPE_IPV6}
    fromEnum MPLS = #{const ETH_TYPE_MPLS}
    fromEnum MPLS_MCAST = #{const ETH_TYPE_MPLS_MCAST}
    fromEnum PPPOEDISC = #{const ETH_TYPE_PPPOEDISC}
    fromEnum PPPOE = #{const ETH_TYPE_PPPOE}
    fromEnum LOOPBACK = #{const ETH_TYPE_LOOPBACK}

-- ETH_IS_MULTICAST

-- ETH_ADDR_BROADCAST

-- eth_pack_hdr

-- typedef struct eth_handle eth_t;

-- fundecls
