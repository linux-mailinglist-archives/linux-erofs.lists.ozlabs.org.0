Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04C188B270
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Mar 2024 22:14:39 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UeprqGAF;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V3Qg145W6z3cLj
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Mar 2024 08:14:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UeprqGAF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V3Qfw757Lz3bWn
	for <linux-erofs@lists.ozlabs.org>; Tue, 26 Mar 2024 08:14:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711401273; x=1742937273;
  h=date:from:to:cc:subject:message-id;
  bh=axZT+Jn7Cfw9X8VxeDapxVwO9UIrVxV2Z11tHRBYQeY=;
  b=UeprqGAFb9SR1vOquqPlDDK9w/l4BE9vZT5GbaoQk3x71F4mDHkbRsXH
   PJj+dRl1Nbfy1pXivDoQDBbefuIwXgn9vzYZ0JYJujOmzuy0qfnjj0Fyf
   Uzhua4PAJ3F6v4GRhxzan+pqWFPoMHxEsAQz2M5kEYWH+Ltta6strNY+O
   gbUTHjzqRQGbQPHP7bq0px1vaO0XjUiI6ZVurU/FMcQHSH06hoSz1aBiH
   uCopltnac1bIJVvQTYAIIGBN/1pGO0flee4fP/JPwlXZRONgv62Y4LZV1
   9tb/hP7pxNrZSKFcF1c9UGg2RWMULwMFPfGeV5UKSYXCwYqDhnjWRO1Jw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="9395190"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="9395190"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 14:14:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="15607574"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 25 Mar 2024 14:14:26 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1roreC-000MqC-0H;
	Mon, 25 Mar 2024 21:14:24 +0000
Date: Tue, 26 Mar 2024 05:13:34 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:fixes] BUILD SUCCESS
 8cdac422e39781869169b1eb4b61b6d5a512233d
Message-ID: <202403260529.vfBDbHBa-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git fixes
branch HEAD: 8cdac422e39781869169b1eb4b61b6d5a512233d  MAINTAINERS: erofs: add myself as reviewer

elapsed time: 1102m

configs tested: 180
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240326   gcc  
arc                   randconfig-002-20240326   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        multi_v5_defconfig   gcc  
arm                   randconfig-001-20240326   gcc  
arm                   randconfig-002-20240326   gcc  
arm                   randconfig-003-20240326   gcc  
arm                   randconfig-004-20240326   gcc  
arm                         s3c6400_defconfig   gcc  
arm                        vexpress_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-003-20240326   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240326   gcc  
csky                  randconfig-002-20240326   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240325   clang
i386         buildonly-randconfig-002-20240325   gcc  
i386         buildonly-randconfig-002-20240326   clang
i386         buildonly-randconfig-003-20240325   gcc  
i386         buildonly-randconfig-003-20240326   clang
i386         buildonly-randconfig-004-20240325   gcc  
i386         buildonly-randconfig-005-20240325   clang
i386         buildonly-randconfig-006-20240325   clang
i386                                defconfig   clang
i386                  randconfig-001-20240325   gcc  
i386                  randconfig-002-20240325   gcc  
i386                  randconfig-003-20240325   clang
i386                  randconfig-004-20240325   gcc  
i386                  randconfig-004-20240326   clang
i386                  randconfig-005-20240325   gcc  
i386                  randconfig-006-20240325   clang
i386                  randconfig-006-20240326   clang
i386                  randconfig-011-20240325   gcc  
i386                  randconfig-011-20240326   clang
i386                  randconfig-012-20240325   clang
i386                  randconfig-013-20240325   clang
i386                  randconfig-013-20240326   clang
i386                  randconfig-014-20240325   clang
i386                  randconfig-014-20240326   clang
i386                  randconfig-015-20240325   gcc  
i386                  randconfig-015-20240326   clang
i386                  randconfig-016-20240325   gcc  
i386                  randconfig-016-20240326   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240326   gcc  
loongarch             randconfig-002-20240326   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                            q40_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                          malta_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
mips                      pic32mzda_defconfig   gcc  
mips                          rm200_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240326   gcc  
nios2                 randconfig-002-20240326   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240326   gcc  
parisc                randconfig-002-20240326   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                   microwatt_defconfig   gcc  
powerpc               randconfig-002-20240326   gcc  
powerpc                     tqm5200_defconfig   gcc  
powerpc                      walnut_defconfig   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240326   gcc  
powerpc64             randconfig-002-20240326   gcc  
powerpc64             randconfig-003-20240326   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20240326   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240326   gcc  
sh                    randconfig-002-20240326   gcc  
sh                          rsk7269_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240326   gcc  
sparc64               randconfig-002-20240326   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240326   gcc  
um                    randconfig-002-20240326   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240326   gcc  
xtensa                randconfig-002-20240326   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
