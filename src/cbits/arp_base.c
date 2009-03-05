#include "arp_base.h"

#include <string.h>

void arp_pack_hdr_ethip_wrapper(struct arp_hdr * hdr, uint16_t op, uint16_t sha, uint16_t spa, uint16_t tha, uint16_t tpa)
{
    arp_pack_hdr_ethip(hdr,op,sha,spa,tha,tpa);
}
