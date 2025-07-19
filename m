Return-Path: <linux-erofs+bounces-679-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E94B0AE75
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Jul 2025 09:45:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bkdxv2ClTz30VZ;
	Sat, 19 Jul 2025 17:45:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752911155;
	cv=none; b=cu27kcpbmnTTvy1ic78fa+rswXchLIBf/PE2G3ErDOcgwWw0CUDrhvf8+yvHJ6TwTOpj4GV8w3utfXafdy2SawXP8Jvmd/6Nzw7GJBJGyR5tTcVIqzJ0oQHZhNNX9efguBuSikWJy4VflL6Y/sl8dzQ/klUyU2XAi4lOeiOJugz0arEYIrXERfd9rCadbYdULEs9tuavri0LA/i8MiFpie+h7sCcVe4jW4BWHSLlo75TPyfj7ZqOOo8G8/28vqoglVWbGRGnv9Y9KcBUwPtKBhgYA5rQmrntbH2Iy0+jU/RMZwWmR6rTH4M1hztNCTXGpr0gePFeP0v3ocopa1y2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752911155; c=relaxed/relaxed;
	bh=DqE8AJFA4LK7qdagH+J4jxIbDxjHa2nx9LXGLRchYVU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TBNmr3W4HeE5HN3oNwyCDM+arOKcc2uN4eo4jWT5srSBQc23gAlYWT6PqgvychZuc5LOjptLt2S8HIqHFCRUyRD43AuvZA+H8vhi8wxbxt3mZmbDwmmW+JeD1BAgDMJjLyPeYfX0HBf2yow3x5ZjkApVm5/GGIMsyZzYMwK7cuybHUF2fGIYFhOxlf3lZDwa2u8e03e7xUTyeIVRqLOo0RsqkZj46ItU7yatZLYW8iIRcXLdsLyqMgpcFEHjDGWriC/l3OtaCL2ZcEgzlCGSBJ1cqj+K/NgvU9St4mKIHWSDvum38MaaS+HeDlTxxD4hDPnDvLT+MNEGuZR1i9lJag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NX0JWkNl; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NX0JWkNl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bkdxs06LWz2ySg
	for <linux-erofs@lists.ozlabs.org>; Sat, 19 Jul 2025 17:45:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752911154; x=1784447154;
  h=date:from:to:cc:subject:message-id;
  bh=9r4ZRiPl8oOItZ88IOb77QedKK7FM1t3oMMKLBJ1Us4=;
  b=NX0JWkNlZT0jtWVt+wacD120bqwSSmUCyYTMy6322cRSy61XNPU8DnqT
   3P7xs09tPbYuu2jRRumjVPk0vgvGw18NC6b0zcKG3E4qAEYeS6B780ycN
   jqh1IwSPG9/QblnqrVwTPk3ZZzeRcHpzhN8nDepD6t2i9Mu7saBgs6jLt
   OsDsEG4nv0ObuTdCBUll2PWjtBoFTtm+50j2iP3ApFQGmE4P1own2cerb
   1du2P4KuHUjdiGU1QIKfhG8QVR3TFRU1t8QOdyWGevQm9sEYCHNv9USOe
   RJEJbHB1yB0nWFv3Ge4o3uOvMqtM9dS/B0gFgmwOrbVKDYGiKUH7O5kz9
   Q==;
X-CSE-ConnectionGUID: RRQnMLVSRbeEwcM3crFjoQ==
X-CSE-MsgGUID: ZTFVQsW7TgOkFOlfruCgzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="77732893"
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; 
   d="scan'208";a="77732893"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 00:45:48 -0700
X-CSE-ConnectionGUID: 4zrTUjPUQsiEsqa2D9wzYQ==
X-CSE-MsgGUID: Nq50AV0aRSyYee+k8vFrjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; 
   d="scan'208";a="164047900"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 19 Jul 2025 00:45:46 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ud2GN-000FJn-1r;
	Sat, 19 Jul 2025 07:45:43 +0000
Date: Sat, 19 Jul 2025 15:44:49 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS WITH WARNING
 e484a15cdbd35414109b8d539c142bb2b7bcd348
