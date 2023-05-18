Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CB17083FB
	for <lists+linux-erofs@lfdr.de>; Thu, 18 May 2023 16:36:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QMXc41kp5z3fC8
	for <lists+linux-erofs@lfdr.de>; Fri, 19 May 2023 00:36:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HsqJo9+d;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HsqJo9+d;
	dkim-atps=neutral
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QMXbw0k3Wz3f8Z
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 May 2023 00:36:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684420604; x=1715956604;
  h=date:from:to:cc:subject:message-id;
  bh=LRhLY5PClUr20EerDnkMnJCuPuXMqTxpV/wECQuWTU4=;
  b=HsqJo9+dGDN71GFocLyRSu21VwwD2uCM5Hfg7Z99C3vIPBneNX674c//
   Q9ssGwaqvdyva9eithce5jagXEGcoe/pzm94ifGt9/WEIpxr1LzlinouJ
   AvGlRhQi22+tBshJxb629PTkHwZsxu5xpHB9MUc3SoaXEqInsyCPKFnVe
   nsefL4Fz4r+8e+7mlDV1sqkBsL7zwM9ntBMv7uoPwTJGqyyoGtpkmBqYW
   CyrJtaBvR7uAUbNV0jlkz+RhHhKbidkBN1FGypjMgQ8yGNaQQRmFllf+L
   Tc5YELQ1BVVIZ0yfOaiSygvRUemDyfdip30Y+7Izm3IeWpbrH3iLcZbFU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="331697059"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="331697059"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 07:36:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="771883285"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="771883285"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 May 2023 07:36:32 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pzek4-000A6l-0K;
	Thu, 18 May 2023 14:36:32 +0000
Date: Thu, 18 May 2023 22:36:31 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 3b35f11c99e128625623df9a80035cfa1b79d504
Message-ID: <20230518143631.qS2rE%lkp@intel.com>
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

