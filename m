Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6662770CE31
	for <lists+linux-erofs@lfdr.de>; Tue, 23 May 2023 00:45:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QQCGK0VTkz3c9x
	for <lists+linux-erofs@lfdr.de>; Tue, 23 May 2023 08:45:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RoC9TIPc;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RoC9TIPc;
	dkim-atps=neutral
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QQCG92FM7z3bYW
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 May 2023 08:45:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684795537; x=1716331537;
  h=date:from:to:cc:subject:message-id;
  bh=s4sru/vFVk5txYgsYsni5qhxkSxmn6ItQMUh40eusKk=;
  b=RoC9TIPcFAkZVdWv1DhFEPSH2ma23l/avUD5JrwTrEgKRlFGVljOsBBZ
   R6qGFjcfccFPD9lnlkcJ7/sw4NSrv2LIdDZI0+h9JzSNWhePX1Dfynfvi
   O6ZFvXchcQhLczBrBxjrM+S9d+zczufJkEGzqF2D5c1xKItTA3fajzDmq
   5CEYO5fKqevh82XOxUrp1k8OBSuqWUqy6b/UizxcWgMOWJ3HXg/6c8fb8
   51I39AqYmQW9p9mf6o46w4yBYExDmPici/Vhijqjl8x3X0cGVVVQlK2XQ
   Um8vCizecN+07Q0WCNKpst9j6u7L5FGVVUZDpH0UW2o9UEJItBf7Hv/rd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="333426627"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="333426627"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 15:45:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="736594002"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="736594002"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 May 2023 15:45:26 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q1EHN-000DHa-22;
	Mon, 22 May 2023 22:45:25 +0000
Date: Tue, 23 May 2023 06:45:02 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 040fe4eee2f91fdfea6306489bbbda1cf33f9151
Message-ID: <20230522224502.kszsI%lkp@intel.com>
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

