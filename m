Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2D07800FA
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Aug 2023 00:23:58 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=avokp/9z;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRffz5qkdz2ytb
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Aug 2023 08:23:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=avokp/9z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.93; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRffq2BL3z2ydN
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Aug 2023 08:23:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692311027; x=1723847027;
  h=date:from:to:cc:subject:message-id;
  bh=mCPwLRR6QjfcX2Qywfq/9Zrp04IS0BG4PspltVMoK3M=;
  b=avokp/9zLvPfcoRAdcQcLKA9F5sPmgwY23bXp0QfWacKrHj2+bbuHVp+
   cRUEf/SItgmugTEx+gCLjkLp6zJyipg+edZTXb14JyuYQfUn0QDlBk3im
   1wbYA9NchcFEtYl9J3cDh8o1z6k7Ex8E06fMC19nsl3GwtvYOaVxkmXrB
   /DxnOp4E72RydB9NYE+Dawhmn/D8OOuewT6a4fYGJLEFc8qxDU5ttgqOn
   DoXjm/T+gXUJKN2nnb3m2MYvi3ig7IAPFdmzl+gN7fEuNR6zoNEZxiQqL
   zKoMy7w6NquPHbQCY2aDXb6+8NIuq15CthVukQDJobQFGNVccedBhxBW/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="370412467"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="370412467"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 15:23:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="769858176"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="769858176"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Aug 2023 15:23:37 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qWlOy-0001Vx-1p;
	Thu, 17 Aug 2023 22:23:36 +0000
Date: Fri, 18 Aug 2023 06:22:39 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 80b45c60a9e7e5531caff1ad34c6ddca2b001ed0
Message-ID: <202308180637.6xMK6LBs-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 80b45c60a9e7e5531caff1ad34c6ddca2b001ed0  erofs: adapt folios for z_erofs_read_folio()

elapsed time: 722m

