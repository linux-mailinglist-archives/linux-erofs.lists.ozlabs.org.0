Return-Path: <linux-erofs+bounces-1042-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 917D3B811F2
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Sep 2025 19:07:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRlYd32Tjz2yhD;
	Thu, 18 Sep 2025 03:07:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758128821;
	cv=none; b=FaYTd6keR9wCJXTM+PEIVerj6T+VVU7So3/+S6c83MMfGB9xVUwFy2njflTEJAqVxkUh+vLw+ii4A/ghsey3quw9bfv8EFph4MVLPw3LmDkQnYiexdcPUpBy3CvQAvPL9rfU+h8DCtiM6S66JoTPbz6ER9rQTFHtR747x9iureS+AIrnZ//NQM1VTriUKQg/gdu242fWj8PUg6OZrd0Wr1n/HfD7GiR6k/PXlbu0gr1MUwbmeIDjtzGpBCnZSda9ub7CmnR31kfjycYTrS0sLmRrgcv92KRsbJvZ4BtpaHfXBosuQt01l7mU9Z1VFELnj8StXIQG6diNVLZiwQ9ZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758128821; c=relaxed/relaxed;
	bh=DVRoi//cn2QZJHFuDUWrnJ2qthxJxEI4gY536Zg5wDA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dKXwjWRrkOueTfedxa21m+NAy5+jIYPXtCgNiOsHvGH0jzKeHwBoCnPEQHqtfXnZqHIUbiEj5YDkjIsJhkf8E7ymkw+f5Qek3L/IQjjCalkwf6VLRuNjtP/GzjoWX61adQ65MWg/hEcpKaL4bdYHFqfgsKP7dEnL8nVsjvIAg6ftqDwRSLD3ps6h1u487btFkDoZ3h6CNkPl6ADD9NhWVcTPfPV+FjtSwMlkMXFqAL2QwP5WePaejm8CW+lIGUNgDhLlCQgokFotkzdkVCHFm/Q/WnBswf3uRXsdVUK6rpACuLULigxXx/wQi5WjJQ9jirsWvP8ThkjB5oblNqytpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MjkGHK9n; dkim-atps=neutral; spf=pass (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MjkGHK9n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRlYb08Jwz2yPd
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Sep 2025 03:06:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758128819; x=1789664819;
  h=date:from:to:cc:subject:message-id;
  bh=QTV1FCnfORdMBmZOR9A2B6EFYMKt0MQF7fLgiOmINF4=;
  b=MjkGHK9nP9FHYZQWzABU9VQVxat3pHSrwf60bqR+tiDIEbmJezGeYA+Q
   jgNIF/fqYbXoXo/fuF2yxeJ9r+PB17SUIzQdrfYdc0UAIcgVlLzSnzXdQ
   BtTHxFw/V9Wq8rSG4bu+NfiwMY3czNlaluaLgEkLsjVVQTbVb2tX2DT4x
   CAg+yFV6w3UrJUAyMBSfiZG19gfiLkujicCgWcge601qT04BtMDqYZ5OA
   j4fuGqyl0szIU0AdKoT9Se9WPYot5ndr1FHFSr+xvT4y3sV0RcIv++LKq
   4Axrz/UnRFH5bOfSyfDytS+u1C+zKLZikANhe7f/n8+FgULoZQLpBHp+n
   Q==;
X-CSE-ConnectionGUID: xuJVzqIeQGK+V0SaBNni5w==
X-CSE-MsgGUID: DGADCvghSemdoaoNGU9aKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60373593"
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="60373593"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 10:06:53 -0700
X-CSE-ConnectionGUID: o+IQ5dzdQISKDkP9ur4u4Q==
X-CSE-MsgGUID: OlYNrWZ1RcKbn+qhraxriw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="174867953"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 17 Sep 2025 10:06:52 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyvcH-0002FS-0i;
	Wed, 17 Sep 2025 17:06:49 +0000
Date: Thu, 18 Sep 2025 01:06:20 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 7d5edf02769702ea33851030a156e98315a460e8
Message-ID: <202509180113.MftRFzeP-lkp@intel.com>
User-Agent: s-nail v14.9.24
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
branch HEAD: 7d5edf02769702ea33851030a156e98315a460e8  erofs: avoid reading more for fragment maps

elapsed time: 1450m