tree/branch: INFO setup_repo_specs: /db/releases/20230522162832/lkp-src/repo/*/xiang-erofs
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 040fe4eee2f91fdfea6306489bbbda1cf33f9151  erofs: use HIPRI by default if per-cpu kthreads are enabled

elapsed time: 724m

configs tested: 246
configs skipped: 19

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230521   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230522   gcc  
alpha                randconfig-r013-20230521   gcc  
alpha                randconfig-r025-20230521   gcc  
alpha                randconfig-r025-20230522   gcc  
alpha                randconfig-r036-20230522   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r013-20230521   gcc  
arc                  randconfig-r014-20230521   gcc  
arc                  randconfig-r026-20230521   gcc  
arc                  randconfig-r043-20230521   gcc  
arc                  randconfig-r043-20230522   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                  randconfig-r024-20230522   gcc  
arm                  randconfig-r046-20230521   clang
arm                  randconfig-r046-20230522   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230521   clang
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230521   clang
arm64                randconfig-r011-20230522   clang
arm64                randconfig-r022-20230522   clang
arm64                randconfig-r023-20230521   gcc  
arm64                randconfig-r033-20230521   clang
csky         buildonly-randconfig-r004-20230522   gcc  
csky         buildonly-randconfig-r006-20230522   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r012-20230521   gcc  
csky                 randconfig-r014-20230521   gcc  
csky                 randconfig-r023-20230522   gcc  
csky                 randconfig-r025-20230521   gcc  
csky                 randconfig-r026-20230521   gcc  
csky                 randconfig-r026-20230522   gcc  
csky                 randconfig-r031-20230521   gcc  
csky                 randconfig-r031-20230522   gcc  
csky                 randconfig-r032-20230522   gcc  
csky                 randconfig-r035-20230521   gcc  
hexagon              randconfig-r003-20230521   clang
hexagon              randconfig-r032-20230521   clang
hexagon              randconfig-r041-20230521   clang
hexagon              randconfig-r041-20230522   clang
hexagon              randconfig-r045-20230521   clang
hexagon              randconfig-r045-20230522   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230522   gcc  
i386                 randconfig-a002-20230522   gcc  
i386                 randconfig-a003-20230522   gcc  
i386                 randconfig-a004-20230522   gcc  
i386                 randconfig-a005-20230522   gcc  
i386                 randconfig-a006-20230522   gcc  
i386                 randconfig-a011-20230522   clang
i386                 randconfig-a012-20230522   clang
i386                 randconfig-a013-20230522   clang
i386                 randconfig-a014-20230522   clang
i386                 randconfig-a015-20230522   clang
i386                 randconfig-a016-20230522   clang
i386                 randconfig-r033-20230522   gcc  
i386                 randconfig-r036-20230522   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r003-20230522   gcc  
ia64         buildonly-randconfig-r006-20230521   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r006-20230521   gcc  
ia64                 randconfig-r013-20230522   gcc  
ia64                 randconfig-r016-20230521   gcc  
ia64                 randconfig-r021-20230521   gcc  
ia64                 randconfig-r023-20230521   gcc  
ia64                 randconfig-r025-20230522   gcc  
ia64                          tiger_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230522   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230521   gcc  
loongarch            randconfig-r005-20230521   gcc  
loongarch            randconfig-r005-20230522   gcc  
loongarch            randconfig-r011-20230521   gcc  
loongarch            randconfig-r012-20230522   gcc  
loongarch            randconfig-r022-20230522   gcc  
loongarch            randconfig-r034-20230521   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r011-20230522   gcc  
m68k                 randconfig-r036-20230522   gcc  
microblaze   buildonly-randconfig-r001-20230521   gcc  
microblaze           randconfig-r004-20230521   gcc  
microblaze           randconfig-r014-20230522   gcc  
microblaze           randconfig-r021-20230521   gcc  
microblaze           randconfig-r034-20230521   gcc  
microblaze           randconfig-r036-20230521   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                 randconfig-r004-20230522   clang
mips                 randconfig-r015-20230521   clang
mips                 randconfig-r031-20230521   gcc  
mips                 randconfig-r032-20230521   gcc  
mips                 randconfig-r036-20230521   gcc  
nios2        buildonly-randconfig-r004-20230521   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230522   gcc  
nios2                randconfig-r005-20230521   gcc  
nios2                randconfig-r016-20230521   gcc  
nios2                randconfig-r016-20230522   gcc  
nios2                randconfig-r021-20230522   gcc  
nios2                randconfig-r026-20230522   gcc  
nios2                randconfig-r032-20230522   gcc  
openrisc     buildonly-randconfig-r003-20230521   gcc  
openrisc             randconfig-r015-20230522   gcc  
openrisc             randconfig-r032-20230521   gcc  
parisc       buildonly-randconfig-r001-20230521   gcc  
parisc       buildonly-randconfig-r001-20230522   gcc  
parisc       buildonly-randconfig-r004-20230522   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r013-20230522   gcc  
parisc               randconfig-r023-20230521   gcc  
parisc               randconfig-r024-20230522   gcc  
parisc               randconfig-r036-20230521   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc                      ppc40x_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc              randconfig-r001-20230522   gcc  
powerpc              randconfig-r006-20230521   clang
powerpc              randconfig-r012-20230521   gcc  
powerpc              randconfig-r015-20230522   clang
powerpc              randconfig-r022-20230521   gcc  
powerpc              randconfig-r024-20230521   gcc  
powerpc              randconfig-r032-20230522   gcc  
powerpc              randconfig-r034-20230521   clang
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r004-20230521   gcc  
riscv        buildonly-randconfig-r005-20230522   clang
riscv        buildonly-randconfig-r006-20230522   clang
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230522   gcc  
riscv                randconfig-r021-20230522   clang
riscv                randconfig-r024-20230522   clang
riscv                randconfig-r035-20230521   clang
riscv                randconfig-r042-20230521   gcc  
riscv                randconfig-r042-20230522   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r006-20230521   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r006-20230522   gcc  
s390                 randconfig-r021-20230521   gcc  
s390                 randconfig-r033-20230522   gcc  
s390                 randconfig-r035-20230522   gcc  
s390                 randconfig-r044-20230521   gcc  
s390                 randconfig-r044-20230522   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230521   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r002-20230522   gcc  
sh                   randconfig-r014-20230522   gcc  
sh                   randconfig-r034-20230522   gcc  
sh                   randconfig-r035-20230522   gcc  
sh                          sdk7786_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230521   gcc  
sparc                randconfig-r013-20230521   gcc  
sparc                randconfig-r015-20230521   gcc  
sparc                randconfig-r022-20230522   gcc  
sparc                randconfig-r025-20230521   gcc  
sparc                randconfig-r033-20230521   gcc  
sparc                randconfig-r034-20230522   gcc  
sparc                randconfig-r035-20230522   gcc  
sparc64      buildonly-randconfig-r002-20230522   gcc  
sparc64      buildonly-randconfig-r003-20230522   gcc  
sparc64              randconfig-r005-20230522   gcc  
sparc64              randconfig-r012-20230522   gcc  
sparc64              randconfig-r023-20230522   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230522   gcc  
x86_64               randconfig-a002-20230522   gcc  
x86_64               randconfig-a003-20230522   gcc  
x86_64               randconfig-a004-20230522   gcc  
x86_64               randconfig-a005-20230522   gcc  
x86_64               randconfig-a006-20230522   gcc  
x86_64               randconfig-a011-20230522   clang
x86_64               randconfig-a012-20230522   clang
x86_64               randconfig-a013-20230522   clang
x86_64               randconfig-a014-20230522   clang
x86_64               randconfig-a015-20230522   clang
x86_64               randconfig-a016-20230522   clang
x86_64                        randconfig-k001   clang
x86_64               randconfig-r015-20230522   clang
x86_64               randconfig-x051-20230522   clang
x86_64               randconfig-x052-20230522   clang
x86_64               randconfig-x053-20230522   clang
x86_64               randconfig-x054-20230522   clang
x86_64               randconfig-x055-20230522   clang
x86_64               randconfig-x056-20230522   clang
x86_64               randconfig-x061-20230522   clang
x86_64               randconfig-x062-20230522   clang
x86_64               randconfig-x063-20230522   clang
x86_64               randconfig-x064-20230522   clang
x86_64               randconfig-x065-20230522   clang
x86_64               randconfig-x066-20230522   clang
x86_64               randconfig-x071-20230522   gcc  
x86_64               randconfig-x072-20230522   gcc  
x86_64               randconfig-x073-20230522   gcc  
x86_64               randconfig-x074-20230522   gcc  
x86_64               randconfig-x075-20230522   gcc  
x86_64               randconfig-x076-20230522   gcc  
x86_64               randconfig-x081-20230522   gcc  
x86_64               randconfig-x082-20230522   gcc  
x86_64               randconfig-x083-20230522   gcc  
x86_64               randconfig-x084-20230522   gcc  
x86_64               randconfig-x085-20230522   gcc  
x86_64               randconfig-x086-20230522   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230522   gcc  
xtensa       buildonly-randconfig-r005-20230521   gcc  
xtensa               randconfig-r002-20230521   gcc  
xtensa               randconfig-r003-20230522   gcc  
xtensa               randconfig-r004-20230521   gcc  
xtensa               randconfig-r004-20230522   gcc  
xtensa               randconfig-r016-20230521   gcc  
xtensa               randconfig-r024-20230521   gcc  
xtensa               randconfig-r031-20230522   gcc  
xtensa               randconfig-r033-20230521   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