configs tested: 183
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r034-20230817   gcc  
arc                  randconfig-r043-20230817   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                         lpc18xx_defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                  randconfig-r004-20230817   gcc  
arm                  randconfig-r012-20230817   clang
arm                  randconfig-r013-20230818   gcc  
arm                  randconfig-r046-20230817   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r032-20230817   clang
csky                                defconfig   gcc  
csky                 randconfig-r006-20230818   gcc  
csky                 randconfig-r012-20230818   gcc  
csky                 randconfig-r013-20230817   gcc  
csky                 randconfig-r034-20230817   gcc  
csky                 randconfig-r035-20230817   gcc  
hexagon              randconfig-r006-20230817   clang
hexagon              randconfig-r021-20230818   clang
hexagon              randconfig-r022-20230818   clang
hexagon              randconfig-r024-20230818   clang
hexagon              randconfig-r041-20230817   clang
hexagon              randconfig-r041-20230818   clang
hexagon              randconfig-r045-20230817   clang
hexagon              randconfig-r045-20230818   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230817   clang
i386         buildonly-randconfig-r004-20230818   gcc  
i386         buildonly-randconfig-r005-20230817   clang
i386         buildonly-randconfig-r005-20230818   gcc  
i386         buildonly-randconfig-r006-20230817   clang
i386         buildonly-randconfig-r006-20230818   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230817   clang
i386                 randconfig-i001-20230818   gcc  
i386                 randconfig-i002-20230817   clang
i386                 randconfig-i002-20230818   gcc  
i386                 randconfig-i003-20230817   clang
i386                 randconfig-i003-20230818   gcc  
i386                 randconfig-i004-20230817   clang
i386                 randconfig-i004-20230818   gcc  
i386                 randconfig-i005-20230817   clang
i386                 randconfig-i005-20230818   gcc  
i386                 randconfig-i006-20230817   clang
i386                 randconfig-i006-20230818   gcc  
i386                 randconfig-i011-20230817   gcc  
i386                 randconfig-i011-20230818   clang
i386                 randconfig-i012-20230817   gcc  
i386                 randconfig-i012-20230818   clang
i386                 randconfig-i013-20230817   gcc  
i386                 randconfig-i013-20230818   clang
i386                 randconfig-i014-20230817   gcc  
i386                 randconfig-i014-20230818   clang
i386                 randconfig-i015-20230817   gcc  
i386                 randconfig-i015-20230818   clang
i386                 randconfig-i016-20230817   gcc  
i386                 randconfig-i016-20230818   clang
i386                 randconfig-r003-20230817   clang
i386                 randconfig-r015-20230817   gcc  
i386                 randconfig-r022-20230818   clang
i386                 randconfig-r035-20230818   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230817   gcc  
loongarch            randconfig-r005-20230818   gcc  
loongarch            randconfig-r026-20230818   gcc  
loongarch            randconfig-r036-20230817   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230817   gcc  
m68k                 randconfig-r031-20230817   gcc  
microblaze                      mmu_defconfig   gcc  
microblaze           randconfig-r012-20230817   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r014-20230817   clang
mips                 randconfig-r016-20230817   clang
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230818   gcc  
nios2                randconfig-r006-20230818   gcc  
nios2                randconfig-r032-20230817   gcc  
openrisc             randconfig-r013-20230817   gcc  
openrisc             randconfig-r014-20230817   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230818   gcc  
parisc               randconfig-r025-20230817   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc              randconfig-r023-20230818   clang
powerpc              randconfig-r026-20230818   clang
powerpc              randconfig-r032-20230818   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230817   gcc  
riscv                randconfig-r022-20230817   gcc  
riscv                randconfig-r023-20230817   gcc  
riscv                randconfig-r023-20230818   clang
riscv                randconfig-r025-20230818   clang
riscv                randconfig-r042-20230817   gcc  
riscv                randconfig-r042-20230818   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230818   gcc  
s390                 randconfig-r036-20230818   gcc  
s390                 randconfig-r044-20230817   gcc  
s390                 randconfig-r044-20230818   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r004-20230818   gcc  
sh                   randconfig-r015-20230817   gcc  
sh                   randconfig-r025-20230818   gcc  
sh                   randconfig-r031-20230817   gcc  
sh                   randconfig-r034-20230818   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230817   gcc  
sparc64              randconfig-r001-20230818   gcc  
sparc64              randconfig-r004-20230818   gcc  
sparc64              randconfig-r014-20230818   gcc  
sparc64              randconfig-r016-20230818   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r011-20230817   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230817   clang
x86_64       buildonly-randconfig-r001-20230818   gcc  
x86_64       buildonly-randconfig-r002-20230817   clang
x86_64       buildonly-randconfig-r002-20230818   gcc  
x86_64       buildonly-randconfig-r003-20230817   clang
x86_64       buildonly-randconfig-r003-20230818   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r024-20230817   gcc  
x86_64               randconfig-r035-20230817   clang
x86_64               randconfig-x001-20230817   gcc  
x86_64               randconfig-x001-20230818   clang
x86_64               randconfig-x002-20230817   gcc  
x86_64               randconfig-x002-20230818   clang
x86_64               randconfig-x003-20230817   gcc  
x86_64               randconfig-x003-20230818   clang
x86_64               randconfig-x004-20230817   gcc  
x86_64               randconfig-x004-20230818   clang
x86_64               randconfig-x005-20230817   gcc  
x86_64               randconfig-x005-20230818   clang
x86_64               randconfig-x006-20230817   gcc  
x86_64               randconfig-x006-20230818   clang
x86_64               randconfig-x011-20230817   clang
x86_64               randconfig-x011-20230818   gcc  
x86_64               randconfig-x012-20230817   clang
x86_64               randconfig-x012-20230818   gcc  
x86_64               randconfig-x013-20230817   clang
x86_64               randconfig-x013-20230818   gcc  
x86_64               randconfig-x014-20230817   clang
x86_64               randconfig-x014-20230818   gcc  
x86_64               randconfig-x015-20230817   clang
x86_64               randconfig-x015-20230818   gcc  
x86_64               randconfig-x016-20230817   clang
x86_64               randconfig-x016-20230818   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r016-20230817   gcc  
xtensa               randconfig-r033-20230817   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
