Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C72D7F0B9A
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Nov 2023 06:41:40 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RGDFg7tz;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SYbwf0Fm4z3cRh
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Nov 2023 16:41:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RGDFg7tz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.43; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SYbwV5hzSz2ydW
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Nov 2023 16:41:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700458891; x=1731994891;
  h=date:from:to:cc:subject:message-id;
  bh=i8IAnPgbYX+L2jMdhppLv/NAP0HiF8UY6vUmc2WuRqQ=;
  b=RGDFg7tz4KSJU3eOcc2FhqbCMhNBc/HPKbHJ4AHxRlS1HhDjIhf4Ek/p
   oPnLIVLX/QCUFpxDEuvNwqJQt0+diQor1Mv8RJVp2G2yhYcwYBFDh2J30
   Aq0jKt9Zl366PSa97mDgnVHVt6VEOxLwa3bgp/EYeOVoketX4IboG/nuV
   RlMc8uhnKQP9sgToQmKmBzrgqrZu0Ek1QkmZLH2kL1AyEhjSXwLzHA+t7
   RQWHJDaGtvOFPiGWZzyzxz43k8NJ2ySWKRmP/9xnCcVz8d12zlvwoyQ/G
   5nqWS5X7O7HNdkDfxdyWRsi8R99wuDw5Jego+BxwzKaE/Dqiq7AV5WDGU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="477765710"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="477765710"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 21:41:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="14488450"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 19 Nov 2023 21:41:21 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r4x26-00062q-2W;
	Mon, 20 Nov 2023 05:41:18 +0000
Date: Mon, 20 Nov 2023 13:40:58 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 62b241efff99fc4d88a86f1c67c7516e31f432a3
Message-ID: <202311201355.yv7ltWaA-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 62b241efff99fc4d88a86f1c67c7516e31f432a3  MAINTAINERS: erofs: add EROFS webpage

elapsed time: 3930m

