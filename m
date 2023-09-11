Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F1079A844
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Sep 2023 15:22:44 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kx33ov3F;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RknSy1rgNz3dF7
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Sep 2023 23:22:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kx33ov3F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.115; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RknSX3cPJz3dDG
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Sep 2023 23:22:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694438540; x=1725974540;
  h=date:from:to:cc:subject:message-id;
  bh=h+dybPT1mwO4dk5bk8FIc18TRt/PxcRVvGohfD+ocs4=;
  b=Kx33ov3F2dWJcp9HWYBCW1ttl2b0nJBtPv17OhVb4BS0sFTtrf0itAHF
   vVkmSM0PgwYJktiVz8QbACoW32ZNz+xXFIVOauxlSB8t1ei8e8cXzPeWl
   /Y0o5A7g7QTsd7NEQBkjNMY/P+/vQsoZaal/+ZomGQyV2yfCSZqUUcQHq
   anU1RNoqet/CsBFWfpA0ohn8GzCDCQXbCDDE9YZWNYhcjPsyOxtU4c809
   7qCCdTqgeFr8MI2YaU6VdGLRxptKfTMEofiP87HEW+HCTlovgtC7ycXse
   z3WnIPD8I4fjYwB9J3Pf3F9QsUnAW4++F1sSdnkG+JJODcenIG4pNI3yh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="377991989"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="377991989"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 06:22:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="866943438"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="866943438"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 11 Sep 2023 06:22:12 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qfgrh-0006G6-2z;
	Mon, 11 Sep 2023 13:22:09 +0000
Date: Mon, 11 Sep 2023 21:21:24 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 75a5221630fe5aa3fedba7a06be618db0f79ba1e
Message-ID: <202309112122.lZA4OBGL-lkp@intel.com>
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
branch HEAD: 75a5221630fe5aa3fedba7a06be618db0f79ba1e  erofs: fix memory leak of LZMA global compressed deduplication

elapsed time: 721m

configs tested: 198
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230911   gcc  
alpha                randconfig-r006-20230911   gcc  
alpha                randconfig-r014-20230911   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20230911   gcc  
arc                  randconfig-r012-20230911   gcc  
arc                  randconfig-r023-20230911   gcc  
arc                  randconfig-r032-20230911   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          exynos_defconfig   gcc  
arm                   milbeaut_m10v_defconfig   clang
arm                            mps2_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                   randconfig-001-20230911   gcc  
arm                        realview_defconfig   gcc  
arm                         socfpga_defconfig   clang
arm                           sunxi_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r014-20230911   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230911   gcc  
csky                 randconfig-r006-20230911   gcc  
csky                 randconfig-r013-20230911   gcc  
hexagon               randconfig-001-20230911   clang
hexagon               randconfig-002-20230911   clang
hexagon              randconfig-r026-20230911   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230911   gcc  
i386         buildonly-randconfig-002-20230911   gcc  
i386         buildonly-randconfig-003-20230911   gcc  
i386         buildonly-randconfig-004-20230911   gcc  
i386         buildonly-randconfig-005-20230911   gcc  
i386         buildonly-randconfig-006-20230911   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-013-20230911   clang
i386                 randconfig-r005-20230911   gcc  
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230911   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                 randconfig-r002-20230911   gcc  
m68k                 randconfig-r022-20230911   gcc  
m68k                 randconfig-r025-20230911   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r003-20230911   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                         cobalt_defconfig   gcc  
mips                          malta_defconfig   clang
mips                        omega2p_defconfig   clang
mips                        qi_lb60_defconfig   clang
mips                 randconfig-r015-20230911   gcc  
mips                 randconfig-r036-20230911   clang
mips                          rb532_defconfig   gcc  
mips                   sb1250_swarm_defconfig   clang
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r016-20230911   gcc  
nios2                randconfig-r026-20230911   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r011-20230911   gcc  
openrisc             randconfig-r021-20230911   gcc  
openrisc             randconfig-r035-20230911   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230911   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                 mpc836x_rdk_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc                     tqm8555_defconfig   gcc  
powerpc64            randconfig-r004-20230911   gcc  
powerpc64            randconfig-r012-20230911   clang
powerpc64            randconfig-r022-20230911   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230911   gcc  
riscv                randconfig-r033-20230911   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230911   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                   randconfig-r011-20230911   gcc  
sh                           se7751_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r004-20230911   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r016-20230911   gcc  
um                   randconfig-r035-20230911   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230911   gcc  
x86_64       buildonly-randconfig-002-20230911   gcc  
x86_64       buildonly-randconfig-003-20230911   gcc  
x86_64       buildonly-randconfig-004-20230911   gcc  
x86_64       buildonly-randconfig-005-20230911   gcc  
x86_64       buildonly-randconfig-006-20230911   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230911   clang
x86_64                randconfig-002-20230911   clang
x86_64                randconfig-003-20230911   clang
x86_64                randconfig-004-20230911   clang
x86_64                randconfig-005-20230911   clang
x86_64                randconfig-006-20230911   clang
x86_64                randconfig-011-20230911   gcc  
x86_64                randconfig-012-20230911   gcc  
x86_64                randconfig-013-20230911   gcc  
x86_64                randconfig-014-20230911   gcc  
x86_64                randconfig-015-20230911   gcc  
x86_64                randconfig-016-20230911   gcc  
x86_64                randconfig-071-20230911   gcc  
x86_64                randconfig-072-20230911   gcc  
x86_64                randconfig-073-20230911   gcc  
x86_64                randconfig-074-20230911   gcc  
x86_64                randconfig-075-20230911   gcc  
x86_64                randconfig-076-20230911   gcc  
x86_64               randconfig-r002-20230911   gcc  
x86_64               randconfig-r031-20230911   gcc  
x86_64               randconfig-r034-20230911   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                              defconfig   gcc  
xtensa               randconfig-r001-20230911   gcc  
xtensa               randconfig-r024-20230911   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
