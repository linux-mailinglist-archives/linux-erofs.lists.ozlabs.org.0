Return-Path: <linux-erofs+bounces-772-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D2777B1BEB3
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Aug 2025 04:22:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bxYwV49S5z30W5;
	Wed,  6 Aug 2025 12:22:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754446954;
	cv=none; b=hzNcDaLj1oLRNRwnzIF8TTd4oKE1B4U50e7XetviYepS7lyEj4gNbBIEjU2e5oK0lI8+r7j/owbKWfcxkjBfKwAldG71KPCg4Fg2VRh6n1Rv5GYmu6LSy5lzJ4gMzAo1QWBKCRObBZ8P7xHWkhcH5PxDLEqknapQXPK4Ag1m8G2/m+83XUc3lMIozdDdvJ3i4GntbHwkEynEGZcxruIIzBMj5ff8+uoAnNUSjhGy/KE380/jhW5yfqf7UjFuiXWVS9GGVcC3hOnHQka42RcCGW6dIapUvh27a+u+K7bGFGzRNBqBP/IKhZVlS4pJ7VaKIGnuXNXoPL4LRIo5IKuMRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754446954; c=relaxed/relaxed;
	bh=8dv/EEKNLOhBBaG0FX2q5ESHlkV/6oShXwUtPKCvy24=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bhpx4mev2EYdu6N7on0NP5BGFmWEaJt2ZGHZAMlak9dV+h2sTagxvuS/uf72F4ut7SPZcDpv7vONf4UedzfA+53YaYM+8w6TuYwUuegHmnUFAzFTdgQ0UcLxqeYzabirgwbt4R6U8nmGMDxmCyIrk39CV8h5jpxcjZ0YabSLOzKs4fWONqwkPyjNw+zBA85gK+UOg/cbNoix9Sec3I2RG5qyg4+L2xTwwdEsBxT7w+zyTkeCtyRyxCRvMMz/XvactXE9GTthN7upLrPWuwt0f8KfKsHBRtocD8Y11P0kyzSoSyqZsmnuXVgPW/2ACefyyGTam8eDGCyR3YryvqAcIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Pwkyhxfd; dkim-atps=neutral; spf=pass (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Pwkyhxfd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bxYwS2F71z2xQ4
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Aug 2025 12:22:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754446953; x=1785982953;
  h=date:from:to:cc:subject:message-id;
  bh=xxqSNq7xbDd/ewLz78kM88sZNDxvPEiIziLDH0miiac=;
  b=PwkyhxfdVmOkbbDrxjyQ1tirpg6cLpLKJ5MhODam1xZgi7JI7PGEqwwP
   t5SfsQAyD54rw+OYu0ZQgTpEVixheclo4cP6LdqQlColMpcsMROIU5Ypx
   R7qhSI+FYNo7mQYagxrcTlUge0Knmfe5Pf9p9fqj0gqS1zYoApy0NRSEw
   MATVItOOJ3jgW5RtJIw2jT+KoVjsvx9qx5ta3zF/BSVMD56WbAr03/EPA
   ETdv7WufB7d8e8HjAYV4/vPhtEi1243fV/M/PIr34F0whXJOzQKpaSKAU
   EnNt5pmjG3iNRGYzx22FTLM3hQdM2H6201nHRu7mL4dFnR4uEPwS9Ks6Z
   A==;
X-CSE-ConnectionGUID: yk3zOxAISjKFhFp8eGv9sA==
X-CSE-MsgGUID: d34mYNmOR12dysiCDN4AiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56622893"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56622893"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 19:22:27 -0700
X-CSE-ConnectionGUID: laEzNRlgT2Sylixas8loEA==
X-CSE-MsgGUID: deUwk0PhQ4+Ab3GpsMoKLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="169101032"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 05 Aug 2025 19:22:25 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujTnL-0000xK-13;
	Wed, 06 Aug 2025 02:22:23 +0000
Date: Wed, 06 Aug 2025 10:21:42 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 e2d8ad009150b636482756d16ea542794cafa8cc
Message-ID: <202508061032.4QSzlLP2-lkp@intel.com>
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
branch HEAD: e2d8ad009150b636482756d16ea542794cafa8cc  erofs: fix atomic context detection when !CONFIG_DEBUG_LOCK_ALLOC

elapsed time: 1177m

configs tested: 174
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                        nsim_700_defconfig    gcc-15.1.0
arc                   randconfig-001-20250805    gcc-8.5.0
arc                   randconfig-001-20250806    gcc-12.5.0
arc                   randconfig-002-20250805    gcc-10.5.0
arc                   randconfig-002-20250806    gcc-11.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250805    gcc-11.5.0
arm                   randconfig-001-20250806    gcc-10.5.0
arm                   randconfig-002-20250805    clang-22
arm                   randconfig-002-20250806    gcc-13.4.0
arm                   randconfig-003-20250805    gcc-12.5.0
arm                   randconfig-003-20250806    gcc-10.5.0
arm                   randconfig-004-20250805    clang-18
arm                   randconfig-004-20250806    clang-22
arm                           u8500_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250805    gcc-12.5.0
arm64                 randconfig-001-20250806    clang-20
arm64                 randconfig-002-20250805    clang-20
arm64                 randconfig-002-20250806    clang-22
arm64                 randconfig-003-20250805    gcc-11.5.0
arm64                 randconfig-003-20250806    gcc-9.5.0
arm64                 randconfig-004-20250805    gcc-13.4.0
arm64                 randconfig-004-20250806    clang-17
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250805    gcc-12.5.0
csky                  randconfig-001-20250806    gcc-10.5.0
csky                  randconfig-002-20250805    gcc-10.5.0
csky                  randconfig-002-20250806    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250805    clang-20
hexagon               randconfig-001-20250806    clang-18
hexagon               randconfig-002-20250805    clang-22
hexagon               randconfig-002-20250806    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250805    clang-20
i386        buildonly-randconfig-001-20250806    clang-20
i386        buildonly-randconfig-002-20250805    gcc-12
i386        buildonly-randconfig-002-20250806    gcc-11
i386        buildonly-randconfig-003-20250805    gcc-12
i386        buildonly-randconfig-003-20250806    clang-20
i386        buildonly-randconfig-004-20250805    gcc-12
i386        buildonly-randconfig-004-20250806    gcc-12
i386        buildonly-randconfig-005-20250805    gcc-12
i386        buildonly-randconfig-005-20250806    gcc-12
i386        buildonly-randconfig-006-20250805    gcc-12
i386        buildonly-randconfig-006-20250806    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250805    gcc-15.1.0
loongarch             randconfig-001-20250806    clang-18
loongarch             randconfig-002-20250805    gcc-12.5.0
loongarch             randconfig-002-20250806    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                        m5272c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250805    gcc-11.5.0
nios2                 randconfig-001-20250806    gcc-10.5.0
nios2                 randconfig-002-20250805    gcc-8.5.0
nios2                 randconfig-002-20250806    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250805    gcc-10.5.0
parisc                randconfig-001-20250806    gcc-15.1.0
parisc                randconfig-002-20250805    gcc-15.1.0
parisc                randconfig-002-20250806    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250805    clang-22
powerpc               randconfig-001-20250806    clang-22
powerpc               randconfig-002-20250805    clang-22
powerpc               randconfig-002-20250806    gcc-14.3.0
powerpc               randconfig-003-20250805    gcc-9.5.0
powerpc               randconfig-003-20250806    clang-22
powerpc64             randconfig-001-20250805    clang-22
powerpc64             randconfig-001-20250806    gcc-15.1.0
powerpc64             randconfig-002-20250805    clang-19
powerpc64             randconfig-002-20250806    gcc-10.5.0
powerpc64             randconfig-003-20250805    clang-22
powerpc64             randconfig-003-20250806    clang-18
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250805    clang-18
riscv                 randconfig-001-20250806    clang-20
riscv                 randconfig-002-20250805    gcc-9.5.0
riscv                 randconfig-002-20250806    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250805    clang-22
s390                  randconfig-001-20250806    gcc-14.3.0
s390                  randconfig-002-20250805    clang-22
s390                  randconfig-002-20250806    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250805    gcc-9.5.0
sh                    randconfig-001-20250806    gcc-15.1.0
sh                    randconfig-002-20250805    gcc-14.3.0
sh                    randconfig-002-20250806    gcc-10.5.0
sh                        sh7757lcr_defconfig    gcc-15.1.0
sh                        sh7785lcr_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250805    gcc-8.5.0
sparc                 randconfig-001-20250806    gcc-11.5.0
sparc                 randconfig-002-20250805    gcc-15.1.0
sparc                 randconfig-002-20250806    gcc-13.4.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250805    gcc-9.5.0
sparc64               randconfig-001-20250806    gcc-8.5.0
sparc64               randconfig-002-20250805    clang-22
sparc64               randconfig-002-20250806    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250805    gcc-12
um                    randconfig-001-20250806    clang-16
um                    randconfig-002-20250805    gcc-12
um                    randconfig-002-20250806    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250805    gcc-12
x86_64      buildonly-randconfig-001-20250806    gcc-12
x86_64      buildonly-randconfig-002-20250805    gcc-12
x86_64      buildonly-randconfig-002-20250806    clang-20
x86_64      buildonly-randconfig-003-20250805    clang-20
x86_64      buildonly-randconfig-003-20250806    gcc-12
x86_64      buildonly-randconfig-004-20250805    gcc-12
x86_64      buildonly-randconfig-004-20250806    gcc-12
x86_64      buildonly-randconfig-005-20250805    clang-20
x86_64      buildonly-randconfig-005-20250806    clang-20
x86_64      buildonly-randconfig-006-20250805    gcc-12
x86_64      buildonly-randconfig-006-20250806    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250805    gcc-14.3.0
xtensa                randconfig-001-20250806    gcc-13.4.0
xtensa                randconfig-002-20250805    gcc-15.1.0
xtensa                randconfig-002-20250806    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

