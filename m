Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6385581FD69
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Dec 2023 08:10:15 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VUHbV7n/;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T1c2r38t8z3bTf
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Dec 2023 18:10:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VUHbV7n/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T1c2h1MRMz2xXY
	for <linux-erofs@lists.ozlabs.org>; Fri, 29 Dec 2023 18:10:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703833804; x=1735369804;
  h=date:from:to:cc:subject:message-id;
  bh=Q/QKxAmcj3mLZqG9Fws7zvLbkfbO3W21nLRhY4i1Kno=;
  b=VUHbV7n/c29P5o2s3kjg/2nduOSXjUkNvMDIeIh9LLbPhJLKzMv+8F5Z
   gzsFbwkEtsCmGRSFGRLlTIW2IWZLhrYQr+UYMLSv7o+eokfoz7AWLL2BS
   +/k8bgUaGLjV4NTKfKFeO1ucsfcLIgxbPA4N4GLQ4xpuH9ce5x6wZx7Ep
   OvL5amGKM+O1bwHO5upctv7sSw8QGpb4naiMZg0OpHoot3BgcrymxcJ8c
   jWvdbOoS7EyFkYqffx6BtCQvn9VI2uVoDlDuE0i0YzIswl1eXq7yeNYCU
   NXDXzU/H2VlJJFafjDpSqzrvWLb3VIlLTT7pUODAPmBxiIQv8bYvG0LxL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="3467196"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="3467196"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 23:09:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="844627124"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="844627124"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 28 Dec 2023 23:09:54 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJ70B-000HAJ-2z;
	Fri, 29 Dec 2023 07:09:51 +0000
Date: Fri, 29 Dec 2023 15:09:05 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 640d17df5cf298e73aa2744fa6296fd47ebd01b0
Message-ID: <202312291501.N6vnSEHm-lkp@intel.com>
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
branch HEAD: 640d17df5cf298e73aa2744fa6296fd47ebd01b0  erofs: avoid debugging output for (de)compressed data

elapsed time: 1468m

