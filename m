Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168CD7E9CBE
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Nov 2023 14:08:30 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OBR22ctA;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4STV9R4mnhz3cV9
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Nov 2023 00:08:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OBR22ctA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.31; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4STV9D0lWnz3cDk
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Nov 2023 00:08:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699880896; x=1731416896;
  h=date:from:to:cc:subject:message-id;
  bh=2HEhnlNTaZHL1ZIp9guld6G6Uz5sVqZ48SRRE1vCrpY=;
  b=OBR22ctADxL1PoBSasnk2ep5dmmsEUatyQvLzw3hJUQmHKpwFT8NOefD
   bPUYJ2m0yb/s/4h5Hu+WCFT/QNaEcpj0daMcQWDMjiSJxHk0kZu6ZAKvM
   OvqA5+cZtP2fQHma2vRYpGHIPE329HjLCXRrFx0SHAseoaTp7hmiUxZxX
   d+/utx+L19ezP/37hNJ9AMUB3fVpvzIZdJxwvanAMm2KkfJRP9AklBlLj
   JK095AwArQhEF2ozQae4vKVhXMjsnVHIoeWSlp6l+RFbyJixvJ2PAz3MF
   DbDxFfooW1PIqFEGx3U4hGsDwKqtjtk2OMAUKBrHqMHT3lMHxWY8N1kSq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="454726006"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="454726006"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 05:08:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="5648114"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 13 Nov 2023 05:08:07 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r2Wfd-000C6j-1U;
	Mon, 13 Nov 2023 13:08:05 +0000
Date: Mon, 13 Nov 2023 21:07:26 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 41087f71cde0d300d140bf32d9c668534c8f1488
Message-ID: <202311132125.13IqLaum-lkp@intel.com>
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
branch HEAD: 41087f71cde0d300d140bf32d9c668534c8f1488  erofs: simplify erofs_read_inode()

elapsed time: 721m

configs tested: 179
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
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231113   gcc  
arc                   randconfig-002-20231113   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231113   gcc  
arm                   randconfig-002-20231113   gcc  
arm                   randconfig-003-20231113   gcc  
arm                   randconfig-004-20231113   gcc  
arm                          sp7021_defconfig   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231113   gcc  
arm64                 randconfig-002-20231113   gcc  
arm64                 randconfig-003-20231113   gcc  
arm64                 randconfig-004-20231113   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231113   gcc  
csky                  randconfig-002-20231113   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231113   gcc  
i386         buildonly-randconfig-002-20231113   gcc  
i386         buildonly-randconfig-003-20231113   gcc  
i386         buildonly-randconfig-004-20231113   gcc  
i386         buildonly-randconfig-005-20231113   gcc  
i386         buildonly-randconfig-006-20231113   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231113   gcc  
i386                  randconfig-002-20231113   gcc  
i386                  randconfig-003-20231113   gcc  
i386                  randconfig-004-20231113   gcc  
i386                  randconfig-005-20231113   gcc  
i386                  randconfig-006-20231113   gcc  
i386                  randconfig-011-20231113   gcc  
i386                  randconfig-012-20231113   gcc  
i386                  randconfig-013-20231113   gcc  
i386                  randconfig-014-20231113   gcc  
i386                  randconfig-015-20231113   gcc  
i386                  randconfig-016-20231113   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231113   gcc  
loongarch             randconfig-002-20231113   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips                        bcm47xx_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                        vocore2_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231113   gcc  
nios2                 randconfig-002-20231113   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231113   gcc  
parisc                randconfig-002-20231113   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc               randconfig-001-20231113   gcc  
powerpc               randconfig-002-20231113   gcc  
powerpc               randconfig-003-20231113   gcc  
powerpc                     tqm8548_defconfig   gcc  
powerpc64             randconfig-001-20231113   gcc  
powerpc64             randconfig-002-20231113   gcc  
powerpc64             randconfig-003-20231113   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231113   gcc  
riscv                 randconfig-002-20231113   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231113   gcc  
s390                  randconfig-002-20231113   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231113   gcc  
sh                    randconfig-002-20231113   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231113   gcc  
sparc                 randconfig-002-20231113   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231113   gcc  
sparc64               randconfig-002-20231113   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231113   gcc  
um                    randconfig-002-20231113   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231113   gcc  
x86_64       buildonly-randconfig-002-20231113   gcc  
x86_64       buildonly-randconfig-003-20231113   gcc  
x86_64       buildonly-randconfig-004-20231113   gcc  
x86_64       buildonly-randconfig-005-20231113   gcc  
x86_64       buildonly-randconfig-006-20231113   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231113   gcc  
x86_64                randconfig-002-20231113   gcc  
x86_64                randconfig-003-20231113   gcc  
x86_64                randconfig-004-20231113   gcc  
x86_64                randconfig-005-20231113   gcc  
x86_64                randconfig-006-20231113   gcc  
x86_64                randconfig-011-20231113   gcc  
x86_64                randconfig-012-20231113   gcc  
x86_64                randconfig-013-20231113   gcc  
x86_64                randconfig-014-20231113   gcc  
x86_64                randconfig-015-20231113   gcc  
x86_64                randconfig-016-20231113   gcc  
x86_64                randconfig-071-20231113   gcc  
x86_64                randconfig-072-20231113   gcc  
x86_64                randconfig-073-20231113   gcc  
x86_64                randconfig-074-20231113   gcc  
x86_64                randconfig-075-20231113   gcc  
x86_64                randconfig-076-20231113   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                randconfig-001-20231113   gcc  
xtensa                randconfig-002-20231113   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
