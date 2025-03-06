Return-Path: <linux-erofs+bounces-13-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1925A54BBE
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Mar 2025 14:15:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z7qfM12wxz3bvW;
	Fri,  7 Mar 2025 00:15:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741266923;
	cv=none; b=EuzKhuRrtteeZgolNHnimCrgt1sOnvmnoApxfJAh8lqjTLI2t40kvN3hJPFSPbmnVn9BoDL1pJRUyhf/sR+lq1+MGAgyQ3P0Vaq5cQI/QjoVWF9r+IBnFWDqdE1zFTiuM1j5spz6xVTdmldWnCVkdY0gTUHug2lCwZMic2Zmy26jRLf3U/JskspqQXOqslYsICQHiL5a1L9MP0K29SFeuK1ohCcxepzNa/Pt9wwh33MwaiiqqWU1H60tuJP8Ko+gT6cULqMXKAQErHntOhL2J5ja3FGBrY/zvFYMAC276hz/jHXi51hlUWXQRHlacxUo/DcWaWVDj1Ny+7lMu3FU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741266923; c=relaxed/relaxed;
	bh=3HOP6zHoh91OI2sk7Mv+cFjxENP3wkocUDCiOdMirKo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hxhLQe5t8nC3oJCFH18uW0v+gRTqRGd8oV3OkuFIkbMJIKDn8Dt4OtMwb1hu80/wUl2CR0by6swKQY9s2bDrGppmAWclGBiLMiGvlRHCpe81Uq8wg5+KDNGCMk4gym/Y8LHTHuaSwmbc2gmbGndyhcCLaSIrkQx5muKBg28EU2zBQu0+C0HUrbcKHVCrep03vAE/7xfA/xu0+9oFTZty4INqxjcFfxdzcPCrBhO4/hCmY4ZrdYlYQSBRajZELaRloZjZr7vaNNnKkqGqMcZMS8Lf3tfchC7b1VYG+lHpOUG/jV3XouSLhUJWHhXW9r3lK2L4kPRm41ZoWVbkf5IYHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FDr2LWRK; dkim-atps=neutral; spf=pass (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FDr2LWRK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z7qfK07lCz3btp
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Mar 2025 00:15:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741266921; x=1772802921;
  h=date:from:to:cc:subject:message-id;
  bh=FSHRV+6riNIzURdB66xOPZ3Cj96XnVbERcCQVfS3SaU=;
  b=FDr2LWRKYJKN7PvvPdhN3EqVhNd8FvnvMGUph592lqkiuel/ZutQTKJ+
   8dg+wymBMUc3W4ZkjmsbFEUsFbZVLBR6MeiO8zfeOoCZVE8nonaWiKkgG
   1RJnjRDq4Au17l4Wa5/igw+FEcYDXc4NJ/BKZe3w1uZ/j9XSCvYHDbRZq
   YKoabZTLUBNpLGBBHsFchfRXhKtojrqhWq52eQCtPDUokPZe+DNmNDf/Y
   +8XgU6TPD8yjudWL52wrQO5SxWOZpL0QEWrgrW4vRjGhCl1d46Y6NrURA
   bpu/MpGM90bfy/XQrMV1BDBctavTitbSdvd6cyeJivdH9pRZ8Icy3bVd7
   A==;
X-CSE-ConnectionGUID: G2DoyXNTQImQkFOJpQ/zJA==
X-CSE-MsgGUID: jVo10GA7QkeygjzlLCgwOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="45078933"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="45078933"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 05:15:15 -0800
X-CSE-ConnectionGUID: pk3DnbmVQWOvgr8h2pz5GA==
X-CSE-MsgGUID: YJlZiJz1Szegax4JKS4w5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="123602038"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 06 Mar 2025 05:15:14 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqB4C-000N5u-0O;
	Thu, 06 Mar 2025 13:15:12 +0000
Date: Thu, 06 Mar 2025 21:14:33 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 e6e330b7b0cae104cd8932fec64582b8da195260
Message-ID: <202503062124.pJRJ4LSB-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: e6e330b7b0cae104cd8932fec64582b8da195260  erofs: move {in,out}pages into struct z_erofs_decompress_req

elapsed time: 1445m

configs tested: 129
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250305    gcc-13.2.0
arc                   randconfig-001-20250306    gcc-13.2.0
arc                   randconfig-002-20250305    gcc-13.2.0
arc                   randconfig-002-20250306    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250305    gcc-14.2.0
arm                   randconfig-001-20250306    gcc-14.2.0
arm                   randconfig-002-20250305    clang-19
arm                   randconfig-002-20250306    gcc-14.2.0
arm                   randconfig-003-20250305    gcc-14.2.0
arm                   randconfig-003-20250306    gcc-14.2.0
arm                   randconfig-004-20250305    gcc-14.2.0
arm                   randconfig-004-20250306    clang-18
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250305    clang-15
arm64                 randconfig-001-20250306    gcc-14.2.0
arm64                 randconfig-002-20250305    gcc-14.2.0
arm64                 randconfig-002-20250306    gcc-14.2.0
arm64                 randconfig-003-20250305    clang-21
arm64                 randconfig-003-20250306    gcc-14.2.0
arm64                 randconfig-004-20250305    gcc-14.2.0
arm64                 randconfig-004-20250306    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250306    gcc-14.2.0
csky                  randconfig-002-20250306    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250306    clang-21
hexagon               randconfig-002-20250306    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250305    clang-19
i386        buildonly-randconfig-001-20250306    clang-19
i386        buildonly-randconfig-002-20250305    clang-19
i386        buildonly-randconfig-002-20250306    clang-19
i386        buildonly-randconfig-003-20250305    clang-19
i386        buildonly-randconfig-003-20250306    clang-19
i386        buildonly-randconfig-004-20250305    clang-19
i386        buildonly-randconfig-004-20250306    gcc-12
i386        buildonly-randconfig-005-20250305    clang-19
i386        buildonly-randconfig-005-20250306    gcc-12
i386        buildonly-randconfig-006-20250305    gcc-12
i386        buildonly-randconfig-006-20250306    clang-19
i386                                defconfig    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250306    gcc-14.2.0
loongarch             randconfig-002-20250306    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250306    gcc-14.2.0
nios2                 randconfig-002-20250306    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250306    gcc-14.2.0
parisc                randconfig-002-20250306    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250306    clang-21
powerpc               randconfig-002-20250306    clang-18
powerpc               randconfig-003-20250306    gcc-14.2.0
powerpc64             randconfig-001-20250306    clang-18
powerpc64             randconfig-002-20250306    clang-21
powerpc64             randconfig-003-20250306    clang-18
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250305    clang-19
riscv                 randconfig-001-20250306    clang-18
riscv                 randconfig-002-20250305    gcc-14.2.0
riscv                 randconfig-002-20250306    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250305    gcc-14.2.0
s390                  randconfig-001-20250306    gcc-14.2.0
s390                  randconfig-002-20250305    gcc-14.2.0
s390                  randconfig-002-20250306    clang-19
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250305    gcc-14.2.0
sh                    randconfig-001-20250306    gcc-14.2.0
sh                    randconfig-002-20250305    gcc-14.2.0
sh                    randconfig-002-20250306    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250305    gcc-14.2.0
sparc                 randconfig-001-20250306    gcc-14.2.0
sparc                 randconfig-002-20250305    gcc-14.2.0
sparc                 randconfig-002-20250306    gcc-14.2.0
sparc64               randconfig-001-20250305    gcc-14.2.0
sparc64               randconfig-001-20250306    gcc-14.2.0
sparc64               randconfig-002-20250305    gcc-14.2.0
sparc64               randconfig-002-20250306    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250305    clang-19
um                    randconfig-001-20250306    gcc-12
um                    randconfig-002-20250305    gcc-12
um                    randconfig-002-20250306    clang-16
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250305    clang-19
x86_64      buildonly-randconfig-001-20250306    gcc-11
x86_64      buildonly-randconfig-002-20250305    gcc-12
x86_64      buildonly-randconfig-002-20250306    clang-19
x86_64      buildonly-randconfig-003-20250305    clang-19
x86_64      buildonly-randconfig-003-20250306    clang-19
x86_64      buildonly-randconfig-004-20250305    gcc-12
x86_64      buildonly-randconfig-004-20250306    clang-19
x86_64      buildonly-randconfig-005-20250305    clang-19
x86_64      buildonly-randconfig-005-20250306    clang-19
x86_64      buildonly-randconfig-006-20250305    clang-19
x86_64      buildonly-randconfig-006-20250306    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250305    gcc-14.2.0
xtensa                randconfig-001-20250306    gcc-14.2.0
xtensa                randconfig-002-20250305    gcc-14.2.0
xtensa                randconfig-002-20250306    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

