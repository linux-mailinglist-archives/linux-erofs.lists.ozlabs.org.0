Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 693B777E8B9
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Aug 2023 20:30:08 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mRvOniUy;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQxWb1R6mz3bZr
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Aug 2023 04:30:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mRvOniUy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.93; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RQxWR0wyTz2ytZ
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Aug 2023 04:29:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692210595; x=1723746595;
  h=date:from:to:cc:subject:message-id;
  bh=wcnavk62CR+UhF4k76Upf4tU1xVUUw8VM7QGB2/ExoI=;
  b=mRvOniUyC+3iv6FkqDqOtcqyGdkwq1Ze5rdrsTJEVBgoCJxgQFbGwcq0
   qxz3F6cTQs3mgJgivVVciax3Atu+5XQVL7xSDEDUXaynbborTsqiGm80z
   16mm0zSWowzggZuTmjZPc+WTUJIp3PMfwKHcl1S+crezjLESOJ5LLUPsa
   fdaHhQb7qmbAmu/Q8tQEUmFY7dOuUICQAe05bBUybjsT7cZD1p98H2RhD
   3i0XS+OWiTS1jBudng0yGsKD4KXJULr+UnhnP/X4U9GADJdb71S13jG5b
   ZVRnOZ5ugE1al1cekD8EL7PEOKFoa4RKD7WoMg596IIVHplTGOnenPHWY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="370077386"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="370077386"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 11:29:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="737381866"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="737381866"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 16 Aug 2023 11:29:46 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qWLH7-0000Un-0S;
	Wed, 16 Aug 2023 18:29:45 +0000
Date: Thu, 17 Aug 2023 02:29:02 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 681352dc72c2dd4184e819ec88d1814232152d07
Message-ID: <202308170259.GKKDv0yv-lkp@intel.com>
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
branch HEAD: 681352dc72c2dd4184e819ec88d1814232152d07  erofs: remove redundant erofs_fs_type declaration in super.c

elapsed time: 727m

configs tested: 141
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230816   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                  randconfig-r026-20230817   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                        realview_defconfig   gcc  
arm                           sama7_defconfig   clang
arm                       spear13xx_defconfig   clang
arm                         wpcm450_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230816   clang
arm64                randconfig-r021-20230817   gcc  
arm64                randconfig-r026-20230816   clang
arm64                randconfig-r035-20230816   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r005-20230816   clang
hexagon              randconfig-r032-20230816   clang
hexagon              randconfig-r034-20230816   clang
hexagon              randconfig-r041-20230816   clang
hexagon              randconfig-r045-20230816   clang
i386                             alldefconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230816   gcc  
i386         buildonly-randconfig-r005-20230816   gcc  
i386         buildonly-randconfig-r006-20230816   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i011-20230816   clang
i386                 randconfig-i012-20230816   clang
i386                 randconfig-i013-20230816   clang
i386                 randconfig-i014-20230816   clang
i386                 randconfig-i015-20230816   clang
i386                 randconfig-i016-20230816   clang
i386                 randconfig-r022-20230816   clang
i386                 randconfig-r025-20230817   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230816   gcc  
loongarch            randconfig-r005-20230816   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                 randconfig-r004-20230816   gcc  
m68k                 randconfig-r012-20230816   gcc  
m68k                 randconfig-r016-20230816   gcc  
microblaze           randconfig-r002-20230816   gcc  
microblaze           randconfig-r005-20230816   gcc  
microblaze           randconfig-r011-20230816   gcc  
microblaze           randconfig-r033-20230816   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                     cu1000-neo_defconfig   gcc  
mips                 randconfig-r006-20230816   clang
mips                 randconfig-r036-20230816   clang
mips                           rs90_defconfig   clang
mips                         rt305x_defconfig   gcc  
mips                   sb1250_swarm_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r013-20230816   gcc  
nios2                randconfig-r034-20230816   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230816   gcc  
parisc               randconfig-r003-20230816   gcc  
parisc               randconfig-r006-20230816   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc                     ksi8560_defconfig   clang
powerpc                     mpc512x_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   gcc  
powerpc              randconfig-r026-20230816   clang
powerpc                     redwood_defconfig   gcc  
powerpc                      walnut_defconfig   clang
powerpc                 xes_mpc85xx_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230816   clang
riscv                randconfig-r042-20230816   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r021-20230816   clang
s390                 randconfig-r044-20230816   clang
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                   randconfig-r006-20230816   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230816   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r014-20230816   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230816   gcc  
x86_64       buildonly-randconfig-r002-20230816   gcc  
x86_64       buildonly-randconfig-r003-20230816   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r023-20230817   gcc  
x86_64               randconfig-x001-20230816   clang
x86_64               randconfig-x002-20230816   clang
x86_64               randconfig-x003-20230816   clang
x86_64               randconfig-x004-20230816   clang
x86_64               randconfig-x005-20230816   clang
x86_64               randconfig-x006-20230816   clang
x86_64               randconfig-x011-20230816   gcc  
x86_64               randconfig-x012-20230816   gcc  
x86_64               randconfig-x013-20230816   gcc  
x86_64               randconfig-x014-20230816   gcc  
x86_64               randconfig-x015-20230816   gcc  
x86_64               randconfig-x016-20230816   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                  nommu_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
