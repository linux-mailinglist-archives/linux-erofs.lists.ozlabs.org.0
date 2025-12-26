Return-Path: <linux-erofs+bounces-1619-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F58BCDEF3E
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Dec 2025 20:54:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ddGXW09D2z2xg9;
	Sat, 27 Dec 2025 06:54:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766778858;
	cv=none; b=m8w2kr0H37WKGc9BG4fZgn9ivDQViq3orNRpY49tGTbRjyCtxgJSn68ZlAgulJZR4X5+UJWmrtKn3gUcCxYlxFA9FOISFZgKv6IgQHvpxLuCYNX3zpmJsRe6DGC85cvaUSNaIaCJd8EzWbfK9DI+H6ffZMysWr2o/oJwHziWZRvBJd9CIredMMBGLlQAYnx0Sf98qlo6H/ON3FmUw15JlyKJ6VkPyKMyQBjKqI1Ba4MNP/Kmqe5/Phw9BhN6TW54L34VsJuGCLsyFh+6UWtSj1AWohMK/av8fkecc+H64RWSTG6jnFQqJ/tqHyiJqLHC0qp71J35znz9Mj717dgcoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766778858; c=relaxed/relaxed;
	bh=7+OX/Bl9chncBf0qqtJLZWM5dDLJm/ikN/gVLfrnWjA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QRCiswdn1ZvPRBzORW0D5JIi9zuKX6qD6Fgj543qh1V81SHLfJ5UOkE0Ar+mStHAh7WX5Ln8pYNu8rTwUlPxm4Qn2D6uee58djc4TnT2m1pcDzTSIP+cGD04HsPtl3R4Va+pg9cyB1N8Es05yQIFrPCNiLI9WrstE8W0OoSiX2QVaEEzGc5GNE7ASDd69FStiT7fOvd3jTziQqGaElz9hekPKsOa/kpCodgV78u53SdTmYOkzWjMkN97MqbGIWLhANjHn79Lg9QkQr5PTFybMRxDRNvyg5pwU0n8FdbyGPZlDqNqwLtyPA+5bFFMB5V5yJiaL9vqcgqvWaoGl5/TKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fsYOOL+o; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fsYOOL+o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ddGXR5pcSz2xcB
	for <linux-erofs@lists.ozlabs.org>; Sat, 27 Dec 2025 06:54:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766778856; x=1798314856;
  h=date:from:to:cc:subject:message-id;
  bh=GyqkwGXg19M1g9p59QtaC/x2srucitk8P+jz4KitZ8g=;
  b=fsYOOL+oGo/JJIPBcQe+2dr2Mx1GRVF0sU2mXGH3gd/rSOL1axOgMnak
   iGnQxqOd3yTmGby5skrGa2OOvcypFfW/5KYrjyKY4h/dovoXnciGT60zm
   NgYXvHFQlWdi6JyWJG9AUJW8NI2RGITHdmEXtESxbS1NMKlmPdzcxtJ8y
   ZBrlIsQw34BIOpJ24tXo5u54XV57skfKnTfn+ydxXYfLwYAYPtjDfMAH6
   FGBrV/ogz2m85dQN7oD/WkegC6c8XdrSui0PDKc+/Lg/T0pzHWr3MCulR
   N0GzIWAmKlEspB5sZ7FJR6JZcRcAaI0ZpPs7+L+/nWJeD1bdmPBIFyUa5
   g==;
X-CSE-ConnectionGUID: bNCnYX8ERRWe8zbpXJypBw==
X-CSE-MsgGUID: hbolQk3FTnq878t6e03NVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11653"; a="79244817"
X-IronPort-AV: E=Sophos;i="6.21,178,1763452800"; 
   d="scan'208";a="79244817"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2025 11:54:09 -0800
X-CSE-ConnectionGUID: P8Mt5//ERBOHm7YFvxygtA==
X-CSE-MsgGUID: Xa60pDgESnaZiFU/1DMZvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,178,1763452800"; 
   d="scan'208";a="200178713"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 26 Dec 2025 11:54:08 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vZDss-000000005K1-1qy5;
	Fri, 26 Dec 2025 19:53:59 +0000
