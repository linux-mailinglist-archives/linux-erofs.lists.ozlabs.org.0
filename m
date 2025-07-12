Return-Path: <linux-erofs+bounces-599-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B8FB02C1F
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Jul 2025 19:25:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bfb7Y52Qdz2yRn;
	Sun, 13 Jul 2025 03:25:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752341113;
	cv=none; b=oRzBPf6ch6PIU6mTrGng1fYb2l/6tdiln35iCaIHI9TZ38w704SpmJW0NdlpXiEkSJFn5JiJv1cD28FKh5+0eN9kygz3WpYIn2HSlFOpr4BBIYsos6SqahHYbAI3l3KmXZLa9NHlsOamhlIs5f5+MyG5GRjC/BwPJxZrQ6jHyCzqj1+esmfAHvYqyj9WwLTwBuaVx2VrfmbMzy4lFNTIy9xxSFvcOA/Bn3JaXOF/iLm5DUs+AX9VYCv5hZj00iAmdrKDw+yYQpmtx5rWmFVSUrpoKvGjwroJkdIsUa6u7rYFLnaapHnLG9axXZjrZibUJn50UILj4WX9B+in7mQBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752341113; c=relaxed/relaxed;
	bh=L0QcfKj6hzlVIb4BySFTMA4DKc68Za4fsehRdM4n1k0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CCVVutdTjcE42v0x94o7rU4eZB3GgbGQ4M6abJnf2yJH0f6mZCWYNR+6KahnpLtQ9/hKUXBG2n/gRK3Oy6HbX0nlIqk9TLV8GgCNs+LMPBeUEmw3RNQAU42EhRkhQ+8zxvpUYwPD37uiQvV/+drk3r+GKI/x+Sjqz98YZl1mF1uuk6G8UfDUitxS+BoQQtX8RotLgo9bVTYzXiXad7+/xCdD1nCAiL7TiXqDstKKG2XhuCG6ltqZX3v/1AaP3fc8h/JUg1i5VwKeQqehiflL+OYDcE1TMLvhIhQvlTL9B+pAfgAGV9F5TMrBDilYyzkbK6UpwQIAl6TA+/9nZ5yWpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eWdemBfu; dkim-atps=neutral; spf=pass (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eWdemBfu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bfb7W2Msvz2xYl
	for <linux-erofs@lists.ozlabs.org>; Sun, 13 Jul 2025 03:25:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752341111; x=1783877111;
  h=date:from:to:cc:subject:message-id;
  bh=cL8/rJ3oN4u+ZMKoRQv+baGhbDZREjBi28CAC30eHRo=;
  b=eWdemBfu6BZAlXXIkHPbyEB/4pme/Oe20NuFN1QhULBkOK73zpGBSWLd
   dMhgCDO0EN8HN1R8Lc/jZGY9BOsiRBoaZodqhkBz/xRNBzq8gZRQgmcu7
   hS6CM0fO3PMcO6dqEzmQaChwFuvTLhLQGhrhdBe9I+4BNXU4FHuH/u2Mw
   EMYurGd2SXNqp7ZsJfrZ+n3dOjwRbCXI+7WtNZRQpymYeg/2vfjjwnhp6
   tqmCxpCaSfgYQpzHscpOBW+v5TkmyWRHPmIdhGy8zKq9tq/qMdMXUIHwk
   a4v1PvnAZmlzkkSIzM22y3rHmx334D1NHcXWUyih7x0pC9NyA8mACidIP
   w==;
X-CSE-ConnectionGUID: z8De4SzgTq+BESeAAwgSww==
X-CSE-MsgGUID: iMp6OmdFQq2u0R5E8HAmiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53712250"
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="53712250"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 10:25:06 -0700
X-CSE-ConnectionGUID: Ng2iYOlxSsGilpV+WqgTCw==
X-CSE-MsgGUID: 6ht/h7Z1Sx+3uy2EhB8Z0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="157325356"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 12 Jul 2025 10:25:04 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uadyA-0007Xj-0m;
	Sat, 12 Jul 2025 17:25:02 +0000
Date: Sun, 13 Jul 2025 01:24:47 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 b44686c8391b427fb1c85a31c35077e6947c6d90
Message-ID: <202507130135.ipOpHDKd-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: b44686c8391b427fb1c85a31c35077e6947c6d90  erofs: fix large fragment handling

elapsed time: 1234m

configs tested: 235
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-21
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250712    gcc-10.5.0
arc                   randconfig-001-20250712    gcc-13.4.0
arc                   randconfig-002-20250712    gcc-13.4.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                          gemini_defconfig    gcc-15.1.0
arm                          ixp4xx_defconfig    gcc-15.1.0
arm                         lpc18xx_defconfig    gcc-15.1.0
arm                         mv78xx0_defconfig    gcc-15.1.0
arm                   randconfig-001-20250712    gcc-13.4.0
arm                   randconfig-001-20250712    gcc-8.5.0
arm                   randconfig-002-20250712    gcc-10.5.0
arm                   randconfig-002-20250712    gcc-13.4.0
arm                   randconfig-003-20250712    clang-21
arm                   randconfig-003-20250712    gcc-13.4.0
arm                   randconfig-004-20250712    clang-21
arm                   randconfig-004-20250712    gcc-13.4.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250712    gcc-12.3.0
arm64                 randconfig-001-20250712    gcc-13.4.0
arm64                 randconfig-002-20250712    gcc-12.3.0
arm64                 randconfig-002-20250712    gcc-13.4.0
arm64                 randconfig-003-20250712    gcc-13.4.0
arm64                 randconfig-003-20250712    gcc-8.5.0
arm64                 randconfig-004-20250712    gcc-13.4.0
csky                              allnoconfig    clang-21
csky                                defconfig    clang-19
csky                  randconfig-001-20250712    gcc-11.5.0
csky                  randconfig-001-20250712    gcc-14.3.0
csky                  randconfig-002-20250712    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250712    clang-21
hexagon               randconfig-001-20250712    gcc-11.5.0
hexagon               randconfig-002-20250712    clang-18
hexagon               randconfig-002-20250712    gcc-11.5.0
i386                             alldefconfig    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250712    clang-20
i386        buildonly-randconfig-001-20250712    gcc-12
i386        buildonly-randconfig-002-20250712    gcc-11
i386        buildonly-randconfig-002-20250712    gcc-12
i386        buildonly-randconfig-003-20250712    gcc-12
i386        buildonly-randconfig-004-20250712    gcc-12
i386        buildonly-randconfig-005-20250712    gcc-12
i386        buildonly-randconfig-006-20250712    clang-20
i386        buildonly-randconfig-006-20250712    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250712    gcc-12
i386                  randconfig-002-20250712    gcc-12
i386                  randconfig-003-20250712    gcc-12
i386                  randconfig-004-20250712    gcc-12
i386                  randconfig-005-20250712    gcc-12
i386                  randconfig-006-20250712    gcc-12
i386                  randconfig-007-20250712    gcc-12
i386                  randconfig-011-20250712    gcc-12
i386                  randconfig-012-20250712    gcc-12
i386                  randconfig-013-20250712    gcc-12
i386                  randconfig-014-20250712    gcc-12
i386                  randconfig-015-20250712    gcc-12
i386                  randconfig-016-20250712    gcc-12
i386                  randconfig-017-20250712    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250712    gcc-11.5.0
loongarch             randconfig-001-20250712    gcc-15.1.0
loongarch             randconfig-002-20250712    gcc-11.5.0
loongarch             randconfig-002-20250712    gcc-14.3.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                        stmark2_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                         rt305x_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250712    gcc-11.5.0
nios2                 randconfig-002-20250712    gcc-11.5.0
nios2                 randconfig-002-20250712    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250712    gcc-11.5.0
parisc                randconfig-001-20250712    gcc-8.5.0
parisc                randconfig-002-20250712    gcc-11.5.0
parisc                randconfig-002-20250712    gcc-12.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                 linkstation_defconfig    gcc-15.1.0
powerpc                      ppc64e_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250712    gcc-11.5.0
powerpc               randconfig-001-20250712    gcc-15.1.0
powerpc               randconfig-002-20250712    gcc-11.5.0
powerpc               randconfig-002-20250712    gcc-8.5.0
powerpc               randconfig-003-20250712    clang-21
powerpc               randconfig-003-20250712    gcc-11.5.0
powerpc64             randconfig-001-20250712    gcc-8.5.0
powerpc64             randconfig-002-20250712    clang-21
powerpc64             randconfig-002-20250712    gcc-11.5.0
powerpc64             randconfig-003-20250712    clang-19
powerpc64             randconfig-003-20250712    gcc-11.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250712    gcc-8.5.0
riscv                 randconfig-002-20250712    clang-21
riscv                 randconfig-002-20250712    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250712    clang-21
s390                  randconfig-001-20250712    gcc-8.5.0
s390                  randconfig-002-20250712    clang-21
s390                  randconfig-002-20250712    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                        apsh4ad0a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                     magicpanelr2_defconfig    gcc-15.1.0
sh                    randconfig-001-20250712    gcc-15.1.0
sh                    randconfig-001-20250712    gcc-8.5.0
sh                    randconfig-002-20250712    gcc-14.3.0
sh                    randconfig-002-20250712    gcc-8.5.0
sh                   rts7751r2dplus_defconfig    gcc-15.1.0
sh                           se7751_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250712    gcc-13.4.0
sparc                 randconfig-001-20250712    gcc-8.5.0
sparc                 randconfig-002-20250712    gcc-15.1.0
sparc                 randconfig-002-20250712    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250712    clang-20
sparc64               randconfig-001-20250712    gcc-8.5.0
sparc64               randconfig-002-20250712    gcc-14.3.0
sparc64               randconfig-002-20250712    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250712    gcc-12
um                    randconfig-001-20250712    gcc-8.5.0
um                    randconfig-002-20250712    clang-21
um                    randconfig-002-20250712    gcc-8.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250712    gcc-12
x86_64      buildonly-randconfig-002-20250712    gcc-12
x86_64      buildonly-randconfig-003-20250712    clang-20
x86_64      buildonly-randconfig-003-20250712    gcc-12
x86_64      buildonly-randconfig-004-20250712    clang-20
x86_64      buildonly-randconfig-004-20250712    gcc-12
x86_64      buildonly-randconfig-005-20250712    gcc-12
x86_64      buildonly-randconfig-006-20250712    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250712    clang-20
x86_64                randconfig-002-20250712    clang-20
x86_64                randconfig-003-20250712    clang-20
x86_64                randconfig-004-20250712    clang-20
x86_64                randconfig-005-20250712    clang-20
x86_64                randconfig-006-20250712    clang-20
x86_64                randconfig-007-20250712    clang-20
x86_64                randconfig-008-20250712    clang-20
x86_64                randconfig-071-20250712    clang-20
x86_64                randconfig-072-20250712    clang-20
x86_64                randconfig-073-20250712    clang-20
x86_64                randconfig-074-20250712    clang-20
x86_64                randconfig-075-20250712    clang-20
x86_64                randconfig-076-20250712    clang-20
x86_64                randconfig-077-20250712    clang-20
x86_64                randconfig-078-20250712    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250712    gcc-8.5.0
xtensa                randconfig-002-20250712    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

