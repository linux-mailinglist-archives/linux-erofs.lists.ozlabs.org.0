Return-Path: <linux-erofs+bounces-499-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F18AEC4CA
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Jun 2025 06:14:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bTfFc1T4Rz2yfH;
	Sat, 28 Jun 2025 14:14:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751084068;
	cv=none; b=byyuQK8hYP1PGPkYJzBz+y/S7A7NOOaNTo5tSdA+id+W8XCNMh8iCesA0zGBaN5yW/odYrhsOS31rb6y2ada/UjOCYxTnaKM2Crx414NjQJUfeBHjA5MB47DBqS8fz5YPyn0mUPF1BcKC1hdCgtFObPOVrbOalX6fe4RuUpy6Inv/xM+J9kzSZWGrT8Jom19T77XLW6aGw6vMzHlDbufm7ECjkBpvPzneRmvJ0cHq+lrQ9nGF2t0R9qSkoh7kjyKhL1cQ5GpqvKJZqlf24ABOwEmHHGPBWgHCH7cQmOo67gm8EheBQG22BMQ8P8B+Xp800924HI+Vp60hEDorYdorw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751084068; c=relaxed/relaxed;
	bh=BxHUHl2yJSD5g5NBruLFhl+pP+KqWD8Qn8gUhplrVxI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BM5HnTwBL+3RYIvWsQ+T2RNvSbkvPGnL0bv1X0z2LDGGnzH7u6oTRoC0zjaB2sjSI1OkL1WgrXzQExjT5zjb3SrVWuequK4bvw+HZgsvixTuz/ha6T7h3JbcobezvLLvEzOXEziuIxPoFizdfh5HKT7iabHSHJ3HZdQdiETkQlC7P0KT9+m/xkLJ1zzfn1nxnfQOOxrh1CgTKpLHmB81vbqt2iE/gOAi0AWOPA+Ox/QmFOrM9mQLn/slSWqfCydyUQqMzf5M7WL4fqEsi01gqOr5j/WlzLlJKqoOzqavFw5a2qhTU//pSAlwX+kTlHy9wXnSIcCswniTYRPDF1JpHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=biuJOwXO; dkim-atps=neutral; spf=pass (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=biuJOwXO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bTfFY36p2z2xgQ
	for <linux-erofs@lists.ozlabs.org>; Sat, 28 Jun 2025 14:14:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751084066; x=1782620066;
  h=date:from:to:cc:subject:message-id;
  bh=9kK2m1BLjR5oKgem/UaE7qhY64TCEMsaz9fiNtMoxTw=;
  b=biuJOwXOcawvxBULuab/rcf3084VzGpI/XXCyNSLRI7ltx3VAk/EoptR
   h/VnneOOkR1wyN2b4eS/d5LAKXhbkLx4EW7aLOmrDezx3HPAA5AlfV3uC
   PSlAQvdjQ1Cb00yny9IQEAEita/QGAIh2BJ+XXfwU3VfsZQe0Alq935uM
   GVK5I+IK0GVtxSGjys2TKF8O3UTH8XHEGjP5nUsXERHskYQRRjuZ8qmyd
   R1XFWdU8zTe4yKn1n2e1tychNprvBebqwvL17aOoKo2kuTHOx0+RHrNFV
   8X4UPdNcJYucRUIK+dtfU5aaX50Fxw22bdiOBECmH1vDpFnfjiB8gRE8n
   Q==;
X-CSE-ConnectionGUID: H3eJ8Td6TZ63AeXmCl7iyw==
X-CSE-MsgGUID: 0/owmjYZQtmh2nC/RiRT+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53519957"
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="53519957"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 21:14:20 -0700
X-CSE-ConnectionGUID: JAqpfdefQyOTprMkJ3iXPA==
X-CSE-MsgGUID: Wu+mYO0VTIGIKiZbU0tvQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="158691365"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 27 Jun 2025 21:14:18 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVMxE-000Wm2-1c;
	Sat, 28 Jun 2025 04:14:16 +0000