Message-ID: <202507191532.6myhyrEJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: e484a15cdbd35414109b8d539c142bb2b7bcd348  erofs: implement metadata compression

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202507170506.Wzz1lR5I-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202507170548.rvm67YSU-lkp@intel.com

    fs/erofs/internal.h:305:31: warning: shift count >= width of type [-Wshift-count-overflow]
    fs/erofs/super.c:327:26: warning: shift count >= width of type [-Wshift-count-overflow]
    include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]

Warning ids grouped by kconfigs:

recent_errors
|-- arc-allmodconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- arc-allyesconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- arm-allmodconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- arm-allyesconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- hexagon-allmodconfig
|   |-- fs-erofs-internal.h:warning:shift-count-width-of-type
|   `-- fs-erofs-super.c:warning:shift-count-width-of-type
|-- hexagon-allyesconfig
|   |-- fs-erofs-internal.h:warning:shift-count-width-of-type
|   `-- fs-erofs-super.c:warning:shift-count-width-of-type
|-- i386-allyesconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- i386-buildonly-randconfig-001-20250718
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- i386-buildonly-randconfig-003-20250718
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- microblaze-allyesconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- powerpc-randconfig-003-20250718
|   |-- fs-erofs-internal.h:warning:shift-count-width-of-type
|   `-- fs-erofs-super.c:warning:shift-count-width-of-type
|-- sh-allmodconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
`-- sh-allyesconfig
    `-- include-vdso-bits.h:warning:left-shift-count-width-of-type

elapsed time: 1375m

configs tested: 127
configs skipped: 5

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              alldefconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250718    gcc-10.5.0
arc                   randconfig-002-20250718    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                      jornada720_defconfig    clang-21
arm                       omap2plus_defconfig    gcc-15.1.0
arm                   randconfig-001-20250718    gcc-8.5.0
arm                   randconfig-002-20250718    gcc-8.5.0
arm                   randconfig-003-20250718    gcc-8.5.0
arm                   randconfig-004-20250718    gcc-10.5.0
arm                        spear6xx_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250718    gcc-13.4.0
arm64                 randconfig-002-20250718    gcc-8.5.0
arm64                 randconfig-003-20250718    clang-21
arm64                 randconfig-004-20250718    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250718    gcc-15.1.0
csky                  randconfig-002-20250718    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250718    clang-21
hexagon               randconfig-002-20250718    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250718    gcc-12
i386        buildonly-randconfig-002-20250718    clang-20
i386        buildonly-randconfig-003-20250718    gcc-12
i386        buildonly-randconfig-004-20250718    gcc-11
i386        buildonly-randconfig-005-20250718    gcc-12
i386        buildonly-randconfig-006-20250718    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                 loongson3_defconfig    clang-21
loongarch             randconfig-001-20250718    gcc-15.1.0
loongarch             randconfig-002-20250718    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                        m5407c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip32_defconfig    clang-21
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250718    gcc-8.5.0
nios2                 randconfig-002-20250718    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250718    gcc-14.3.0
parisc                randconfig-002-20250718    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                 mpc832x_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250718    gcc-9.5.0
powerpc               randconfig-002-20250718    gcc-11.5.0
powerpc               randconfig-003-20250718    clang-17
powerpc                      tqm8xx_defconfig    clang-19
powerpc                        warp_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250718    clang-18
powerpc64             randconfig-002-20250718    clang-21
powerpc64             randconfig-003-20250718    gcc-8.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250718    clang-21
riscv                 randconfig-002-20250718    clang-16
s390                             alldefconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250718    clang-21
s390                  randconfig-002-20250718    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                        edosk7705_defconfig    gcc-15.1.0
sh                             espt_defconfig    gcc-15.1.0
sh                    randconfig-001-20250718    gcc-15.1.0
sh                    randconfig-002-20250718    gcc-15.1.0
sh                            shmin_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250718    gcc-15.1.0
sparc                 randconfig-002-20250718    gcc-11.5.0
sparc64               randconfig-001-20250718    gcc-10.5.0
sparc64               randconfig-002-20250718    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250718    gcc-12
um                    randconfig-002-20250718    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250718    clang-20
x86_64      buildonly-randconfig-002-20250718    gcc-12
x86_64      buildonly-randconfig-003-20250718    gcc-12
x86_64      buildonly-randconfig-004-20250718    clang-20
x86_64      buildonly-randconfig-005-20250718    clang-20
x86_64      buildonly-randconfig-006-20250718    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250718    gcc-8.5.0
xtensa                randconfig-002-20250718    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

