Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E946E815A25
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Dec 2023 17:19:40 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lVf8i4He;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ssrrm4YCPz3bl6
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Dec 2023 03:19:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lVf8i4He;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.65; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ssrrd19Fyz2y1j
	for <linux-erofs@lists.ozlabs.org>; Sun, 17 Dec 2023 03:19:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702743569; x=1734279569;
  h=date:from:to:cc:subject:message-id;
  bh=Mxb3U/zbXRSwQl+F34x5XJtx0ToFPUGPe5pJatsB5Ds=;
  b=lVf8i4HeOvWGBIP+lc/GOILkDFF8rveIFaiaaQmlOwbjGkyYz8GL1Itd
   RN0kE98rHXBfJJcSqPNVyUqNoGsRp7eD9ONQxUcoP3lLYbQuaH6WlpHJ4
   RH026wPfy/bSzwMQQ2S/xbdIzOMvMPAGsFY6NOkff97HbnHhK6bviSDEh
   XsK3cEc90jkUcDgO3ZNLebjzH63lR5ujEiC8zaiXbbR8lreF8QjXUIvF2
   osXVUI/xT8/tBFaLXNlHY5tYl29x6eNXaXUC2zD+7Lg58j27VhCVeE/67
   cM17Sq3g5WoWRr9YyEUxc+iBzCsJV+VIgEr7fgvnvsEIfqIg/ZS0hIhqN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="399213259"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="399213259"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 08:19:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="1022281289"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="1022281289"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 16 Dec 2023 08:19:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEXNl-0001qH-2h;
	Sat, 16 Dec 2023 16:19:17 +0000
Date: Sun, 17 Dec 2023 00:17:46 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 4232173f8f7fb924f3c065ebd8cbfdadc5dbef90
Message-ID: <202312170043.IGQ9jxcV-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 4232173f8f7fb924f3c065ebd8cbfdadc5dbef90  erofs: enable sub-page compressed block support

elapsed time: 1491m

configs tested: 189
configs skipped: 2

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
arc                                 defconfig   gcc  
arc                   randconfig-001-20231216   gcc  
arc                   randconfig-002-20231216   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   clang
arm                        multi_v5_defconfig   clang
arm                        mvebu_v7_defconfig   gcc  
arm                        neponset_defconfig   clang
arm                           omap1_defconfig   clang
arm                          pxa168_defconfig   clang
arm                   randconfig-001-20231216   gcc  
arm                   randconfig-002-20231216   gcc  
arm                   randconfig-003-20231216   gcc  
arm                   randconfig-004-20231216   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231216   gcc  
arm64                 randconfig-002-20231216   gcc  
arm64                 randconfig-003-20231216   gcc  
arm64                 randconfig-004-20231216   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231216   gcc  
csky                  randconfig-002-20231216   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231216   clang
hexagon               randconfig-002-20231216   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231216   gcc  
i386         buildonly-randconfig-002-20231216   gcc  
i386         buildonly-randconfig-003-20231216   gcc  
i386         buildonly-randconfig-004-20231216   gcc  
i386         buildonly-randconfig-005-20231216   gcc  
i386         buildonly-randconfig-006-20231216   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231216   gcc  
i386                  randconfig-002-20231216   gcc  
i386                  randconfig-003-20231216   gcc  
i386                  randconfig-004-20231216   gcc  
i386                  randconfig-005-20231216   gcc  
i386                  randconfig-006-20231216   gcc  
i386                  randconfig-011-20231216   clang
i386                  randconfig-012-20231216   clang
i386                  randconfig-013-20231216   clang
i386                  randconfig-014-20231216   clang
i386                  randconfig-015-20231216   clang
i386                  randconfig-016-20231216   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20231216   gcc  
loongarch             randconfig-002-20231216   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips                     cu1000-neo_defconfig   clang
mips                          rb532_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231216   gcc  
nios2                 randconfig-002-20231216   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20231216   gcc  
parisc                randconfig-002-20231216   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      chrp32_defconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                     kilauea_defconfig   clang
powerpc                     kmeter1_defconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc                       maple_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc               randconfig-001-20231216   gcc  
powerpc               randconfig-002-20231216   gcc  
powerpc               randconfig-003-20231216   gcc  
powerpc                     redwood_defconfig   gcc  
powerpc                     sequoia_defconfig   gcc  
powerpc                    socrates_defconfig   gcc  
powerpc64             randconfig-001-20231216   gcc  
powerpc64             randconfig-002-20231216   gcc  
powerpc64             randconfig-003-20231216   gcc  
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231216   gcc  
riscv                 randconfig-002-20231216   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231216   clang
s390                  randconfig-002-20231216   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231216   gcc  
sh                    randconfig-002-20231216   gcc  
sh                          rsk7203_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231216   gcc  
sparc64               randconfig-002-20231216   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231216   gcc  
um                    randconfig-002-20231216   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231216   gcc  
x86_64       buildonly-randconfig-002-20231216   gcc  
x86_64       buildonly-randconfig-003-20231216   gcc  
x86_64       buildonly-randconfig-004-20231216   gcc  
x86_64       buildonly-randconfig-005-20231216   gcc  
x86_64       buildonly-randconfig-006-20231216   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231216   clang
x86_64                randconfig-002-20231216   clang
x86_64                randconfig-003-20231216   clang
x86_64                randconfig-004-20231216   clang
x86_64                randconfig-005-20231216   clang
x86_64                randconfig-006-20231216   clang
x86_64                randconfig-011-20231216   gcc  
x86_64                randconfig-012-20231216   gcc  
x86_64                randconfig-013-20231216   gcc  
x86_64                randconfig-014-20231216   gcc  
x86_64                randconfig-015-20231216   gcc  
x86_64                randconfig-016-20231216   gcc  
x86_64                randconfig-071-20231216   gcc  
x86_64                randconfig-072-20231216   gcc  
x86_64                randconfig-073-20231216   gcc  
x86_64                randconfig-074-20231216   gcc  
x86_64                randconfig-075-20231216   gcc  
x86_64                randconfig-076-20231216   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20231216   gcc  
xtensa                randconfig-002-20231216   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
