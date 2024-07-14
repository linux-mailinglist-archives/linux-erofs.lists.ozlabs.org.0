Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844DA930895
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Jul 2024 07:20:24 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j+JyvAsm;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WMDDf3HHxz3cZ1
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Jul 2024 15:20:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j+JyvAsm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WMDDX298Mz3c1L
	for <linux-erofs@lists.ozlabs.org>; Sun, 14 Jul 2024 15:20:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720934413; x=1752470413;
  h=date:from:to:cc:subject:message-id;
  bh=ZwhEA2iIMpzein19qAiYjWyVUNMWYTioXPA5vpbVWHs=;
  b=j+JyvAsm8/kk+GFqzoTxbuKL99wNYS+HiAdwfgzab8trajd9g0x4kzUv
   PqOx5tRX4OFg7BQzzbcositB4bNyWMUJyvdTTUXw9YVyCKQNjMXYyb5EP
   vmysNUscbQFTyZDSqrsH7qb1ogBsUii5K9qgIcAKx+6+BcAN3KG3l9r7x
   U7fs57L02zNm9tZFlRMnr+ILUVNsQwVUPGFuzEfg3C6mrQvzALiWvRjcG
   de+Tc9jQNbNfcW+0cl74XDvMkhaQa4Ywkum+T9rY8iyPJHCaR1+wCfFSj
   aYbPiKlQnfBw1ngxenYs86AqxO1EEitTHVklnX1CdMxpe5xghhp9l/C6T
   w==;
X-CSE-ConnectionGUID: nLqA6bzUSneMoJjTQDfGDg==
X-CSE-MsgGUID: P0yTv7YGQdW+AtpWcH5jTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11132"; a="18179766"
X-IronPort-AV: E=Sophos;i="6.09,207,1716274800"; 
   d="scan'208";a="18179766"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2024 22:20:04 -0700
X-CSE-ConnectionGUID: RfKYKASXQoeg/Cr2F4uyiw==
X-CSE-MsgGUID: K6v3TxeXRkqlAMZwK3sqrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,207,1716274800"; 
   d="scan'208";a="53855613"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 13 Jul 2024 22:20:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSreR-000d6o-2R;
	Sun, 14 Jul 2024 05:19:59 +0000
Date: Sun, 14 Jul 2024 13:19:20 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 a3c10bed330b7ab401254a0c91098a03b04f1448
Message-ID: <202407141317.fc4RzJ5z-lkp@intel.com>
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
branch HEAD: a3c10bed330b7ab401254a0c91098a03b04f1448  erofs: silence uninitialized variable warning in z_erofs_scan_folio()

elapsed time: 1396m

