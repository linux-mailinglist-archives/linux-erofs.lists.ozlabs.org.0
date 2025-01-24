Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7389AA1AF76
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Jan 2025 05:41:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YfQBn6Jpjz30Ss
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Jan 2025 15:41:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737693712;
	cv=none; b=cPeXIA9y03i9cCve1n8bZdVuBp7GBc3ySD42IEpgArfsnCNItOH4jmG7oVceHzQcFLtSgkoH/SSe2g3zhOi4IXFTF+GW6798yyQ3y9htAVjOzrlA4F7v/V15g37CclyUzY+d6GUJbhYD0KOzMKe8WA4KLbCnEYMrL+MEPrAunbEDdlxZ+LwtayfZ/baCKe9WGcPIzb+DR1X0Top6CMWKaFRKtoVhXumVSgAOReS0pTTS7OtOeCjibYpA46ukul558xMKzZJTD2V11+uvPcu8SZXlLXXsg8AgLh5BILu1o9tyCQkJTrDC4aHGySKgNbuzWlySgzDwsYEEiMs8CDX05w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737693712; c=relaxed/relaxed;
	bh=cHblbdgoQBtMRVdemn5ZqaKGCs3pP2mq6laGwlvXvQ8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GTbOfyd0oqDWArr683guAyKS1/JJVr00qfnoxNaH2F0xNzKfEz1tFsAJvyeTqnxMi1UxW8YhR/JiIJUQjg2A6GNn4jEQVHQvYnrCkEqGbmw9W0l628J7H6DBSciRrfwpIJ8Hlt57dB3GNb/RXKQw8eDEZkN1YmtHt6b8FgJA9TQ6dTUwdnb3gA2b/7zAWXF9iuP7nbzmSPQhZEk+bWhvM07eKn+ZQnlnon4e72S+i2KmTI69A1TUbpPlbe2JMz7Fz8x3K/NXU1NAb92R47BnC86WXw1RXTISU7bbtyaSeaFpZfJvILsxvhcbqx0AQOGpcpeCnfll0yuvC5UH6TEndg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fa39STH2; dkim-atps=neutral; spf=pass (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fa39STH2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YfQBj71gyz2yfj
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Jan 2025 15:41:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737693711; x=1769229711;
  h=date:from:to:cc:subject:message-id;
  bh=r833Ldrs1L+ccNkpwdUf7NiNVnmGJDwgZhGjeb+AGdc=;
  b=Fa39STH2D9lfH6yy/5rm5pawiC/obygqq29zWu+Llzgo+AAGjx/t7apk
   Ot95IG3LW3iRwX3GgGVsz3IJPSSmEvtzK0kj4aswnHoXdKpml7aEi3NbU
   po35CGrYq4opv/fi85dl69TbcK9VO6Ili5nFcXNA2I3VtIZ5jDlfUAaJB
   rsK6GB6xQSYQPIHCuQnuyvsmyvZ1lO+yPtJRAzNZGTbn4sqdJNcHrQbzX
   qIFBYQIEs8qb6LH7ERbLQyEtrZfdjzwSjctDmTFYQ5TlbKRbeZcn2wyoe
   ze4fyRqdr4DWyvFgPWrEUJE8RJ28BRKJcW6+o9fiP+ceaQPJcAvb9VrvF
   A==;
X-CSE-ConnectionGUID: hOxGe941TSmEm1NZpJiVlA==
X-CSE-MsgGUID: ytmyeO51RUyIwDuQ7Ar6pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="41886347"
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; 
   d="scan'208";a="41886347"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 20:41:46 -0800
X-CSE-ConnectionGUID: MFarP8bkTLKb7xwCCgALow==
X-CSE-MsgGUID: 1PT/erX2TUO6Vpj7dfnRPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112805411"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 23 Jan 2025 20:41:44 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tbBVl-000cAC-2s;
	Fri, 24 Jan 2025 04:41:41 +0000
Date: Fri, 24 Jan 2025 12:40:48 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 8f9530aeeb4f756bdfa70510b40e5d28ea3c742e
Message-ID: <202501241241.Qa8q3OSL-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 8f9530aeeb4f756bdfa70510b40e5d28ea3c742e  erofs: refine z_erofs_get_extent_compressedlen()

elapsed time: 1088m

configs tested: 235
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250123    gcc-13.2.0
arc                   randconfig-001-20250124    clang-20
arc                   randconfig-001-20250124    gcc-13.2.0
arc                   randconfig-002-20250123    gcc-13.2.0
arc                   randconfig-002-20250124    clang-20
arc                   randconfig-002-20250124    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g4_defconfig    gcc-14.2.0
arm                          ep93xx_defconfig    clang-20
arm                      integrator_defconfig    clang-15
arm                   milbeaut_m10v_defconfig    clang-20
arm                   randconfig-001-20250123    clang-20
arm                   randconfig-001-20250124    clang-17
arm                   randconfig-001-20250124    clang-20
arm                   randconfig-002-20250123    gcc-14.2.0
arm                   randconfig-002-20250124    clang-20
arm                   randconfig-002-20250124    gcc-14.2.0
arm                   randconfig-003-20250123    gcc-14.2.0
arm                   randconfig-003-20250124    clang-20
arm                   randconfig-003-20250124    gcc-14.2.0
arm                   randconfig-004-20250123    gcc-14.2.0
arm                   randconfig-004-20250124    clang-19
arm                   randconfig-004-20250124    clang-20
arm                             rpc_defconfig    clang-17
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250123    gcc-14.2.0
arm64                 randconfig-001-20250124    clang-20
arm64                 randconfig-002-20250123    clang-20
arm64                 randconfig-002-20250124    clang-20
arm64                 randconfig-003-20250123    clang-20
arm64                 randconfig-003-20250124    clang-19
arm64                 randconfig-003-20250124    clang-20
arm64                 randconfig-004-20250123    clang-16
arm64                 randconfig-004-20250124    clang-20
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250123    gcc-14.2.0
csky                  randconfig-001-20250124    gcc-14.2.0
csky                  randconfig-002-20250123    gcc-14.2.0
csky                  randconfig-002-20250124    gcc-14.2.0
hexagon                          alldefconfig    clang-15
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20250123    clang-20
hexagon               randconfig-001-20250124    clang-20
hexagon               randconfig-002-20250123    clang-20
hexagon               randconfig-002-20250124    clang-14
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250123    gcc-12
i386        buildonly-randconfig-001-20250124    clang-19
i386        buildonly-randconfig-002-20250123    clang-19
i386        buildonly-randconfig-002-20250124    clang-19
i386        buildonly-randconfig-003-20250123    gcc-12
i386        buildonly-randconfig-003-20250124    clang-19
i386        buildonly-randconfig-003-20250124    gcc-12
i386        buildonly-randconfig-004-20250123    clang-19
i386        buildonly-randconfig-004-20250124    clang-19
i386        buildonly-randconfig-004-20250124    gcc-12
i386        buildonly-randconfig-005-20250123    gcc-12
i386        buildonly-randconfig-005-20250124    clang-19
i386        buildonly-randconfig-005-20250124    gcc-12
i386        buildonly-randconfig-006-20250123    clang-19
i386        buildonly-randconfig-006-20250124    clang-19
i386        buildonly-randconfig-006-20250124    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250124    clang-19
i386                  randconfig-002-20250124    clang-19
i386                  randconfig-003-20250124    clang-19
i386                  randconfig-004-20250124    clang-19
i386                  randconfig-005-20250124    clang-19
i386                  randconfig-006-20250124    clang-19
i386                  randconfig-007-20250124    clang-19
i386                  randconfig-011-20250124    gcc-12
i386                  randconfig-012-20250124    gcc-12
i386                  randconfig-013-20250124    gcc-12
i386                  randconfig-014-20250124    gcc-12
i386                  randconfig-015-20250124    gcc-12
i386                  randconfig-016-20250124    gcc-12
i386                  randconfig-017-20250124    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250123    gcc-14.2.0
loongarch             randconfig-001-20250124    gcc-14.2.0
loongarch             randconfig-002-20250123    gcc-14.2.0
loongarch             randconfig-002-20250124    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                           virt_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250123    gcc-14.2.0
nios2                 randconfig-001-20250124    gcc-14.2.0
nios2                 randconfig-002-20250123    gcc-14.2.0
nios2                 randconfig-002-20250124    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           alldefconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250123    gcc-14.2.0
parisc                randconfig-001-20250124    gcc-14.2.0
parisc                randconfig-002-20250123    gcc-14.2.0
parisc                randconfig-002-20250124    gcc-14.2.0
powerpc                    adder875_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                       ebony_defconfig    clang-18
powerpc                        fsp2_defconfig    gcc-14.2.0
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                   motionpro_defconfig    gcc-14.2.0
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250123    gcc-14.2.0
powerpc               randconfig-001-20250124    gcc-14.2.0
powerpc               randconfig-002-20250123    clang-18
powerpc               randconfig-002-20250124    gcc-14.2.0
powerpc               randconfig-003-20250123    gcc-14.2.0
powerpc               randconfig-003-20250124    clang-20
powerpc                        warp_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250123    gcc-14.2.0
powerpc64             randconfig-001-20250124    gcc-14.2.0
powerpc64             randconfig-002-20250123    clang-16
powerpc64             randconfig-002-20250124    clang-20
powerpc64             randconfig-003-20250124    clang-19
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20250123    gcc-14.2.0
riscv                 randconfig-001-20250124    clang-19
riscv                 randconfig-001-20250124    gcc-14.2.0
riscv                 randconfig-002-20250123    clang-20
riscv                 randconfig-002-20250124    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250123    gcc-14.2.0
s390                  randconfig-001-20250124    gcc-14.2.0
s390                  randconfig-002-20250123    clang-15
s390                  randconfig-002-20250124    clang-20
s390                  randconfig-002-20250124    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                          r7785rp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250123    gcc-14.2.0
sh                    randconfig-001-20250124    gcc-14.2.0
sh                    randconfig-002-20250123    gcc-14.2.0
sh                    randconfig-002-20250124    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250123    gcc-14.2.0
sparc                 randconfig-001-20250124    gcc-14.2.0
sparc                 randconfig-002-20250123    gcc-14.2.0
sparc                 randconfig-002-20250124    gcc-14.2.0
sparc64                          alldefconfig    gcc-14.2.0
sparc64               randconfig-001-20250123    gcc-14.2.0
sparc64               randconfig-001-20250124    gcc-14.2.0
sparc64               randconfig-002-20250123    gcc-14.2.0
sparc64               randconfig-002-20250124    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                    randconfig-001-20250123    gcc-12
um                    randconfig-001-20250124    gcc-12
um                    randconfig-001-20250124    gcc-14.2.0
um                    randconfig-002-20250123    gcc-11
um                    randconfig-002-20250124    clang-20
um                    randconfig-002-20250124    gcc-14.2.0
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250123    clang-19
x86_64      buildonly-randconfig-001-20250124    gcc-12
x86_64      buildonly-randconfig-002-20250123    clang-19
x86_64      buildonly-randconfig-002-20250124    gcc-12
x86_64      buildonly-randconfig-003-20250123    gcc-12
x86_64      buildonly-randconfig-003-20250124    clang-19
x86_64      buildonly-randconfig-004-20250123    gcc-12
x86_64      buildonly-randconfig-004-20250124    clang-19
x86_64      buildonly-randconfig-005-20250123    clang-19
x86_64      buildonly-randconfig-005-20250124    clang-19
x86_64      buildonly-randconfig-006-20250123    clang-19
x86_64      buildonly-randconfig-006-20250124    clang-19
x86_64                              defconfig    gcc-11
x86_64                randconfig-001-20250124    clang-19
x86_64                randconfig-002-20250124    clang-19
x86_64                randconfig-003-20250124    clang-19
x86_64                randconfig-004-20250124    clang-19
x86_64                randconfig-005-20250124    clang-19
x86_64                randconfig-006-20250124    clang-19
x86_64                randconfig-007-20250124    clang-19
x86_64                randconfig-008-20250124    clang-19
x86_64                randconfig-071-20250124    gcc-12
x86_64                randconfig-072-20250124    gcc-12
x86_64                randconfig-073-20250124    gcc-12
x86_64                randconfig-074-20250124    gcc-12
x86_64                randconfig-075-20250124    gcc-12
x86_64                randconfig-076-20250124    gcc-12
x86_64                randconfig-077-20250124    gcc-12
x86_64                randconfig-078-20250124    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250123    gcc-14.2.0
xtensa                randconfig-001-20250124    gcc-14.2.0
xtensa                randconfig-002-20250123    gcc-14.2.0
xtensa                randconfig-002-20250124    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
