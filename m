Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 145E9759AC9
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jul 2023 18:31:58 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=et5uIZJv;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R5hDC6rQxz2yw4
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jul 2023 02:31:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=et5uIZJv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R5hD514fdz2yVX
	for <linux-erofs@lists.ozlabs.org>; Thu, 20 Jul 2023 02:31:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689784309; x=1721320309;
  h=date:from:to:cc:subject:message-id;
  bh=vTRS3y1xo/xebsC8KUweJvuDGaQkCCOP/JzaKyR2oVg=;
  b=et5uIZJvCudst5vZAy92GfClTCLrM7dOUOn7+sIBwH8wBpoz+WWOR27K
   UI/hVpWB1Y7ARLhphjbvNqzsdpUKRNeM1qqJbxeCN7MyCbO1Cgf6DRoWe
   Bxvydax0Rjm0uQrnyue0Cl884F0sFFlZbyZAAiq34WrQbh65SWH6WWlnG
   zkxADcog477I8t14GTY4aO61WoTwjlk4G9/yDZ2mkf4oUh6CCWKvrkv17
   VG1JIGLoC0WsdFJnNVIob3stX8PypJ+bGsziNRP2mT561L1Zje4+d+zen
   p9o7DEUWeqqV2Y25p/1jNKdFCvmhwEOM+tahDsdMAmiQ+mFYP0H4ODkPC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="430284186"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="430284186"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 09:31:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="789478225"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="789478225"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jul 2023 09:31:35 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qMA5J-0005Cp-1l;
	Wed, 19 Jul 2023 16:31:35 +0000
Date: Thu, 20 Jul 2023 00:21:37 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 72cd679f2a828645beb7090badcc32de9cac74a5
Message-ID: <202307200036.h8oPzJPr-lkp@intel.com>
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
branch HEAD: 72cd679f2a828645beb7090badcc32de9cac74a5  erofs: deprecate superblock checksum feature

elapsed time: 1714m

configs tested: 155
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r031-20230718   gcc  
arc                  randconfig-r043-20230718   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                                 defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                           omap1_defconfig   clang
arm                          pxa3xx_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                  randconfig-r046-20230718   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r036-20230718   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r016-20230718   gcc  
csky                 randconfig-r034-20230718   gcc  
hexagon              randconfig-r024-20230718   clang
hexagon              randconfig-r034-20230718   clang
hexagon              randconfig-r041-20230718   clang
hexagon              randconfig-r045-20230718   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230718   gcc  
i386         buildonly-randconfig-r005-20230718   gcc  
i386         buildonly-randconfig-r006-20230718   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230718   gcc  
i386                 randconfig-i002-20230718   gcc  
i386                 randconfig-i003-20230718   gcc  
i386                 randconfig-i004-20230718   gcc  
i386                 randconfig-i005-20230718   gcc  
i386                 randconfig-i006-20230718   gcc  
i386                 randconfig-i011-20230718   clang
i386                 randconfig-i012-20230718   clang
i386                 randconfig-i013-20230718   clang
i386                 randconfig-i014-20230718   clang
i386                 randconfig-i015-20230718   clang
i386                 randconfig-i016-20230718   clang
i386                 randconfig-r002-20230718   gcc  
i386                 randconfig-r015-20230718   clang
i386                 randconfig-r022-20230718   clang
i386                 randconfig-r026-20230718   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r031-20230718   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                 randconfig-r002-20230718   gcc  
m68k                 randconfig-r021-20230718   gcc  
microblaze           randconfig-r023-20230718   gcc  
microblaze           randconfig-r033-20230718   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   clang
mips                           ip22_defconfig   clang
mips                 randconfig-r004-20230718   clang
mips                 randconfig-r023-20230718   gcc  
nios2                            alldefconfig   gcc  
nios2                               defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r022-20230718   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                     kilauea_defconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                    mvme5100_defconfig   clang
powerpc              randconfig-r005-20230718   gcc  
powerpc              randconfig-r006-20230718   gcc  
powerpc              randconfig-r036-20230718   gcc  
powerpc                     tqm8540_defconfig   clang
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r013-20230718   clang
riscv                randconfig-r016-20230718   clang
riscv                randconfig-r042-20230718   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r006-20230718   gcc  
s390                 randconfig-r044-20230718   clang
sh                               allmodconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                         microdev_defconfig   gcc  
sh                   randconfig-r001-20230718   gcc  
sh                   randconfig-r025-20230718   gcc  
sh                   randconfig-r033-20230718   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r024-20230718   gcc  
sparc64              randconfig-r001-20230718   gcc  
sparc64              randconfig-r004-20230718   gcc  
sparc64              randconfig-r011-20230718   gcc  
sparc64              randconfig-r036-20230718   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r026-20230718   gcc  
um                   randconfig-r031-20230718   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230718   gcc  
x86_64       buildonly-randconfig-r002-20230718   gcc  
x86_64       buildonly-randconfig-r003-20230718   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r005-20230718   gcc  
x86_64               randconfig-r012-20230718   clang
x86_64               randconfig-r014-20230718   clang
x86_64               randconfig-r032-20230718   gcc  
x86_64               randconfig-x001-20230718   clang
x86_64               randconfig-x002-20230718   clang
x86_64               randconfig-x003-20230718   clang
x86_64               randconfig-x004-20230718   clang
x86_64               randconfig-x005-20230718   clang
x86_64               randconfig-x006-20230718   clang
x86_64               randconfig-x011-20230718   gcc  
x86_64               randconfig-x012-20230718   gcc  
x86_64               randconfig-x013-20230718   gcc  
x86_64               randconfig-x014-20230718   gcc  
x86_64               randconfig-x015-20230718   gcc  
x86_64               randconfig-x016-20230718   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r006-20230718   gcc  
xtensa               randconfig-r034-20230718   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
