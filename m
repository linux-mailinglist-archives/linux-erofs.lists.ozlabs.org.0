Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD027A16665
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 06:42:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YbzkX22C6z301v
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 16:42:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737351745;
	cv=none; b=RZUICZLhyzMJ+Sg5fc09TUTmII5uQecvLc4f+ax4VcRlgSjVxQzCcCJ988oq5kKjXqMvp6StwwFvUFGQMwFDSACEDKLDkWiRZuPddgLqhk03TPkM3Ha5SY1a0xBQgyOn9mxooi3SD25q+zK7Oy1s+Eu9vtC0zMl/88/LOI0FXqH547JlSK72ar8GxtiMsiAp+F4PY/fpxmFTasCOhGPsDCfra+MM2qCZyV1uSbiqwO5jhlgyPMNRf3s24vHmhuE3myDNhepfDDubr+GuxQGqHa5ipgL36RvO/CdZj4FUA45fS/nTSrv/zxECEccZ2BP8x8cCkYT1Vb6/CBdhSrVA2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737351745; c=relaxed/relaxed;
	bh=9CcZVha33ZIHRxjelo3EU4NqynNKLzewAJXaF4OwBZw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Hh+gmblPQjoinrxovxBsyUBvI84tOwLgi9gfGhGiTliivZJMqqer3hcWd6q0x9JtwdMJIH0LUO1D+dCtvz8+mmCTIj0KsN83EoEFozen0t3nzWJSC190nT5b+d1WdzTLcDup74tEtqMHnqyqlR65lQvBGYwsaI3XgpYD7cYauYdLYuacSfC9yzS5n1gHrTLetUguqmukmqfYmAMhPVTphkHM2cVUnwBVVYAUWtkf1XC4n+aS3teWFd5AF9dN6tReYo6UvG8+7MBMKaWs+paI0aTdz9AI/eeNhO8nIvX0GMtffep9feR/lydYJgbHAmcGyTUTOvIYwy2HgaCuCv0Nww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W0VBhsgf; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W0VBhsgf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YbzkR4Qj8z2ymQ
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Jan 2025 16:42:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737351744; x=1768887744;
  h=date:from:to:cc:subject:message-id;
  bh=debjxfY4qw8fM9urw2Ak6Qm72RXkCgWEPmkGr7O78zU=;
  b=W0VBhsgf3nRRL9WTwGckZfb/jySrWeKVzDN7OkWT6aq/ZzVor0vSLije
   65tpF9nepkVGBraE1LJiWohQHzIFCGD88H5VVVZMcHFnlc1GnTV7KlcFn
   rlLHraToIpE9uH47/BWiZIvLqrR32QZH0SusMir2PXCI+vUfNCZz03txz
   IZWHHQe2SFxBvC4NPe9Kr2/b8pwIIYDJBztSdnUhTu8sBMhtRuVEU6QIK
   VlRKP1ys7RZ39IILNF15Ng6HeE6zbRMuv7h59aeuRgiIq/ENHo4L/itqn
   CbuwhpIFCfIvlKRNcs+18qnG7qSwNw+jSC1FXT4BSyP3pItaJJSfGo6OB
   Q==;
X-CSE-ConnectionGUID: FWnSs/f7Rc2TpB13R1zvFA==
X-CSE-MsgGUID: hkaCqCdcSLe0AdxGEVqEGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="55263089"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="55263089"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 21:42:18 -0800
X-CSE-ConnectionGUID: W9IFgVZrRWG+EqBKUA855g==
X-CSE-MsgGUID: qVwTWNGTTTObUOK5xEeH0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110996185"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 19 Jan 2025 21:42:16 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tZkYA-000WEJ-26;
	Mon, 20 Jan 2025 05:42:14 +0000
Date: Mon, 20 Jan 2025 13:41:37 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 6e2c2342e2b608264cf763a27410295b05995191
Message-ID: <202501201330.XgoGppKb-lkp@intel.com>
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
branch HEAD: 6e2c2342e2b608264cf763a27410295b05995191  erofs: remove dead code in erofs_fc_parse_param

