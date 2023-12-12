Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 366A980E685
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Dec 2023 09:44:44 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DOn/xE2A;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SqBxj4nJsz3bx1
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Dec 2023 19:44:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DOn/xE2A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Tue, 12 Dec 2023 19:44:36 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SqBxc1r7Yz30Pg
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Dec 2023 19:44:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702370676; x=1733906676;
  h=date:from:to:cc:subject:message-id;
  bh=4IYdNJkZD6Sicsl/L1D9XnTty3dPZMLA6yqtzpSS35I=;
  b=DOn/xE2AXJVXx7cV/Mdld9i8AbA59H3oZ1O/IqZYuBq9yUBYh4RFExNv
   brm38hvZ8uoxsChu5L3frn6Jbzv2KoCwf87TRhp92r87PPUINJgJkoZmA
   Im3noiZTfbupAn4GB0tYdULQLzO8CJe+b7+xt/slSIFhjXd9b9XRmr3ok
   LACRm7dV4YZEXdbksoQ/Vbg+kEJJLMhEG3cnNGTdN26pw/Gbsi+xftz6g
   cpMyq7o28utAz5aYSbAlCeYgqAydgf4SSumycfgPdUwSMXEb/Cu6Ek96E
   kTdQGsHhmcW7nEws9ZX1d+x+zIu86CHvfuDK/UX7wt2feX0muMQ04u+b/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1589190"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="1589190"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 00:43:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="864133301"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="864133301"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2023 00:43:25 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rCyMN-000Ivr-1A;
	Tue, 12 Dec 2023 08:43:23 +0000
Date: Tue, 12 Dec 2023 16:41:53 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 6b07eb1629328184dd7d07957c9a9a519a42c5c7
Message-ID: <202312121650.oiWOkWui-lkp@intel.com>
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
branch HEAD: 6b07eb1629328184dd7d07957c9a9a519a42c5c7  erofs: enable sub-page compressed block support

elapsed time: 1456m

configs tested: 260
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
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20231211   gcc  
arc                   randconfig-001-20231212   gcc  
arc                   randconfig-002-20231211   gcc  
arc                   randconfig-002-20231212   gcc  
arc                           tb10x_defconfig   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          exynos_defconfig   gcc  
arm                      footbridge_defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                         nhk8815_defconfig   gcc  
arm                   randconfig-001-20231212   gcc  
arm                   randconfig-002-20231212   gcc  
arm                   randconfig-003-20231212   gcc  
arm                   randconfig-004-20231212   gcc  
arm                        realview_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231212   gcc  
arm64                 randconfig-002-20231212   gcc  
arm64                 randconfig-003-20231212   gcc  
arm64                 randconfig-004-20231212   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231211   gcc  
csky                  randconfig-001-20231212   gcc  
csky                  randconfig-002-20231211   gcc  
csky                  randconfig-002-20231212   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231212   clang
hexagon               randconfig-002-20231212   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231211   clang
i386         buildonly-randconfig-002-20231211   clang
i386         buildonly-randconfig-003-20231211   clang
i386         buildonly-randconfig-004-20231211   clang
i386         buildonly-randconfig-005-20231211   clang
i386         buildonly-randconfig-006-20231211   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231211   clang
i386                  randconfig-002-20231211   clang
i386                  randconfig-003-20231211   clang
i386                  randconfig-004-20231211   clang
i386                  randconfig-005-20231211   clang
i386                  randconfig-006-20231211   clang
i386                  randconfig-011-20231211   gcc  
i386                  randconfig-011-20231212   clang
i386                  randconfig-012-20231211   gcc  
i386                  randconfig-012-20231212   clang
i386                  randconfig-013-20231211   gcc  
i386                  randconfig-013-20231212   clang
i386                  randconfig-014-20231211   gcc  
i386                  randconfig-014-20231212   clang
i386                  randconfig-015-20231211   gcc  
i386                  randconfig-015-20231212   clang
i386                  randconfig-016-20231211   gcc  
i386                  randconfig-016-20231212   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231211   gcc  
loongarch             randconfig-001-20231212   gcc  
loongarch             randconfig-002-20231211   gcc  
loongarch             randconfig-002-20231212   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                          rb532_defconfig   gcc  
mips                         rt305x_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231211   gcc  
nios2                 randconfig-001-20231212   gcc  
nios2                 randconfig-002-20231211   gcc  
nios2                 randconfig-002-20231212   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20231211   gcc  
parisc                randconfig-001-20231212   gcc  
parisc                randconfig-002-20231211   gcc  
parisc                randconfig-002-20231212   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 linkstation_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                   microwatt_defconfig   clang
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20231212   gcc  
powerpc               randconfig-002-20231212   gcc  
powerpc               randconfig-003-20231212   gcc  
powerpc                     tqm8541_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20231212   gcc  
powerpc64             randconfig-002-20231212   gcc  
powerpc64             randconfig-003-20231212   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20231212   gcc  
riscv                 randconfig-002-20231212   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231211   gcc  
s390                  randconfig-001-20231212   clang
s390                  randconfig-002-20231211   gcc  
s390                  randconfig-002-20231212   clang
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20231211   gcc  
sh                    randconfig-001-20231212   gcc  
sh                    randconfig-002-20231211   gcc  
sh                    randconfig-002-20231212   gcc  
sh                          rsk7203_defconfig   gcc  
sh                          rsk7269_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231211   gcc  
sparc64               randconfig-001-20231212   gcc  
sparc64               randconfig-002-20231211   gcc  
sparc64               randconfig-002-20231212   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231212   gcc  
um                    randconfig-002-20231212   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231211   clang
x86_64       buildonly-randconfig-001-20231212   gcc  
x86_64       buildonly-randconfig-002-20231211   clang
x86_64       buildonly-randconfig-002-20231212   gcc  
x86_64       buildonly-randconfig-003-20231211   clang
x86_64       buildonly-randconfig-003-20231212   gcc  
x86_64       buildonly-randconfig-004-20231211   clang
x86_64       buildonly-randconfig-004-20231212   gcc  
x86_64       buildonly-randconfig-005-20231211   clang
x86_64       buildonly-randconfig-005-20231212   gcc  
x86_64       buildonly-randconfig-006-20231211   clang
x86_64       buildonly-randconfig-006-20231212   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231211   clang
x86_64                randconfig-011-20231212   gcc  
x86_64                randconfig-012-20231211   clang
x86_64                randconfig-012-20231212   gcc  
x86_64                randconfig-013-20231211   clang
x86_64                randconfig-013-20231212   gcc  
x86_64                randconfig-014-20231211   clang
x86_64                randconfig-014-20231212   gcc  
x86_64                randconfig-015-20231211   clang
x86_64                randconfig-015-20231212   gcc  
x86_64                randconfig-016-20231211   clang
x86_64                randconfig-016-20231212   gcc  
x86_64                randconfig-071-20231211   clang
x86_64                randconfig-071-20231212   gcc  
x86_64                randconfig-072-20231211   clang
x86_64                randconfig-072-20231212   gcc  
x86_64                randconfig-073-20231211   clang
x86_64                randconfig-073-20231212   gcc  
x86_64                randconfig-074-20231211   clang
x86_64                randconfig-074-20231212   gcc  
x86_64                randconfig-075-20231211   clang
x86_64                randconfig-075-20231212   gcc  
x86_64                randconfig-076-20231211   clang
x86_64                randconfig-076-20231212   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20231211   gcc  
xtensa                randconfig-001-20231212   gcc  
xtensa                randconfig-002-20231211   gcc  
xtensa                randconfig-002-20231212   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