configs tested: 252
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsim_700_defconfig   gcc-13.2.0
arc                   randconfig-001-20240713   gcc-13.2.0
arc                   randconfig-001-20240714   gcc-13.2.0
arc                   randconfig-002-20240713   gcc-13.2.0
arc                   randconfig-002-20240714   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                         at91_dt_defconfig   clang-19
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   clang-19
arm                            hisi_defconfig   clang-19
arm                      jornada720_defconfig   clang-19
arm                         lpc18xx_defconfig   gcc-13.2.0
arm                        multi_v5_defconfig   gcc-13.2.0
arm                       omap2plus_defconfig   gcc-14.1.0
arm                         orion5x_defconfig   clang-19
arm                   randconfig-001-20240713   gcc-13.2.0
arm                   randconfig-001-20240714   gcc-13.2.0
arm                   randconfig-002-20240713   gcc-13.2.0
arm                   randconfig-002-20240714   gcc-13.2.0
arm                   randconfig-003-20240713   gcc-13.2.0
arm                   randconfig-003-20240714   gcc-13.2.0
arm                   randconfig-004-20240713   gcc-13.2.0
arm                   randconfig-004-20240714   gcc-13.2.0
arm                        shmobile_defconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240713   gcc-13.2.0
arm64                 randconfig-001-20240714   gcc-13.2.0
arm64                 randconfig-002-20240713   gcc-13.2.0
arm64                 randconfig-002-20240714   gcc-13.2.0
arm64                 randconfig-003-20240713   gcc-13.2.0
arm64                 randconfig-003-20240714   gcc-13.2.0
arm64                 randconfig-004-20240713   gcc-13.2.0
arm64                 randconfig-004-20240714   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240713   gcc-13.2.0
csky                  randconfig-001-20240714   gcc-13.2.0
csky                  randconfig-002-20240713   gcc-13.2.0
csky                  randconfig-002-20240714   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240713   clang-18
i386         buildonly-randconfig-001-20240714   gcc-13
i386         buildonly-randconfig-002-20240713   clang-18
i386         buildonly-randconfig-002-20240714   gcc-13
i386         buildonly-randconfig-003-20240713   gcc-8
i386         buildonly-randconfig-003-20240714   gcc-13
i386         buildonly-randconfig-004-20240713   clang-18
i386         buildonly-randconfig-004-20240714   gcc-13
i386         buildonly-randconfig-005-20240713   gcc-13
i386         buildonly-randconfig-005-20240714   gcc-13
i386         buildonly-randconfig-006-20240713   clang-18
i386         buildonly-randconfig-006-20240714   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240713   gcc-10
i386                  randconfig-001-20240714   gcc-13
i386                  randconfig-002-20240713   gcc-13
i386                  randconfig-002-20240714   gcc-13
i386                  randconfig-003-20240713   gcc-13
i386                  randconfig-003-20240714   gcc-13
i386                  randconfig-004-20240713   clang-18
i386                  randconfig-004-20240714   gcc-13
i386                  randconfig-005-20240713   gcc-10
i386                  randconfig-005-20240714   gcc-13
i386                  randconfig-006-20240713   gcc-12
i386                  randconfig-006-20240714   gcc-13
i386                  randconfig-011-20240713   clang-18
i386                  randconfig-011-20240714   gcc-13
i386                  randconfig-012-20240713   gcc-7
i386                  randconfig-012-20240714   gcc-13
i386                  randconfig-013-20240713   gcc-13
i386                  randconfig-013-20240714   gcc-13
i386                  randconfig-014-20240713   gcc-13
i386                  randconfig-014-20240714   gcc-13
i386                  randconfig-015-20240713   gcc-11
i386                  randconfig-015-20240714   gcc-13
i386                  randconfig-016-20240713   clang-18
i386                  randconfig-016-20240714   gcc-13
loongarch                        alldefconfig   gcc-14.1.0
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240713   gcc-13.2.0
loongarch             randconfig-001-20240714   gcc-13.2.0
loongarch             randconfig-002-20240713   gcc-13.2.0
loongarch             randconfig-002-20240714   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                       bvme6000_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                          multi_defconfig   gcc-13.2.0
m68k                           sun3_defconfig   gcc-14.1.0
microblaze                       alldefconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                         db1xxx_defconfig   gcc-13.2.0
mips                     loongson1b_defconfig   gcc-14.1.0
mips                      malta_kvm_defconfig   gcc-14.1.0
mips                      maltasmvp_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240713   gcc-13.2.0
nios2                 randconfig-001-20240714   gcc-13.2.0
nios2                 randconfig-002-20240713   gcc-13.2.0
nios2                 randconfig-002-20240714   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240713   gcc-13.2.0
parisc                randconfig-001-20240714   gcc-13.2.0
parisc                randconfig-002-20240713   gcc-13.2.0
parisc                randconfig-002-20240714   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                     akebono_defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                   bluestone_defconfig   gcc-13.2.0
powerpc                      chrp32_defconfig   gcc-13.2.0
powerpc                     kmeter1_defconfig   gcc-13.2.0
powerpc                   lite5200b_defconfig   gcc-13.2.0
powerpc                   motionpro_defconfig   gcc-14.1.0
powerpc                     mpc5200_defconfig   gcc-14.1.0
powerpc                      pcm030_defconfig   gcc-13.2.0
powerpc                      ppc44x_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240713   gcc-13.2.0
powerpc               randconfig-001-20240714   gcc-13.2.0
powerpc               randconfig-002-20240713   gcc-13.2.0
powerpc               randconfig-002-20240714   gcc-13.2.0
powerpc               randconfig-003-20240713   gcc-13.2.0
powerpc               randconfig-003-20240714   gcc-13.2.0
powerpc                     skiroot_defconfig   clang-19
powerpc                  storcenter_defconfig   clang-19
powerpc64             randconfig-001-20240713   gcc-13.2.0
powerpc64             randconfig-001-20240714   gcc-13.2.0
powerpc64             randconfig-002-20240713   gcc-13.2.0
powerpc64             randconfig-002-20240714   gcc-13.2.0
powerpc64             randconfig-003-20240713   gcc-13.2.0
powerpc64             randconfig-003-20240714   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                    nommu_k210_defconfig   gcc-14.1.0
riscv                 randconfig-001-20240713   gcc-13.2.0
riscv                 randconfig-001-20240714   gcc-13.2.0
riscv                 randconfig-002-20240713   gcc-13.2.0
riscv                 randconfig-002-20240714   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-19
s390                          debug_defconfig   gcc-13.2.0
s390                                defconfig   clang-19
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240713   gcc-13.2.0
s390                  randconfig-001-20240714   gcc-13.2.0
s390                  randconfig-002-20240713   gcc-13.2.0
s390                  randconfig-002-20240714   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                         ap325rxa_defconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                ecovec24-romimage_defconfig   gcc-14.1.0
sh                    randconfig-001-20240713   gcc-13.2.0
sh                    randconfig-001-20240714   gcc-13.2.0
sh                    randconfig-002-20240713   gcc-13.2.0
sh                    randconfig-002-20240714   gcc-13.2.0
sh                          rsk7264_defconfig   gcc-13.2.0
sh                           se7619_defconfig   gcc-13.2.0
sh                             shx3_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240713   gcc-13.2.0
sparc64               randconfig-001-20240714   gcc-13.2.0
sparc64               randconfig-002-20240713   gcc-13.2.0
sparc64               randconfig-002-20240714   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240713   gcc-13.2.0
um                    randconfig-001-20240714   gcc-13.2.0
um                    randconfig-002-20240713   gcc-13.2.0
um                    randconfig-002-20240714   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240713   clang-18
x86_64       buildonly-randconfig-002-20240713   clang-18
x86_64       buildonly-randconfig-003-20240713   clang-18
x86_64       buildonly-randconfig-004-20240713   clang-18
x86_64       buildonly-randconfig-005-20240713   clang-18
x86_64       buildonly-randconfig-006-20240713   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240713   clang-18
x86_64                randconfig-002-20240713   clang-18
x86_64                randconfig-003-20240713   clang-18
x86_64                randconfig-004-20240713   clang-18
x86_64                randconfig-005-20240713   clang-18
x86_64                randconfig-006-20240713   clang-18
x86_64                randconfig-011-20240713   clang-18
x86_64                randconfig-012-20240713   clang-18
x86_64                randconfig-013-20240713   clang-18
x86_64                randconfig-014-20240713   clang-18
x86_64                randconfig-015-20240713   clang-18
x86_64                randconfig-016-20240713   clang-18
x86_64                randconfig-071-20240713   clang-18
x86_64                randconfig-072-20240713   clang-18
x86_64                randconfig-073-20240713   clang-18
x86_64                randconfig-074-20240713   clang-18
x86_64                randconfig-075-20240713   clang-18
x86_64                randconfig-076-20240713   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  audio_kc705_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240713   gcc-13.2.0
xtensa                randconfig-001-20240714   gcc-13.2.0
xtensa                randconfig-002-20240713   gcc-13.2.0
xtensa                randconfig-002-20240714   gcc-13.2.0
xtensa                    xip_kc705_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
