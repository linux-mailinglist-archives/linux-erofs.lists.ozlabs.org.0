Return-Path: <linux-erofs+bounces-693-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE07B0CD5F
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Jul 2025 00:44:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bmFnv4vR8z2xck;
	Tue, 22 Jul 2025 08:44:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753137875;
	cv=none; b=A3znOed5sZl7P3Er7Ve7fmbu+nIkFh/o0llJkMUZUiEFruCm5nuGAIkiEkACjCJSNZaVRJ42CXiE1+iVLSTN9XnoCWoRwI5Qmh1lJtBawbWIERJxOPOnOYnAIW5QxcczzWNvQtUNWtErWrCnbgZvJnXvjvBbnM5npbHGV0/8ow85/ZLi0n4nLhOtx03rrSq/Rwx3O2E9R97c6s1Y5wCBRjuW4w+TXFdGElcXVoNm7ienAdKSmZAwH0f/GZZLRV1BYNEcaQ8dOedSyRGUvI0gpQSiZB3up7051fo2ilZldZmwL84XlX/S0N+CISGBuviqxUgxFTHU28/SDnv0IhP5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753137875; c=relaxed/relaxed;
	bh=6wsegtLhzVIrBm1dgadNrkidxeKbYVLLLC1JT87DogU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=c+9IY1gAjXobSChmhJF1Kx5DG4tlGKofZOoUw1CToOyqty3Xxy3c9usAOyohS8OozQELbLjQ1tRSJ80W/uFjyj8BngUVyYpdte+kPjoxWWK+FyUlSyOFSN8EGAKHPxv4Y4t1yNzn8AoPjqzXEHdjqWJLK2SY6qFlO+veHmJrwdkQW1ucwwCqPdXQpCSl6IbrBVetKJbzzVeLSv4yAW71CFLira0xMYUiC0zB5m6u2MYlw4UX0QjW+cUlVvDrWUR+RvsXv3qfgr/4rapI4mES0ViND4Hmtmb6ddhh6rRj7/ZMX+l9rD9GmdZUl1vy6UZdNlM9i//tFIFWVIr4G8FU/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TwLkHfju; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TwLkHfju;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bmFns4bYKz2xTh
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Jul 2025 08:44:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753137874; x=1784673874;
  h=date:from:to:cc:subject:message-id;
  bh=gRq+G5IB8wxbDOjPtoG2aups3lB12wQF2VY1b60Akok=;
  b=TwLkHfjuN3slVFnXtoDal+lNwESmezinqzYkD1DidCDtYMbj+T/2pBgX
   Vgn68ChYRnayeiS60utG4BtTBdn572HBUcQRhl/fczWsZK5RHljTqhdxK
   7MgZYd8Gy2Ap7Oi6rtqb6hLNHQCAg10Q0i/YiI+GUlKm6cCWF/KpaiQpi
   3Vf0WAS0eGsURPGWutMGWIhCTUBbOP7vWMjDxCb6CVwRiZZLu+u+vtOYR
   TjM98tQxxgpQH8hzdH+rbIZfMMgsHDy4HwA8wIxrQ8/kmjwTFCJSs62Bc
   4pMXUzjGUe5dalcX3phfXqwwV1MgFLzcPnz2Vh+tINoyJq1rtDFmCfDdG
   Q==;
X-CSE-ConnectionGUID: sMumLqLwTwWhaKqqog4Z/Q==
X-CSE-MsgGUID: 9te+LFFcRn2p0LdpPhp1BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="54583041"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="54583041"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 15:44:29 -0700
X-CSE-ConnectionGUID: i4Iwfk7OTN2KNFRJU57E9g==
X-CSE-MsgGUID: g5X0xshUT/acqLtvbnzPSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="163524411"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 21 Jul 2025 15:44:28 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udzFB-000HDR-0U;
	Mon, 21 Jul 2025 22:44:25 +0000
Date: Tue, 22 Jul 2025 06:43:35 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS WITH WARNING
 6fc2317fa8aadc03d0449e0b98fde89057715a03
Message-ID: <202507220617.7IavsUgg-lkp@intel.com>
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
branch HEAD: 6fc2317fa8aadc03d0449e0b98fde89057715a03  erofs: support to readahead dirent blocks in erofs_readdir()

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202507170506.Wzz1lR5I-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202507170548.rvm67YSU-lkp@intel.com

    fs/erofs/internal.h:309:31: warning: shift count >= width of type [-Wshift-count-overflow]
    fs/erofs/super.c:327:26: warning: shift count >= width of type [-Wshift-count-overflow]
    include/vdso/bits.h:7:26: warning: left shift count >= width of type [-Wshift-count-overflow]
    include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]

Warning ids grouped by kconfigs:

