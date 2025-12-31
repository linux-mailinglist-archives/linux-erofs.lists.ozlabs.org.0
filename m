Return-Path: <linux-erofs+bounces-1655-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79504CEAF94
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Dec 2025 01:49:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dgrtn325dz2xqj;
	Wed, 31 Dec 2025 11:49:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767142145;
	cv=none; b=VEWC56BPiA35qFwzFG8+xM/wP+gwNFbT2KsaFITClZR+f0UK13YLhNKkBZ7WTTtWucbWYpjFX7ZQhtSgEHx7aIOc9n61Jz28me45V1OpdyIVQx+ds9uwjH4Ks37cJ97Oa7ICFSzZOZ4Qb2Sbjp8K7LTJo0PHDDWwnM2lUQzoAZgaTYKvoK8ismJCTduJzhc+4wpV87Yv/nXfq6BYusoYNOpLYPYIpIiFjiEorYfbmEc6vFasgx538y7aGlhVryfnrVw6N4Gn4vfiECb4ZMjQMvuX8886UyT4lB1UGO3oiNqc9j9WSr11SuImabyT1TaWHnIzgchLZnOA8s2lUbGwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767142145; c=relaxed/relaxed;
	bh=3fI9yUg5DCotv/axBrKWoegDqWGrVpqKyUNhVre1BmI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=N8fsEre0Mnb3w1MEPiUEGvgsgW+U3JJ2ByZ/2p8NcqjdRMX37GhA9Gtg63raAUug9e4aPLj2Jiua0J1zanNgAe+xcZEYX1wgsstnEmfNaGrY5JXIDnhWulqct3kxVfhdA+/NIVlY8J82tKEDEjon0XDt/pe4+lU3FGPO48LwYC2jsR3kboiDp/6ltKLt8bOprPD++Sk6X/rlD/l7mYzFgF9Xn3kadPyeVTXxkjaA+jKt4GzNZG2BPXctm1VTtCVMe7JJmpPDYKwskcNZoqKi2/8CVDeGNt/vJNDWn4J61vptYhdi1M3Wd9+uKVQfhMeNWSrfnob7TYoQSkv6bcan1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MtW5HyTE; dkim-atps=neutral; spf=pass (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MtW5HyTE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dgrtk2Ph7z2x9M
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 Dec 2025 11:49:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767142143; x=1798678143;
  h=date:from:to:cc:subject:message-id;
  bh=/KUWorytiSOHm1G/SCmhxHfAxH5408dns67PxwKmEeQ=;
  b=MtW5HyTE6RV8+BK09XPp2hVlsYSZielT1JXKK9C0FtW8gUm9pdQ2hpmC
   a6dKQP5cyRUzylZYlwPLcebZp8kz05QOp7BTr2k9jXsJCBjXlYr93+WmW
   /uRplPi/IwzLICEQ+Ur3h/x0Xr3PUxXTYbBd9dxq1UyeN920xFgXppscE
   WRy8eLSftB6oH6h1bTrZiox9J0x8q9RZwzyKMxmA8FO+8Spu1pYGbAC8t
   FawdHDCgCP4rnx9eV7F/385WPjY0kP6mE2ecnh75eO01PAO9jmtSjA6QL
   PytkEdd6AsJuCW88ie8CoLyJSYTTWRI69UBw1t0eA4dcvSPA1lgwejSjK
   g==;
X-CSE-ConnectionGUID: NbDoXqzuQimgAw0xKc1suA==
X-CSE-MsgGUID: T9kPCLlsSJewTAKBXjvP1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11657"; a="68615691"
X-IronPort-AV: E=Sophos;i="6.21,190,1763452800"; 
   d="scan'208";a="68615691"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 16:48:56 -0800
X-CSE-ConnectionGUID: toS6+CYhSqefdNotoBdsmQ==
X-CSE-MsgGUID: YA2Qwc/hRcy89hjJnlqd8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,190,1763452800"; 
   d="scan'208";a="205844771"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 30 Dec 2025 16:48:55 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vakOS-000000000nl-1QBR;
	Wed, 31 Dec 2025 00:48:52 +0000
Date: Wed, 31 Dec 2025 08:48:34 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 e84fd1bdbe05e6b3ebe5766b98b7e4902203e8e1
Message-ID: <202512310827.njBz1LnR-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: e84fd1bdbe05e6b3ebe5766b98b7e4902203e8e1  erofs: remove useless src in erofs_xattr_copy_to_buffer()

elapsed time: 1222m

configs tested: 166
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
arc                   randconfig-001-20251230    gcc-12.5.0
arc                   randconfig-002-20251230    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                           imxrt_defconfig    clang-22
arm                   randconfig-001-20251230    gcc-8.5.0
arm                   randconfig-002-20251230    gcc-8.5.0
arm                   randconfig-003-20251230    gcc-10.5.0
arm                   randconfig-004-20251230    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251230    gcc-15.1.0
arm64                 randconfig-002-20251230    gcc-14.3.0
arm64                 randconfig-003-20251230    clang-22
arm64                 randconfig-004-20251230    clang-20
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251230    gcc-15.1.0
csky                  randconfig-002-20251230    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251230    clang-22
hexagon               randconfig-002-20251230    clang-18
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251230    gcc-14
i386        buildonly-randconfig-002-20251230    clang-20
i386        buildonly-randconfig-003-20251230    clang-20
i386        buildonly-randconfig-004-20251230    clang-20
i386        buildonly-randconfig-005-20251230    clang-20
i386        buildonly-randconfig-006-20251230    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251230    gcc-14
i386                  randconfig-002-20251230    clang-20
i386                  randconfig-003-20251230    clang-20
i386                  randconfig-004-20251230    clang-20
i386                  randconfig-005-20251230    clang-20
i386                  randconfig-006-20251230    clang-20
i386                  randconfig-007-20251230    clang-20
i386                  randconfig-011-20251230    gcc-14
i386                  randconfig-012-20251230    gcc-14
i386                  randconfig-013-20251230    clang-20
i386                  randconfig-014-20251230    gcc-12
i386                  randconfig-015-20251230    gcc-14
i386                  randconfig-016-20251230    gcc-14
i386                  randconfig-017-20251230    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251230    gcc-15.1.0
loongarch             randconfig-002-20251230    clang-22
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
mips                          malta_defconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251230    gcc-8.5.0
nios2                 randconfig-002-20251230    gcc-9.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251230    gcc-15.1.0
parisc                randconfig-002-20251230    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                   currituck_defconfig    clang-22
powerpc               randconfig-001-20251230    gcc-10.5.0
powerpc               randconfig-002-20251230    gcc-12.5.0
powerpc64             randconfig-001-20251230    gcc-14.3.0
powerpc64             randconfig-002-20251230    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251230    gcc-15.1.0
riscv                 randconfig-002-20251230    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251230    gcc-14.3.0
s390                  randconfig-002-20251230    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          kfr2r09_defconfig    gcc-15.1.0
sh                    randconfig-001-20251230    gcc-13.4.0
sh                    randconfig-002-20251230    gcc-12.5.0
sh                          rsk7269_defconfig    gcc-15.1.0
sh                           se7721_defconfig    gcc-15.1.0
sparc                            alldefconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251230    gcc-8.5.0
sparc                 randconfig-002-20251230    gcc-11.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251230    clang-22
sparc64               randconfig-002-20251230    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251230    gcc-13
um                    randconfig-002-20251230    clang-18
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251230    gcc-14
x86_64      buildonly-randconfig-002-20251230    gcc-14
x86_64      buildonly-randconfig-003-20251230    clang-20
x86_64      buildonly-randconfig-004-20251230    clang-20
x86_64      buildonly-randconfig-005-20251230    clang-20
x86_64      buildonly-randconfig-006-20251230    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251230    gcc-14
x86_64                randconfig-002-20251230    clang-20
x86_64                randconfig-003-20251230    clang-20
x86_64                randconfig-004-20251230    clang-20
x86_64                randconfig-005-20251230    clang-20
x86_64                randconfig-006-20251230    gcc-14
x86_64                randconfig-011-20251230    gcc-14
x86_64                randconfig-012-20251230    gcc-14
x86_64                randconfig-013-20251230    gcc-14
x86_64                randconfig-014-20251230    clang-20
x86_64                randconfig-015-20251230    clang-20
x86_64                randconfig-016-20251230    clang-20
x86_64                randconfig-071-20251230    clang-20
x86_64                randconfig-072-20251230    clang-20
x86_64                randconfig-073-20251230    gcc-14
x86_64                randconfig-074-20251230    clang-20
x86_64                randconfig-075-20251230    clang-20
x86_64                randconfig-076-20251230    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251230    gcc-8.5.0
xtensa                randconfig-002-20251230    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