tree/branch: INFO setup_repo_specs: /db/releases/20230517200055/lkp-src/repo/*/xiang-erofs
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 3b35f11c99e128625623df9a80035cfa1b79d504  erofs: avoid pcpubuf.c inclusion if CONFIG_EROFS_FS_ZIP is off

elapsed time: 725m

configs tested: 201
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230517   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230517   gcc  
alpha                randconfig-r005-20230517   gcc  
alpha                randconfig-r006-20230517   gcc  
alpha                randconfig-r013-20230517   gcc  
alpha                randconfig-r022-20230517   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230517   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230517   gcc  
arc                  randconfig-r023-20230517   gcc  
arc                  randconfig-r034-20230517   gcc  
arc                  randconfig-r043-20230517   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                        mvebu_v5_defconfig   clang
arm                  randconfig-r001-20230517   gcc  
arm                  randconfig-r003-20230517   gcc  
arm                  randconfig-r004-20230517   gcc  
arm                  randconfig-r011-20230517   clang
arm                  randconfig-r015-20230517   clang
arm                  randconfig-r036-20230517   gcc  
arm                  randconfig-r046-20230517   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230517   clang
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230517   clang
arm64                randconfig-r003-20230517   clang
arm64                randconfig-r006-20230517   clang
arm64                randconfig-r011-20230517   gcc  
arm64                randconfig-r012-20230517   gcc  
arm64                randconfig-r014-20230517   gcc  
arm64                randconfig-r022-20230518   clang
csky         buildonly-randconfig-r005-20230517   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230517   gcc  
csky                 randconfig-r004-20230517   gcc  
csky                 randconfig-r013-20230517   gcc  
csky                 randconfig-r021-20230517   gcc  
csky                 randconfig-r024-20230517   gcc  
csky                 randconfig-r025-20230517   gcc  
hexagon              randconfig-r035-20230517   clang
hexagon              randconfig-r041-20230517   clang
hexagon              randconfig-r045-20230517   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r004-20230517   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r006-20230517   gcc  
ia64                 randconfig-r016-20230517   gcc  
ia64                 randconfig-r023-20230517   gcc  
ia64                 randconfig-r036-20230517   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230517   gcc  
loongarch    buildonly-randconfig-r006-20230517   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230517   gcc  
m68k                             allmodconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r016-20230517   gcc  
m68k                 randconfig-r023-20230517   gcc  
m68k                 randconfig-r024-20230517   gcc  
m68k                 randconfig-r034-20230517   gcc  
microblaze   buildonly-randconfig-r004-20230517   gcc  
microblaze           randconfig-r031-20230517   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips         buildonly-randconfig-r005-20230517   gcc  
mips                            gpr_defconfig   gcc  
mips                 randconfig-r006-20230517   gcc  
mips                 randconfig-r015-20230517   clang
mips                 randconfig-r023-20230517   clang
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230517   gcc  
nios2                randconfig-r025-20230517   gcc  
nios2                randconfig-r036-20230517   gcc  
openrisc             randconfig-r002-20230517   gcc  
openrisc             randconfig-r013-20230517   gcc  
openrisc             randconfig-r035-20230517   gcc  
parisc                           alldefconfig   gcc  
parisc       buildonly-randconfig-r005-20230517   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r013-20230517   gcc  
parisc               randconfig-r014-20230517   gcc  
parisc               randconfig-r024-20230517   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r011-20230517   gcc  
powerpc              randconfig-r012-20230517   gcc  
powerpc              randconfig-r014-20230517   gcc  
powerpc              randconfig-r025-20230518   clang
powerpc                     tqm5200_defconfig   clang
powerpc                      tqm8xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230517   clang
riscv                randconfig-r002-20230517   clang
riscv                randconfig-r005-20230517   clang
riscv                randconfig-r026-20230517   gcc  
riscv                randconfig-r032-20230517   clang
riscv                randconfig-r042-20230517   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230517   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r015-20230517   gcc  
s390                 randconfig-r016-20230517   gcc  
s390                 randconfig-r021-20230517   gcc  
s390                 randconfig-r022-20230517   gcc  
s390                 randconfig-r026-20230517   gcc  
s390                 randconfig-r031-20230517   clang
s390                 randconfig-r032-20230517   clang
s390                 randconfig-r044-20230517   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r006-20230517   gcc  
sh                        dreamcast_defconfig   gcc  
sh                   randconfig-r012-20230517   gcc  
sh                   randconfig-r022-20230517   gcc  
sh                   randconfig-r024-20230517   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc        buildonly-randconfig-r002-20230517   gcc  
sparc        buildonly-randconfig-r004-20230517   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230517   gcc  
sparc                randconfig-r006-20230517   gcc  
sparc                randconfig-r032-20230517   gcc  
sparc                randconfig-r033-20230517   gcc  
sparc64      buildonly-randconfig-r003-20230517   gcc  
sparc64              randconfig-r004-20230517   gcc  
sparc64              randconfig-r005-20230517   gcc  
sparc64              randconfig-r033-20230517   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                        randconfig-x051   gcc  
x86_64                        randconfig-x052   clang
x86_64                        randconfig-x053   gcc  
x86_64                        randconfig-x054   clang
x86_64                        randconfig-x055   gcc  
x86_64                        randconfig-x056   clang
x86_64                        randconfig-x061   gcc  
x86_64                        randconfig-x062   clang
x86_64                        randconfig-x063   gcc  
x86_64                        randconfig-x064   clang
x86_64                        randconfig-x065   gcc  
x86_64                        randconfig-x066   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r002-20230517   gcc  
xtensa               randconfig-r002-20230517   gcc  
xtensa               randconfig-r021-20230517   gcc  
xtensa               randconfig-r025-20230517   gcc  
xtensa               randconfig-r034-20230517   gcc  
xtensa               randconfig-r035-20230517   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