recent_errors
|-- arc-allmodconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- arc-allyesconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- arm-allmodconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- arm-allyesconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- hexagon-allmodconfig
|   |-- fs-erofs-internal.h:warning:shift-count-width-of-type
|   `-- fs-erofs-super.c:warning:shift-count-width-of-type
|-- hexagon-allyesconfig
|   |-- fs-erofs-internal.h:warning:shift-count-width-of-type
|   `-- fs-erofs-super.c:warning:shift-count-width-of-type
|-- i386-allmodconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- i386-allyesconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- i386-buildonly-randconfig-002-20250721
|   |-- fs-erofs-internal.h:warning:shift-count-width-of-type
|   `-- fs-erofs-super.c:warning:shift-count-width-of-type
|-- i386-buildonly-randconfig-003-20250721
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- i386-buildonly-randconfig-004-20250721
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- i386-buildonly-randconfig-005-20250721
|   |-- fs-erofs-internal.h:warning:shift-count-width-of-type
|   `-- fs-erofs-super.c:warning:shift-count-width-of-type
|-- m68k-allmodconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- m68k-allyesconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- microblaze-allmodconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- microblaze-allyesconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- nios2-randconfig-001-20250721
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- openrisc-allyesconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- parisc-allmodconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- parisc-allyesconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- parisc-randconfig-002-20250721
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- sh-allmodconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
|-- sh-allyesconfig
|   `-- include-vdso-bits.h:warning:left-shift-count-width-of-type
`-- um-randconfig-001-20250721
    `-- include-vdso-bits.h:warning:left-shift-count-width-of-type

elapsed time: 724m

configs tested: 150
configs skipped: 6

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250721    gcc-11.5.0
arc                   randconfig-001-20250722    gcc-10.5.0
arc                   randconfig-002-20250721    gcc-12.5.0
arc                   randconfig-002-20250722    gcc-11.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                         assabet_defconfig    clang-18
arm                   randconfig-001-20250721    clang-22
arm                   randconfig-001-20250722    gcc-12.5.0
arm                   randconfig-002-20250721    gcc-13.4.0
arm                   randconfig-002-20250722    clang-22
arm                   randconfig-003-20250721    gcc-15.1.0
arm                   randconfig-003-20250722    gcc-8.5.0
arm                   randconfig-004-20250721    clang-22
arm                   randconfig-004-20250722    clang-17
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250721    clang-22
arm64                 randconfig-002-20250721    clang-20
arm64                 randconfig-003-20250721    gcc-13.4.0
arm64                 randconfig-004-20250721    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250721    gcc-15.1.0
csky                  randconfig-002-20250721    gcc-15.1.0
csky                  randconfig-002-20250722    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250721    clang-22
hexagon               randconfig-002-20250721    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250721    clang-20
i386        buildonly-randconfig-001-20250722    gcc-12
i386        buildonly-randconfig-002-20250721    clang-20
i386        buildonly-randconfig-002-20250722    gcc-12
i386        buildonly-randconfig-003-20250721    gcc-12
i386        buildonly-randconfig-003-20250722    clang-20
i386        buildonly-randconfig-004-20250721    gcc-12
i386        buildonly-randconfig-004-20250722    gcc-12
i386        buildonly-randconfig-005-20250721    clang-20
i386        buildonly-randconfig-005-20250722    clang-20
i386        buildonly-randconfig-006-20250721    clang-20
i386        buildonly-randconfig-006-20250722    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250721    clang-18
loongarch             randconfig-002-20250721    gcc-12.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       alldefconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip28_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250721    gcc-8.5.0
nios2                 randconfig-002-20250721    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250721    gcc-15.1.0
parisc                randconfig-002-20250721    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                      cm5200_defconfig    clang-22
powerpc               randconfig-001-20250721    gcc-12.5.0
powerpc               randconfig-002-20250721    gcc-10.5.0
powerpc               randconfig-003-20250721    gcc-11.5.0
powerpc64             randconfig-001-20250721    clang-22
powerpc64             randconfig-002-20250721    clang-22
powerpc64             randconfig-003-20250721    clang-19
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250721    clang-22
riscv                 randconfig-001-20250722    clang-16
riscv                 randconfig-002-20250721    gcc-8.5.0
riscv                 randconfig-002-20250722    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250721    clang-22
s390                  randconfig-001-20250722    clang-22
s390                  randconfig-002-20250721    clang-20
s390                  randconfig-002-20250722    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                ecovec24-romimage_defconfig    gcc-15.1.0
sh                    randconfig-001-20250721    gcc-15.1.0
sh                    randconfig-001-20250722    gcc-15.1.0
sh                    randconfig-002-20250721    gcc-14.3.0
sh                    randconfig-002-20250722    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250721    gcc-15.1.0
sparc                 randconfig-001-20250722    gcc-13.4.0
sparc                 randconfig-002-20250721    gcc-13.4.0
sparc                 randconfig-002-20250722    gcc-15.1.0
sparc64               randconfig-001-20250721    clang-20
sparc64               randconfig-001-20250722    gcc-8.5.0
sparc64               randconfig-002-20250721    clang-22
sparc64               randconfig-002-20250722    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250721    gcc-12
um                    randconfig-001-20250722    gcc-12
um                    randconfig-002-20250721    clang-17
um                    randconfig-002-20250722    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250721    clang-20
x86_64      buildonly-randconfig-001-20250722    gcc-12
x86_64      buildonly-randconfig-002-20250721    gcc-12
x86_64      buildonly-randconfig-002-20250722    gcc-12
x86_64      buildonly-randconfig-003-20250721    gcc-12
x86_64      buildonly-randconfig-003-20250722    gcc-12
x86_64      buildonly-randconfig-004-20250721    gcc-12
x86_64      buildonly-randconfig-004-20250722    clang-20
x86_64      buildonly-randconfig-005-20250721    clang-20
x86_64      buildonly-randconfig-005-20250722    gcc-12
x86_64      buildonly-randconfig-006-20250721    gcc-12
x86_64      buildonly-randconfig-006-20250722    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250721    gcc-11.5.0
xtensa                randconfig-001-20250722    gcc-15.1.0
xtensa                randconfig-002-20250721    gcc-8.5.0
xtensa                randconfig-002-20250722    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

