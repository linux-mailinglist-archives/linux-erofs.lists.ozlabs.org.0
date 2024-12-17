Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 701479F4CB5
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Dec 2024 14:46:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YCJ4f2PMqz30Vf
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Dec 2024 00:46:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734443184;
	cv=none; b=Zs2+3ul7v4x/TiepPjuW+wd5P3+gMLWwXiX932Lg0zELZZNgALgBkEvH7ZGmbeMxo9CYX1goGM5yDHbJw9a29Q5A6mZyY5I+UWpueicS3n7Qw95FucjUu4nV3w2Xt9+r95UDaYka+JZFxsLoSuhRF+Ct/iz68Z4L1rKbcwdD5EX26PUPSM51YoUR7XntfKOi2mH3UBh4xNjiFt2wbJOGWCbXEJr0NQ8/mUP5pd2XQYsifroox+oaazXoATxEVUi7Aeww7FmQcog53NZnlL5gOY2oeit/pyWi0nGPp02kWQ25Gf6WWbBnh4Rw2SNZpctpGnag24ZZOJWI4c1z+WKIoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734443184; c=relaxed/relaxed;
	bh=vpHQVZiwYsNieYEpcVjMZYXQF7PIbEGsvf4XZCL+z3Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hIUfT/wnoTnJD/d5x+hfp1qXwKEcKyKKALGfdIgZK8hgFa2Yxi04lOOk8fFLRa20bbuUouk08Hxmv/B/OPt99sRq0Ttygg5ui6Du6F5kxhnEL5SE7GPYPAqBPLslJGCaIqO/PUMqIJqU/nK5l7aNW8EcrbC38KPSgFDPiJozg9I5woX2I8uaps8Lsc5WSeipIBXMyWx8nlJBXt6bbiOqreo42EkW3iJ2jDnvEYBkFkewhmEV37sao905cZ7YU0Cv2esdKuN882chCDtTSnTVtsbXIg14QsQFgGVTP0oO13Q8ylvbVqp/t9ucZll509MH7xdULq/1jl4ZzSBjmNb86w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZL4pWbyn; dkim-atps=neutral; spf=pass (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZL4pWbyn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YCJ4X31Ylz2x9j
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Dec 2024 00:46:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734443181; x=1765979181;
  h=date:from:to:cc:subject:message-id;
  bh=9pTqDYpPHgtx7+GtR8iTzQWGshjfe1ziE+lutzmhQdc=;
  b=ZL4pWbynR0Y684ukw64HTPyoQT13a9LsVhR0RtZ5//wL1AdEz6XFnthq
   ScE7gxydr1ItMKceWbmyMrqAie72CFwVSEmG7yl7t7jIfCpTgELuh9nqC
   0NGvvxPhOG7e0mHBfG73dqRA1DAiFAz0Fc8XwOsibb1jFv+XYxD1VR6lF
   dv93PVjd6scwddI6uneevwDkPDPo9H0kAJAaEF3XcgJXX7HOCTTHuUSn0
   SbIas549+WWhBumDrei65Yzpu39eVfEbBbAzy+iG+weE+vRkLrWDuevj6
   p1vySTqy8QyP5VBfqZbcC4E+ma8zF6vINqifWE7Q7OqA528AIaD8l0oZP
   Q==;
X-CSE-ConnectionGUID: V66rbZE1RT221gYRzebbUA==
X-CSE-MsgGUID: 5MVCcqAOTkmKyqj507puQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="35018438"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="35018438"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 05:46:13 -0800
X-CSE-ConnectionGUID: Sml32LhwQBeEdGMaD/dK5A==
X-CSE-MsgGUID: NJCOss8HRJGE8HQ7VzAZ4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102523923"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 17 Dec 2024 05:46:11 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tNXtp-000F28-0E;
	Tue, 17 Dec 2024 13:46:09 +0000
Date: Tue, 17 Dec 2024 21:46:02 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 6422cde1b0d5a31b206b263417c1c2b3c80fe82c
Message-ID: <202412172156.qJmQukst-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 6422cde1b0d5a31b206b263417c1c2b3c80fe82c  erofs: use buffered I/O for file-backed mounts by default

elapsed time: 1437m

configs tested: 143
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20241216    gcc-13.2.0
arc                   randconfig-002-20241216    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         bcm2835_defconfig    clang-16
arm                                 defconfig    clang-20
arm                          exynos_defconfig    clang-20
arm                         nhk8815_defconfig    clang-20
arm                   randconfig-001-20241216    clang-15
arm                   randconfig-002-20241216    gcc-14.2.0
arm                   randconfig-003-20241216    clang-20
arm                   randconfig-004-20241216    clang-17
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241216    gcc-14.2.0
arm64                 randconfig-002-20241216    clang-20
arm64                 randconfig-003-20241216    gcc-14.2.0
arm64                 randconfig-004-20241216    clang-15
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241216    gcc-14.2.0
csky                  randconfig-002-20241216    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20241216    clang-20
hexagon               randconfig-002-20241216    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241217    clang-19
i386        buildonly-randconfig-002-20241217    gcc-12
i386        buildonly-randconfig-003-20241217    gcc-12
i386        buildonly-randconfig-004-20241217    clang-19
i386        buildonly-randconfig-005-20241217    clang-19
i386        buildonly-randconfig-006-20241217    gcc-11
i386                                defconfig    clang-19
loongarch                        alldefconfig    gcc-14.2.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241216    gcc-14.2.0
loongarch             randconfig-002-20241216    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          amiga_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-20
mips                        bcm63xx_defconfig    clang-20
mips                  cavium_octeon_defconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241216    gcc-14.2.0
nios2                 randconfig-002-20241216    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241216    gcc-14.2.0
parisc                randconfig-002-20241216    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                       eiger_defconfig    clang-17
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                 mpc836x_rdk_defconfig    clang-18
powerpc                      ppc64e_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241216    clang-20
powerpc               randconfig-002-20241216    clang-20
powerpc               randconfig-003-20241216    gcc-14.2.0
powerpc                      tqm8xx_defconfig    clang-20
powerpc64             randconfig-001-20241216    clang-20
powerpc64             randconfig-002-20241216    clang-15
powerpc64             randconfig-003-20241216    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20241216    clang-20
riscv                 randconfig-002-20241216    clang-15
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20241216    gcc-14.2.0
s390                  randconfig-002-20241216    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         ap325rxa_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.2.0
sh                        edosk7705_defconfig    gcc-14.2.0
sh                    randconfig-001-20241216    gcc-14.2.0
sh                    randconfig-002-20241216    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241216    gcc-14.2.0
sparc                 randconfig-002-20241216    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241216    gcc-14.2.0
sparc64               randconfig-002-20241216    gcc-14.2.0
um                               alldefconfig    clang-19
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241216    gcc-12
um                    randconfig-002-20241216    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241216    gcc-12
x86_64      buildonly-randconfig-002-20241216    gcc-12
x86_64      buildonly-randconfig-003-20241216    clang-19
x86_64      buildonly-randconfig-004-20241216    clang-19
x86_64      buildonly-randconfig-005-20241216    clang-19
x86_64      buildonly-randconfig-006-20241216    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                generic_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20241216    gcc-14.2.0
xtensa                randconfig-002-20241216    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
