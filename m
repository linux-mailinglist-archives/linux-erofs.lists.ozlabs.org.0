Return-Path: <linux-erofs+bounces-898-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24321B3350F
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Aug 2025 06:31:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c9Hv033Hgz3cPG;
	Mon, 25 Aug 2025 14:31:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756096316;
	cv=none; b=Gg/S86UKavyMbT+EfalVGzOBGtVsP6sDKLxAf3iNXNekpUYfNXZwKNb3VutYGVyq8GzHQZQSojJPa+ZgnhYyBLDd7khs30KmvEdx2gHmjc4+Ir/N3I5DcQA8ThjzzQPoxKqweKK3HfQHfogLFxJDo9PjCpEAWaxE2D6ABCNsCy5QarGF4vIo8PfnohYsToSrVRPgFRCQ96LiTOerqxZx0q63q6YYG1iJahB0R8WDeE/KSeSywA6t9hr1zGzKNqOP8sc5dwBUYPi6ydsBGSvBVvJc2T1alzDkA9lPAhkfHtEuBsz2zsZAV9F/UKi97v3d5m+HCGqyv7+EMIUGFZzH9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756096316; c=relaxed/relaxed;
	bh=H18wORDgLB/rxIR7jCitXbLypHZNd2IRVKCbqrpcWW0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PQ4VE63l9ucrUBn34K9dhzSL/gJhb9KlJXyE2rf3xms636su6UiH4zCdcQMgR4R2kFc3Jk3xsN1XDJbzun84Cuyc0IhjZ03gtkjlELdcFUdXZYmGBnf8IrBiigUEbFd4y7BLQ+tnQwjKsHadtFql3U/JuVng6khxmwR9m1t0XkE7lrYphP87AmUW/iH5WPADTWzUh1XsgxTdXcOLZNRMRz7M3/BUrujyd6ADykxxCbHb/NgrrOzSQs+sDLHxFWsMd2s9V+UJx/E7RiQdQbxMb6zJOiUTa0yiNOs7jw70eYvcG/n/XeNMMInLBRvYVa+L06UXPLX5/rsbaooQUYXtQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bTDJI8an; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bTDJI8an;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c9Htt39w4z3cDN
	for <linux-erofs@lists.ozlabs.org>; Mon, 25 Aug 2025 14:31:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756096310; x=1787632310;
  h=date:from:to:cc:subject:message-id;
  bh=fXfwo+jdBntkOnqA7IZfFuSRd+ZfUUAmimEdSH50H98=;
  b=bTDJI8ang1UakWgi+Si7ZDiQx9x2hWzdTpEwyM/XtW2N4XZPv4IhqP1L
   VLq+GEjpk3Nb9rwVXKbrVkmjk8XeUW9FA7Vucgf6LJEzXh0+8UcCwXJzl
   DP9Yohfpn7xiKfdmxsp1Y0eGSXWu5ydeWMSy+K/yLbj3ngufXRx1dCZRV
   qWYemijgyifZrVzgQug1uHa0d2FQsdRz0v+oOQXj02B24Ejk8I/Ryac6d
   TIZAoRuPqGMzEuHCdLG1q9VVj9A3w5a6vLUNXRBBHEgCwhpLKM7KtuucX
   QPXKXJE4+S3PX8PBvx0GtgYbl9w5fL4hJMVGIWxDPrpTsWfzcghhy5cgP
   w==;
X-CSE-ConnectionGUID: 5g5KUqKqTSCOfJDeWNhlBw==
X-CSE-MsgGUID: iBl4zEfMRlyfVkTXozKmbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="69012373"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="69012373"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 21:31:44 -0700
X-CSE-ConnectionGUID: 0AMZLhLKSMir2MWdwpkuWg==
X-CSE-MsgGUID: nJVpXwpqTWC23qAEUaRHEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168435086"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 24 Aug 2025 21:31:43 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqOrs-000NMK-18;
	Mon, 25 Aug 2025 04:31:40 +0000
Date: Mon, 25 Aug 2025 12:31:25 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 27ad534606c4cd8bd816b929e46e8a8eeb6cb07d
Message-ID: <202508251211.2SMAmo19-lkp@intel.com>
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
branch HEAD: 27ad534606c4cd8bd816b929e46e8a8eeb6cb07d  erofs: fix invalid algorithm for encoded extents