configs tested: 246
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                 nsimosci_hs_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20250917    clang-22
arc                   randconfig-001-20250917    gcc-8.5.0
arc                   randconfig-002-20250917    clang-22
arc                   randconfig-002-20250917    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                             mxs_defconfig    clang-22
arm                        neponset_defconfig    gcc-15.1.0
arm                   randconfig-001-20250917    clang-22
arm                   randconfig-002-20250917    clang-22
arm                   randconfig-002-20250917    gcc-12.5.0
arm                   randconfig-003-20250917    clang-22
arm                   randconfig-003-20250917    gcc-10.5.0
arm                   randconfig-004-20250917    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250917    clang-22
arm64                 randconfig-002-20250917    clang-19
arm64                 randconfig-002-20250917    clang-22
arm64                 randconfig-003-20250917    clang-22
arm64                 randconfig-003-20250917    gcc-10.5.0
arm64                 randconfig-004-20250917    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250917    clang-22
csky                  randconfig-001-20250917    gcc-12.5.0
csky                  randconfig-002-20250917    clang-22
csky                  randconfig-002-20250917    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250917    clang-22
hexagon               randconfig-002-20250917    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250917    gcc-14
i386        buildonly-randconfig-002-20250917    clang-20
i386        buildonly-randconfig-002-20250917    gcc-14
i386        buildonly-randconfig-003-20250917    gcc-14
i386        buildonly-randconfig-004-20250917    gcc-14
i386        buildonly-randconfig-005-20250917    gcc-14
i386        buildonly-randconfig-006-20250917    clang-20
i386        buildonly-randconfig-006-20250917    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20250917    gcc-14
i386                  randconfig-002-20250917    gcc-14
i386                  randconfig-003-20250917    gcc-14
i386                  randconfig-004-20250917    gcc-14
i386                  randconfig-005-20250917    gcc-14
i386                  randconfig-006-20250917    gcc-14
i386                  randconfig-007-20250917    gcc-14
i386                  randconfig-011-20250917    gcc-14
i386                  randconfig-012-20250917    gcc-14
i386                  randconfig-013-20250917    gcc-14
i386                  randconfig-014-20250917    gcc-14
i386                  randconfig-015-20250917    gcc-14
i386                  randconfig-016-20250917    gcc-14
i386                  randconfig-017-20250917    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250917    clang-22
loongarch             randconfig-001-20250917    gcc-15.1.0
loongarch             randconfig-002-20250917    clang-22
loongarch             randconfig-002-20250917    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                       m5475evb_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250917    clang-22
nios2                 randconfig-001-20250917    gcc-11.5.0
nios2                 randconfig-002-20250917    clang-22
nios2                 randconfig-002-20250917    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250917    clang-22
parisc                randconfig-001-20250917    gcc-14.3.0
parisc                randconfig-002-20250917    clang-22
parisc                randconfig-002-20250917    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc                  iss476-smp_defconfig    gcc-15.1.0
powerpc                      pasemi_defconfig    gcc-15.1.0
powerpc                      ppc6xx_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250917    clang-18
powerpc               randconfig-001-20250917    clang-22
powerpc               randconfig-002-20250917    clang-22
powerpc               randconfig-003-20250917    clang-22
powerpc               randconfig-003-20250917    gcc-9.5.0
powerpc                     tqm8541_defconfig    clang-22
powerpc64             randconfig-001-20250917    clang-19
powerpc64             randconfig-001-20250917    clang-22
powerpc64             randconfig-002-20250917    clang-22
powerpc64             randconfig-002-20250917    gcc-8.5.0
powerpc64             randconfig-003-20250917    gcc-10.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250917    gcc-14.3.0
riscv                 randconfig-001-20250917    gcc-15.1.0
riscv                 randconfig-002-20250917    clang-22
riscv                 randconfig-002-20250917    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-14
s390                  randconfig-001-20250917    clang-22
s390                  randconfig-001-20250917    gcc-15.1.0
s390                  randconfig-002-20250917    gcc-15.1.0
s390                  randconfig-002-20250917    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         ap325rxa_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                        edosk7760_defconfig    gcc-15.1.0
sh                          kfr2r09_defconfig    gcc-15.1.0
sh                    randconfig-001-20250917    gcc-14.3.0
sh                    randconfig-001-20250917    gcc-15.1.0
sh                    randconfig-002-20250917    gcc-15.1.0
sh                           se7721_defconfig    gcc-15.1.0
sh                        sh7763rdp_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250917    gcc-15.1.0
sparc                 randconfig-001-20250917    gcc-8.5.0
sparc                 randconfig-002-20250917    gcc-14.3.0
sparc                 randconfig-002-20250917    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250917    gcc-11.5.0
sparc64               randconfig-001-20250917    gcc-15.1.0
sparc64               randconfig-002-20250917    gcc-15.1.0
sparc64               randconfig-002-20250917    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250917    gcc-14
um                    randconfig-001-20250917    gcc-15.1.0
um                    randconfig-002-20250917    gcc-14
um                    randconfig-002-20250917    gcc-15.1.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250917    clang-20
x86_64      buildonly-randconfig-001-20250917    gcc-14
x86_64      buildonly-randconfig-002-20250917    clang-20
x86_64      buildonly-randconfig-003-20250917    clang-20
x86_64      buildonly-randconfig-004-20250917    clang-20
x86_64      buildonly-randconfig-005-20250917    clang-20
x86_64      buildonly-randconfig-006-20250917    clang-20
x86_64      buildonly-randconfig-006-20250917    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250917    clang-20
x86_64                randconfig-002-20250917    clang-20
x86_64                randconfig-003-20250917    clang-20
x86_64                randconfig-004-20250917    clang-20
x86_64                randconfig-005-20250917    clang-20
x86_64                randconfig-006-20250917    clang-20
x86_64                randconfig-007-20250917    clang-20
x86_64                randconfig-008-20250917    clang-20
x86_64                randconfig-071-20250917    clang-20
x86_64                randconfig-072-20250917    clang-20
x86_64                randconfig-073-20250917    clang-20
x86_64                randconfig-074-20250917    clang-20
x86_64                randconfig-075-20250917    clang-20
x86_64                randconfig-076-20250917    clang-20
x86_64                randconfig-077-20250917    clang-20
x86_64                randconfig-078-20250917    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250917    gcc-15.1.0
xtensa                randconfig-001-20250917    gcc-8.5.0
xtensa                randconfig-002-20250917    gcc-11.5.0
xtensa                randconfig-002-20250917    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

