Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B188959368
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 05:46:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WpXLc35kpz2yGd
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 13:46:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.12
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l6c61WqZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WpXLX4Chkz2xHx
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2024 13:46:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724211974; x=1755747974;
  h=date:from:to:cc:subject:message-id;
  bh=t+prPB8U2j1iHiqZSunxxVd8yxXstNrFCCWxK7m3FPg=;
  b=l6c61WqZmfPMkdCbdKV3eyRyD4QEp/LJhfihbeR0fgHy5m5xbF56K/GV
   3vH5QC+z8mc50mFrHRGdfFLDeprE68r6vdJ3YgpCdCEn8O0s2l+DihXxP
   4xVzz4vT+/isTvIw9gdwd2hsWm1TFaBAfAcGxfwH5AraLgX7zNk24/sNl
   O5etXwxlV1qaf9ZzZMDRkBOux4SajO+8ZaiLazU6oIxQnBrXzK346jrZf
   GqqGW8UjB9Lcfqo3gIA5Zon1vRhYW+pIP53qCIeCjzLDmXyT/76lVIzKS
   Vb6R30Ddr3cYDvG39kBfHWwFG33+qOjgc+87ySbr73e59Zy2bOvaDSeQK
   A==;
X-CSE-ConnectionGUID: N0hwbJbIQpeZMUpPaGd1FQ==
X-CSE-MsgGUID: +ZOnIScqTLyKECytm3jeRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33936031"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="33936031"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 20:46:08 -0700
X-CSE-ConnectionGUID: 7ZFpOWsWTWq18/IrsP0OWw==
X-CSE-MsgGUID: qr7wqyNzR0aPFrymg1iBVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="65646430"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 20 Aug 2024 20:46:05 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgcIN-000Ara-1I;
	Wed, 21 Aug 2024 03:46:03 +0000
Date: Wed, 21 Aug 2024 11:45:36 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:fixes] BUILD SUCCESS
 db2cc8a6b8ec28a6269bc9032634967a0ad7c3ef
Message-ID: <202408211133.Ns6WTiAH-lkp@intel.com>
User-Agent: s-nail v14.9.24
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git fixes
branch HEAD: db2cc8a6b8ec28a6269bc9032634967a0ad7c3ef  erofs: fix out-of-bound access when z_erofs_gbuf_growsize() partially fails

elapsed time: 1047m

