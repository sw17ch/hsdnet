#include "/usr/lib64/ghc-6.10.1/hsc2hs-0.67/template-hsc.h"
#line 5 "Base.hsc"
#include "dnet.h"

int main (int argc, char *argv [])
{
#if __GLASGOW_HASKELL__ && __GLASGOW_HASKELL__ < 409
    printf ("{-# OPTIONS -optc-D__GLASGOW_HASKELL__=%d #-}\n", __GLASGOW_HASKELL__);
#endif
#if __GLASGOW_HASKELL__ && __GLASGOW_HASKELL__ < 603
    printf ("{-# OPTIONS -#include %s #-}\n", "\"dnet.h\"");
#else
    printf ("{-# INCLUDE %s #-}\n", "\"dnet.h\"");
#endif
    hsc_line (1, "Base.hsc");
    fputs ("module Network.DNet.Ethernet.Base where\n"
           "", stdout);
    hsc_line (2, "Base.hsc");
    fputs ("\n"
           "import Data.Word\n"
           "\n"
           "", stdout);
    fputs ("\n"
           "", stdout);
    hsc_line (6, "Base.hsc");
    fputs ("\n"
           "ethAddrLen :: Int\n"
           "ethAddrLen = ", stdout);
#line 8 "Base.hsc"
    hsc_const (ETH_ADDR_LEN);
    fputs ("\n"
           "", stdout);
    hsc_line (9, "Base.hsc");
    fputs ("\n"
           "ethAddrBits :: Int\n"
           "ethAddrBits = ", stdout);
#line 11 "Base.hsc"
    hsc_const (ETH_ADDR_BITS);
    fputs ("\n"
           "", stdout);
    hsc_line (12, "Base.hsc");
    fputs ("\n"
           "ethTypeLen :: Int\n"
           "ethTypeLen = ", stdout);
#line 14 "Base.hsc"
    hsc_const (ETH_TYPE_LEN);
    fputs ("\n"
           "", stdout);
    hsc_line (15, "Base.hsc");
    fputs ("\n"
           "ethCrcLen :: Int\n"
           "ethCrcLen = ", stdout);
#line 17 "Base.hsc"
    hsc_const (ETH_CRC_LEN);
    fputs ("\n"
           "", stdout);
    hsc_line (18, "Base.hsc");
    fputs ("\n"
           "ethHdrLen :: Int\n"
           "ethHdrLen = ", stdout);
#line 20 "Base.hsc"
    hsc_const (ETH_HDR_LEN);
    fputs ("\n"
           "", stdout);
    hsc_line (21, "Base.hsc");
    fputs ("\n"
           "ethLenMin :: Int\n"
           "ethLenMin = ", stdout);
#line 23 "Base.hsc"
    hsc_const (ETH_LEN_MIN);
    fputs ("\n"
           "", stdout);
    hsc_line (24, "Base.hsc");
    fputs ("\n"
           "ethLenMax :: Int\n"
           "ethLenMax = ", stdout);
#line 26 "Base.hsc"
    hsc_const (ETH_LEN_MAX);
    fputs ("\n"
           "", stdout);
    hsc_line (27, "Base.hsc");
    fputs ("\n"
           "ethMtu :: Int\n"
           "ethMtu = ", stdout);
#line 29 "Base.hsc"
    hsc_const (ETH_MTU);
    fputs ("\n"
           "", stdout);
    hsc_line (30, "Base.hsc");
    fputs ("\n"
           "ethMin :: Int\n"
           "ethMin = ", stdout);
#line 32 "Base.hsc"
    hsc_const (ETH_MIN);
    fputs ("\n"
           "", stdout);
    hsc_line (33, "Base.hsc");
    fputs ("\n"
           "data EthAddr {\n"
           "    unEthAddr :: [Word8]\n"
           "} deriving (Read,Show)\n"
           "\n"
           "mkEthAddr :: [Word8] -> Maybe EthAddr\n"
           "mkEthAddr addr =\n"
           "    case length addr of\n"
           "        ethAddrLen -> Just (EthAddr {unEthAddr = addr })\n"
           "        _          -> Nothing\n"
           "\n"
           "data EthHdr {\n"
           "    eth_dst  :: EthAddr,\n"
           "    eth_src  :: EthAddr,\n"
           "    eth_type :: EthType\n"
           "} deriving (Read,Show)\n"
           "\n"
           "data EthType = Eth_PUP\n"
           "             | Eth_IP\n"
           "             | Eth_ARP\n"
           "             | Eth_REVARP\n"
           "             | Eth_8021Q\n"
           "             | Eth_IPV6\n"
           "             | Eth_MPLS\n"
           "             | Eth_MPLS_MCAST\n"
           "             | Eth_PPPOEDISC\n"
           "             | Eth_PPPOE\n"
           "             | Eth_LOOPBACK\n"
           "    deriving (Read,Show)\n"
           "\n"
           "instance Enum EthType where\n"
           "    toEnum Eth_PUP        = ", stdout);
#line 64 "Base.hsc"
    hsc_const (ETH_TYPE_PUP);
    fputs ("\n"
           "", stdout);
    hsc_line (65, "Base.hsc");
    fputs ("    toEnum Eth_IP         = ", stdout);
#line 65 "Base.hsc"
    hsc_const (ETH_TYPE_IP);
    fputs ("\n"
           "", stdout);
    hsc_line (66, "Base.hsc");
    fputs ("    toEnum Eth_ARP        = ", stdout);
#line 66 "Base.hsc"
    hsc_const (ETH_TYPE_ARP);
    fputs ("\n"
           "", stdout);
    hsc_line (67, "Base.hsc");
    fputs ("    toEnum Eth_REVARP     = ", stdout);
#line 67 "Base.hsc"
    hsc_const (ETH_TYPE_REVARP);
    fputs ("\n"
           "", stdout);
    hsc_line (68, "Base.hsc");
    fputs ("    toEnum Eth_8021Q      = ", stdout);
#line 68 "Base.hsc"
    hsc_const (ETH_TYPE_8021Q);
    fputs ("\n"
           "", stdout);
    hsc_line (69, "Base.hsc");
    fputs ("    toEnum Eth_IPV6       = ", stdout);
#line 69 "Base.hsc"
    hsc_const (ETH_TYPE_IPV6);
    fputs ("\n"
           "", stdout);
    hsc_line (70, "Base.hsc");
    fputs ("    toEnum Eth_MPLS       = ", stdout);
#line 70 "Base.hsc"
    hsc_const (ETH_TYPE_MPLS);
    fputs ("\n"
           "", stdout);
    hsc_line (71, "Base.hsc");
    fputs ("    toEnum Eth_MPLS_MCAST = ", stdout);
#line 71 "Base.hsc"
    hsc_const (ETH_TYPE_MPLS_MCAST);
    fputs ("\n"
           "", stdout);
    hsc_line (72, "Base.hsc");
    fputs ("    toEnum Eth_PPPOEDISC  = ", stdout);
#line 72 "Base.hsc"
    hsc_const (ETH_TYPE_PPPOEDISC);
    fputs ("\n"
           "", stdout);
    hsc_line (73, "Base.hsc");
    fputs ("    toEnum Eth_PPPOE      = ", stdout);
#line 73 "Base.hsc"
    hsc_const (ETH_TYPE_PPPOE);
    fputs ("\n"
           "", stdout);
    hsc_line (74, "Base.hsc");
    fputs ("    toEnum Eth_LOOPBACK   = ", stdout);
#line 74 "Base.hsc"
    hsc_const (ETH_TYPE_LOOPBACK);
    fputs ("\n"
           "", stdout);
    hsc_line (75, "Base.hsc");
    fputs ("\n"
           "isMultiCast :: EthAddr -> Bool\n"
           "\n"
           "ethAddrBroadcast :: EthAddr\n"
           "ethAddrBroadcast = mkEthAddr ", stdout);
#line 79 "Base.hsc"
    hsc_const_str (ETH_ADDR_BROADCAST);
    fputs ("\n"
           "", stdout);
    hsc_line (80, "Base.hsc");
    fputs ("", stdout);
    return 0;
}
