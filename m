Return-Path: <linux-erofs+bounces-585-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66BCB01271
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Jul 2025 06:56:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bdfZS3ThXz30Qk;
	Fri, 11 Jul 2025 14:56:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752209808;
	cv=none; b=AhCXZ57pEPT1l8O58vIbGeE0vQmnV0XjCbwccR/DrF/xvh4Ufn69uR7zXog7jW6BQaT3j6/8UUvs3n7bHS2l2tLUA3RyOYY7rBGUMYITdVkSyBTtqlvA89n/0PebXmRMuh4qRUrQqqf3gsGaWzReIAdyY4USxhIkjsi87Grrga7RicDUglA+5+Qz0gKAjy1GPL2+aotQXzqXK/ZMR15tN15uS3FP74dceOf5xulUseOZLFhwqgyD0ljWorS8zYnzn0zo/LPft0CnIjPcXKmzJGOcSixqpNbKRwXg5uY+obliWc/cDDIGZmrLhr8YuvnOZq2b30s7IoDHSacwcbNaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752209808; c=relaxed/relaxed;
	bh=sukcZHtW66FgFX6ns6945JZYtLDHhBFX3Khw6S0YzDE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=akqrySr5Q4UzPFDzDWBPYWlS3/Iq+9xqHPMoDoGlwiVE7gUEcOdXf8Zlw4lF+QG4kYF7KjIoYZ8bLloQMgonR0fSTgS0GM3Vy/iaXRYIuaIBLgX/ASbsuuga62FmZLPUe++60XJTm2yncGNI2Rcm9Z/lol09NEQlpdhWmDm/3WHpnVpGmKxLg2IyfNO7FjSYA0BPa7Jy7atxzefMQQiS5hBESrrqMz1Kr5g3JusOIpMcHKslG1jVVRkEyksvS6xD+4MkTCKCY9uh/YOTznryBRdRT56r9bK74ryE0fHnIbGXZjeJ5fqdxbxu9uv0NIEyUxMgnysEcpQdwz7cAiOHDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=faNYWpcA; dkim-atps=neutral; spf=pass (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=faNYWpcA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bdfZQ16WJz2yF0
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Jul 2025 14:56:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752209806; x=1783745806;
  h=date:from:to:cc:subject:message-id;
  bh=6YwN14TJsBksTnaQFVh2mURWhnfkJ1GTC/uWVteNVs8=;
  b=faNYWpcA074ZuEvcg7YwuzYekiaH2iZhB0uq1PMI7WfhOsgqum4jogFj
   0z/tadDGZ+KEAVg+emB4yDxNQDlomhGYyitl8iPFktNw7HgdUJd0HObuS
   pzwAV8MqBUSbk8Hy6bKJ4CEKjo8Sfru8jOFREMlnmiHmorUMZWQgH1+X9
   gA92DItvuTKML7Kwx9WYITKBqJ05X6NfJYs+H7mHwroOhrmaHAeVXw6M+
   zfhASC9ULisdwIDXaZ7/lNtq1KWKfxVt5eKqOEuRAtsycKNV6W4NcnOeW
   tWNcsMiWIqEUnIa+5UC87He9rY/+UrMZI6ocnjeNuqqG5w/BVLpX5AweC
   Q==;
X-CSE-ConnectionGUID: uMhUhXFmQjKdHH3HDkN+Iw==
X-CSE-MsgGUID: jpM+K4i2SjW0pVcSZklXOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65085819"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="65085819"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 21:56:41 -0700
X-CSE-ConnectionGUID: o6OblYLnQ4GdLq/p7mHLtw==
X-CSE-MsgGUID: xsxzG2k2TZSTW8vX9IHllg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="156366216"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 10 Jul 2025 21:56:40 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ua5oL-0005tJ-32;
	Fri, 11 Jul 2025 04:56:37 +0000
Date: Fri, 11 Jul 2025 12:56:17 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 934eed98ca20f2123257e47e06e19ad641fd2ebb
Message-ID: <202507111205.XqigTHsY-lkp@intel.com>
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
branch HEAD: 934eed98ca20f2123257e47e06e19ad641fd2ebb  erofs: do sanity check on m->type in z_erofs_load_compact_lcluster()

elapsed time: 1150m

configs tested: 120
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250710    gcc-15.1.0
arc                   randconfig-002-20250710    gcc-12.4.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250710    gcc-8.5.0
arm                   randconfig-002-20250710    clang-21
arm                   randconfig-003-20250710    clang-21
arm                   randconfig-004-20250710    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250710    clang-21
arm64                 randconfig-002-20250710    clang-21
arm64                 randconfig-003-20250710    gcc-8.5.0
arm64                 randconfig-004-20250710    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250710    gcc-15.1.0
csky                  randconfig-002-20250710    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250710    clang-21
hexagon               randconfig-002-20250710    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250710    gcc-12
i386        buildonly-randconfig-002-20250710    gcc-12
i386        buildonly-randconfig-003-20250710    clang-20
i386        buildonly-randconfig-004-20250710    gcc-11
i386        buildonly-randconfig-005-20250710    clang-20
i386        buildonly-randconfig-006-20250710    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250710    gcc-14.3.0
loongarch             randconfig-002-20250710    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250710    gcc-9.3.0
nios2                 randconfig-002-20250710    gcc-12.4.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250710    gcc-8.5.0
parisc                randconfig-002-20250710    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250710    gcc-12.4.0
powerpc               randconfig-002-20250710    gcc-9.3.0
powerpc               randconfig-003-20250710    gcc-8.5.0
powerpc64             randconfig-001-20250710    gcc-11.5.0
powerpc64             randconfig-002-20250710    clang-17
powerpc64             randconfig-003-20250710    gcc-14.3.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250710    gcc-15.1.0
riscv                 randconfig-002-20250710    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250710    gcc-14.3.0
s390                  randconfig-002-20250710    clang-17
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250710    gcc-15.1.0
sh                    randconfig-002-20250710    gcc-13.4.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250710    gcc-13.4.0
sparc                 randconfig-002-20250710    gcc-14.3.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250710    gcc-8.5.0
sparc64               randconfig-002-20250710    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250710    gcc-11
um                    randconfig-002-20250710    clang-16
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250710    gcc-12
x86_64      buildonly-randconfig-002-20250710    gcc-12
x86_64      buildonly-randconfig-003-20250710    gcc-12
x86_64      buildonly-randconfig-004-20250710    clang-20
x86_64      buildonly-randconfig-005-20250710    clang-20
x86_64      buildonly-randconfig-006-20250710    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250710    gcc-12.4.0
xtensa                randconfig-002-20250710    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

