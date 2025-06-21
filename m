Return-Path: <linux-erofs+bounces-479-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A63FAE2844
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Jun 2025 11:31:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bPTct3MQcz2yF0;
	Sat, 21 Jun 2025 19:31:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750498302;
	cv=none; b=i9sHXCa9sYy11MOKntN+7ufN1TrZhk1v1K+euqlGm7GTL9FYezKrTwt2SjVUtsXeOd4fddD7HTuUBRL4irCKtc/cLZeTiTlhILC92dCMWA8lg+P3T/CNpEjAgEYhkVytUUQfYf0Q7uqf9aQ2jBY2KTSlRNOooLDwZkK5F16sPRV9Te08UaGpqfMu7sbUdk9v680Yr2xSHe6lKZbWS/qHNjS2xRx9GaMpK1u3rXanjbbNB9ShK4rTXblSyWNa0vYV4BtSgJKS/IDaks4Fp8gaUWzix8yyx8Iy7D9viiMmVlre/YYVMwms6SQnapoPx8f7ETCLxzshrlnu7a5SvqAy/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750498302; c=relaxed/relaxed;
	bh=3Pa8HljFQF67P43t0Cnjma6P44AEIvVQqQ8ZsgJMqn4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ViJQhHNrirKk+LfU+Q0ih7nRxGSUbpGUitDm0cyHDutKAk155aKOWZtQYEIptkEYaMwdgSxaoEfJv9Hp11ksOMKPLBtvsVx7uVrPY3AGoynYddHVuLoxifmcC3inBw96a9slFDpZmk2UM3sgg2cYRRBHuodG5G3QErBFvG+4uRUnhqPeO20yrF8CuQdR70TD8HGcegWE02mHLcyJAnUmeca9Up3MPGUS6gq21Z26/1NQz48sLk5yCzubUhjKQxcQiGx1kppJqYcs88lCOUcFYqYwtBPwwRz5OK16vnwAbh67EeISaglJiL4jZg67lU46IHW6GqfUieUAODRvfYw/Tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hIArkC8X; dkim-atps=neutral; spf=pass (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hIArkC8X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bPTcr0QHxz2xsW
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Jun 2025 19:31:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750498301; x=1782034301;
  h=date:from:to:cc:subject:message-id;
  bh=Vf/JlBIobefmO7WN2eP2EYZUDYzLJU5zjIIVQ5UEtcY=;
  b=hIArkC8Xmtl4pTVwSaji2urH2fnUsMKw88Jj/66yt9lY96xSRxC9ekYY
   sCByx8iSMK6cz66SpQHY2VaVZZTzFwVrGJj4Viki4QPPyui+7liKMZs3M
   zKU6WnaG2Id4SeGHqcEM5Lz+ldpAozQr26LI4kPDPYbrbb+SlhRzEbtH8
   6PMJ9ks/p0AEyOIWO69N+jS/e0mPV5HpTcO8NqaKHJLpa8ovTgjXKDqrs
   Uqr1cUPMZk+ZkdJ+Bk7usmCQ/1mY3d+MnZp+7U5P0de4U5lTqHV9U5+Uk
   Px0wYBv1dYfCbzUcxjq9kEWYFWTvtJihq2XXrkI9xAgraJU0tUHKEcyCg
   Q==;
X-CSE-ConnectionGUID: Pd4gqx8AQ2u7MRHm3Gyy+w==
X-CSE-MsgGUID: YEzfs0HrQeq6RhFDmEPtKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52632767"
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="52632767"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2025 02:31:35 -0700
X-CSE-ConnectionGUID: MMwTG2NRT9G/eiIDWusbug==
X-CSE-MsgGUID: 8wcYqD3QSYCp5Ca9LTzNZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="155511635"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 21 Jun 2025 02:31:33 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSuZP-000MW4-0G;
	Sat, 21 Jun 2025 09:31:31 +0000
Date: Sat, 21 Jun 2025 17:31:20 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 417b8af2e30d7f131682a893ad79c506fd39c624
Message-ID: <202506211710.PlwGYmkP-lkp@intel.com>
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
branch HEAD: 417b8af2e30d7f131682a893ad79c506fd39c624  erofs: remove a superfluous check for encoded extents

elapsed time: 991m

configs tested: 167
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                      axs103_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20250621    gcc-8.5.0
arc                   randconfig-002-20250621    gcc-10.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    gcc-15.1.0
arm                            dove_defconfig    gcc-15.1.0
arm                            hisi_defconfig    gcc-15.1.0
arm                             mxs_defconfig    clang-21
arm                       omap2plus_defconfig    gcc-15.1.0
arm                         orion5x_defconfig    clang-21
arm                   randconfig-001-20250621    clang-21
arm                   randconfig-002-20250621    gcc-15.1.0
arm                   randconfig-003-20250621    clang-20
arm                   randconfig-004-20250621    gcc-8.5.0
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250621    clang-21
arm64                 randconfig-002-20250621    gcc-15.1.0
arm64                 randconfig-003-20250621    clang-17
arm64                 randconfig-004-20250621    gcc-10.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250621    gcc-15.1.0
csky                  randconfig-002-20250621    gcc-15.1.0
hexagon                          alldefconfig    clang-21
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250621    clang-21
hexagon               randconfig-002-20250621    clang-16
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250621    clang-20
i386        buildonly-randconfig-002-20250621    gcc-12
i386        buildonly-randconfig-003-20250621    clang-20
i386        buildonly-randconfig-004-20250621    clang-20
i386        buildonly-randconfig-005-20250621    clang-20
i386        buildonly-randconfig-006-20250621    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250621    gcc-12.4.0
loongarch             randconfig-002-20250621    gcc-15.1.0
m68k                             alldefconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                           sun3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    clang-21
mips                         bigsur_defconfig    gcc-15.1.0
mips                      bmips_stb_defconfig    clang-21
nios2                         3c120_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250621    gcc-9.3.0
nios2                 randconfig-002-20250621    gcc-12.4.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                    or1ksim_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250621    gcc-10.5.0
parisc                randconfig-002-20250621    gcc-12.4.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                    amigaone_defconfig    gcc-15.1.0
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc                     kmeter1_defconfig    gcc-15.1.0
powerpc                     ksi8560_defconfig    gcc-15.1.0
powerpc                     mpc512x_defconfig    clang-21
powerpc                     mpc5200_defconfig    clang-21
powerpc               randconfig-001-20250621    clang-17
powerpc               randconfig-002-20250621    clang-19
powerpc               randconfig-003-20250621    gcc-8.5.0
powerpc                     tqm8555_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250621    gcc-11.5.0
powerpc64             randconfig-002-20250621    gcc-13.3.0
powerpc64             randconfig-003-20250621    gcc-11.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250621    clang-21
riscv                 randconfig-002-20250621    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250621    clang-21
s390                  randconfig-002-20250621    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                          landisk_defconfig    gcc-15.1.0
sh                     magicpanelr2_defconfig    gcc-15.1.0
sh                    randconfig-001-20250621    gcc-15.1.0
sh                    randconfig-002-20250621    gcc-15.1.0
sh                          rsk7203_defconfig    gcc-15.1.0
sh                      rts7751r2d1_defconfig    gcc-15.1.0
sh                           se7343_defconfig    gcc-15.1.0
sh                           se7780_defconfig    gcc-15.1.0
sh                        sh7785lcr_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250621    gcc-15.1.0
sparc                 randconfig-002-20250621    gcc-15.1.0
sparc64               randconfig-001-20250621    gcc-8.5.0
sparc64               randconfig-002-20250621    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250621    clang-21
um                    randconfig-002-20250621    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250621    gcc-12
x86_64      buildonly-randconfig-002-20250621    clang-20
x86_64      buildonly-randconfig-003-20250621    gcc-12
x86_64      buildonly-randconfig-004-20250621    gcc-12
x86_64      buildonly-randconfig-005-20250621    gcc-12
x86_64      buildonly-randconfig-006-20250621    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250621    gcc-12
x86_64                randconfig-002-20250621    gcc-12
x86_64                randconfig-003-20250621    gcc-12
x86_64                randconfig-004-20250621    gcc-12
x86_64                randconfig-005-20250621    gcc-12
x86_64                randconfig-006-20250621    gcc-12
x86_64                randconfig-007-20250621    gcc-12
x86_64                randconfig-008-20250621    gcc-12
x86_64                randconfig-071-20250621    gcc-12
x86_64                randconfig-072-20250621    gcc-12
x86_64                randconfig-073-20250621    gcc-12
x86_64                randconfig-074-20250621    gcc-12
x86_64                randconfig-075-20250621    gcc-12
x86_64                randconfig-076-20250621    gcc-12
x86_64                randconfig-077-20250621    gcc-12
x86_64                randconfig-078-20250621    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250621    gcc-12.4.0
xtensa                randconfig-002-20250621    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

