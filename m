Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCB47346FC
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Jun 2023 18:29:46 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W+jPRkNc;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qkddz15Tpz30PR
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jun 2023 02:29:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W+jPRkNc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qkddr14fXz2xq6
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jun 2023 02:29:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687105776; x=1718641776;
  h=date:from:to:cc:subject:message-id;
  bh=ILmCVS2DOFyOOj2Q1uIQDJMVzGXXtBohFHnNqcICyj4=;
  b=W+jPRkNcn7mGgICvkjCeWW35So3NhGhNLce0769fj2Us3UFrctugvR4B
   EtDdcgI4pzv8iQGOW3GMGIK2Jv9lNhL+yTrtLZczKDf+onDKvREYtIhSD
   fdkU/PPmnZdvKpLuxKYl3aEGi0hmfi/VJUD8soRCIaRay9QgpurHV47hr
   9e087ZWPfbtrdGCtNOAKfSjr/K4VXiyCU474BxzpXMGlln0kWUGo3IkJZ
   M3lJKunv4ymrPd2ZberKwKV2i1qHb+341Qc2cn3+Vl/fDSrlwRIbMXFmq
   PAuapWJGpraU0M80PllaszghKwPR6M8AzDzqZCWTs5LNM6SvfoSKMclMV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="344235446"
X-IronPort-AV: E=Sophos;i="6.00,252,1681196400"; 
   d="scan'208";a="344235446"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 09:29:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="826344632"
X-IronPort-AV: E=Sophos;i="6.00,252,1681196400"; 
   d="scan'208";a="826344632"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jun 2023 09:29:24 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qAvHH-0003sz-1S;
	Sun, 18 Jun 2023 16:29:23 +0000
Date: Mon, 19 Jun 2023 00:29:06 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 30a33dc4a7d1070eff3476e287aeceb9812a6124
Message-ID: <202306190004.siaYj7Zs-lkp@intel.com>
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
branch HEAD: 30a33dc4a7d1070eff3476e287aeceb9812a6124  erofs: clean up zmap.c

elapsed time: 722m

configs tested: 163
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r016-20230618   gcc  
alpha                randconfig-r022-20230618   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230618   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                                 defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                  randconfig-r046-20230618   clang
arm                        realview_defconfig   gcc  
arm                             rpc_defconfig   gcc  
arm                           sama7_defconfig   clang
arm                         wpcm450_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230618   clang
arm64                randconfig-r021-20230618   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230618   gcc  
hexagon                             defconfig   clang
hexagon              randconfig-r006-20230618   clang
hexagon              randconfig-r013-20230618   clang
hexagon              randconfig-r024-20230618   clang
hexagon              randconfig-r034-20230618   clang
hexagon              randconfig-r041-20230618   clang
hexagon              randconfig-r045-20230618   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230618   clang
i386         buildonly-randconfig-r005-20230618   clang
i386         buildonly-randconfig-r006-20230618   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230618   clang
i386                 randconfig-i002-20230618   clang
i386                 randconfig-i003-20230618   clang
i386                 randconfig-i004-20230618   clang
i386                 randconfig-i005-20230618   clang
i386                 randconfig-i006-20230618   clang
i386                 randconfig-i011-20230618   gcc  
i386                 randconfig-i012-20230618   gcc  
i386                 randconfig-i013-20230618   gcc  
i386                 randconfig-i014-20230618   gcc  
i386                 randconfig-i015-20230618   gcc  
i386                 randconfig-i016-20230618   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230618   gcc  
loongarch            randconfig-r016-20230618   gcc  
loongarch            randconfig-r025-20230618   gcc  
loongarch            randconfig-r032-20230618   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r004-20230618   gcc  
m68k                 randconfig-r011-20230618   gcc  
m68k                 randconfig-r026-20230618   gcc  
m68k                 randconfig-r032-20230618   gcc  
m68k                           virt_defconfig   gcc  
microblaze           randconfig-r022-20230618   gcc  
microblaze           randconfig-r031-20230618   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                       lemote2f_defconfig   clang
mips                 randconfig-r006-20230618   gcc  
mips                 randconfig-r013-20230618   clang
mips                 randconfig-r015-20230618   clang
mips                 randconfig-r026-20230618   clang
mips                 randconfig-r035-20230618   gcc  
mips                           xway_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r035-20230618   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230618   gcc  
parisc               randconfig-r023-20230618   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                   lite5200b_defconfig   clang
powerpc                     mpc512x_defconfig   clang
powerpc                  mpc885_ads_defconfig   clang
powerpc                      ppc40x_defconfig   gcc  
powerpc              randconfig-r033-20230618   clang
powerpc                     sequoia_defconfig   gcc  
powerpc                    socrates_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r031-20230618   clang
riscv                randconfig-r034-20230618   clang
riscv                randconfig-r036-20230618   clang
riscv                randconfig-r042-20230618   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230618   clang
s390                 randconfig-r024-20230618   gcc  
s390                 randconfig-r044-20230618   gcc  
sh                               allmodconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r001-20230618   gcc  
sh                   randconfig-r021-20230618   gcc  
sh                   randconfig-r023-20230618   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230618   gcc  
sparc                randconfig-r025-20230618   gcc  
sparc                randconfig-r033-20230618   gcc  
sparc                       sparc32_defconfig   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r011-20230618   clang
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230618   clang
x86_64       buildonly-randconfig-r002-20230618   clang
x86_64       buildonly-randconfig-r003-20230618   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230618   clang
x86_64               randconfig-a002-20230618   clang
x86_64               randconfig-a003-20230618   clang
x86_64               randconfig-a004-20230618   clang
x86_64               randconfig-a005-20230618   clang
x86_64               randconfig-a006-20230618   clang
x86_64               randconfig-a011-20230618   gcc  
x86_64               randconfig-a012-20230618   gcc  
x86_64               randconfig-a013-20230618   gcc  
x86_64               randconfig-a014-20230618   gcc  
x86_64               randconfig-a015-20230618   gcc  
x86_64               randconfig-a016-20230618   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
