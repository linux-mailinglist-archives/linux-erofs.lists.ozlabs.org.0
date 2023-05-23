Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A99B70E8AE
	for <lists+linux-erofs@lfdr.de>; Wed, 24 May 2023 00:14:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QQpXF0lcKz3c34
	for <lists+linux-erofs@lfdr.de>; Wed, 24 May 2023 08:14:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZGT7e4NY;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZGT7e4NY;
	dkim-atps=neutral
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QQpX53fD1z30CT
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 May 2023 08:14:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684880085; x=1716416085;
  h=date:from:to:cc:subject:message-id;
  bh=guxXtME5RY/ljTC/E4w3mcgsG5+5wHeGI7DMU94RIHY=;
  b=ZGT7e4NYCC7Mp3FFGjGfsYhEbzbXQt87yaHpLFZVt5xTrqy7wCbHTyrX
   LFHYbb/+Ez/KyYovZW2NHHTClq+Tz7SjshPgjPS71FQq1ZfLKrRaBy3J3
   NBD2GwNQNhf4Fdy7ugYGBa082iOBpmJrpK3aOhw4mAEbzMbM2gv5Rmm82
   XPy/3mz1C/1G3FV5B1eNtpZw7+tFi99+Wbd/RGenXzn34JJTE4dBpjit0
   qQNQ1scS15mmXp9hfUGeqvq8MEwA2pjKV2pE+m5obt+juxO+piHvOHeIy
   6hYSacPwXChv71dMposOVxYv694h0bATQOPWpYCevyHwSyN71OTvbxya/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="352220768"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="352220768"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 15:14:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="773967149"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="773967149"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 May 2023 15:14:34 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q1aH3-000E9H-33;
	Tue, 23 May 2023 22:14:33 +0000
Date: Wed, 24 May 2023 06:13:40 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 cf7f2732b4b83026842832e7e4e04bf862108ac2
Message-ID: <20230523221340.MV6ag%lkp@intel.com>
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

