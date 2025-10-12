Return-Path: <linux-erofs+bounces-1175-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 440C1BCFE04
	for <lists+linux-erofs@lfdr.de>; Sun, 12 Oct 2025 02:17:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ckgyg1S2lz300F;
	Sun, 12 Oct 2025 11:16:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760228219;
	cv=none; b=PGae77GOVoP597rbGeJy4sTt3cAtC9OXy1JhV6cWjnwVSley8JK1Nti1O5Q9QT+vUvbe++/Vy/DAP4HZ1Jltc5fVZGewCUtduy1sSBH8VNdXjbUQPEnXmIvQwVok3g/xhM0AbGtVzOIzWSGx6N3NVLsO9VwFkYDTt4+HfVluL1GGTtjkXuSeuLPkZHeBFawxWuop6QTQHq5zODGNqBoroSq9xYJXc66rnqSpmennM7ppauZ9pPQsK089vn/pytm13VOAYqMTJHxQcDIRcyE8hD7DwzhemWRsfxjIeH06CCVjzeZmukgPFNRzk5LM/GzTAmcyep7HnN0wGfQBw2y1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760228219; c=relaxed/relaxed;
	bh=kjiU1T0xm9Zvyr19ak5QG4tV9Y2/BBwkjJXcFkZSaIk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=d9p6N0KEeQCJiFztiHBbLeMvtppCfZVyV3q3sG7yhVLgo8Jpe9RDbWoD8iGHjh3ft7I776R08rD4Z3T6KEdgb8/BZ2TxeZhHLZXsxbi8B/rejyillBdHqNr8I1Mh8jwudI44u0EpWL6Zrm2mCf2obpFexGs3yuxH9dUkKd6EMRdNGxNDAOK8Xv4pKbTlt0trNG56/dFAC0Lz+o6KiHC0359Ho/rSX9a4lpP8vAW35tD4iDtl8EtGK7k/JFGUv3KMCuzAtelEAQ0t+sUV+YN1SPR4NXLU9badR647Jj7uVNKW1SFqFUqjDtntGxc25yo1Y2v3xuCZsd6NZ80zpqMGHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I2VS+Usu; dkim-atps=neutral; spf=pass (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I2VS+Usu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ckgyb6MGQz2yvv
	for <linux-erofs@lists.ozlabs.org>; Sun, 12 Oct 2025 11:16:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760228217; x=1791764217;
  h=date:from:to:cc:subject:message-id;
  bh=ViSpbNFbWayCphPkz2/DL4RX8FordKhb3HWrow3tOLk=;
  b=I2VS+Usubrqp3La0RoMZUOn0vouz25HkuGRDqbPJ8NZoKPBw0IdtOGQS
   lN83265fqWFAKfN3/t09855QAE92tY+Fm9iYfyBEgpwaAbfnGQ1j4gTks
   NdR8jIsH0HSHGCzwMFb7p0EQC4PTbr9m5OSEEoAHEp7vQpNQajTsyAC6l
   yTwLbgASw1Q4f6aR4Y3wVi0QiIBllrKCn5MQ7CEnOX8dqS6f+/jtKozEv
   iXzqQEXrd+Vov+3A95kCxu/dBvSnkt+iwvKnlRNnguDpH5xDUsZ/N/IS/
   pYP7FYtZkmwEyTb7IfnzyUZ7Z4KVt5/RF9wz//jYzdwgjIg5CY8l9OKm3
   w==;
X-CSE-ConnectionGUID: YoXMdUlJT7imSzEYES1bkA==
X-CSE-MsgGUID: cryQPITsTcuh89L7tO7SCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11579"; a="62438487"
X-IronPort-AV: E=Sophos;i="6.19,222,1754982000"; 
   d="scan'208";a="62438487"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 17:16:50 -0700
X-CSE-ConnectionGUID: jfukXxB/Sa+8PS7JNkU+VQ==
X-CSE-MsgGUID: delpua2/SZGs2tsB4bG4mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,222,1754982000"; 
   d="scan'208";a="181102612"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 11 Oct 2025 17:16:48 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7jlW-00044B-0A;
	Sun, 12 Oct 2025 00:16:46 +0000
Date: Sun, 12 Oct 2025 08:16:37 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 97d62c3419a0292dabcf2ddda85e51722f2cd81d
Message-ID: <202510120831.4PViSvpu-lkp@intel.com>
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
branch HEAD: 97d62c3419a0292dabcf2ddda85e51722f2cd81d  erofs: fix crafted invalid cases for encoded extents

elapsed time: 1197m

configs tested: 277
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20251011    clang-22
arc                   randconfig-001-20251011    gcc-9.5.0
arc                   randconfig-002-20251011    clang-22
arc                   randconfig-002-20251011    gcc-9.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                        clps711x_defconfig    gcc-15.1.0
arm                          collie_defconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                       imx_v6_v7_defconfig    gcc-15.1.0
arm                          moxart_defconfig    gcc-15.1.0
arm                       netwinder_defconfig    gcc-15.1.0
arm                   randconfig-001-20251011    clang-22
arm                   randconfig-002-20251011    clang-22
arm                   randconfig-002-20251011    gcc-12.5.0
arm                   randconfig-003-20251011    clang-22
arm                   randconfig-004-20251011    clang-22
arm                       versatile_defconfig    gcc-11.5.0
arm                    vt8500_v6_v7_defconfig    gcc-15.1.0
arm                         wpcm450_defconfig    gcc-11.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251011    clang-22
arm64                 randconfig-001-20251011    gcc-10.5.0
arm64                 randconfig-002-20251011    clang-22
arm64                 randconfig-002-20251011    gcc-12.5.0
arm64                 randconfig-003-20251011    clang-22
arm64                 randconfig-004-20251011    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251011    gcc-13.4.0
csky                  randconfig-001-20251011    gcc-8.5.0
csky                  randconfig-002-20251011    gcc-13.4.0
csky                  randconfig-002-20251011    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251011    clang-18
hexagon               randconfig-001-20251011    gcc-8.5.0
hexagon               randconfig-002-20251011    clang-22
hexagon               randconfig-002-20251011    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251011    clang-20
i386        buildonly-randconfig-001-20251011    gcc-13
i386        buildonly-randconfig-001-20251012    clang-20
i386        buildonly-randconfig-002-20251011    clang-20
i386        buildonly-randconfig-002-20251012    clang-20
i386        buildonly-randconfig-003-20251011    clang-20
i386        buildonly-randconfig-003-20251011    gcc-14
i386        buildonly-randconfig-003-20251012    clang-20
i386        buildonly-randconfig-004-20251011    clang-20
i386        buildonly-randconfig-004-20251011    gcc-14
i386        buildonly-randconfig-004-20251012    clang-20
i386        buildonly-randconfig-005-20251011    clang-20
i386        buildonly-randconfig-005-20251012    clang-20
i386        buildonly-randconfig-006-20251011    clang-20
i386        buildonly-randconfig-006-20251012    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251011    gcc-14
i386                  randconfig-001-20251012    gcc-14
i386                  randconfig-002-20251011    gcc-14
i386                  randconfig-002-20251012    gcc-14
i386                  randconfig-003-20251011    gcc-14
i386                  randconfig-003-20251012    gcc-14
i386                  randconfig-004-20251011    gcc-14
i386                  randconfig-004-20251012    gcc-14
i386                  randconfig-005-20251011    gcc-14
i386                  randconfig-005-20251012    gcc-14
i386                  randconfig-006-20251011    gcc-14
i386                  randconfig-006-20251012    gcc-14
i386                  randconfig-007-20251011    gcc-14
i386                  randconfig-007-20251012    gcc-14
i386                  randconfig-011-20251011    clang-20
i386                  randconfig-011-20251012    gcc-14
i386                  randconfig-012-20251011    clang-20
i386                  randconfig-012-20251012    gcc-14
i386                  randconfig-013-20251011    clang-20
i386                  randconfig-013-20251012    gcc-14
i386                  randconfig-014-20251011    clang-20
i386                  randconfig-014-20251012    gcc-14
i386                  randconfig-015-20251011    clang-20
i386                  randconfig-015-20251012    gcc-14
i386                  randconfig-016-20251011    clang-20
i386                  randconfig-016-20251012    gcc-14
i386                  randconfig-017-20251011    clang-20
i386                  randconfig-017-20251012    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251011    clang-18
loongarch             randconfig-001-20251011    gcc-8.5.0
loongarch             randconfig-002-20251011    gcc-12.5.0
loongarch             randconfig-002-20251011    gcc-8.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                            gpr_defconfig    gcc-15.1.0
nios2                         3c120_defconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251011    gcc-8.5.0
nios2                 randconfig-002-20251011    gcc-8.5.0
nios2                 randconfig-002-20251011    gcc-9.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251011    gcc-8.5.0
parisc                randconfig-002-20251011    gcc-14.3.0
parisc                randconfig-002-20251011    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      bamboo_defconfig    clang-22
powerpc                      chrp32_defconfig    clang-19
powerpc                     ksi8560_defconfig    gcc-15.1.0
powerpc                 linkstation_defconfig    gcc-15.1.0
powerpc                   lite5200b_defconfig    clang-22
powerpc                 mpc8315_rdb_defconfig    gcc-11.5.0
powerpc                      pasemi_defconfig    gcc-15.1.0
powerpc                      pmac32_defconfig    clang-22
powerpc               randconfig-001-20251011    clang-22
powerpc               randconfig-001-20251011    gcc-8.5.0
powerpc               randconfig-002-20251011    gcc-8.5.0
powerpc               randconfig-003-20251011    clang-22
powerpc               randconfig-003-20251011    gcc-8.5.0
powerpc                     tqm8541_defconfig    gcc-11.5.0
powerpc64             randconfig-001-20251011    clang-22
powerpc64             randconfig-001-20251011    gcc-8.5.0
powerpc64             randconfig-002-20251011    gcc-8.5.0
powerpc64             randconfig-003-20251011    clang-22
powerpc64             randconfig-003-20251011    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251011    clang-18
riscv                 randconfig-001-20251011    clang-22
riscv                 randconfig-002-20251011    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-14
s390                  randconfig-001-20251011    clang-22
s390                  randconfig-001-20251011    gcc-9.5.0
s390                  randconfig-002-20251011    clang-22
s390                  randconfig-002-20251011    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                        dreamcast_defconfig    gcc-15.1.0
sh                        edosk7705_defconfig    gcc-15.1.0
sh                    randconfig-001-20251011    clang-22
sh                    randconfig-001-20251011    gcc-15.1.0
sh                    randconfig-002-20251011    clang-22
sh                    randconfig-002-20251011    gcc-11.5.0
sh                   rts7751r2dplus_defconfig    gcc-11.5.0
sh                           se7619_defconfig    gcc-15.1.0
sh                   sh7724_generic_defconfig    gcc-11.5.0
sh                  sh7785lcr_32bit_defconfig    gcc-15.1.0
sh                             shx3_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251011    clang-22
sparc                 randconfig-001-20251011    gcc-15.1.0
sparc                 randconfig-002-20251011    clang-22
sparc                 randconfig-002-20251011    gcc-15.1.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251011    clang-22
sparc64               randconfig-002-20251011    clang-22
sparc64               randconfig-002-20251011    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251011    clang-17
um                    randconfig-001-20251011    clang-22
um                    randconfig-002-20251011    clang-19
um                    randconfig-002-20251011    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251011    clang-20
x86_64      buildonly-randconfig-002-20251011    clang-20
x86_64      buildonly-randconfig-003-20251011    clang-20
x86_64      buildonly-randconfig-004-20251011    clang-20
x86_64      buildonly-randconfig-004-20251011    gcc-14
x86_64      buildonly-randconfig-005-20251011    clang-20
x86_64      buildonly-randconfig-005-20251011    gcc-14
x86_64      buildonly-randconfig-006-20251011    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251011    gcc-14
x86_64                randconfig-002-20251011    gcc-14
x86_64                randconfig-003-20251011    gcc-14
x86_64                randconfig-004-20251011    gcc-14
x86_64                randconfig-005-20251011    gcc-14
x86_64                randconfig-006-20251011    gcc-14
x86_64                randconfig-007-20251011    gcc-14
x86_64                randconfig-008-20251011    gcc-14
x86_64                randconfig-071-20251011    clang-20
x86_64                randconfig-072-20251011    clang-20
x86_64                randconfig-073-20251011    clang-20
x86_64                randconfig-074-20251011    clang-20
x86_64                randconfig-075-20251011    clang-20
x86_64                randconfig-076-20251011    clang-20
x86_64                randconfig-077-20251011    clang-20
x86_64                randconfig-078-20251011    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251011    clang-22
xtensa                randconfig-001-20251011    gcc-8.5.0
xtensa                randconfig-002-20251011    clang-22
xtensa                randconfig-002-20251011    gcc-8.5.0
xtensa                    xip_kc705_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

