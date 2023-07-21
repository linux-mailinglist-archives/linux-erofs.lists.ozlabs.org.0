Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 323B075BCD9
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jul 2023 05:39:03 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Obi5JRqV;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R6ZzT0mlbz3bTf
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jul 2023 13:39:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Obi5JRqV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R6ZzK1rF9z2yDC
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jul 2023 13:38:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689910733; x=1721446733;
  h=date:from:to:cc:subject:message-id;
  bh=HIpm7P9PLBeSYeiOqi9q24arhbBGjmx2l5pUpmi3WRg=;
  b=Obi5JRqVgdR0XiEu/DgHdKeDbkSriz5gdEr0iCmKnbHEbCvDdw5chDM3
   kEUpHbkKr0RW7xKW9IJkmenoNpdv97Rc3vocLvWLBn1Ujekuz1jzKcJoU
   cpCvZvokt1nsYuzhyf2U1cApe8BSDxDch2pgAd6TKB1rl07O2TGfRcVHA
   zKYftnqva67eJWnzbkWqN5sXljZPJt5m8B7SKUJwVrBdzvcIGcJ9ydDge
   4/avWZYgMFsuhVg8dk/4RextQki6ZWgpep7Omtjima1L4fmYe6lLgNyFp
   jmt4gN5IgfNLYR3a3/REyRbcrdqfxDgVs9EHSAdgsqhq6Z7bKCqOlmI4F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="346518831"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="346518831"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 20:38:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="814790630"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="814790630"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jul 2023 20:38:26 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qMgyC-0006pA-1b;
	Fri, 21 Jul 2023 03:38:22 +0000
Date: Fri, 21 Jul 2023 11:37:27 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 7d15c91a75aae55767f368e8abbabd7cedf4ec94
Message-ID: <202307211125.5I0wSXzU-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 7d15c91a75aae55767f368e8abbabd7cedf4ec94  erofs: fix wrong primary bvec selection on deduplicated extents

elapsed time: 1444m

configs tested: 185
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r014-20230720   gcc  
alpha                randconfig-r032-20230720   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                  randconfig-r002-20230720   gcc  
arc                  randconfig-r003-20230720   gcc  
arc                  randconfig-r012-20230720   gcc  
arc                  randconfig-r016-20230720   gcc  
arc                  randconfig-r021-20230720   gcc  
arc                  randconfig-r043-20230720   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r014-20230720   gcc  
arm                  randconfig-r033-20230720   clang
arm                  randconfig-r035-20230720   clang
arm                  randconfig-r046-20230720   gcc  
arm                         s3c6400_defconfig   gcc  
arm                          sp7021_defconfig   clang
arm                       spear13xx_defconfig   clang
arm                        vexpress_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r023-20230720   clang
arm64                randconfig-r026-20230720   clang
arm64                randconfig-r031-20230720   gcc  
csky                             alldefconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r016-20230720   gcc  
csky                 randconfig-r032-20230720   gcc  
hexagon              randconfig-r001-20230720   clang
hexagon              randconfig-r022-20230720   clang
hexagon              randconfig-r024-20230720   clang
hexagon              randconfig-r036-20230720   clang
hexagon              randconfig-r041-20230720   clang
hexagon              randconfig-r045-20230720   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230720   gcc  
i386         buildonly-randconfig-r005-20230720   gcc  
i386         buildonly-randconfig-r006-20230720   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230720   gcc  
i386                 randconfig-i002-20230720   gcc  
i386                 randconfig-i003-20230720   gcc  
i386                 randconfig-i004-20230720   gcc  
i386                 randconfig-i005-20230720   gcc  
i386                 randconfig-i006-20230720   gcc  
i386                 randconfig-i011-20230720   clang
i386                 randconfig-i012-20230720   clang
i386                 randconfig-i013-20230720   clang
i386                 randconfig-i014-20230720   clang
i386                 randconfig-i015-20230720   clang
i386                 randconfig-i016-20230720   clang
i386                 randconfig-r011-20230720   clang
i386                 randconfig-r024-20230720   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230720   gcc  
loongarch            randconfig-r015-20230720   gcc  
loongarch            randconfig-r023-20230720   gcc  
loongarch            randconfig-r033-20230720   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                 randconfig-r006-20230720   gcc  
m68k                 randconfig-r011-20230720   gcc  
m68k                 randconfig-r025-20230720   gcc  
m68k                 randconfig-r035-20230720   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
microblaze           randconfig-r011-20230720   gcc  
microblaze           randconfig-r022-20230720   gcc  
microblaze           randconfig-r031-20230720   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                 randconfig-r005-20230720   clang
mips                 randconfig-r012-20230720   gcc  
mips                 randconfig-r036-20230720   clang
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230720   gcc  
nios2                randconfig-r002-20230720   gcc  
openrisc             randconfig-r014-20230720   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230720   gcc  
parisc               randconfig-r016-20230720   gcc  
parisc               randconfig-r036-20230720   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                     kmeter1_defconfig   clang
powerpc                       maple_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      ppc40x_defconfig   gcc  
powerpc                      ppc44x_defconfig   clang
powerpc                     rainier_defconfig   gcc  
powerpc              randconfig-r005-20230720   gcc  
powerpc              randconfig-r013-20230720   clang
powerpc              randconfig-r023-20230720   clang
powerpc              randconfig-r024-20230720   clang
powerpc              randconfig-r026-20230720   clang
powerpc                      walnut_defconfig   clang
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230720   clang
riscv                randconfig-r015-20230720   clang
riscv                randconfig-r032-20230720   gcc  
riscv                randconfig-r042-20230720   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230720   gcc  
s390                 randconfig-r013-20230720   clang
s390                 randconfig-r025-20230720   clang
s390                 randconfig-r044-20230720   clang
sh                               allmodconfig   gcc  
sh                             espt_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r022-20230720   gcc  
sh                          rsk7201_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r034-20230720   gcc  
sparc                randconfig-r036-20230720   gcc  
sparc64              randconfig-r013-20230720   gcc  
sparc64              randconfig-r015-20230720   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r035-20230720   clang
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230720   gcc  
x86_64       buildonly-randconfig-r002-20230720   gcc  
x86_64       buildonly-randconfig-r003-20230720   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r011-20230720   clang
x86_64               randconfig-r016-20230720   clang
x86_64               randconfig-x001-20230720   clang
x86_64               randconfig-x002-20230720   clang
x86_64               randconfig-x003-20230720   clang
x86_64               randconfig-x004-20230720   clang
x86_64               randconfig-x005-20230720   clang
x86_64               randconfig-x006-20230720   clang
x86_64               randconfig-x011-20230720   gcc  
x86_64               randconfig-x012-20230720   gcc  
x86_64               randconfig-x013-20230720   gcc  
x86_64               randconfig-x014-20230720   gcc  
x86_64               randconfig-x015-20230720   gcc  
x86_64               randconfig-x016-20230720   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                       common_defconfig   gcc  
xtensa               randconfig-r003-20230720   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