tree/branch: INFO setup_repo_specs: /db/releases/20230524001904/lkp-src/repo/*/xiang-erofs
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: cf7f2732b4b83026842832e7e4e04bf862108ac2  erofs: use HIPRI by default if per-cpu kthreads are enabled

elapsed time: 732m

configs tested: 237
configs skipped: 25

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230521   gcc  
alpha        buildonly-randconfig-r006-20230521   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230522   gcc  
alpha                randconfig-r011-20230522   gcc  
alpha                randconfig-r013-20230521   gcc  
alpha                randconfig-r013-20230523   gcc  
alpha                randconfig-r014-20230523   gcc  
alpha                randconfig-r022-20230522   gcc  
alpha                randconfig-r023-20230523   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230522   gcc  
arc          buildonly-randconfig-r004-20230522   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230521   gcc  
arc                  randconfig-r014-20230521   gcc  
arc                  randconfig-r015-20230521   gcc  
arc                  randconfig-r024-20230523   gcc  
arc                  randconfig-r043-20230521   gcc  
arc                  randconfig-r043-20230522   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                  randconfig-r003-20230521   gcc  
arm                  randconfig-r035-20230521   gcc  
arm                  randconfig-r036-20230521   gcc  
arm                  randconfig-r046-20230521   clang
arm                  randconfig-r046-20230522   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230521   clang
arm64                randconfig-r011-20230523   gcc  
arm64                randconfig-r016-20230522   clang
arm64                randconfig-r021-20230522   clang
arm64                randconfig-r034-20230522   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230521   gcc  
csky                 randconfig-r012-20230521   gcc  
hexagon              randconfig-r014-20230522   clang
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
i386                 randconfig-i051-20230523   clang
i386                 randconfig-i052-20230523   clang
i386                 randconfig-i053-20230523   clang
i386                 randconfig-i054-20230523   clang
i386                 randconfig-i055-20230523   clang
i386                 randconfig-i056-20230523   clang
i386                 randconfig-i061-20230523   clang
i386                 randconfig-i062-20230523   clang
i386                 randconfig-i063-20230523   clang
i386                 randconfig-i064-20230523   clang
i386                 randconfig-i065-20230523   clang
i386                 randconfig-i066-20230523   clang
i386                 randconfig-r004-20230522   gcc  
i386                 randconfig-r011-20230522   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r003-20230522   gcc  
ia64         buildonly-randconfig-r006-20230521   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230521   gcc  
ia64                 randconfig-r013-20230522   gcc  
ia64                 randconfig-r015-20230523   gcc  
ia64                 randconfig-r016-20230521   gcc  
ia64                 randconfig-r022-20230523   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230522   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230521   gcc  
loongarch            randconfig-r012-20230522   gcc  
loongarch            randconfig-r012-20230523   gcc  
loongarch            randconfig-r032-20230521   gcc  
loongarch            randconfig-r033-20230522   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230521   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                 randconfig-r014-20230522   gcc  
m68k                 randconfig-r034-20230521   gcc  
microblaze   buildonly-randconfig-r006-20230522   gcc  
microblaze           randconfig-r016-20230521   gcc  
microblaze           randconfig-r035-20230521   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230522   clang
mips         buildonly-randconfig-r004-20230521   gcc  
mips         buildonly-randconfig-r006-20230521   gcc  
mips                           jazz_defconfig   gcc  
mips                 randconfig-r016-20230523   clang
nios2                               defconfig   gcc  
nios2                randconfig-r031-20230522   gcc  
nios2                randconfig-r032-20230521   gcc  
nios2                randconfig-r033-20230521   gcc  
nios2                randconfig-r035-20230522   gcc  
openrisc     buildonly-randconfig-r003-20230521   gcc  
openrisc             randconfig-r014-20230522   gcc  
openrisc             randconfig-r015-20230522   gcc  
parisc       buildonly-randconfig-r001-20230521   gcc  
parisc       buildonly-randconfig-r004-20230522   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230521   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230521   gcc  
powerpc      buildonly-randconfig-r004-20230522   clang
powerpc              randconfig-r004-20230522   gcc  
powerpc              randconfig-r006-20230522   gcc  
powerpc              randconfig-r013-20230522   clang
powerpc              randconfig-r026-20230522   clang
powerpc              randconfig-r033-20230521   clang
powerpc                     tqm8541_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230522   clang
riscv        buildonly-randconfig-r004-20230521   gcc  
riscv        buildonly-randconfig-r005-20230522   clang
riscv        buildonly-randconfig-r006-20230522   clang
riscv                               defconfig   gcc  
riscv                randconfig-r024-20230522   clang
riscv                randconfig-r042-20230521   gcc  
riscv                randconfig-r042-20230522   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230521   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r011-20230521   gcc  
s390                 randconfig-r013-20230521   gcc  
s390                 randconfig-r034-20230522   gcc  
s390                 randconfig-r044-20230521   gcc  
s390                 randconfig-r044-20230522   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230521   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r002-20230522   gcc  
sh                   randconfig-r003-20230522   gcc  
sh                   randconfig-r006-20230521   gcc  
sh                   randconfig-r015-20230521   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r012-20230521   gcc  
sparc                randconfig-r015-20230522   gcc  
sparc                randconfig-r035-20230522   gcc  
sparc                randconfig-r036-20230522   gcc  
sparc64      buildonly-randconfig-r002-20230522   gcc  
sparc64      buildonly-randconfig-r003-20230522   gcc  
sparc64      buildonly-randconfig-r005-20230521   gcc  
sparc64      buildonly-randconfig-r006-20230522   gcc  
sparc64              randconfig-r001-20230522   gcc  
sparc64              randconfig-r015-20230522   gcc  
sparc64              randconfig-r016-20230521   gcc  
sparc64              randconfig-r031-20230521   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r005-20230522   gcc  
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
x86_64               randconfig-r013-20230522   clang
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
x86_64               randconfig-x091-20230523   gcc  
x86_64               randconfig-x092-20230523   gcc  
x86_64               randconfig-x093-20230523   gcc  
x86_64               randconfig-x094-20230523   gcc  
x86_64               randconfig-x095-20230523   gcc  
x86_64               randconfig-x096-20230523   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230522   gcc  
xtensa       buildonly-randconfig-r005-20230521   gcc  
xtensa               randconfig-r001-20230521   gcc  
xtensa               randconfig-r003-20230522   gcc  
xtensa               randconfig-r013-20230521   gcc  
xtensa               randconfig-r023-20230522   gcc  
xtensa               randconfig-r025-20230522   gcc  
xtensa               randconfig-r025-20230523   gcc  
xtensa               randconfig-r026-20230523   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