Date: Sat, 28 Jun 2025 12:13:35 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 634351c1a39b791d70b4ec31b78bb5c81547692e
Message-ID: <202506281224.PdqWI7cm-lkp@intel.com>
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
branch HEAD: 634351c1a39b791d70b4ec31b78bb5c81547692e  erofs: get rid of {get,put}_page() for ztailpacking data

elapsed time: 1200m

configs tested: 259
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-21
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250627    gcc-8.5.0
arc                   randconfig-001-20250628    clang-21
arc                   randconfig-002-20250627    gcc-12.4.0
arc                   randconfig-002-20250628    clang-21
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         assabet_defconfig    clang-21
arm                                 defconfig    gcc-15.1.0
arm                         orion5x_defconfig    clang-21
arm                          pxa3xx_defconfig    clang-21
arm                   randconfig-001-20250627    gcc-15.1.0
arm                   randconfig-001-20250628    clang-21
arm                   randconfig-002-20250627    gcc-10.5.0
arm                   randconfig-002-20250628    clang-21
arm                   randconfig-003-20250627    clang-21
arm                   randconfig-003-20250628    clang-21
arm                   randconfig-004-20250627    gcc-8.5.0
arm                   randconfig-004-20250628    clang-21
arm                         wpcm450_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-21
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250627    clang-17
arm64                 randconfig-001-20250628    clang-21
arm64                 randconfig-002-20250627    gcc-10.5.0
arm64                 randconfig-002-20250628    clang-21
arm64                 randconfig-003-20250627    gcc-12.3.0
arm64                 randconfig-003-20250628    clang-21
arm64                 randconfig-004-20250627    clang-19
arm64                 randconfig-004-20250628    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250627    gcc-15.1.0
csky                  randconfig-001-20250628    clang-21
csky                  randconfig-002-20250627    gcc-15.1.0
csky                  randconfig-002-20250628    clang-21
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250627    clang-21
hexagon               randconfig-001-20250628    clang-21
hexagon               randconfig-002-20250627    clang-21
hexagon               randconfig-002-20250628    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250627    gcc-12
i386        buildonly-randconfig-001-20250628    clang-20
i386        buildonly-randconfig-002-20250627    gcc-12
i386        buildonly-randconfig-002-20250628    clang-20
i386        buildonly-randconfig-003-20250627    gcc-12
i386        buildonly-randconfig-003-20250628    clang-20
i386        buildonly-randconfig-004-20250627    gcc-12
i386        buildonly-randconfig-004-20250628    clang-20
i386        buildonly-randconfig-005-20250627    clang-20
i386        buildonly-randconfig-005-20250628    clang-20
i386        buildonly-randconfig-006-20250627    gcc-12
i386        buildonly-randconfig-006-20250628    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250628    clang-20
i386                  randconfig-002-20250628    clang-20
i386                  randconfig-003-20250628    clang-20
i386                  randconfig-004-20250628    clang-20
i386                  randconfig-005-20250628    clang-20
i386                  randconfig-006-20250628    clang-20
i386                  randconfig-007-20250628    clang-20
i386                  randconfig-011-20250628    gcc-12
i386                  randconfig-012-20250628    gcc-12
i386                  randconfig-013-20250628    gcc-12
i386                  randconfig-014-20250628    gcc-12
i386                  randconfig-015-20250628    gcc-12
i386                  randconfig-016-20250628    gcc-12
i386                  randconfig-017-20250628    gcc-12
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250627    gcc-15.1.0
loongarch             randconfig-001-20250628    clang-21
loongarch             randconfig-002-20250627    gcc-15.1.0
loongarch             randconfig-002-20250628    clang-21
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       bvme6000_defconfig    clang-21
m68k                                defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    clang-21
m68k                        m5407c3_defconfig    clang-21
m68k                            mac_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      bmips_stb_defconfig    clang-21
mips                           ci20_defconfig    gcc-15.1.0
mips                     loongson1b_defconfig    gcc-15.1.0
mips                        vocore2_defconfig    clang-21
nios2                         3c120_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250627    gcc-8.5.0
nios2                 randconfig-001-20250628    clang-21
nios2                 randconfig-002-20250627    gcc-8.5.0
nios2                 randconfig-002-20250628    clang-21
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250627    gcc-9.3.0
parisc                randconfig-001-20250628    clang-21
parisc                randconfig-002-20250627    gcc-8.5.0
parisc                randconfig-002-20250628    clang-21
parisc64                            defconfig    gcc-15.1.0
powerpc                    adder875_defconfig    clang-21
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   bluestone_defconfig    gcc-15.1.0
powerpc                      ppc6xx_defconfig    clang-21
powerpc               randconfig-001-20250627    gcc-15.1.0
powerpc               randconfig-001-20250628    clang-21
powerpc               randconfig-002-20250627    clang-21
powerpc               randconfig-002-20250628    clang-21
powerpc               randconfig-003-20250627    gcc-15.1.0
powerpc               randconfig-003-20250628    clang-21
powerpc64             randconfig-001-20250627    gcc-12.4.0
powerpc64             randconfig-001-20250628    clang-21
powerpc64             randconfig-002-20250627    gcc-10.5.0
powerpc64             randconfig-002-20250628    clang-21
powerpc64             randconfig-003-20250627    gcc-8.5.0
powerpc64             randconfig-003-20250628    clang-21
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250627    gcc-8.5.0
riscv                 randconfig-001-20250628    gcc-8.5.0
riscv                 randconfig-002-20250627    gcc-13.3.0
riscv                 randconfig-002-20250628    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250627    clang-21
s390                  randconfig-001-20250628    gcc-8.5.0
s390                  randconfig-002-20250627    clang-21
s390                  randconfig-002-20250628    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                         ecovec24_defconfig    clang-21
sh                    randconfig-001-20250627    gcc-9.3.0
sh                    randconfig-001-20250628    gcc-8.5.0
sh                    randconfig-002-20250627    gcc-15.1.0
sh                    randconfig-002-20250628    gcc-8.5.0
sh                          sdk7780_defconfig    clang-21
sh                           se7780_defconfig    clang-21
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250627    gcc-11.5.0
sparc                 randconfig-001-20250628    gcc-8.5.0
sparc                 randconfig-002-20250627    gcc-8.5.0
sparc                 randconfig-002-20250628    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250627    gcc-11.5.0
sparc64               randconfig-001-20250628    gcc-8.5.0
sparc64               randconfig-002-20250627    gcc-8.5.0
sparc64               randconfig-002-20250628    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250627    gcc-12
um                    randconfig-001-20250628    gcc-8.5.0
um                    randconfig-002-20250627    gcc-12
um                    randconfig-002-20250628    gcc-8.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250627    clang-20
x86_64      buildonly-randconfig-001-20250628    gcc-12
x86_64      buildonly-randconfig-002-20250627    clang-20
x86_64      buildonly-randconfig-002-20250628    gcc-12
x86_64      buildonly-randconfig-003-20250627    clang-20
x86_64      buildonly-randconfig-003-20250628    gcc-12
x86_64      buildonly-randconfig-004-20250627    clang-20
x86_64      buildonly-randconfig-004-20250628    gcc-12
x86_64      buildonly-randconfig-005-20250627    gcc-12
x86_64      buildonly-randconfig-005-20250628    gcc-12
x86_64      buildonly-randconfig-006-20250627    gcc-12
x86_64      buildonly-randconfig-006-20250628    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250628    gcc-12
x86_64                randconfig-002-20250628    gcc-12
x86_64                randconfig-003-20250628    gcc-12
x86_64                randconfig-004-20250628    gcc-12
x86_64                randconfig-005-20250628    gcc-12
x86_64                randconfig-006-20250628    gcc-12
x86_64                randconfig-007-20250628    gcc-12
x86_64                randconfig-008-20250628    gcc-12
x86_64                randconfig-071-20250628    clang-20
x86_64                randconfig-072-20250628    clang-20
x86_64                randconfig-073-20250628    clang-20
x86_64                randconfig-074-20250628    clang-20
x86_64                randconfig-075-20250628    clang-20
x86_64                randconfig-076-20250628    clang-20
x86_64                randconfig-077-20250628    clang-20
x86_64                randconfig-078-20250628    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250627    gcc-13.3.0
xtensa                randconfig-001-20250628    gcc-8.5.0
xtensa                randconfig-002-20250627    gcc-10.5.0
xtensa                randconfig-002-20250628    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