configs tested: 402
configs skipped: 22

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20231118   gcc  
arc                   randconfig-001-20231119   gcc  
arc                   randconfig-001-20231120   gcc  
arc                   randconfig-002-20231118   gcc  
arc                   randconfig-002-20231119   gcc  
arc                   randconfig-002-20231120   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   clang
arm                          gemini_defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20231118   gcc  
arm                   randconfig-001-20231119   gcc  
arm                   randconfig-001-20231120   clang
arm                   randconfig-002-20231118   gcc  
arm                   randconfig-002-20231119   gcc  
arm                   randconfig-002-20231120   clang
arm                   randconfig-003-20231118   gcc  
arm                   randconfig-003-20231119   gcc  
arm                   randconfig-003-20231120   clang
arm                   randconfig-004-20231118   gcc  
arm                   randconfig-004-20231119   gcc  
arm                   randconfig-004-20231120   clang
arm                        spear6xx_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231118   gcc  
arm64                 randconfig-001-20231119   gcc  
arm64                 randconfig-001-20231120   clang
arm64                 randconfig-002-20231118   gcc  
arm64                 randconfig-002-20231119   gcc  
arm64                 randconfig-002-20231120   clang
arm64                 randconfig-003-20231118   gcc  
arm64                 randconfig-003-20231119   gcc  
arm64                 randconfig-003-20231120   clang
arm64                 randconfig-004-20231118   gcc  
arm64                 randconfig-004-20231119   gcc  
arm64                 randconfig-004-20231120   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231118   gcc  
csky                  randconfig-001-20231119   gcc  
csky                  randconfig-001-20231120   gcc  
csky                  randconfig-002-20231118   gcc  
csky                  randconfig-002-20231119   gcc  
csky                  randconfig-002-20231120   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231120   clang
hexagon               randconfig-002-20231120   clang
i386                             alldefconfig   gcc  
i386                             allmodconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231117   gcc  
i386         buildonly-randconfig-001-20231118   gcc  
i386         buildonly-randconfig-001-20231119   gcc  
i386         buildonly-randconfig-002-20231117   gcc  
i386         buildonly-randconfig-002-20231118   gcc  
i386         buildonly-randconfig-002-20231119   gcc  
i386         buildonly-randconfig-003-20231117   gcc  
i386         buildonly-randconfig-003-20231118   gcc  
i386         buildonly-randconfig-003-20231119   gcc  
i386         buildonly-randconfig-004-20231117   gcc  
i386         buildonly-randconfig-004-20231118   gcc  
i386         buildonly-randconfig-004-20231119   gcc  
i386         buildonly-randconfig-005-20231117   gcc  
i386         buildonly-randconfig-005-20231118   gcc  
i386         buildonly-randconfig-005-20231119   gcc  
i386         buildonly-randconfig-006-20231117   gcc  
i386         buildonly-randconfig-006-20231118   gcc  
i386         buildonly-randconfig-006-20231119   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231117   gcc  
i386                  randconfig-001-20231118   gcc  
i386                  randconfig-001-20231119   gcc  
i386                  randconfig-002-20231117   gcc  
i386                  randconfig-002-20231118   gcc  
i386                  randconfig-002-20231119   gcc  
i386                  randconfig-003-20231117   gcc  
i386                  randconfig-003-20231118   gcc  
i386                  randconfig-003-20231119   gcc  
i386                  randconfig-004-20231117   gcc  
i386                  randconfig-004-20231118   gcc  
i386                  randconfig-004-20231119   gcc  
i386                  randconfig-005-20231117   gcc  
i386                  randconfig-005-20231118   gcc  
i386                  randconfig-005-20231119   gcc  
i386                  randconfig-006-20231117   gcc  
i386                  randconfig-006-20231118   gcc  
i386                  randconfig-006-20231119   gcc  
i386                  randconfig-011-20231117   gcc  
i386                  randconfig-011-20231118   gcc  
i386                  randconfig-011-20231119   clang
i386                  randconfig-011-20231119   gcc  
i386                  randconfig-011-20231120   gcc  
i386                  randconfig-012-20231117   gcc  
i386                  randconfig-012-20231118   gcc  
i386                  randconfig-012-20231119   clang
i386                  randconfig-012-20231119   gcc  
i386                  randconfig-012-20231120   gcc  
i386                  randconfig-013-20231117   gcc  
i386                  randconfig-013-20231118   gcc  
i386                  randconfig-013-20231119   clang
i386                  randconfig-013-20231119   gcc  
i386                  randconfig-013-20231120   gcc  
i386                  randconfig-014-20231117   gcc  
i386                  randconfig-014-20231118   gcc  
i386                  randconfig-014-20231119   clang
i386                  randconfig-014-20231119   gcc  
i386                  randconfig-014-20231120   gcc  
i386                  randconfig-015-20231117   gcc  
i386                  randconfig-015-20231118   gcc  
i386                  randconfig-015-20231119   clang
i386                  randconfig-015-20231119   gcc  
i386                  randconfig-015-20231120   gcc  
i386                  randconfig-016-20231117   gcc  
i386                  randconfig-016-20231118   gcc  
i386                  randconfig-016-20231119   clang
i386                  randconfig-016-20231119   gcc  
i386                  randconfig-016-20231120   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231118   gcc  
loongarch             randconfig-001-20231119   gcc  
loongarch             randconfig-001-20231120   gcc  
loongarch             randconfig-002-20231118   gcc  
loongarch             randconfig-002-20231119   gcc  
loongarch             randconfig-002-20231120   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                        bcm63xx_defconfig   clang
mips                         cobalt_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231118   gcc  
nios2                 randconfig-001-20231119   gcc  
nios2                 randconfig-001-20231120   gcc  
nios2                 randconfig-002-20231118   gcc  
nios2                 randconfig-002-20231119   gcc  
nios2                 randconfig-002-20231120   gcc  
openrisc                         alldefconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231118   gcc  
parisc                randconfig-001-20231119   gcc  
parisc                randconfig-001-20231120   gcc  
parisc                randconfig-002-20231118   gcc  
parisc                randconfig-002-20231119   gcc  
parisc                randconfig-002-20231120   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                          allyesconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc                      ppc40x_defconfig   gcc  
powerpc               randconfig-001-20231118   gcc  
powerpc               randconfig-001-20231119   gcc  
powerpc               randconfig-001-20231120   clang
powerpc               randconfig-002-20231118   gcc  
powerpc               randconfig-002-20231119   gcc  
powerpc               randconfig-002-20231120   clang
powerpc               randconfig-003-20231118   gcc  
powerpc               randconfig-003-20231119   gcc  
powerpc               randconfig-003-20231120   clang
powerpc                     redwood_defconfig   gcc  
powerpc                     sequoia_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20231118   gcc  
powerpc64             randconfig-001-20231119   gcc  
powerpc64             randconfig-001-20231120   clang
powerpc64             randconfig-002-20231118   gcc  
powerpc64             randconfig-002-20231119   gcc  
powerpc64             randconfig-002-20231120   clang
powerpc64             randconfig-003-20231118   gcc  
powerpc64             randconfig-003-20231119   gcc  
powerpc64             randconfig-003-20231120   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20231118   gcc  
riscv                 randconfig-001-20231119   gcc  
riscv                 randconfig-001-20231120   clang
riscv                 randconfig-002-20231118   gcc  
riscv                 randconfig-002-20231119   gcc  
riscv                 randconfig-002-20231120   clang
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231118   gcc  
s390                  randconfig-001-20231119   gcc  
s390                  randconfig-001-20231120   gcc  
s390                  randconfig-002-20231118   gcc  
s390                  randconfig-002-20231119   gcc  
s390                  randconfig-002-20231120   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20231118   gcc  
sh                    randconfig-001-20231119   gcc  
sh                    randconfig-001-20231120   gcc  
sh                    randconfig-002-20231118   gcc  
sh                    randconfig-002-20231119   gcc  
sh                    randconfig-002-20231120   gcc  
sh                          rsk7264_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231118   gcc  
sparc64               randconfig-001-20231119   gcc  
sparc64               randconfig-001-20231120   gcc  
sparc64               randconfig-002-20231118   gcc  
sparc64               randconfig-002-20231119   gcc  
sparc64               randconfig-002-20231120   gcc  
um                               allmodconfig   gcc  
um                                allnoconfig   gcc  
um                               allyesconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231118   gcc  
um                    randconfig-001-20231119   gcc  
um                    randconfig-001-20231120   clang
um                    randconfig-002-20231118   gcc  
um                    randconfig-002-20231119   gcc  
um                    randconfig-002-20231120   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231118   gcc  
x86_64       buildonly-randconfig-001-20231119   gcc  
x86_64       buildonly-randconfig-001-20231120   clang
x86_64       buildonly-randconfig-002-20231118   gcc  
x86_64       buildonly-randconfig-002-20231119   gcc  
x86_64       buildonly-randconfig-002-20231120   clang
x86_64       buildonly-randconfig-003-20231118   gcc  
x86_64       buildonly-randconfig-003-20231119   gcc  
x86_64       buildonly-randconfig-003-20231120   clang
x86_64       buildonly-randconfig-004-20231118   gcc  
x86_64       buildonly-randconfig-004-20231119   gcc  
x86_64       buildonly-randconfig-004-20231120   clang
x86_64       buildonly-randconfig-005-20231118   gcc  
x86_64       buildonly-randconfig-005-20231119   gcc  
x86_64       buildonly-randconfig-005-20231120   clang
x86_64       buildonly-randconfig-006-20231118   gcc  
x86_64       buildonly-randconfig-006-20231119   gcc  
x86_64       buildonly-randconfig-006-20231120   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231118   gcc  
x86_64                randconfig-001-20231119   clang
x86_64                randconfig-001-20231119   gcc  
x86_64                randconfig-002-20231118   gcc  
x86_64                randconfig-002-20231119   clang
x86_64                randconfig-002-20231119   gcc  
x86_64                randconfig-003-20231118   gcc  
x86_64                randconfig-003-20231119   clang
x86_64                randconfig-003-20231119   gcc  
x86_64                randconfig-004-20231118   gcc  
x86_64                randconfig-004-20231119   clang
x86_64                randconfig-004-20231119   gcc  
x86_64                randconfig-005-20231118   gcc  
x86_64                randconfig-005-20231119   clang
x86_64                randconfig-005-20231119   gcc  
x86_64                randconfig-006-20231118   gcc  
x86_64                randconfig-006-20231119   clang
x86_64                randconfig-006-20231119   gcc  
x86_64                randconfig-011-20231118   gcc  
x86_64                randconfig-011-20231119   gcc  
x86_64                randconfig-011-20231120   clang
x86_64                randconfig-012-20231118   gcc  
x86_64                randconfig-012-20231119   gcc  
x86_64                randconfig-012-20231120   clang
x86_64                randconfig-013-20231118   gcc  
x86_64                randconfig-013-20231119   gcc  
x86_64                randconfig-013-20231120   clang
x86_64                randconfig-014-20231118   gcc  
x86_64                randconfig-014-20231119   gcc  
x86_64                randconfig-014-20231120   clang
x86_64                randconfig-015-20231118   gcc  
x86_64                randconfig-015-20231119   gcc  
x86_64                randconfig-015-20231120   clang
x86_64                randconfig-016-20231118   gcc  
x86_64                randconfig-016-20231119   gcc  
x86_64                randconfig-016-20231120   clang
x86_64                randconfig-071-20231118   gcc  
x86_64                randconfig-071-20231119   gcc  
x86_64                randconfig-071-20231120   clang
x86_64                randconfig-072-20231118   gcc  
x86_64                randconfig-072-20231119   gcc  
x86_64                randconfig-072-20231120   clang
x86_64                randconfig-073-20231118   gcc  
x86_64                randconfig-073-20231119   gcc  
x86_64                randconfig-073-20231120   clang
x86_64                randconfig-074-20231118   gcc  
x86_64                randconfig-074-20231119   gcc  
x86_64                randconfig-074-20231120   clang
x86_64                randconfig-075-20231118   gcc  
x86_64                randconfig-075-20231119   gcc  
x86_64                randconfig-075-20231120   clang
x86_64                randconfig-076-20231118   gcc  
x86_64                randconfig-076-20231119   gcc  
x86_64                randconfig-076-20231120   clang
x86_64                           rhel-8.3-bpf   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20231118   gcc  
xtensa                randconfig-001-20231119   gcc  
xtensa                randconfig-001-20231120   gcc  
xtensa                randconfig-002-20231118   gcc  
xtensa                randconfig-002-20231119   gcc  
xtensa                randconfig-002-20231120   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
