Return-Path: <linux-erofs+bounces-475-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 943D4AE12E0
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Jun 2025 07:22:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bNm805byKz2yf3;
	Fri, 20 Jun 2025 15:22:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750396960;
	cv=none; b=mx6zxfPStB8gnNaRsgHNiCeYKdKEMCDrBUCCs50CAMaoOgybe3SDMCLsGMTCtAhIitl7EkQXGM4ogRy0mKe0zCeBwuLJnMAOJK3NKSYsbSs6D4/p+nAotTqOwveTZZC0GAfLcP4MJc3kofmCboTtHUibl6/xN4i6Nzx72VaA2guX+294H7XGz/SFDJWNhhpc3o5gJw2mVKKwCf/x6JNkzW6Le8TP/ONhQ39SqZggqYSfgYRWLjQipbN6igKXF1AQUVExi2llTtQLQfEwAC/8uCTvMI5XeuDeMgEzx9G6Cl1EW1O3RjqYva00mHmHJ5v7riktx5bKqLTZkBTTi5OGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750396960; c=relaxed/relaxed;
	bh=uHYq9Ki2j2LzK+zcclsZr35dqJrzVYU4GuSgbC44JEU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mFcAI08BEcve/iFKy45g3lq1x09pXYBcxglgPlGAEeYi6x1SlUlYf4/poYGbPJz2J9jUfnvWBSJ7Ky1cJtjUQZUcuKT51NODXR2xm6S1ucNrfuPCgtpSSboL+lzvLDJKdQ7QFODGlZeMHravKDYfoD/hijbsDseZLI8zzq1haPMQ4zhVyNZNcqLdvv2peHIEI+msdLhKPNpFSaVAlgoGFiSAn/PM8xYbAyP9H+RnJz9PwJV2Cjf5Woix+XzlHGJ/MsbSfHLTvFuK1ENksT1CMrHPsmHmosGuMZiQ7xgVPtRTKfOdiYsUx2bP6+wjbvBkLadwsGO52h5RVUXE7UsAUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DEFsdRK7; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DEFsdRK7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bNm7y0R7cz2xHT
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Jun 2025 15:22:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750396958; x=1781932958;
  h=date:from:to:cc:subject:message-id;
  bh=dKG7N2pKVFCv5DGNfGcNVLmC3Ha7tdHs8ZWhXq/YKJ0=;
  b=DEFsdRK7c+aHZRCoRmXzdKT5xgbM6LmufpPvHth+IA64lcwzQPJo1VJh
   6AE86LBqGtxQG19Cv0U91ixxjPy2Zp5qWILFobo67jjor3ndN7nOBWYOr
   IaojVuqbKOTtJS7J+dvfhJQhxfZM6g9YtyvRKU6Mv7t8t7emseI/JwE0J
   I9YDdYcLIJ+LNRonVS1Hn9Md523hvNGcwGRbeFzL3fgqq+f0BJ/kv18lG
   vWAIQfJNOe6Kgwg4MPDQuOzxuITD7D6uKgI/kxgv8Cryb0350ZFfND8JF
   ftrQzgf+58TkSJVTwYtvkc9zVKCpW6hqtLHccpW33h6ISLlaD8b/e5lvC
   g==;
X-CSE-ConnectionGUID: J/AmplMsRcyo4elGGO16og==
X-CSE-MsgGUID: doaOmxz0SS2I9aUD6sDwyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="51879055"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="51879055"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 22:22:32 -0700
X-CSE-ConnectionGUID: 8CsElU+nSdugc5QM4L+PHA==
X-CSE-MsgGUID: d23czLwgQluj4GRK8GBc8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="155190714"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 19 Jun 2025 22:22:31 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSUCq-000LO2-1y;
	Fri, 20 Jun 2025 05:22:28 +0000
Date: Fri, 20 Jun 2025 13:21:38 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 7869738b6908eec7755818aaf6f3aa068b2f0e1b
Message-ID: <202506201328.YfTtJ8B4-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 7869738b6908eec7755818aaf6f3aa068b2f0e1b  erofs: refuse crafted out-of-file-range encoded extents

