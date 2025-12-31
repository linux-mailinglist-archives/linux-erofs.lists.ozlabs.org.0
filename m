Return-Path: <linux-erofs+bounces-1672-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C86C8CEC9B1
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Dec 2025 22:47:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dhNpl1H2hz2x9W;
	Thu, 01 Jan 2026 08:47:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767217647;
	cv=none; b=WWy1bKsUPkP+Qr3TwfBdGMhF8twxa0spz2bsLW4po4N2OgoGkSwZDPEKYi8J3GFWo/GzDuqvwzTus6Wal9S2r5nu1Y+Nl8KrscONQYaoVyCsOUcVQBjFczvfVNY2IUBfJZsxBE0i9sel9sSZ/BrdM9YsU+4/JHe2tshgB9JDcaUq6Hc5PJteOS+JUbijdPCMD4nGhyypPhaFKN5sK0sIs1PVSud7h4w1CIEa3dkxszgN9ipOb+O2CJBDvESB/qJMQI/sjjVZC5K0gcuq69m3P6Ca7Cdxj5sDVAymwXwYLPyjPD66yM1vX6LA73J9cK57dKHvy6u5NE3B7DL5NOubaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767217647; c=relaxed/relaxed;
	bh=T5r3FLe3TULzjaN7v+n9mMb+MKyGn5RRoRBnjsASRPk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MU93JZSLvzGyvwWG3ppxUi2fQkC5umNRt1fcDFJiJC2p6B5BEWJMdk+15uFzzFOd2aBO63ACWI2GfReogT7vWbmXjlsgdWd8Uq8Qi+6KILasX1PdQbMd7yPEuwu1HIrxBcb63o4/Gt44hu75l2w8dM08ulM/cWzUTsFDwyzfugAPwDsAn5lsQu6PdX0eEfUc3PvokzzVHpwO70q1n95Tdkb1EIcI9G+OKNpLifJlBrYdQe2mh7xKLJjuDMCMKw23gYiLCIIQ2jwO4z+PF/pSi0PD/kfGj7Rzq2IUiZkiiTybOpL1J7fCOKmRxCrL/gI2CmsxUFDNnxQNTqlrYKi7mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RF+QIlDs; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RF+QIlDs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dhNph4Gdrz2x9M
	for <linux-erofs@lists.ozlabs.org>; Thu, 01 Jan 2026 08:47:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767217645; x=1798753645;
  h=date:from:to:cc:subject:message-id;
  bh=VftzsFgHryT9q60UFWVXC2HQX2aByTYcokpYfx4v3vM=;
  b=RF+QIlDsmHyHBs4gDHcolboBla4Mu/N28SZGG6fpsqSuQbaqfoW5fTW6
   X95stIAJX0udCvjgnzlcNYaVQpbKF8oBFSJsMOzDMRBI+WCZgMCdL+JxS
   VnYbjHobP46JZMPDwsJRVZut8EXvLRYOQ44xRuwN1/27JE5KUxnnjJcDT
   btewzzOa4e41XdpcBrvVvP2OPS7CCmZkocsMl8ka4F0jsI5egvmhjIa9W
   KFJrN92Z/anE8urj7FEKi5BY1QBnxrglH8aHx0qcYjhj5zjzSeudZk8eS
   ZEV76fvEx9qxotnuNtr94rtRMQ1uzyFX9sVYkP17Ap3pnaXXyUk8Ix9dQ
   A==;
X-CSE-ConnectionGUID: DpMW+smIQRqfocrIimxpIQ==
X-CSE-MsgGUID: 9+WeyUA+T3CgZnnnOTfb6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="79502113"
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="79502113"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 13:47:19 -0800
X-CSE-ConnectionGUID: j3oLQOxXQLe0XrbbbjNtkw==
X-CSE-MsgGUID: /vRt8mSeR2i+ca1rMPFsYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="205662378"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 31 Dec 2025 13:47:18 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vb42F-000000001VR-1NqC;
	Wed, 31 Dec 2025 21:47:15 +0000
Date: Thu, 01 Jan 2026 05:46:55 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 ab4b58a1bcba0d39ae20208a41e062d5ffee1614
Message-ID: <202601010550.NHoGYKq0-lkp@intel.com>
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
branch HEAD: ab4b58a1bcba0d39ae20208a41e062d5ffee1614  erofs: remove useless src in erofs_xattr_copy_to_buffer()

elapsed time: 730m