Date: Sat, 27 Dec 2025 03:53:10 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 1896b9f9c7d473df959c51fed4849d3357b55d14
Message-ID: <202512270305.Fhi58jVp-lkp@intel.com>
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
branch HEAD: 1896b9f9c7d473df959c51fed4849d3357b55d14  erofs: avoid noisy messages for transient -ENOMEM

elapsed time: 725m

configs tested: 163
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251226    gcc-14.3.0
arc                   randconfig-002-20251226    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20251226    gcc-13.4.0
arm                   randconfig-002-20251226    gcc-8.5.0
arm                   randconfig-003-20251226    clang-19
arm                   randconfig-004-20251226    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251226    clang-20
arm64                 randconfig-002-20251226    clang-22
arm64                 randconfig-003-20251226    gcc-12.5.0
arm64                 randconfig-004-20251226    gcc-13.4.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251226    gcc-15.1.0
csky                  randconfig-002-20251226    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251226    clang-17
hexagon               randconfig-002-20251226    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251226    gcc-14
i386        buildonly-randconfig-002-20251226    gcc-12
i386        buildonly-randconfig-003-20251226    gcc-14
i386        buildonly-randconfig-004-20251226    gcc-14
i386        buildonly-randconfig-005-20251226    clang-20
i386        buildonly-randconfig-006-20251226    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251226    gcc-14
i386                  randconfig-002-20251226    gcc-14
i386                  randconfig-003-20251226    gcc-14
i386                  randconfig-004-20251226    gcc-14
i386                  randconfig-005-20251226    clang-20
i386                  randconfig-006-20251226    gcc-14
i386                  randconfig-007-20251226    gcc-14
i386                  randconfig-011-20251226    clang-20
i386                  randconfig-012-20251226    gcc-13
i386                  randconfig-013-20251226    clang-20
i386                  randconfig-014-20251226    clang-20
i386                  randconfig-015-20251226    clang-20
i386                  randconfig-016-20251226    clang-20
i386                  randconfig-017-20251226    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251226    gcc-15.1.0
loongarch             randconfig-002-20251226    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251226    gcc-9.5.0
nios2                 randconfig-002-20251226    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251226    gcc-14.3.0
parisc                randconfig-002-20251226    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                 canyonlands_defconfig    clang-22
powerpc               randconfig-001-20251226    clang-17
powerpc               randconfig-002-20251226    gcc-9.5.0
powerpc64             randconfig-001-20251226    gcc-15.1.0
powerpc64             randconfig-002-20251226    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251226    gcc-15.1.0
riscv                 randconfig-002-20251226    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251226    clang-17
s390                  randconfig-002-20251226    gcc-8.5.0
s390                       zfcpdump_defconfig    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251226    gcc-9.5.0
sh                    randconfig-002-20251226    gcc-15.1.0
sh                          rsk7269_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251226    gcc-14.3.0
sparc                 randconfig-002-20251226    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251226    gcc-11.5.0
sparc64               randconfig-002-20251226    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251226    clang-22
um                    randconfig-002-20251226    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251226    gcc-12
x86_64      buildonly-randconfig-002-20251226    clang-20
x86_64      buildonly-randconfig-003-20251226    gcc-12
x86_64      buildonly-randconfig-005-20251226    gcc-14
x86_64      buildonly-randconfig-006-20251226    gcc-12
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251226    clang-20
x86_64                randconfig-002-20251226    clang-20
x86_64                randconfig-003-20251226    gcc-14
x86_64                randconfig-004-20251226    gcc-14
x86_64                randconfig-005-20251226    gcc-14
x86_64                randconfig-006-20251226    clang-20
x86_64                randconfig-011-20251226    clang-20
x86_64                randconfig-012-20251226    gcc-14
x86_64                randconfig-013-20251226    gcc-14
x86_64                randconfig-014-20251226    clang-20
x86_64                randconfig-015-20251226    gcc-14
x86_64                randconfig-016-20251226    gcc-14
x86_64                randconfig-071-20251226    gcc-12
x86_64                randconfig-072-20251226    clang-20
x86_64                randconfig-073-20251226    gcc-14
x86_64                randconfig-074-20251226    gcc-14
x86_64                randconfig-075-20251226    gcc-14
x86_64                randconfig-076-20251226    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20251226    gcc-8.5.0
xtensa                randconfig-002-20251226    gcc-8.5.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

