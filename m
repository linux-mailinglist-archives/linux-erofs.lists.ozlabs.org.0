Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6518D969069
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2024 01:25:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WyPxw1q9bz2yL0
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2024 09:25:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725319536;
	cv=none; b=mZUEuddGB2y9VFmZ9ofoQjRZpjX5H9Xfn2bv/c0t1anb5M+Tw27Vzp1fAZ/UeBEl5F6ZOEWj+8chT4U8qv616KVGuNrfdqpGjNFrwJMLb4UrvtQfeMhMw/hulK8CTwhVmKyUUnmyzjbhXOqcopJkkDmNQZhG+BR4bOkTJk+ZkWXTeBGi2I7MDbQw8uU7BN6gAA3zpWzLGboL+cDJymN8e5bxRL+8WCxFlA9jrU3UYV2SkEwPzC6NR89PP4KD67cAdFZN4dsMjFPOsqX8ZZ70X5qoNfe9GdNW2tRMXPJT9G13MOomN4zTnSCzQduuIytMh5k4bAn3R3JWyhExpdBXjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725319536; c=relaxed/relaxed;
	bh=FQ+eL68R3HqF5fToHW+eRwpv5XUHKSABrkTT7FdY6GY=;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID; b=lnNiTbrzxb6GxJTPqa7zmz8fWIGkw89VMvQEOLLv8iPGneJgpdRhMQXJhJIao9gKlcN6gH6L/C9bAUahDxp/N4bMeghs8Irt5IVhmQwKmYU8+Qu1WL4AwLGBQ8MozSqdY8kcEZ9Cwb6oMJg1ghgrqmg0EJNISNadaQysX4b8uLlqVFhkdLcL+nzq8P1TRQdndKKnm/5AYyNuMoIcG1Wtwe5rrs4AZtaH9yWFVLJ//dg708AEQC9Bs8qWSfl4J9iGBJa2RpMx7DHMB51rPY3PkCiiyAXiubCRkJHgNwLwmEcbVd1Euv4Hhx72AFWi6nFouXYqDwVqkrvbXTR29ZVsTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MzVzF530; dkim-atps=neutral; spf=pass (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MzVzF530;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WyPxp3rvvz2xck
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Sep 2024 09:25:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725319535; x=1756855535;
  h=date:from:to:cc:subject:message-id;
  bh=ZnRUF9fLeyxzROAqyvoPcGGBC58Vj43bLkHI3VwQOxw=;
  b=MzVzF5303FvbWR9dmoE5ZxDMpMpW5alOZQ7GDVXnjWvh641897UWG1Jy
   fuG9kzNpdQUkBnKtYJb1SfxGd9RnIKgK1mNPMZztWa4QLmkQQKLli7/BA
   xKzQb+bDeECLXrks07MlJ8/fTScyEd762qz3HOoWHag2Iy6W/6EaeToF7
   YHXbKXWnfVh/K/tLCNSFPLTIrbyLpHblQ4HfykikqVn2YxRaNPjat6Beo
   +zZyRrcF94d+32BaxaAzsuVXsnGT0bL6sH6PGrhZ8oROefRiN/BXV0xly
   xJV/fFwmrlHHdvY0LaZbD4IsWy6EnNfeT3pjr6E5l0g/GBvYIaZ4j5WQg
   w==;
X-CSE-ConnectionGUID: J/BFYYAZRh23ySU3wM9/pg==
X-CSE-MsgGUID: eX3SvZYgQ7OItv5Ihk1Alw==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="34470107"
X-IronPort-AV: E=Sophos;i="6.10,196,1719903600"; 
   d="scan'208";a="34470107"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 16:25:28 -0700
X-CSE-ConnectionGUID: xmHvZaEsTqGLodiI4I/5NA==
X-CSE-MsgGUID: qi+cjVSZT5mWDqOuMWfokQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,196,1719903600"; 
   d="scan'208";a="64757045"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 02 Sep 2024 16:25:26 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slGQF-00061W-2m;
	Mon, 02 Sep 2024 23:25:23 +0000
Date: Tue, 03 Sep 2024 07:25:16 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 92da11bddec83ed87e7117beb9555440c8fa7325
Message-ID: <202409030714.aHxhNHmx-lkp@intel.com>
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
branch HEAD: 92da11bddec83ed87e7117beb9555440c8fa7325  erofs: mark experimental fscache backend deprecated

elapsed time: 998m

configs tested: 135
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                          axs103_defconfig   gcc-14.1.0
arc                                 defconfig   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                       imx_v4_v5_defconfig   gcc-14.1.0
arm                        neponset_defconfig   gcc-14.1.0
arm                         vf610m4_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240902   clang-18
i386         buildonly-randconfig-002-20240902   clang-18
i386         buildonly-randconfig-003-20240902   clang-18
i386         buildonly-randconfig-004-20240902   clang-18
i386         buildonly-randconfig-005-20240902   clang-18
i386         buildonly-randconfig-006-20240902   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240902   clang-18
i386                  randconfig-002-20240902   clang-18
i386                  randconfig-003-20240902   clang-18
i386                  randconfig-004-20240902   clang-18
i386                  randconfig-005-20240902   clang-18
i386                  randconfig-006-20240902   clang-18
i386                  randconfig-011-20240902   clang-18
i386                  randconfig-012-20240902   clang-18
i386                  randconfig-013-20240902   clang-18
i386                  randconfig-014-20240902   clang-18
i386                  randconfig-015-20240902   clang-18
i386                  randconfig-016-20240902   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          amiga_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                       m5208evb_defconfig   gcc-14.1.0
m68k                       m5249evb_defconfig   gcc-14.1.0
m68k                          sun3x_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                 decstation_r4k_defconfig   gcc-14.1.0
mips                           mtx1_defconfig   gcc-14.1.0
mips                       rbtx49xx_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                        cell_defconfig   gcc-14.1.0
powerpc                   currituck_defconfig   gcc-14.1.0
powerpc                       ebony_defconfig   gcc-14.1.0
powerpc                     powernv_defconfig   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                      rts7751r2d1_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240902   clang-18
x86_64       buildonly-randconfig-002-20240902   clang-18
x86_64       buildonly-randconfig-003-20240902   clang-18
x86_64       buildonly-randconfig-004-20240902   clang-18
x86_64       buildonly-randconfig-005-20240902   clang-18
x86_64       buildonly-randconfig-006-20240902   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240902   clang-18
x86_64                randconfig-002-20240902   clang-18
x86_64                randconfig-003-20240902   clang-18
x86_64                randconfig-004-20240902   clang-18
x86_64                randconfig-005-20240902   clang-18
x86_64                randconfig-006-20240902   clang-18
x86_64                randconfig-011-20240902   clang-18
x86_64                randconfig-012-20240902   clang-18
x86_64                randconfig-013-20240902   clang-18
x86_64                randconfig-014-20240902   clang-18
x86_64                randconfig-015-20240902   clang-18
x86_64                randconfig-016-20240902   clang-18
x86_64                randconfig-071-20240902   clang-18
x86_64                randconfig-072-20240902   clang-18
x86_64                randconfig-073-20240902   clang-18
x86_64                randconfig-074-20240902   clang-18
x86_64                randconfig-075-20240902   clang-18
x86_64                randconfig-076-20240902   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  cadence_csp_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
