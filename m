Return-Path: <linux-erofs+bounces-1798-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB140D0929C
	for <lists+linux-erofs@lfdr.de>; Fri, 09 Jan 2026 13:01:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dngN44mx1z2xc8;
	Fri, 09 Jan 2026 23:01:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767960068;
	cv=none; b=cJrysTpOKK2oRC+Em3F2Oq4li5ift9d8BTQcQ5P0m+UuzYLVldCxQ8gqO3mLqWkFnPM9fJ0sDktTyPi7UflquiO0Id2i8jRIomRI40L7ABU4lt47UoY8X5LEDOFZqMNIjQjzfiGmv0SGccr/gAWqekl75INGXZfwpgqGMarzGtiLh7ywBqOEgmzEX0w0r1atOLr5RmQ90VJHeJYZ3K4a3A91NsBgSB5TO6Q2H5ePzgHDro7BRYlICwynUrihUJtQ5vh/5xYcQ7ezpjGtYktatBrPUFM0YjLU1yFTpZahu5evgp7Rjl7OuZ6nyEmIk4u1t2RcI0ChsR9NWQ31MhqfzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767960068; c=relaxed/relaxed;
	bh=NwTltbjPq6jLkHHieQjIOGfdyOdQGguo7TCyCobF5oI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AN1ekjW2p18S1/6zGwBhsikL/yzJg/2d4/7heDU0eh/ljksrEMmRrbJHXQ7LaW1nuZ7du69enRfZVyb1+yVCpPkd4uQECy9FSGwHMC8oRBa1nrKffJjn+YAE5iJiCTok++5TzQ1YI7N7mgODgFzFpIJ36naIjyfXACFPkCd9UuG0hw3RWkvftaZ+RXyNhgE9jbegkA2JwqJCVBMwfR8rC7JVcpnRr4umKrgAFhIcU0dQjp99Q4IjYPpKYvZEjRs+YCFitP3nuAcCURaNxMyc/BoKTOVsCZoMQWwgir63MHeNe1osrO2hi0XSHXiK/naf63ihDtcVKCXzZx3eUCyaRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H7qZUyqi; dkim-atps=neutral; spf=pass (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H7qZUyqi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dngN11Gt0z2xP8
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 23:01:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767960065; x=1799496065;
  h=date:from:to:cc:subject:message-id;
  bh=Lk+nJ0shfnbC2sdHg8NHvo1JLEmhz1SIVKYJxgrC/tA=;
  b=H7qZUyqiQ6teCJ6ZAJ4c1OGMYhLBDNnDw6EkDCojUgJt2DSqRqTP9BPt
   ZGQ0wMoGiaLDTzHJAKcmUjO4Si3Q+s46bjRm4jZ6VZLJH8YcXFeeRtJlF
   Osd8QbBPJIYR+MgOHiDK4YTl6DRlWLzUeS+Vinf5WoY1BbsDWPojWaYf+
   ORYUvkRKwjwk+dYOqb/mC9+x3KgkE9E3PvgDC2EKYpsGcGuBUoKVxN6PR
   r8iiGIcbIqQOPEbZO02X7VhguljPwWukUtWA3WVFEbSBv6VEDM3d2//uW
   HlYG1ZN1nHIfGGqKv4xHNd7CmUjsxWHf6DEo0FQiQPTzQd5Xm3wGt5T+R
   w==;
X-CSE-ConnectionGUID: YnntmCsUQaeRMVdhLsEEMQ==
X-CSE-MsgGUID: tyvYYEFuRZ+abCcU737tkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="80708241"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="80708241"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 04:01:00 -0800
X-CSE-ConnectionGUID: dJ7zX3bjSZyRkqbgB6GkTA==
X-CSE-MsgGUID: PjicaPCHT/yaY6k7bz6woA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="208290623"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 09 Jan 2026 04:00:58 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1veBAm-000000005zf-2DSl;
	Fri, 09 Jan 2026 12:00:56 +0000
Date: Fri, 09 Jan 2026 20:00:53 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 23da3c774fc3ed87e7b9ec86addbb743cb82f4b0
Message-ID: <202601092047.5sIr14e2-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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
branch HEAD: 23da3c774fc3ed87e7b9ec86addbb743cb82f4b0  erofs: don't bother with s_stack_depth increasing for now

elapsed time: 1560m

configs tested: 253
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                      axs103_smp_defconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20260108    gcc-9.5.0
arc                   randconfig-001-20260109    gcc-13.4.0
arc                   randconfig-002-20260108    gcc-8.5.0
arc                   randconfig-002-20260109    gcc-13.4.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.1.0
arm                        mvebu_v5_defconfig    clang-22
arm                           omap1_defconfig    clang-22
arm                   randconfig-001-20260108    gcc-8.5.0
arm                   randconfig-001-20260109    gcc-13.4.0
arm                   randconfig-002-20260108    gcc-13.4.0
arm                   randconfig-002-20260109    gcc-13.4.0
arm                   randconfig-003-20260108    clang-17
arm                   randconfig-003-20260109    gcc-13.4.0
arm                   randconfig-004-20260108    clang-22
arm                   randconfig-004-20260109    gcc-13.4.0
arm                           sama7_defconfig    clang-22
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20260108    gcc-15.1.0
arm64                 randconfig-001-20260109    gcc-8.5.0
arm64                 randconfig-002-20260108    clang-22
arm64                 randconfig-002-20260109    gcc-8.5.0
arm64                 randconfig-003-20260108    clang-22
arm64                 randconfig-003-20260109    gcc-8.5.0
arm64                 randconfig-004-20260108    gcc-10.5.0
arm64                 randconfig-004-20260109    gcc-8.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20260108    gcc-9.5.0
csky                  randconfig-001-20260109    gcc-8.5.0
csky                  randconfig-002-20260108    gcc-11.5.0
csky                  randconfig-002-20260109    gcc-8.5.0
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20260108    clang-22
hexagon               randconfig-001-20260109    gcc-8.5.0
hexagon               randconfig-002-20260108    clang-22
hexagon               randconfig-002-20260109    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260108    clang-20
i386        buildonly-randconfig-001-20260109    clang-20
i386        buildonly-randconfig-002-20260108    clang-20
i386        buildonly-randconfig-002-20260109    clang-20
i386        buildonly-randconfig-003-20260108    gcc-13
i386        buildonly-randconfig-003-20260109    clang-20
i386        buildonly-randconfig-004-20260108    clang-20
i386        buildonly-randconfig-004-20260109    clang-20
i386        buildonly-randconfig-005-20260108    clang-20
i386        buildonly-randconfig-005-20260109    clang-20
i386        buildonly-randconfig-006-20260108    gcc-14
i386        buildonly-randconfig-006-20260109    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20260109    gcc-14
i386                  randconfig-002-20260109    gcc-14
i386                  randconfig-003-20260109    gcc-12
i386                  randconfig-003-20260109    gcc-14
i386                  randconfig-004-20260109    gcc-14
i386                  randconfig-005-20260109    gcc-14
i386                  randconfig-006-20260109    clang-20
i386                  randconfig-006-20260109    gcc-14
i386                  randconfig-007-20260109    gcc-14
i386                  randconfig-011-20260108    gcc-12
i386                  randconfig-011-20260109    clang-20
i386                  randconfig-012-20260108    gcc-14
i386                  randconfig-012-20260109    clang-20
i386                  randconfig-013-20260108    gcc-14
i386                  randconfig-013-20260109    clang-20
i386                  randconfig-014-20260108    gcc-12
i386                  randconfig-014-20260109    clang-20
i386                  randconfig-015-20260108    gcc-14
i386                  randconfig-015-20260109    clang-20
i386                  randconfig-016-20260108    gcc-14
i386                  randconfig-016-20260109    clang-20
i386                  randconfig-017-20260108    gcc-14
i386                  randconfig-017-20260109    clang-20
loongarch                        alldefconfig    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260108    clang-22
loongarch             randconfig-001-20260109    gcc-8.5.0
loongarch             randconfig-002-20260108    clang-22
loongarch             randconfig-002-20260109    gcc-8.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.1.0
m68k                        m5407c3_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                           ip28_defconfig    gcc-15.1.0
mips                          malta_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260108    gcc-8.5.0
nios2                 randconfig-001-20260109    gcc-8.5.0
nios2                 randconfig-002-20260108    gcc-8.5.0
nios2                 randconfig-002-20260109    gcc-8.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
openrisc                    or1ksim_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20260108    gcc-13.4.0
parisc                randconfig-001-20260109    gcc-8.5.0
parisc                randconfig-002-20260108    gcc-12.5.0
parisc                randconfig-002-20260109    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                      arches_defconfig    gcc-15.1.0
powerpc                      chrp32_defconfig    clang-22
powerpc                      pmac32_defconfig    clang-22
powerpc                      ppc6xx_defconfig    clang-22
powerpc               randconfig-001-20260108    gcc-13.4.0
powerpc               randconfig-001-20260109    gcc-8.5.0
powerpc               randconfig-002-20260108    clang-22
powerpc               randconfig-002-20260109    gcc-8.5.0
powerpc64             randconfig-001-20260108    clang-22
powerpc64             randconfig-001-20260109    gcc-8.5.0
powerpc64             randconfig-002-20260108    clang-22
powerpc64             randconfig-002-20260109    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.1.0
riscv             nommu_k210_sdcard_defconfig    gcc-15.1.0
riscv                 randconfig-001-20260108    gcc-15.1.0
riscv                 randconfig-001-20260109    clang-22
riscv                 randconfig-002-20260108    clang-22
riscv                 randconfig-002-20260109    clang-22
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20260108    gcc-13.4.0
s390                  randconfig-001-20260109    clang-22
s390                  randconfig-002-20260109    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260108    gcc-9.5.0
sh                    randconfig-001-20260109    clang-22
sh                    randconfig-002-20260108    gcc-13.4.0
sh                    randconfig-002-20260109    clang-22
sh                           se7722_defconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20260108    gcc-8.5.0
sparc                 randconfig-001-20260109    gcc-14.3.0
sparc                 randconfig-002-20260108    gcc-15.1.0
sparc                 randconfig-002-20260109    gcc-14.3.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260108    gcc-8.5.0
sparc64               randconfig-001-20260109    gcc-14.3.0
sparc64               randconfig-002-20260108    clang-20
sparc64               randconfig-002-20260109    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260108    clang-18
um                    randconfig-001-20260109    gcc-14.3.0
um                    randconfig-002-20260108    clang-22
um                    randconfig-002-20260109    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260108    clang-20
x86_64      buildonly-randconfig-001-20260109    clang-20
x86_64      buildonly-randconfig-001-20260109    gcc-14
x86_64      buildonly-randconfig-002-20260108    clang-20
x86_64      buildonly-randconfig-002-20260109    gcc-14
x86_64      buildonly-randconfig-003-20260109    gcc-14
x86_64      buildonly-randconfig-004-20260108    clang-20
x86_64      buildonly-randconfig-004-20260109    gcc-14
x86_64      buildonly-randconfig-005-20260108    gcc-14
x86_64      buildonly-randconfig-005-20260109    gcc-14
x86_64      buildonly-randconfig-006-20260108    gcc-14
x86_64      buildonly-randconfig-006-20260109    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260108    clang-20
x86_64                randconfig-001-20260109    gcc-14
x86_64                randconfig-002-20260108    clang-20
x86_64                randconfig-002-20260109    gcc-14
x86_64                randconfig-003-20260108    gcc-12
x86_64                randconfig-003-20260109    gcc-14
x86_64                randconfig-004-20260108    gcc-14
x86_64                randconfig-004-20260109    gcc-14
x86_64                randconfig-005-20260108    gcc-14
x86_64                randconfig-005-20260109    gcc-14
x86_64                randconfig-006-20260108    gcc-14
x86_64                randconfig-006-20260109    gcc-14
x86_64                randconfig-011-20260108    clang-20
x86_64                randconfig-012-20260108    clang-20
x86_64                randconfig-013-20260108    clang-20
x86_64                randconfig-014-20260108    gcc-14
x86_64                randconfig-015-20260108    gcc-14
x86_64                randconfig-016-20260108    gcc-14
x86_64                randconfig-071-20260109    clang-20
x86_64                randconfig-072-20260109    clang-20
x86_64                randconfig-073-20260109    clang-20
x86_64                randconfig-074-20260109    clang-20
x86_64                randconfig-075-20260109    clang-20
x86_64                randconfig-076-20260109    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                          iss_defconfig    gcc-15.1.0
xtensa                randconfig-001-20260108    gcc-11.5.0
xtensa                randconfig-001-20260109    gcc-14.3.0
xtensa                randconfig-002-20260108    gcc-8.5.0
xtensa                randconfig-002-20260109    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