configs tested: 167
configs skipped: 2

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
arc                   randconfig-001-20251231    gcc-11.5.0
arc                   randconfig-002-20251231    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                         lpc32xx_defconfig    clang-17
arm                   randconfig-001-20251231    gcc-12.5.0
arm                   randconfig-002-20251231    clang-22
arm                   randconfig-003-20251231    gcc-8.5.0
arm                   randconfig-004-20251231    clang-19
arm                    vt8500_v6_v7_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251231    clang-22
arm64                 randconfig-002-20251231    clang-19
arm64                 randconfig-003-20251231    gcc-8.5.0
arm64                 randconfig-004-20251231    gcc-13.4.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251231    gcc-14.3.0
csky                  randconfig-002-20251231    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251231    clang-22
hexagon               randconfig-002-20251231    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251231    clang-20
i386        buildonly-randconfig-002-20251231    gcc-14
i386        buildonly-randconfig-003-20251231    gcc-14
i386        buildonly-randconfig-004-20251231    gcc-14
i386        buildonly-randconfig-005-20251231    gcc-14
i386        buildonly-randconfig-006-20251231    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251231    gcc-14
i386                  randconfig-002-20251231    gcc-12
i386                  randconfig-003-20251231    gcc-14
i386                  randconfig-004-20251231    clang-20
i386                  randconfig-005-20251231    gcc-14
i386                  randconfig-006-20251231    gcc-14
i386                  randconfig-007-20251231    gcc-14
i386                  randconfig-011-20251231    gcc-14
i386                  randconfig-012-20251231    clang-20
i386                  randconfig-013-20251231    gcc-13
i386                  randconfig-014-20251231    gcc-14
i386                  randconfig-015-20251231    gcc-13
i386                  randconfig-016-20251231    clang-20
i386                  randconfig-017-20251231    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251231    gcc-12.5.0
loongarch             randconfig-002-20251231    gcc-15.1.0
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
mips                      fuloong2e_defconfig    gcc-15.1.0
mips                           ip22_defconfig    gcc-15.1.0
mips                  maltasmvp_eva_defconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251231    gcc-8.5.0
nios2                 randconfig-002-20251231    gcc-10.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251231    gcc-8.5.0
parisc                randconfig-002-20251231    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                   microwatt_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251231    gcc-8.5.0
powerpc               randconfig-002-20251231    clang-22
powerpc64             randconfig-001-20251231    clang-16
powerpc64             randconfig-002-20251231    gcc-14.3.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv             nommu_k210_sdcard_defconfig    gcc-15.1.0
riscv                 randconfig-001-20251231    gcc-14.3.0
riscv                 randconfig-002-20251231    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251231    gcc-8.5.0
s390                  randconfig-002-20251231    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251231    gcc-15.1.0
sh                    randconfig-002-20251231    gcc-15.1.0
sh                           se7750_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251231    gcc-11.5.0
sparc                 randconfig-002-20251231    gcc-13.4.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251231    clang-22
sparc64               randconfig-002-20251231    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251231    clang-22
um                    randconfig-002-20251231    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251231    gcc-14
x86_64      buildonly-randconfig-002-20251231    gcc-14
x86_64      buildonly-randconfig-003-20251231    gcc-14
x86_64      buildonly-randconfig-004-20251231    clang-20
x86_64      buildonly-randconfig-005-20251231    gcc-14
x86_64      buildonly-randconfig-006-20251231    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251231    gcc-13
x86_64                randconfig-002-20251231    clang-20
x86_64                randconfig-003-20251231    clang-20
x86_64                randconfig-004-20251231    clang-20
x86_64                randconfig-005-20251231    clang-20
x86_64                randconfig-006-20251231    clang-20
x86_64                randconfig-011-20251231    clang-20
x86_64                randconfig-012-20251231    gcc-14
x86_64                randconfig-013-20251231    gcc-14
x86_64                randconfig-014-20251231    gcc-12
x86_64                randconfig-015-20251231    gcc-14
x86_64                randconfig-016-20251231    gcc-14
x86_64                randconfig-071-20251231    clang-20
x86_64                randconfig-072-20251231    clang-20
x86_64                randconfig-073-20251231    gcc-12
x86_64                randconfig-074-20251231    gcc-14
x86_64                randconfig-075-20251231    clang-20
x86_64                randconfig-076-20251231    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20251231    gcc-8.5.0
xtensa                randconfig-002-20251231    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