configs tested: 257
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
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                   randconfig-001-20231228   gcc  
arc                   randconfig-001-20231229   gcc  
arc                   randconfig-002-20231228   gcc  
arc                   randconfig-002-20231229   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   clang
arm                          exynos_defconfig   gcc  
arm                      footbridge_defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                          pxa3xx_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                   randconfig-001-20231228   gcc  
arm                   randconfig-002-20231228   gcc  
arm                   randconfig-003-20231228   gcc  
arm                   randconfig-004-20231228   gcc  
arm                           sama5_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231228   gcc  
arm64                 randconfig-002-20231228   gcc  
arm64                 randconfig-003-20231228   gcc  
arm64                 randconfig-004-20231228   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231228   gcc  
csky                  randconfig-001-20231229   gcc  
csky                  randconfig-002-20231228   gcc  
csky                  randconfig-002-20231229   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231228   clang
hexagon               randconfig-002-20231228   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231228   gcc  
i386         buildonly-randconfig-002-20231228   gcc  
i386         buildonly-randconfig-003-20231228   gcc  
i386         buildonly-randconfig-004-20231228   gcc  
i386         buildonly-randconfig-005-20231228   gcc  
i386         buildonly-randconfig-006-20231228   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231228   gcc  
i386                  randconfig-002-20231228   gcc  
i386                  randconfig-003-20231228   gcc  
i386                  randconfig-004-20231228   gcc  
i386                  randconfig-005-20231228   gcc  
i386                  randconfig-006-20231228   gcc  
i386                  randconfig-011-20231228   clang
i386                  randconfig-011-20231229   gcc  
i386                  randconfig-012-20231228   clang
i386                  randconfig-012-20231229   gcc  
i386                  randconfig-013-20231228   clang
i386                  randconfig-013-20231229   gcc  
i386                  randconfig-014-20231228   clang
i386                  randconfig-014-20231229   gcc  
i386                  randconfig-015-20231228   clang
i386                  randconfig-015-20231229   gcc  
i386                  randconfig-016-20231228   clang
i386                  randconfig-016-20231229   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20231228   gcc  
loongarch             randconfig-001-20231229   gcc  
loongarch             randconfig-002-20231228   gcc  
loongarch             randconfig-002-20231229   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                           ip22_defconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                   sb1250_swarm_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231228   gcc  
nios2                 randconfig-001-20231229   gcc  
nios2                 randconfig-002-20231228   gcc  
nios2                 randconfig-002-20231229   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20231228   gcc  
parisc                randconfig-001-20231229   gcc  
parisc                randconfig-002-20231228   gcc  
parisc                randconfig-002-20231229   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20231228   gcc  
powerpc               randconfig-002-20231228   gcc  
powerpc               randconfig-003-20231228   gcc  
powerpc                     redwood_defconfig   gcc  
powerpc                     sequoia_defconfig   gcc  
powerpc                     taishan_defconfig   gcc  
powerpc                      tqm8xx_defconfig   gcc  
powerpc64             randconfig-001-20231228   gcc  
powerpc64             randconfig-002-20231228   gcc  
powerpc64             randconfig-003-20231228   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231228   gcc  
riscv                 randconfig-002-20231228   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231228   clang
s390                  randconfig-001-20231229   gcc  
s390                  randconfig-002-20231228   clang
s390                  randconfig-002-20231229   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20231228   gcc  
sh                    randconfig-001-20231229   gcc  
sh                    randconfig-002-20231228   gcc  
sh                    randconfig-002-20231229   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231228   gcc  
sparc64               randconfig-001-20231229   gcc  
sparc64               randconfig-002-20231228   gcc  
sparc64               randconfig-002-20231229   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231228   gcc  
um                    randconfig-002-20231228   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231228   gcc  
x86_64       buildonly-randconfig-001-20231229   clang
x86_64       buildonly-randconfig-002-20231228   gcc  
x86_64       buildonly-randconfig-002-20231229   clang
x86_64       buildonly-randconfig-003-20231228   gcc  
x86_64       buildonly-randconfig-003-20231229   clang
x86_64       buildonly-randconfig-004-20231228   gcc  
x86_64       buildonly-randconfig-004-20231229   clang
x86_64       buildonly-randconfig-005-20231228   gcc  
x86_64       buildonly-randconfig-005-20231229   clang
x86_64       buildonly-randconfig-006-20231228   gcc  
x86_64       buildonly-randconfig-006-20231229   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231228   clang
x86_64                randconfig-002-20231228   clang
x86_64                randconfig-003-20231228   clang
x86_64                randconfig-004-20231228   clang
x86_64                randconfig-005-20231228   clang
x86_64                randconfig-006-20231228   clang
x86_64                randconfig-011-20231228   gcc  
x86_64                randconfig-011-20231229   clang
x86_64                randconfig-012-20231228   gcc  
x86_64                randconfig-012-20231229   clang
x86_64                randconfig-013-20231228   gcc  
x86_64                randconfig-013-20231229   clang
x86_64                randconfig-014-20231228   gcc  
x86_64                randconfig-014-20231229   clang
x86_64                randconfig-015-20231228   gcc  
x86_64                randconfig-015-20231229   clang
x86_64                randconfig-016-20231228   gcc  
x86_64                randconfig-016-20231229   clang
x86_64                randconfig-071-20231228   gcc  
x86_64                randconfig-071-20231229   clang
x86_64                randconfig-072-20231228   gcc  
x86_64                randconfig-072-20231229   clang
x86_64                randconfig-073-20231228   gcc  
x86_64                randconfig-073-20231229   clang
x86_64                randconfig-074-20231228   gcc  
x86_64                randconfig-074-20231229   clang
x86_64                randconfig-075-20231228   gcc  
x86_64                randconfig-075-20231229   clang
x86_64                randconfig-076-20231228   gcc  
x86_64                randconfig-076-20231229   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20231228   gcc  
xtensa                randconfig-001-20231229   gcc  
xtensa                randconfig-002-20231228   gcc  
xtensa                randconfig-002-20231229   gcc  
xtensa                    smp_lx200_defconfig   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
