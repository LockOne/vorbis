/********************************************************************
 *                                                                  *
 * THIS FILE IS PART OF THE OggVorbis SOFTWARE CODEC SOURCE CODE.   *
 * USE, DISTRIBUTION AND REPRODUCTION OF THIS SOURCE IS GOVERNED BY *
 * THE GNU LESSER/LIBRARY PUBLIC LICENSE, WHICH IS INCLUDED WITH    *
 * THIS SOURCE. PLEASE READ THESE TERMS BEFORE DISTRIBUTING.        *
 *                                                                  *
 * THE OggVorbis SOURCE CODE IS (C) COPYRIGHT 1994-2000             *
 * by Monty <monty@xiph.org> and the XIPHOPHORUS Company            *
 * http://www.xiph.org/                                             *
 *                                                                  *
 ********************************************************************

 function: registry for time, floor, res backends and channel mappings
 last mod: $Id: registry.h,v 1.2.14.2 2000/11/04 06:21:45 xiphmont Exp $

 ********************************************************************/

#ifndef _V_REG_H_
#define _V_REG_H_

#include "backends.h"

#define VI_TRANSFORMB 1
#define VI_WINDOWB 1
#define VI_TIMEB 1
#define VI_FLOORB 1
#define VI_RESB 1
#define VI_MAPB 1

extern vorbis_func_time      *_time_P[];
extern vorbis_func_floor     *_floor_P[];
extern vorbis_func_residue   *_residue_P[];
extern vorbis_func_mapping   *_mapping_P[];

#endif