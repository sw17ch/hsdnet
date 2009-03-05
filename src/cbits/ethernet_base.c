#include "ethernet_base.h"

uint8_t ETH_IS_MULTICAST_Wrapper(uint8_t * ea)
{
    return ETH_IS_MULTICAST(ea);
}
