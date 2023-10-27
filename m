Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B82727D8EEA
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Oct 2023 08:48:40 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jx6cOQ9H;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SGtXw5Mg1z3c2V
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Oct 2023 17:48:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jx6cOQ9H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.24; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SGtXj5tl4z2xTN
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 Oct 2023 17:48:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698389302; x=1729925302;
  h=date:from:to:cc:subject:message-id;
  bh=Spkn0ED7PJkm6meFdKEoMhI576AMmVrTShQK/ei1VuQ=;
  b=Jx6cOQ9HWrASPfYpkLZOsRPx3URunApzLM1BiFGdbmZziET1qognAmtS
   QjNyslbER08ZEjle7nJxSGaQJpDnQ1KaOwb2owkqqGZO/vs81bkCiPNdo
   G9FW13q1PVP7TDMZ9t0ONizD4r4HG3sHMaWJFpHZGK+FBO3X9XuYEIGuA
   PwtB+VWVRgMgC8YXhDAYWMd+VZDQZCew1/9+GRe9teRVx0U9CWKYgxREK
   YqA5vU7/TAPakWi8NIshRkcNZLvAscBOZvXkieAScBX8vHLu9Az5F1Nlj
   6tqfrWsxSZRvRY9t5mpfzO9HzwweibXwQ66xDUvpZ2L7/4HtjnfhgEvjf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="390578949"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="390578949"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 23:48:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="903179614"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="903179614"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 26 Oct 2023 23:45:45 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qwGde-000AYe-1R;
	Fri, 27 Oct 2023 06:48:10 +0000
Date: Fri, 27 Oct 2023 14:47:37 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 3120ee29695aece9fd3ff01747405f273604d96f
Message-ID: <202310271434.pSOVBwim-lkp@intel.com>
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
branch HEAD: 3120ee29695aece9fd3ff01747405f273604d96f  erofs: tidy up redundant includes

elapsed time: 1490m

configs tested: 205
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
arc                                 defconfig   gcc  
arc                   randconfig-001-20231026   gcc  
arc                   randconfig-001-20231027   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231027   gcc  
arm                       spear13xx_defconfig   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                           allnoconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231026   gcc  
i386         buildonly-randconfig-001-20231027   gcc  
i386         buildonly-randconfig-002-20231026   gcc  
i386         buildonly-randconfig-002-20231027   gcc  
i386         buildonly-randconfig-003-20231026   gcc  
i386         buildonly-randconfig-003-20231027   gcc  
i386         buildonly-randconfig-004-20231026   gcc  
i386         buildonly-randconfig-004-20231027   gcc  
i386         buildonly-randconfig-005-20231026   gcc  
i386         buildonly-randconfig-005-20231027   gcc  
i386         buildonly-randconfig-006-20231026   gcc  
i386         buildonly-randconfig-006-20231027   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231026   gcc  
i386                  randconfig-001-20231027   gcc  
i386                  randconfig-002-20231026   gcc  
i386                  randconfig-002-20231027   gcc  
i386                  randconfig-003-20231026   gcc  
i386                  randconfig-003-20231027   gcc  
i386                  randconfig-004-20231026   gcc  
i386                  randconfig-004-20231027   gcc  
i386                  randconfig-005-20231026   gcc  
i386                  randconfig-005-20231027   gcc  
i386                  randconfig-006-20231026   gcc  
i386                  randconfig-006-20231027   gcc  
i386                  randconfig-011-20231026   gcc  
i386                  randconfig-011-20231027   gcc  
i386                  randconfig-012-20231026   gcc  
i386                  randconfig-012-20231027   gcc  
i386                  randconfig-013-20231026   gcc  
i386                  randconfig-013-20231027   gcc  
i386                  randconfig-014-20231026   gcc  
i386                  randconfig-014-20231027   gcc  
i386                  randconfig-015-20231026   gcc  
i386                  randconfig-015-20231027   gcc  
i386                  randconfig-016-20231026   gcc  
i386                  randconfig-016-20231027   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231026   gcc  
loongarch             randconfig-001-20231027   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                     ksi8560_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_virt_defconfig   clang
riscv                 randconfig-001-20231026   gcc  
riscv                 randconfig-001-20231027   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231026   gcc  
s390                  randconfig-001-20231027   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231026   gcc  
sparc                 randconfig-001-20231027   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231026   gcc  
x86_64       buildonly-randconfig-001-20231027   gcc  
x86_64       buildonly-randconfig-002-20231026   gcc  
x86_64       buildonly-randconfig-002-20231027   gcc  
x86_64       buildonly-randconfig-003-20231026   gcc  
x86_64       buildonly-randconfig-003-20231027   gcc  
x86_64       buildonly-randconfig-004-20231026   gcc  
x86_64       buildonly-randconfig-004-20231027   gcc  
x86_64       buildonly-randconfig-005-20231026   gcc  
x86_64       buildonly-randconfig-005-20231027   gcc  
x86_64       buildonly-randconfig-006-20231026   gcc  
x86_64       buildonly-randconfig-006-20231027   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231026   gcc  
x86_64                randconfig-001-20231027   gcc  
x86_64                randconfig-002-20231026   gcc  
x86_64                randconfig-002-20231027   gcc  
x86_64                randconfig-003-20231026   gcc  
x86_64                randconfig-003-20231027   gcc  
x86_64                randconfig-004-20231026   gcc  
x86_64                randconfig-004-20231027   gcc  
x86_64                randconfig-005-20231026   gcc  
x86_64                randconfig-005-20231027   gcc  
x86_64                randconfig-006-20231026   gcc  
x86_64                randconfig-006-20231027   gcc  
x86_64                randconfig-011-20231026   gcc  
x86_64                randconfig-011-20231027   gcc  
x86_64                randconfig-012-20231026   gcc  
x86_64                randconfig-012-20231027   gcc  
x86_64                randconfig-013-20231026   gcc  
x86_64                randconfig-013-20231027   gcc  
x86_64                randconfig-014-20231026   gcc  
x86_64                randconfig-014-20231027   gcc  
x86_64                randconfig-015-20231026   gcc  
x86_64                randconfig-015-20231027   gcc  
x86_64                randconfig-016-20231026   gcc  
x86_64                randconfig-016-20231027   gcc  
x86_64                randconfig-071-20231026   gcc  
x86_64                randconfig-071-20231027   gcc  
x86_64                randconfig-072-20231026   gcc  
x86_64                randconfig-072-20231027   gcc  
x86_64                randconfig-073-20231026   gcc  
x86_64                randconfig-073-20231027   gcc  
x86_64                randconfig-074-20231026   gcc  
x86_64                randconfig-074-20231027   gcc  
x86_64                randconfig-075-20231026   gcc  
x86_64                randconfig-075-20231027   gcc  
x86_64                randconfig-076-20231026   gcc  
x86_64                randconfig-076-20231027   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                          iss_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
