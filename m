Return-Path: <linux-erofs+bounces-336-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A664ABA1D1
	for <lists+linux-erofs@lfdr.de>; Fri, 16 May 2025 19:19:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZzYj06NBYz30RT;
	Sat, 17 May 2025 03:19:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747415956;
	cv=none; b=Yhv/rHaFK4yND9GVEjVDhaRrDF/+uJoCXUYZkvU8QSLyvSuG7dfvh/drCDV2y+FBIhT7aY6Hr2ty9Emmrgax70V/vVU/nkF6lJ73wM6sulP+6Tue6EV8OzJJMpHMDg9q/riv74+efb76qO8wO7geB77IBS420Qkhltuw3wDJiLc2DDAmGP89ERfpeuw3rDYjKbP3x3PV+GdwCUWjTEUzl++PzMrh53WZ8bXWwNeqyrTuvJlQ3Pm99/7ONe3ykcOu4zALV/9FLetyZq1GYLcqYS/g8C6qhWO319kbjMRGakwsJQFJarXcHqmR+VaLDRf5E9iy2moZzytKUt300UspIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747415956; c=relaxed/relaxed;
	bh=AHLE9bxGaFHdod3lK8rm9CnF9AYz62SxciZVbL75vtY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=djrFnfEQ6OVfM9n3sgS/Wyn74bbmJAD9hOHmuE/Z3eqxSNhZI33C75Qz8kxcVJDlmVT5Zp6f0Zwo9ur+B0sGShwwQ2r8b+OpADsu1IdfcC/dnXyLkyNVrhVahukCt3LlSSAPmnbwIwPyIxpfQY5EQ476XBcUQ6B+t8u7LQoi5dKQuXCuJZ+ix9zSr+j8IvqqTfeNjCVWN45bSSjotKI2w2VrHkZpa5d6Osr76QX+rftyIjsBoilVeP+KInObgkH+MVuaeLB0lXyXcXMdQRvZkhX0Ensh4tGjphtN1Oy/7hZcZa8CDpmT1wESpXKAfjVCK40GejCiCrg2L/SWz/bgWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jibmt6pO; dkim-atps=neutral; spf=pass (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jibmt6pO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZzYhx6Ltlz30RN
	for <linux-erofs@lists.ozlabs.org>; Sat, 17 May 2025 03:19:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747415954; x=1778951954;
  h=date:from:to:cc:subject:message-id;
  bh=uB9mbuRNkbMvAhC+b59QMe/GYi9H9biwmmWduNQ/Rp0=;
  b=Jibmt6pOrCegsZMHg7/LFhblkb/xKnBE4qHUe7mCFYDRz8/E8thZTkxO
   4YFFrxwAPBzH23bIgLXPU18iftSBS9juTRmz/jzEe/kIGBaXrT4w1Y4Vk
   /JIT2ITuOGuqSgTulDoKumi2NaH5dHamMqwrCyXnpWm3KhNpfoVVoaB6A
   ABss2mnHI9jOodIpvFkfbRedrEc/VqCY3ypFTdbdm6h4Abb1ychdr8O+e
   em2VD6QE/0enYNMQk+Tl9aG4J1vaRvdl/ZPBTdhezU+j8YvNUOFB6zIIs
   MOAdZENd7qWQFJvFnHuU6SipUfEzqHvpFmHWMlVCmrNySClTVuPc/qu3n
   g==;
X-CSE-ConnectionGUID: C2i99JU/RTeOKciRD62axw==
X-CSE-MsgGUID: ZL5mvXIVRry+KGL9+aA7Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="60787231"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="60787231"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 10:19:09 -0700
X-CSE-ConnectionGUID: 6Ds23uWnTsmSmdzwoh/0Pw==
X-CSE-MsgGUID: G2a2us3bRgCkhqQHGsud/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="139149225"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 16 May 2025 10:19:08 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFyiA-000JZ5-0B;
	Fri, 16 May 2025 17:19:06 +0000
Date: Sat, 17 May 2025 01:18:48 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 12bf25d1659b1ec55e44fad2485155707062df79
Message-ID: <202505170138.wnHh7ru6-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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
branch HEAD: 12bf25d1659b1ec55e44fad2485155707062df79  erofs: lazily initialize per-CPU workers and CPU hotplug hooks

elapsed time: 1098m

configs tested: 217
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                          axs101_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                         haps_hs_defconfig    gcc-14.2.0
arc                   randconfig-001-20250516    gcc-13.3.0
arc                   randconfig-001-20250516    gcc-9.5.0
arc                   randconfig-002-20250516    gcc-13.3.0
arc                   randconfig-002-20250516    gcc-9.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-14.2.0
arm                       imx_v6_v7_defconfig    gcc-14.2.0
arm                           imxrt_defconfig    gcc-14.2.0
arm                   randconfig-001-20250516    gcc-7.5.0
arm                   randconfig-001-20250516    gcc-9.5.0
arm                   randconfig-002-20250516    clang-21
arm                   randconfig-002-20250516    gcc-9.5.0
arm                   randconfig-003-20250516    clang-21
arm                   randconfig-003-20250516    gcc-9.5.0
arm                   randconfig-004-20250516    clang-21
arm                   randconfig-004-20250516    gcc-9.5.0
arm                           sama5_defconfig    gcc-14.2.0
arm                           sama7_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250516    gcc-9.5.0
arm64                 randconfig-002-20250516    gcc-9.5.0
arm64                 randconfig-003-20250516    gcc-5.5.0
arm64                 randconfig-003-20250516    gcc-9.5.0
arm64                 randconfig-004-20250516    gcc-9.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250516    clang-21
csky                  randconfig-001-20250516    gcc-14.2.0
csky                  randconfig-002-20250516    clang-21
csky                  randconfig-002-20250516    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250516    clang-19
hexagon               randconfig-001-20250516    clang-21
hexagon               randconfig-002-20250516    clang-21
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250516    clang-20
i386        buildonly-randconfig-002-20250516    clang-20
i386        buildonly-randconfig-002-20250516    gcc-12
i386        buildonly-randconfig-003-20250516    clang-20
i386        buildonly-randconfig-004-20250516    clang-20
i386        buildonly-randconfig-005-20250516    clang-20
i386        buildonly-randconfig-006-20250516    clang-20
i386        buildonly-randconfig-006-20250516    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250516    gcc-12
i386                  randconfig-002-20250516    gcc-12
i386                  randconfig-003-20250516    gcc-12
i386                  randconfig-004-20250516    gcc-12
i386                  randconfig-005-20250516    gcc-12
i386                  randconfig-006-20250516    gcc-12
i386                  randconfig-007-20250516    gcc-12
i386                  randconfig-011-20250516    gcc-12
i386                  randconfig-012-20250516    gcc-12
i386                  randconfig-013-20250516    gcc-12
i386                  randconfig-014-20250516    gcc-12
i386                  randconfig-015-20250516    gcc-12
i386                  randconfig-016-20250516    gcc-12
i386                  randconfig-017-20250516    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250516    clang-21
loongarch             randconfig-001-20250516    gcc-14.2.0
loongarch             randconfig-002-20250516    clang-21
loongarch             randconfig-002-20250516    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    gcc-14.2.0
mips                         bigsur_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250516    clang-21
nios2                 randconfig-001-20250516    gcc-13.3.0
nios2                 randconfig-002-20250516    clang-21
nios2                 randconfig-002-20250516    gcc-13.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250516    clang-21
parisc                randconfig-001-20250516    gcc-10.5.0
parisc                randconfig-002-20250516    clang-21
parisc                randconfig-002-20250516    gcc-12.4.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                   currituck_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250516    clang-21
powerpc               randconfig-001-20250516    gcc-5.5.0
powerpc               randconfig-002-20250516    clang-21
powerpc               randconfig-002-20250516    gcc-5.5.0
powerpc               randconfig-003-20250516    clang-17
powerpc               randconfig-003-20250516    clang-21
powerpc                     tqm8541_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250516    clang-21
powerpc64             randconfig-002-20250516    clang-21
powerpc64             randconfig-003-20250516    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250516    gcc-7.5.0
riscv                 randconfig-002-20250516    gcc-14.2.0
riscv                 randconfig-002-20250516    gcc-7.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250516    gcc-7.5.0
s390                  randconfig-002-20250516    gcc-7.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                          polaris_defconfig    gcc-14.2.0
sh                    randconfig-001-20250516    gcc-7.5.0
sh                    randconfig-002-20250516    gcc-7.5.0
sh                    randconfig-002-20250516    gcc-9.3.0
sh                           se7724_defconfig    gcc-14.2.0
sh                           se7780_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250516    gcc-7.5.0
sparc                 randconfig-001-20250516    gcc-8.5.0
sparc                 randconfig-002-20250516    gcc-7.5.0
sparc                 randconfig-002-20250516    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250516    gcc-12.4.0
sparc64               randconfig-001-20250516    gcc-7.5.0
sparc64               randconfig-002-20250516    gcc-14.2.0
sparc64               randconfig-002-20250516    gcc-7.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250516    clang-21
um                    randconfig-001-20250516    gcc-7.5.0
um                    randconfig-002-20250516    gcc-12
um                    randconfig-002-20250516    gcc-7.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250516    clang-20
x86_64      buildonly-randconfig-001-20250516    gcc-12
x86_64      buildonly-randconfig-002-20250516    gcc-12
x86_64      buildonly-randconfig-003-20250516    clang-20
x86_64      buildonly-randconfig-003-20250516    gcc-12
x86_64      buildonly-randconfig-004-20250516    clang-20
x86_64      buildonly-randconfig-004-20250516    gcc-12
x86_64      buildonly-randconfig-005-20250516    gcc-12
x86_64      buildonly-randconfig-006-20250516    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250516    gcc-12
x86_64                randconfig-002-20250516    gcc-12
x86_64                randconfig-003-20250516    gcc-12
x86_64                randconfig-004-20250516    gcc-12
x86_64                randconfig-005-20250516    gcc-12
x86_64                randconfig-006-20250516    gcc-12
x86_64                randconfig-007-20250516    gcc-12
x86_64                randconfig-008-20250516    gcc-12
x86_64                randconfig-071-20250516    clang-20
x86_64                randconfig-072-20250516    clang-20
x86_64                randconfig-073-20250516    clang-20
x86_64                randconfig-074-20250516    clang-20
x86_64                randconfig-075-20250516    clang-20
x86_64                randconfig-076-20250516    clang-20
x86_64                randconfig-077-20250516    clang-20
x86_64                randconfig-078-20250516    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250516    gcc-10.5.0
xtensa                randconfig-001-20250516    gcc-7.5.0
xtensa                randconfig-002-20250516    gcc-10.5.0
xtensa                randconfig-002-20250516    gcc-7.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