elapsed time: 764m

configs tested: 158
configs skipped: 4

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
arc                   randconfig-001-20250825    gcc-8.5.0
arc                   randconfig-002-20250825    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                        keystone_defconfig    gcc-15.1.0
arm                          moxart_defconfig    gcc-15.1.0
arm                   randconfig-001-20250825    gcc-12.5.0
arm                   randconfig-002-20250825    gcc-13.4.0
arm                   randconfig-003-20250825    gcc-8.5.0
arm                   randconfig-004-20250825    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250825    gcc-8.5.0
arm64                 randconfig-002-20250825    gcc-8.5.0
arm64                 randconfig-003-20250825    clang-22
arm64                 randconfig-004-20250825    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250824    gcc-10.5.0
csky                  randconfig-001-20250825    gcc-12.5.0
csky                  randconfig-002-20250824    gcc-15.1.0
csky                  randconfig-002-20250825    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250824    clang-22
hexagon               randconfig-001-20250825    clang-18
hexagon               randconfig-002-20250824    clang-22
hexagon               randconfig-002-20250825    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250824    gcc-12
i386        buildonly-randconfig-002-20250824    gcc-12
i386        buildonly-randconfig-003-20250824    gcc-12
i386        buildonly-randconfig-004-20250824    gcc-12
i386        buildonly-randconfig-005-20250824    gcc-12
i386        buildonly-randconfig-006-20250824    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250824    gcc-12.5.0
loongarch             randconfig-001-20250825    gcc-12.5.0
loongarch             randconfig-002-20250824    clang-22
loongarch             randconfig-002-20250825    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip27_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250824    gcc-8.5.0
nios2                 randconfig-001-20250825    gcc-8.5.0
nios2                 randconfig-002-20250824    gcc-9.5.0
nios2                 randconfig-002-20250825    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250824    gcc-9.5.0
parisc                randconfig-001-20250825    gcc-8.5.0
parisc                randconfig-002-20250824    gcc-14.3.0
parisc                randconfig-002-20250825    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                     ep8248e_defconfig    gcc-15.1.0
powerpc                     ksi8560_defconfig    gcc-15.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-15.1.0
powerpc                       ppc64_defconfig    clang-22
powerpc                      ppc6xx_defconfig    gcc-15.1.0
powerpc                     rainier_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250824    gcc-9.5.0
powerpc               randconfig-001-20250825    clang-22
powerpc               randconfig-002-20250824    clang-22
powerpc               randconfig-002-20250825    clang-22
powerpc               randconfig-003-20250824    gcc-12.5.0
powerpc               randconfig-003-20250825    clang-22
powerpc                     tqm8540_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250824    gcc-8.5.0
powerpc64             randconfig-001-20250825    gcc-13.4.0
powerpc64             randconfig-002-20250824    gcc-13.4.0
powerpc64             randconfig-002-20250825    gcc-15.1.0
powerpc64             randconfig-003-20250824    gcc-12.5.0
powerpc64             randconfig-003-20250825    clang-20
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250825    clang-18
riscv                 randconfig-002-20250825    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250825    gcc-12.5.0
s390                  randconfig-002-20250825    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250825    gcc-14.3.0
sh                    randconfig-002-20250825    gcc-13.4.0
sh                           se7619_defconfig    gcc-15.1.0
sh                           se7712_defconfig    gcc-15.1.0
sh                        sh7757lcr_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250825    gcc-15.1.0
sparc                 randconfig-002-20250825    gcc-14.3.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250825    clang-22
sparc64               randconfig-002-20250825    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250825    clang-22
um                    randconfig-002-20250825    clang-20
um                           x86_64_defconfig    clang-22
x86_64                           alldefconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250825    clang-20
x86_64      buildonly-randconfig-002-20250825    gcc-12
x86_64      buildonly-randconfig-003-20250825    gcc-12
x86_64      buildonly-randconfig-004-20250825    clang-20
x86_64      buildonly-randconfig-005-20250825    clang-20
x86_64      buildonly-randconfig-006-20250825    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250825    gcc-8.5.0
xtensa                randconfig-002-20250825    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

