Return-Path: <linux-erofs+bounces-407-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCD4ADA0B7
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Jun 2025 05:14:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bKdX75Rf4z30P3;
	Sun, 15 Jun 2025 13:14:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749957255;
	cv=none; b=WWFVq9Sl1kyf8cdZcQnRt0QBy9e5cYH9eK0o0g8jhF0TIz/5fxuCpGbU89ncrpoTG7ai1oxElNArQN19X00Buh8e/ff8w3j9C3evfA9VFJjB6gC032qeWs96GcY0aBI5f+Gc74e0uzSw+lUxu/FrVj21NSMFKgfPg4EQBKh0ThDfR6hobonNxm2Lguq3Z9GtnCxY+IlZmMITae9jEoM/dJOmqkxOqzTjuTS9e6LAxaohu+iLFHd1sYM+tLeYfuUwcGxewkAPcfCUKN1reE+G7MTjD0G4ZLPL3cZFOXD32gRvz61LezwdWmVglKXkvdOdFli9X38mIXEPqANbeNIgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749957255; c=relaxed/relaxed;
	bh=kwHoetsIV1SMMnQehWy8HaPZ/RKrbUNcOkZRGc5ZWwA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Az54e5/sP4XgpIW3vTR1AMBrKxnbbwjWIXx9W5/5/vTbG0oRQll9NTmn0jHrE9zp7gaWvHJOvYIT8Dvi2bjzzGMM6sSn1r+qnaKIGZEvl9MY/adkLn3FsSesPGuUe7AeH7JaeCKJG1W0v0AxV59sp02hl6Dz+Y7H2C/QfmJqNZXUqSF4BIgXRuSIEKv028uK/GjJx7fPt2xkwXrGRriPQiD8s94xNDKgkaB9embMGdD7rV+hPT2U5W4glHVCrNHOo3TN/HGWQqp4tfYGNLXlkw/J3UrkUe83C4ITwmq2u5iP39evOSR+uiMmaByu/JDE9Vpr0C5F17nefuJ+hCQB4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CVkn2/VL; dkim-atps=neutral; spf=pass (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CVkn2/VL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bKdX5062Nz307q
	for <linux-erofs@lists.ozlabs.org>; Sun, 15 Jun 2025 13:14:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749957253; x=1781493253;
  h=date:from:to:cc:subject:message-id;
  bh=jxmdvrIlf+3d4GINGSE9Za7JF001CD1G51perFcM0sE=;
  b=CVkn2/VLCO3Wdq6rk8fmZL6wth7iNWpFN7UbiPMTbUbonpLFFLlyD4Pl
   5g52A+woggeICyoHWwSddJPFx3BQgOrPLgNiCfrv02UAdWH5GgKrUnujK
   PMU4CIgVKRF74avzs20TarMw5I2xooYHWUxCe662hkxGK4m7l4m0iZe98
   g3U102LFTIoFuHoEu9eujXIL0YILT2paMNiAkIv2JZHWFpvLSoF2ovpLN
   HW4OojDn6rN65QKya9EOhFkJV7FP77s60UqTl9hnp87IrokREInP1hy3r
   9RkiB0ywu/gfNB5G0oHs8G5eH1piXJiEIi4SEhKkM60QKi03htHAyUUeQ
   g==;
X-CSE-ConnectionGUID: bshCTILdQK+l1azEoJjFGg==
X-CSE-MsgGUID: iJCtF6h9TCmo/6rAZ9BhGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11464"; a="52114358"
X-IronPort-AV: E=Sophos;i="6.16,238,1744095600"; 
   d="scan'208";a="52114358"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2025 20:14:07 -0700
X-CSE-ConnectionGUID: FeEfCN1fTkyhc1aZ+ePgvQ==
X-CSE-MsgGUID: OExKwTbnQVOfXx7wllm03A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,238,1744095600"; 
   d="scan'208";a="148144042"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 14 Jun 2025 20:14:04 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQdop-000E5M-10;
	Sun, 15 Jun 2025 03:14:03 +0000
Date: Sun, 15 Jun 2025 11:13:25 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 ef102dfe9e96a0f3e339e300c608ac441f71e738
Message-ID: <202506151114.BSnrOmvB-lkp@intel.com>
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
branch HEAD: ef102dfe9e96a0f3e339e300c608ac441f71e738  erofs: impersonate the opener's credentials when accessing backing file

elapsed time: 1442m

configs tested: 267
configs skipped: 11

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
arc                          axs103_defconfig    clang-21
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250614    gcc-8.5.0
arc                   randconfig-001-20250615    gcc-12.4.0
arc                   randconfig-002-20250614    gcc-12.4.0
arc                   randconfig-002-20250614    gcc-8.5.0
arc                   randconfig-002-20250615    gcc-12.4.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         at91_dt_defconfig    clang-21
arm                                 defconfig    gcc-15.1.0
arm                          gemini_defconfig    clang-21
arm                      integrator_defconfig    clang-21
arm                             mxs_defconfig    clang-21
arm                   randconfig-001-20250614    gcc-8.5.0
arm                   randconfig-001-20250615    gcc-12.4.0
arm                   randconfig-002-20250614    clang-21
arm                   randconfig-002-20250614    gcc-8.5.0
arm                   randconfig-002-20250615    gcc-12.4.0
arm                   randconfig-003-20250614    clang-16
arm                   randconfig-003-20250614    gcc-8.5.0
arm                   randconfig-003-20250615    gcc-12.4.0
arm                   randconfig-004-20250614    clang-17
arm                   randconfig-004-20250614    gcc-8.5.0
arm                   randconfig-004-20250615    gcc-12.4.0
arm                        vexpress_defconfig    gcc-15.1.0
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250614    clang-21
arm64                 randconfig-001-20250614    gcc-8.5.0
arm64                 randconfig-001-20250615    gcc-12.4.0
arm64                 randconfig-002-20250614    gcc-15.1.0
arm64                 randconfig-002-20250614    gcc-8.5.0
arm64                 randconfig-002-20250615    gcc-12.4.0
arm64                 randconfig-003-20250614    clang-21
arm64                 randconfig-003-20250614    gcc-8.5.0
arm64                 randconfig-003-20250615    gcc-12.4.0
arm64                 randconfig-004-20250614    gcc-8.5.0
arm64                 randconfig-004-20250615    gcc-12.4.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250614    gcc-13.3.0
csky                  randconfig-001-20250615    gcc-15.1.0
csky                  randconfig-002-20250614    gcc-12.4.0
csky                  randconfig-002-20250615    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250614    clang-21
hexagon               randconfig-001-20250615    gcc-15.1.0
hexagon               randconfig-002-20250614    clang-16
hexagon               randconfig-002-20250615    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250614    clang-20
i386        buildonly-randconfig-001-20250615    gcc-12
i386        buildonly-randconfig-002-20250614    clang-20
i386        buildonly-randconfig-002-20250615    gcc-12
i386        buildonly-randconfig-003-20250614    clang-20
i386        buildonly-randconfig-003-20250615    gcc-12
i386        buildonly-randconfig-004-20250614    clang-20
i386        buildonly-randconfig-004-20250614    gcc-12
i386        buildonly-randconfig-004-20250615    gcc-12
i386        buildonly-randconfig-005-20250614    clang-20
i386        buildonly-randconfig-005-20250615    gcc-12
i386        buildonly-randconfig-006-20250614    clang-20
i386        buildonly-randconfig-006-20250615    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250615    clang-20
i386                  randconfig-002-20250615    clang-20
i386                  randconfig-003-20250615    clang-20
i386                  randconfig-004-20250615    clang-20
i386                  randconfig-005-20250615    clang-20
i386                  randconfig-006-20250615    clang-20
i386                  randconfig-007-20250615    clang-20
i386                  randconfig-011-20250615    gcc-12
i386                  randconfig-012-20250615    gcc-12
i386                  randconfig-013-20250615    gcc-12
i386                  randconfig-014-20250615    gcc-12
i386                  randconfig-015-20250615    gcc-12
i386                  randconfig-016-20250615    gcc-12
i386                  randconfig-017-20250615    gcc-12
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250614    gcc-15.1.0
loongarch             randconfig-001-20250615    gcc-15.1.0
loongarch             randconfig-002-20250614    gcc-15.1.0
loongarch             randconfig-002-20250615    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5407c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip22_defconfig    clang-21
mips                           ip30_defconfig    clang-21
mips                        omega2p_defconfig    clang-21
mips                         rt305x_defconfig    clang-21
mips                   sb1250_swarm_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250614    gcc-13.3.0
nios2                 randconfig-001-20250615    gcc-15.1.0
nios2                 randconfig-002-20250614    gcc-11.5.0
nios2                 randconfig-002-20250615    gcc-15.1.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    clang-21
parisc                randconfig-001-20250614    gcc-8.5.0
parisc                randconfig-001-20250615    gcc-15.1.0
parisc                randconfig-002-20250614    gcc-11.5.0
parisc                randconfig-002-20250615    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                        cell_defconfig    clang-21
powerpc                    ge_imp3a_defconfig    clang-21
powerpc                 linkstation_defconfig    clang-21
powerpc                     mpc512x_defconfig    gcc-15.1.0
powerpc                     mpc5200_defconfig    clang-21
powerpc                     mpc83xx_defconfig    clang-21
powerpc                      ppc64e_defconfig    clang-21
powerpc               randconfig-001-20250614    gcc-13.3.0
powerpc               randconfig-001-20250615    gcc-15.1.0
powerpc               randconfig-002-20250614    clang-21
powerpc               randconfig-002-20250615    gcc-15.1.0
powerpc               randconfig-003-20250614    gcc-12.4.0
powerpc               randconfig-003-20250615    gcc-15.1.0
powerpc                     tqm5200_defconfig    gcc-15.1.0
powerpc                      tqm8xx_defconfig    clang-21
powerpc64                        alldefconfig    gcc-15.1.0
powerpc64             randconfig-001-20250614    gcc-11.5.0
powerpc64             randconfig-002-20250614    clang-21
powerpc64             randconfig-002-20250615    gcc-15.1.0
powerpc64             randconfig-003-20250614    gcc-12.4.0
powerpc64             randconfig-003-20250615    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250614    clang-21
riscv                 randconfig-001-20250614    gcc-14.3.0
riscv                 randconfig-002-20250614    gcc-14.3.0
riscv                 randconfig-002-20250614    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250614    clang-21
s390                  randconfig-001-20250614    gcc-14.3.0
s390                  randconfig-002-20250614    gcc-10.5.0
s390                  randconfig-002-20250614    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                               j2_defconfig    clang-21
sh                    randconfig-001-20250614    gcc-14.3.0
sh                    randconfig-002-20250614    gcc-12.4.0
sh                    randconfig-002-20250614    gcc-14.3.0
sh                           se7751_defconfig    clang-21
sh                            titan_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250614    gcc-14.3.0
sparc                 randconfig-001-20250614    gcc-15.1.0
sparc                 randconfig-002-20250614    gcc-10.3.0
sparc                 randconfig-002-20250614    gcc-14.3.0
sparc                       sparc64_defconfig    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250614    gcc-14.3.0
sparc64               randconfig-001-20250614    gcc-8.5.0
sparc64               randconfig-002-20250614    gcc-14.3.0
sparc64               randconfig-002-20250614    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250614    clang-21
um                    randconfig-001-20250614    gcc-14.3.0
um                    randconfig-002-20250614    gcc-12
um                    randconfig-002-20250614    gcc-14.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250614    clang-20
x86_64      buildonly-randconfig-001-20250615    clang-20
x86_64      buildonly-randconfig-002-20250614    clang-20
x86_64      buildonly-randconfig-002-20250615    clang-20
x86_64      buildonly-randconfig-003-20250614    gcc-12
x86_64      buildonly-randconfig-003-20250615    clang-20
x86_64      buildonly-randconfig-004-20250614    clang-20
x86_64      buildonly-randconfig-004-20250615    clang-20
x86_64      buildonly-randconfig-005-20250614    clang-20
x86_64      buildonly-randconfig-005-20250615    clang-20
x86_64      buildonly-randconfig-006-20250614    clang-20
x86_64      buildonly-randconfig-006-20250615    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250615    clang-20
x86_64                randconfig-002-20250615    clang-20
x86_64                randconfig-003-20250615    clang-20
x86_64                randconfig-004-20250615    clang-20
x86_64                randconfig-005-20250615    clang-20
x86_64                randconfig-006-20250615    clang-20
x86_64                randconfig-007-20250615    clang-20
x86_64                randconfig-008-20250615    clang-20
x86_64                randconfig-071-20250615    gcc-12
x86_64                randconfig-072-20250615    gcc-12
x86_64                randconfig-073-20250615    gcc-12
x86_64                randconfig-074-20250615    gcc-12
x86_64                randconfig-075-20250615    gcc-12
x86_64                randconfig-076-20250615    gcc-12
x86_64                randconfig-077-20250615    gcc-12
x86_64                randconfig-078-20250615    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    clang-21
xtensa                randconfig-001-20250614    gcc-14.3.0
xtensa                randconfig-001-20250614    gcc-9.3.0
xtensa                randconfig-002-20250614    gcc-13.3.0
xtensa                randconfig-002-20250614    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