configs tested: 232
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240821   gcc-13.2.0
arc                   randconfig-002-20240821   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                     davinci_all_defconfig   clang-20
arm                                 defconfig   gcc-13.2.0
arm                          ep93xx_defconfig   clang-20
arm                      jornada720_defconfig   clang-20
arm                             mxs_defconfig   clang-20
arm                       netwinder_defconfig   clang-20
arm                   randconfig-001-20240821   gcc-14.1.0
arm                   randconfig-002-20240821   gcc-14.1.0
arm                   randconfig-003-20240821   clang-20
arm                   randconfig-004-20240821   gcc-14.1.0
arm                          sp7021_defconfig   clang-20
arm                           stm32_defconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240821   gcc-14.1.0
arm64                 randconfig-002-20240821   gcc-14.1.0
arm64                 randconfig-003-20240821   gcc-14.1.0
arm64                 randconfig-004-20240821   clang-20
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240821   gcc-14.1.0
csky                  randconfig-002-20240821   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240821   clang-20
hexagon               randconfig-002-20240821   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240820   clang-18
i386         buildonly-randconfig-001-20240821   gcc-12
i386         buildonly-randconfig-002-20240820   clang-18
i386         buildonly-randconfig-002-20240821   clang-18
i386         buildonly-randconfig-002-20240821   gcc-12
i386         buildonly-randconfig-003-20240820   clang-18
i386         buildonly-randconfig-003-20240821   clang-18
i386         buildonly-randconfig-003-20240821   gcc-12
i386         buildonly-randconfig-004-20240820   gcc-12
i386         buildonly-randconfig-004-20240821   gcc-12
i386         buildonly-randconfig-005-20240820   clang-18
i386         buildonly-randconfig-005-20240821   gcc-12
i386         buildonly-randconfig-006-20240820   clang-18
i386         buildonly-randconfig-006-20240821   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240820   clang-18
i386                  randconfig-001-20240821   clang-18
i386                  randconfig-001-20240821   gcc-12
i386                  randconfig-002-20240820   clang-18
i386                  randconfig-002-20240821   gcc-12
i386                  randconfig-003-20240820   clang-18
i386                  randconfig-003-20240821   clang-18
i386                  randconfig-003-20240821   gcc-12
i386                  randconfig-004-20240820   clang-18
i386                  randconfig-004-20240821   gcc-12
i386                  randconfig-005-20240820   clang-18
i386                  randconfig-005-20240821   clang-18
i386                  randconfig-005-20240821   gcc-12
i386                  randconfig-006-20240820   clang-18
i386                  randconfig-006-20240821   gcc-12
i386                  randconfig-011-20240820   gcc-11
i386                  randconfig-011-20240821   gcc-11
i386                  randconfig-011-20240821   gcc-12
i386                  randconfig-012-20240820   gcc-12
i386                  randconfig-012-20240821   gcc-12
i386                  randconfig-013-20240820   gcc-12
i386                  randconfig-013-20240821   clang-18
i386                  randconfig-013-20240821   gcc-12
i386                  randconfig-014-20240820   gcc-12
i386                  randconfig-014-20240821   clang-18
i386                  randconfig-014-20240821   gcc-12
i386                  randconfig-015-20240820   gcc-12
i386                  randconfig-015-20240821   gcc-12
i386                  randconfig-016-20240820   clang-18
i386                  randconfig-016-20240821   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240821   gcc-14.1.0
loongarch             randconfig-002-20240821   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                       bmips_be_defconfig   clang-20
mips                          eyeq6_defconfig   clang-20
mips                      malta_kvm_defconfig   clang-20
mips                      maltaaprp_defconfig   clang-20
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240821   gcc-14.1.0
nios2                 randconfig-002-20240821   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240821   gcc-14.1.0
parisc                randconfig-002-20240821   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                       eiger_defconfig   clang-20
powerpc                      pcm030_defconfig   clang-20
powerpc                     rainier_defconfig   clang-20
powerpc               randconfig-001-20240821   gcc-14.1.0
powerpc               randconfig-002-20240821   clang-20
powerpc               randconfig-003-20240821   clang-20
powerpc64             randconfig-001-20240821   gcc-14.1.0
powerpc64             randconfig-002-20240821   clang-20
powerpc64             randconfig-003-20240821   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240821   gcc-14.1.0
riscv                 randconfig-002-20240821   clang-16
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240821   clang-17
s390                  randconfig-002-20240821   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240821   gcc-14.1.0
sh                    randconfig-002-20240821   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240821   gcc-14.1.0
sparc64               randconfig-002-20240821   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   clang-20
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-12
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240821   clang-20
um                    randconfig-002-20240821   gcc-12
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240821   gcc-12
x86_64       buildonly-randconfig-002-20240821   clang-18
x86_64       buildonly-randconfig-002-20240821   gcc-12
x86_64       buildonly-randconfig-003-20240821   gcc-12
x86_64       buildonly-randconfig-004-20240821   gcc-12
x86_64       buildonly-randconfig-005-20240821   gcc-12
x86_64       buildonly-randconfig-006-20240821   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240821   clang-18
x86_64                randconfig-001-20240821   gcc-12
x86_64                randconfig-002-20240821   gcc-12
x86_64                randconfig-003-20240821   clang-18
x86_64                randconfig-003-20240821   gcc-12
x86_64                randconfig-004-20240821   clang-18
x86_64                randconfig-004-20240821   gcc-12
x86_64                randconfig-005-20240821   clang-18
x86_64                randconfig-005-20240821   gcc-12
x86_64                randconfig-006-20240821   gcc-12
x86_64                randconfig-011-20240821   gcc-12
x86_64                randconfig-012-20240821   clang-18
x86_64                randconfig-012-20240821   gcc-12
x86_64                randconfig-013-20240821   clang-18
x86_64                randconfig-013-20240821   gcc-12
x86_64                randconfig-014-20240821   clang-18
x86_64                randconfig-014-20240821   gcc-12
x86_64                randconfig-015-20240821   gcc-12
x86_64                randconfig-016-20240821   clang-18
x86_64                randconfig-016-20240821   gcc-12
x86_64                randconfig-071-20240821   gcc-12
x86_64                randconfig-072-20240821   clang-18
x86_64                randconfig-072-20240821   gcc-12
x86_64                randconfig-073-20240821   gcc-12
x86_64                randconfig-074-20240821   clang-18
x86_64                randconfig-074-20240821   gcc-12
x86_64                randconfig-075-20240821   gcc-12
x86_64                randconfig-076-20240821   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240821   gcc-14.1.0
xtensa                randconfig-002-20240821   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
