Return-Path: <linux-erofs+bounces-337-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BE071ABA2A9
	for <lists+linux-erofs@lfdr.de>; Fri, 16 May 2025 20:20:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zzb3R2k76z30Vm;
	Sat, 17 May 2025 04:20:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747419619;
	cv=none; b=nSyXNGY9xzIki6O7KMqGOQtGQrMMrK8dwJcN9nyv6BXr+/74RkC5tqdyEfGEdVlhfx5fYIizElWpAGl7zKT/YSZtjcBbP+2kbPp5/vlV0CjiPohNsA0H8NiIT/cgFMhiw6ruDTNaUrr7Fk3KdjNSnKfjHTSApR9xNbqZrNnlsfBtzc5V4v8X02inhhKpcjMZvJWLOycEXUE9udssxOoYS/YTzE/PnGaPW0yKYxzxJ85dwAGkGYORPPFYdj+EZY9y5XXjRXd6ZEa6dvQE6rh3zKJKUp3srbqXSyNPE5K1pAfS+kTup77gMOKvFFyXyNk4QrccU732Odaf4Bk7lY2LaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747419619; c=relaxed/relaxed;
	bh=PMi3W18IGMgS7W1g5+KaY/pDg9xm3egsaThzJ0zF2Ks=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GNcvojlbcTf4FiLfRctexs4RJu3+u72oX4xTke0vz8k+jFM61YOhhDxEThMt5n9ECl3Jp+Oi/1/8y2oFzVG0eDXz52Kx6gzV96HPSvWEeu/mWXSAY3JZg71cq7I4Bxeaq1ogeaYWlG0yK2S3Gf8H1XpKWPbjySOcgA6c4ZizQCcJ5zvnTn4/EQdbW47pc79IdcYjtZzSJKaPSkJieTOALOd1YfKlQGmlkCZLpDbDo4uBnd8smHn6vUq1fquKOGvULl/fNeGRTAY9X4SQp2gD0JCLGzH4YjHC4nDCq9xbMpH6eJM/2Jg9hRDueyE7gMKHbgDhPqFrSBkVN8VfBqXtzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nXAxd0gA; dkim-atps=neutral; spf=pass (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nXAxd0gA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zzb3Q0J5Dz30Vf
	for <linux-erofs@lists.ozlabs.org>; Sat, 17 May 2025 04:20:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747419618; x=1778955618;
  h=date:from:to:cc:subject:message-id;
  bh=7RRCgUfVFBBc4/dAE0PwgayjEZT541eLcdh8yV33Jo8=;
  b=nXAxd0gAiPBv1CWUbe4XEVOcVfPULwCWhfDq9ecPpOFcAHR03TJ/Dg/S
   Eh930Yg3jjrK2zWcMIzUutKq6ByVzT9UKZnKzMYUCxD6/oj2ZpcH5nLDc
   qwDerwvjhClH1aeHDlm9PGdprLi/dV0E7VElwSJ2XVZfUQFNgMDJ/rCca
   A8D+NLeOQjj92EbDCzZf5Wo5kGEQn2gMWRKcDqy2m02g1qVNJVi0U+HoY
   mw+dQxzbynrpZUgA2i1oi4UHSJqXGuD7EDGJf0Ls6Qs074inTeJ0IDVmI
   EsrObfx0kRJAz00ZZ3J0JKaA76f1K+9RZJR6/MrFM7Jpcwsd4MP51QUlC
   w==;
X-CSE-ConnectionGUID: e+i5EllPTzazDCRginBeCQ==
X-CSE-MsgGUID: mvvx/+VHTHqQWXEp1Yt1ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49469276"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49469276"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 11:20:14 -0700
X-CSE-ConnectionGUID: QBmnQuGeSU2dTAvBdrSa0Q==
X-CSE-MsgGUID: fQ6OPY31QiOFRot8fi68Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="139647990"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 16 May 2025 11:20:13 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFzfG-000Jbg-2F;
	Fri, 16 May 2025 18:20:10 +0000
Date: Sat, 17 May 2025 02:20:07 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 4eb56b0761e75034dd35067a81da4c280c178262
Message-ID: <202505170258.n09irJmw-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 4eb56b0761e75034dd35067a81da4c280c178262  erofs: refine readahead tracepoint

elapsed time: 1159m

configs tested: 221
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
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250516    clang-21
parisc                randconfig-001-20250516    gcc-10.5.0
parisc                randconfig-002-20250516    clang-21
parisc                randconfig-002-20250516    gcc-12.4.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
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
riscv                             allnoconfig    clang-21
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