Unverified Warning (likely false positive, kindly check if interested):

    fs/erofs/zdata.c:554 z_erofs_bind_cache() error: uninitialized symbol 'newfolio'.

Warning ids grouped by kconfigs:

recent_errors
|-- i386-randconfig-141-20250120
|   `-- fs-erofs-zdata.c-z_erofs_bind_cache()-error:uninitialized-symbol-newfolio-.
`-- x86_64-randconfig-r073-20250119
    `-- fs-erofs-zdata.c-z_erofs_bind_cache()-error:uninitialized-symbol-newfolio-.

elapsed time: 724m

configs tested: 142
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                          axs101_defconfig    gcc-13.2.0
arc                   randconfig-001-20250120    gcc-13.2.0
arc                   randconfig-002-20250120    gcc-13.2.0
arc                        vdk_hs38_defconfig    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-17
arm                            hisi_defconfig    gcc-14.2.0
arm                            mmp2_defconfig    gcc-14.2.0
arm                   randconfig-001-20250120    clang-20
arm                   randconfig-002-20250120    clang-20
arm                   randconfig-003-20250120    clang-20
arm                   randconfig-004-20250120    clang-19
arm                        shmobile_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250120    gcc-14.2.0
arm64                 randconfig-002-20250120    clang-20
arm64                 randconfig-003-20250120    clang-19
arm64                 randconfig-004-20250120    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250120    gcc-14.2.0
csky                  randconfig-002-20250120    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250120    clang-20
hexagon               randconfig-002-20250120    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250120    gcc-11
i386        buildonly-randconfig-002-20250120    clang-19
i386        buildonly-randconfig-003-20250120    gcc-12
i386        buildonly-randconfig-004-20250120    gcc-12
i386        buildonly-randconfig-005-20250120    clang-19
i386        buildonly-randconfig-006-20250120    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250120    gcc-14.2.0
loongarch             randconfig-002-20250120    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                           virt_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ci20_defconfig    clang-19
mips                           ip27_defconfig    gcc-14.2.0
mips                       lemote2f_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250120    gcc-14.2.0
nios2                 randconfig-002-20250120    gcc-14.2.0
openrisc                         alldefconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                generic-64bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250120    gcc-14.2.0
parisc                randconfig-002-20250120    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      cm5200_defconfig    clang-20
powerpc                   currituck_defconfig    clang-17
powerpc                       eiger_defconfig    clang-17
powerpc                 mpc8313_rdb_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250120    clang-20
powerpc               randconfig-002-20250120    clang-20
powerpc               randconfig-003-20250120    clang-20
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250120    clang-19
powerpc64             randconfig-002-20250120    clang-17
powerpc64             randconfig-003-20250120    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250120    clang-20
riscv                 randconfig-002-20250120    clang-20
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250120    gcc-14.2.0
s390                  randconfig-002-20250120    clang-18
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                          landisk_defconfig    gcc-14.2.0
sh                    randconfig-001-20250120    gcc-14.2.0
sh                    randconfig-002-20250120    gcc-14.2.0
sh                           se7722_defconfig    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.2.0
sh                            shmin_defconfig    gcc-14.2.0
sparc                            alldefconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250120    gcc-14.2.0
sparc                 randconfig-002-20250120    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250120    gcc-14.2.0
sparc64               randconfig-002-20250120    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250120    clang-15
um                    randconfig-002-20250120    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                           alldefconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250120    clang-19
x86_64      buildonly-randconfig-002-20250120    clang-19
x86_64      buildonly-randconfig-003-20250120    gcc-12
x86_64      buildonly-randconfig-004-20250120    clang-19
x86_64      buildonly-randconfig-005-20250120    clang-19
x86_64      buildonly-randconfig-006-20250120    gcc-11
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250120    gcc-14.2.0
xtensa                randconfig-002-20250120    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