elapsed time: 1444m

configs tested: 251
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250619    gcc-15.1.0
arc                   randconfig-001-20250620    clang-21
arc                   randconfig-002-20250619    gcc-15.1.0
arc                   randconfig-002-20250620    clang-21
arc                    vdk_hs38_smp_defconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                   randconfig-001-20250619    clang-21
arm                   randconfig-001-20250620    clang-21
arm                   randconfig-002-20250619    gcc-8.5.0
arm                   randconfig-002-20250620    clang-21
arm                   randconfig-003-20250619    gcc-8.5.0
arm                   randconfig-003-20250620    clang-21
arm                   randconfig-004-20250619    gcc-10.5.0
arm                   randconfig-004-20250620    clang-21
arm                           stm32_defconfig    gcc-15.1.0
arm                       versatile_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250619    gcc-8.5.0
arm64                 randconfig-001-20250620    clang-21
arm64                 randconfig-002-20250619    gcc-9.5.0
arm64                 randconfig-002-20250620    clang-21
arm64                 randconfig-003-20250619    gcc-10.5.0
arm64                 randconfig-003-20250620    clang-21
arm64                 randconfig-004-20250619    gcc-10.5.0
arm64                 randconfig-004-20250620    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250619    gcc-11.5.0
csky                  randconfig-001-20250620    clang-21
csky                  randconfig-002-20250619    gcc-9.3.0
csky                  randconfig-002-20250620    clang-21
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250619    clang-21
hexagon               randconfig-001-20250620    clang-21
hexagon               randconfig-002-20250619    clang-21
hexagon               randconfig-002-20250620    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250619    gcc-12
i386        buildonly-randconfig-001-20250620    clang-20
i386        buildonly-randconfig-002-20250619    gcc-12
i386        buildonly-randconfig-002-20250620    clang-20
i386        buildonly-randconfig-003-20250619    clang-20
i386        buildonly-randconfig-003-20250620    clang-20
i386        buildonly-randconfig-004-20250619    clang-20
i386        buildonly-randconfig-004-20250620    clang-20
i386        buildonly-randconfig-005-20250619    clang-20
i386        buildonly-randconfig-005-20250620    clang-20
i386        buildonly-randconfig-006-20250619    clang-20
i386        buildonly-randconfig-006-20250620    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250620    gcc-12
i386                  randconfig-002-20250620    gcc-12
i386                  randconfig-003-20250620    gcc-12
i386                  randconfig-004-20250620    gcc-12
i386                  randconfig-005-20250620    gcc-12
i386                  randconfig-006-20250620    gcc-12
i386                  randconfig-007-20250620    gcc-12
i386                  randconfig-011-20250620    gcc-12
i386                  randconfig-012-20250620    gcc-12
i386                  randconfig-013-20250620    gcc-12
i386                  randconfig-014-20250620    gcc-12
i386                  randconfig-015-20250620    gcc-12
i386                  randconfig-016-20250620    gcc-12
i386                  randconfig-017-20250620    gcc-12
loongarch                        alldefconfig    gcc-15.1.0
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250619    gcc-15.1.0
loongarch             randconfig-001-20250620    clang-21
loongarch             randconfig-002-20250619    gcc-15.1.0
loongarch             randconfig-002-20250620    clang-21
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          amiga_defconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        stmark2_defconfig    gcc-15.1.0
m68k                           sun3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip32_defconfig    gcc-15.1.0
nios2                         3c120_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250619    gcc-8.5.0
nios2                 randconfig-001-20250620    clang-21
nios2                 randconfig-002-20250619    gcc-8.5.0
nios2                 randconfig-002-20250620    clang-21
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250619    gcc-11.5.0
parisc                randconfig-001-20250620    clang-21
parisc                randconfig-002-20250619    gcc-8.5.0
parisc                randconfig-002-20250620    clang-21
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     ep8248e_defconfig    gcc-15.1.0
powerpc                     kmeter1_defconfig    gcc-15.1.0
powerpc                     mpc83xx_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250619    gcc-9.3.0
powerpc               randconfig-001-20250620    clang-21
powerpc               randconfig-002-20250619    clang-21
powerpc               randconfig-002-20250620    clang-21
powerpc               randconfig-003-20250619    gcc-10.5.0
powerpc               randconfig-003-20250620    clang-21
powerpc64             randconfig-001-20250619    gcc-11.5.0
powerpc64             randconfig-001-20250620    clang-21
powerpc64             randconfig-002-20250619    clang-21
powerpc64             randconfig-002-20250620    clang-21
powerpc64             randconfig-003-20250619    gcc-10.5.0
powerpc64             randconfig-003-20250620    clang-21
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250619    gcc-11.5.0
riscv                 randconfig-001-20250620    gcc-13.3.0
riscv                 randconfig-002-20250619    clang-16
riscv                 randconfig-002-20250620    gcc-13.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250619    clang-19
s390                  randconfig-001-20250620    gcc-13.3.0
s390                  randconfig-002-20250619    gcc-13.2.0
s390                  randconfig-002-20250620    gcc-13.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                 kfr2r09-romimage_defconfig    gcc-15.1.0
sh                    randconfig-001-20250619    gcc-9.3.0
sh                    randconfig-001-20250620    gcc-13.3.0
sh                    randconfig-002-20250619    gcc-9.3.0
sh                    randconfig-002-20250620    gcc-13.3.0
sh                           se7343_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250619    gcc-14.3.0
sparc                 randconfig-001-20250620    gcc-13.3.0
sparc                 randconfig-002-20250619    gcc-10.3.0
sparc                 randconfig-002-20250620    gcc-13.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250619    gcc-13.3.0
sparc64               randconfig-001-20250620    gcc-13.3.0
sparc64               randconfig-002-20250619    gcc-8.5.0
sparc64               randconfig-002-20250620    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250619    clang-19
um                    randconfig-001-20250620    gcc-13.3.0
um                    randconfig-002-20250619    clang-21
um                    randconfig-002-20250620    gcc-13.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250619    clang-20
x86_64      buildonly-randconfig-001-20250620    gcc-12
x86_64      buildonly-randconfig-002-20250619    gcc-12
x86_64      buildonly-randconfig-002-20250620    gcc-12
x86_64      buildonly-randconfig-003-20250619    clang-20
x86_64      buildonly-randconfig-003-20250620    gcc-12
x86_64      buildonly-randconfig-004-20250619    gcc-12
x86_64      buildonly-randconfig-004-20250620    gcc-12
x86_64      buildonly-randconfig-005-20250619    clang-20
x86_64      buildonly-randconfig-005-20250620    gcc-12
x86_64      buildonly-randconfig-006-20250619    gcc-12
x86_64      buildonly-randconfig-006-20250620    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250620    clang-20
x86_64                randconfig-002-20250620    clang-20
x86_64                randconfig-003-20250620    clang-20
x86_64                randconfig-004-20250620    clang-20
x86_64                randconfig-005-20250620    clang-20
x86_64                randconfig-006-20250620    clang-20
x86_64                randconfig-007-20250620    clang-20
x86_64                randconfig-008-20250620    clang-20
x86_64                randconfig-071-20250620    clang-20
x86_64                randconfig-072-20250620    clang-20
x86_64                randconfig-073-20250620    clang-20
x86_64                randconfig-074-20250620    clang-20
x86_64                randconfig-075-20250620    clang-20
x86_64                randconfig-076-20250620    clang-20
x86_64                randconfig-077-20250620    clang-20
x86_64                randconfig-078-20250620    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250619    gcc-9.3.0
xtensa                randconfig-001-20250620    gcc-13.3.0
xtensa                randconfig-002-20250619    gcc-8.5.0
xtensa                randconfig-002-20250620    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

