Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960FE705208
	for <lists+linux-erofs@lfdr.de>; Tue, 16 May 2023 17:24:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QLKm32yg8z3f6t
	for <lists+linux-erofs@lfdr.de>; Wed, 17 May 2023 01:24:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CquXu5a2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CquXu5a2;
	dkim-atps=neutral
X-Greylist: delayed 64 seconds by postgrey-1.36 at boromir; Wed, 17 May 2023 01:24:30 AEST
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QLKly6NMHz3bT7
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 May 2023 01:24:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684250671; x=1715786671;
  h=date:from:to:cc:subject:message-id;
  bh=gSNNUhZZe7K6oaHNEtud9gwuStpyIAMqYwqi2h1cpLk=;
  b=CquXu5a2JKD0nkPRzPaSfIceyaJr/M38OQACxZaZZootLG4ECZ6mCX1F
   44IEWYt0st7e/4eVvS3A673xzKHyoNkBEhCTnyenTO1EJLL1HLBLEw+v6
   y1SUlzY7PEytX0ZRjkLfzw661pagRpix4x0+VP7hKSUdVaUnYBiDQ2/6Y
   ZHLd7l9mMqdoRdN3ND5Yg1tM0JFEcgR5xzBKY42Ew8UaL00ZW2BUJ4r8q
   DZZEScIJr/2VSk83p3r/ok+2wHLcqy9vGLANF0JdNU0GQ74h3DJq00X4I
   7rHQHmniPBeMgYwixJY8DY6ZpbKsvZpuyEJdk5fF//DlX3tHx9Zuj6MXy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="414914063"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="414914063"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 08:23:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="875678287"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="875678287"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 May 2023 08:23:20 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pywWF-0007Xf-34;
	Tue, 16 May 2023 15:23:19 +0000
Date: Tue, 16 May 2023 23:23:11 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 ae0bac79926330a0b0f25649079ba935d9be0194
Message-ID: <20230516152311.eTq97%lkp@intel.com>
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

tree/branch: INFO setup_repo_specs: /db/releases/20230516180935/lkp-src/repo/*/xiang-erofs
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: ae0bac79926330a0b0f25649079ba935d9be0194  erofs: avoid pcpubuf.c inclusion if CONFIG_EROFS_FS_ZIP is off

elapsed time: 727m

configs tested: 397
configs skipped: 27

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230515   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230516   gcc  
alpha                randconfig-r013-20230516   gcc  
alpha                randconfig-r021-20230515   gcc  
alpha                randconfig-r025-20230515   gcc  
alpha                randconfig-r032-20230515   gcc  
alpha                randconfig-r033-20230516   gcc  
alpha                randconfig-r034-20230515   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230515   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230515   gcc  
arc                  randconfig-r015-20230515   gcc  
arc                  randconfig-r015-20230516   gcc  
arc                  randconfig-r016-20230515   gcc  
arc                  randconfig-r022-20230515   gcc  
arc                  randconfig-r022-20230516   gcc  
arc                  randconfig-r025-20230515   gcc  
arc                  randconfig-r032-20230515   gcc  
arc                  randconfig-r043-20230515   gcc  
arc                  randconfig-r043-20230516   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm          buildonly-randconfig-r005-20230516   gcc  
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                           imxrt_defconfig   gcc  
arm                  randconfig-r001-20230515   gcc  
arm                  randconfig-r002-20230515   gcc  
arm                  randconfig-r004-20230515   gcc  
arm                  randconfig-r025-20230515   clang
arm                  randconfig-r033-20230515   gcc  
arm                  randconfig-r046-20230516   gcc  
arm                           spitz_defconfig   clang
arm                       versatile_defconfig   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230515   clang
arm64        buildonly-randconfig-r005-20230515   clang
arm64        buildonly-randconfig-r006-20230516   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230516   gcc  
arm64                randconfig-r006-20230515   clang
arm64                randconfig-r014-20230515   gcc  
arm64                randconfig-r022-20230515   gcc  
arm64                randconfig-r024-20230516   clang
csky         buildonly-randconfig-r001-20230515   gcc  
csky         buildonly-randconfig-r002-20230515   gcc  
csky         buildonly-randconfig-r003-20230515   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230516   gcc  
csky                 randconfig-r004-20230515   gcc  
csky                 randconfig-r012-20230516   gcc  
csky                 randconfig-r013-20230515   gcc  
csky                 randconfig-r022-20230515   gcc  
csky                 randconfig-r031-20230515   gcc  
csky                 randconfig-r036-20230515   gcc  
hexagon      buildonly-randconfig-r004-20230515   clang
hexagon              randconfig-r021-20230515   clang
hexagon              randconfig-r023-20230515   clang
hexagon              randconfig-r025-20230516   clang
hexagon              randconfig-r026-20230516   clang
hexagon              randconfig-r033-20230515   clang
hexagon              randconfig-r041-20230516   clang
hexagon              randconfig-r045-20230516   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r005-20230515   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230515   clang
i386                 randconfig-a002-20230515   clang
i386                          randconfig-a002   clang
i386                 randconfig-a003-20230515   clang
i386                 randconfig-a004-20230515   clang
i386                          randconfig-a004   clang
i386                 randconfig-a005-20230515   clang
i386                 randconfig-a006-20230515   clang
i386                          randconfig-a006   clang
i386                 randconfig-a011-20230515   gcc  
i386                 randconfig-a012-20230515   gcc  
i386                 randconfig-a013-20230515   gcc  
i386                 randconfig-a014-20230515   gcc  
i386                 randconfig-a015-20230515   gcc  
i386                 randconfig-a016-20230515   gcc  
i386                 randconfig-i051-20230515   clang
i386                 randconfig-i052-20230515   clang
i386                          randconfig-i052   clang
i386                 randconfig-i053-20230515   clang
i386                 randconfig-i054-20230515   clang
i386                          randconfig-i054   clang
i386                 randconfig-i055-20230515   clang
i386                 randconfig-i056-20230515   clang
i386                          randconfig-i056   clang
i386                 randconfig-i061-20230515   clang
i386                 randconfig-i062-20230515   clang
i386                          randconfig-i062   clang
i386                 randconfig-i063-20230515   clang
i386                 randconfig-i064-20230515   clang
i386                          randconfig-i064   clang
i386                 randconfig-i065-20230515   clang
i386                 randconfig-i066-20230515   clang
i386                          randconfig-i066   clang
i386                 randconfig-i071-20230515   gcc  
i386                          randconfig-i071   clang
i386                 randconfig-i072-20230515   gcc  
i386                 randconfig-i073-20230515   gcc  
i386                          randconfig-i073   clang
i386                 randconfig-i074-20230515   gcc  
i386                 randconfig-i075-20230515   gcc  
i386                          randconfig-i075   clang
i386                 randconfig-i076-20230515   gcc  
i386                 randconfig-i081-20230515   gcc  
i386                 randconfig-i082-20230515   gcc  
i386                          randconfig-i082   clang
i386                 randconfig-i083-20230515   gcc  
i386                 randconfig-i084-20230515   gcc  
i386                          randconfig-i084   clang
i386                 randconfig-i085-20230515   gcc  
i386                 randconfig-i086-20230515   gcc  
i386                          randconfig-i086   clang
i386                 randconfig-i091-20230515   clang
i386                 randconfig-i092-20230515   clang
i386                 randconfig-i093-20230515   clang
i386                 randconfig-i094-20230515   clang
i386                 randconfig-i095-20230515   clang
i386                 randconfig-i096-20230515   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230516   gcc  
ia64         buildonly-randconfig-r002-20230516   gcc  
ia64         buildonly-randconfig-r003-20230515   gcc  
ia64         buildonly-randconfig-r004-20230515   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230515   gcc  
ia64                 randconfig-r011-20230515   gcc  
ia64                 randconfig-r011-20230516   gcc  
ia64                 randconfig-r013-20230515   gcc  
ia64                 randconfig-r015-20230515   gcc  
ia64                 randconfig-r024-20230516   gcc  
ia64                 randconfig-r032-20230516   gcc  
ia64                 randconfig-r036-20230516   gcc  
ia64                            zx1_defconfig   gcc  
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230516   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230516   gcc  
loongarch            randconfig-r002-20230515   gcc  
loongarch            randconfig-r011-20230515   gcc  
loongarch            randconfig-r023-20230516   gcc  
loongarch            randconfig-r024-20230515   gcc  
loongarch            randconfig-r031-20230515   gcc  
loongarch            randconfig-r033-20230515   gcc  
loongarch            randconfig-r035-20230515   gcc  
loongarch            randconfig-r035-20230516   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230515   gcc  
m68k         buildonly-randconfig-r002-20230516   gcc  
m68k         buildonly-randconfig-r004-20230515   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230516   gcc  
m68k                 randconfig-r005-20230515   gcc  
m68k                 randconfig-r016-20230515   gcc  
m68k                 randconfig-r022-20230515   gcc  
m68k                 randconfig-r023-20230515   gcc  
m68k                 randconfig-r026-20230515   gcc  
m68k                 randconfig-r032-20230516   gcc  
m68k                 randconfig-r033-20230515   gcc  
m68k                 randconfig-r034-20230515   gcc  
m68k                 randconfig-r035-20230516   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze   buildonly-randconfig-r006-20230516   gcc  
microblaze           randconfig-r002-20230516   gcc  
microblaze           randconfig-r004-20230516   gcc  
microblaze           randconfig-r005-20230515   gcc  
microblaze           randconfig-r014-20230515   gcc  
microblaze           randconfig-r021-20230515   gcc  
microblaze           randconfig-r036-20230516   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                       bmips_be_defconfig   gcc  
mips         buildonly-randconfig-r004-20230515   gcc  
mips         buildonly-randconfig-r006-20230515   gcc  
mips                 randconfig-r022-20230515   clang
mips                 randconfig-r035-20230515   gcc  
mips                           rs90_defconfig   clang
nios2        buildonly-randconfig-r003-20230516   gcc  
nios2        buildonly-randconfig-r005-20230515   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230516   gcc  
nios2                randconfig-r021-20230515   gcc  
nios2                randconfig-r022-20230515   gcc  
nios2                randconfig-r023-20230515   gcc  
nios2                randconfig-r024-20230515   gcc  
nios2                randconfig-r025-20230515   gcc  
nios2                randconfig-r026-20230515   gcc  
nios2                randconfig-r033-20230515   gcc  
nios2                randconfig-r034-20230515   gcc  
openrisc     buildonly-randconfig-r003-20230515   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r004-20230515   gcc  
openrisc             randconfig-r006-20230516   gcc  
openrisc             randconfig-r014-20230515   gcc  
openrisc             randconfig-r015-20230515   gcc  
openrisc             randconfig-r023-20230515   gcc  
openrisc             randconfig-r033-20230516   gcc  
openrisc             randconfig-r036-20230515   gcc  
openrisc                       virt_defconfig   gcc  
parisc       buildonly-randconfig-r001-20230515   gcc  
parisc       buildonly-randconfig-r004-20230515   gcc  
parisc       buildonly-randconfig-r005-20230515   gcc  
parisc       buildonly-randconfig-r006-20230515   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r006-20230516   gcc  
parisc               randconfig-r012-20230516   gcc  
parisc               randconfig-r021-20230515   gcc  
parisc               randconfig-r026-20230515   gcc  
parisc               randconfig-r026-20230516   gcc  
parisc               randconfig-r031-20230516   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       ebony_defconfig   clang
powerpc                        fsp2_defconfig   clang
powerpc                   microwatt_defconfig   clang
powerpc                 mpc836x_rdk_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc              randconfig-r001-20230515   clang
powerpc              randconfig-r002-20230515   clang
powerpc              randconfig-r004-20230515   clang
powerpc              randconfig-r025-20230515   gcc  
powerpc                     skiroot_defconfig   clang
powerpc                     tqm8541_defconfig   gcc  
powerpc                     tqm8560_defconfig   clang
powerpc                      tqm8xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230515   clang
riscv                randconfig-r004-20230515   clang
riscv                randconfig-r004-20230516   gcc  
riscv                randconfig-r012-20230515   gcc  
riscv                randconfig-r014-20230515   gcc  
riscv                randconfig-r036-20230516   gcc  
riscv                randconfig-r042-20230515   gcc  
riscv                randconfig-r042-20230516   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230515   gcc  
s390         buildonly-randconfig-r004-20230516   clang
s390                                defconfig   gcc  
s390                 randconfig-r001-20230516   gcc  
s390                 randconfig-r004-20230515   clang
s390                 randconfig-r005-20230515   clang
s390                 randconfig-r013-20230515   gcc  
s390                 randconfig-r021-20230515   gcc  
s390                 randconfig-r022-20230516   clang
s390                 randconfig-r023-20230516   clang
s390                 randconfig-r026-20230516   clang
s390                 randconfig-r032-20230515   clang
s390                 randconfig-r033-20230515   clang
s390                 randconfig-r035-20230515   clang
s390                 randconfig-r044-20230515   gcc  
s390                 randconfig-r044-20230516   clang
sh                               allmodconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh           buildonly-randconfig-r005-20230515   gcc  
sh           buildonly-randconfig-r006-20230515   gcc  
sh                   randconfig-r001-20230515   gcc  
sh                   randconfig-r003-20230515   gcc  
sh                   randconfig-r006-20230515   gcc  
sh                   randconfig-r011-20230516   gcc  
sh                   randconfig-r013-20230516   gcc  
sh                   randconfig-r024-20230515   gcc  
sh                   randconfig-r032-20230515   gcc  
sh                   randconfig-r033-20230515   gcc  
sh                   randconfig-r034-20230515   gcc  
sh                   randconfig-r035-20230515   gcc  
sh                           se7206_defconfig   gcc  
sparc        buildonly-randconfig-r002-20230515   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230515   gcc  
sparc                randconfig-r016-20230515   gcc  
sparc                randconfig-r025-20230515   gcc  
sparc                randconfig-r031-20230515   gcc  
sparc                randconfig-r032-20230515   gcc  
sparc                randconfig-r034-20230515   gcc  
sparc64      buildonly-randconfig-r006-20230515   gcc  
sparc64              randconfig-r006-20230515   gcc  
sparc64              randconfig-r012-20230515   gcc  
sparc64              randconfig-r023-20230515   gcc  
sparc64              randconfig-r024-20230515   gcc  
sparc64              randconfig-r035-20230516   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230515   clang
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230515   clang
x86_64                        randconfig-a002   gcc  
x86_64               randconfig-a003-20230515   clang
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230515   clang
x86_64                        randconfig-a004   gcc  
x86_64               randconfig-a005-20230515   clang
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230515   clang
x86_64                        randconfig-a006   gcc  
x86_64               randconfig-a011-20230515   gcc  
x86_64                        randconfig-a011   gcc  
x86_64               randconfig-a012-20230515   gcc  
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230515   gcc  
x86_64                        randconfig-a013   gcc  
x86_64               randconfig-a014-20230515   gcc  
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230515   gcc  
x86_64                        randconfig-a015   gcc  
x86_64               randconfig-a016-20230515   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-k001-20230515   gcc  
x86_64               randconfig-r011-20230515   gcc  
x86_64               randconfig-r014-20230515   gcc  
x86_64               randconfig-r026-20230515   gcc  
x86_64               randconfig-x051-20230515   gcc  
x86_64               randconfig-x052-20230515   gcc  
x86_64                        randconfig-x052   clang
x86_64               randconfig-x053-20230515   gcc  
x86_64               randconfig-x054-20230515   gcc  
x86_64                        randconfig-x054   clang
x86_64               randconfig-x055-20230515   gcc  
x86_64               randconfig-x056-20230515   gcc  
x86_64                        randconfig-x056   clang
x86_64               randconfig-x061-20230515   gcc  
x86_64                        randconfig-x061   gcc  
x86_64               randconfig-x062-20230515   gcc  
x86_64               randconfig-x063-20230515   gcc  
x86_64                        randconfig-x063   gcc  
x86_64               randconfig-x064-20230515   gcc  
x86_64               randconfig-x065-20230515   gcc  
x86_64                        randconfig-x065   gcc  
x86_64               randconfig-x066-20230515   gcc  
x86_64               randconfig-x071-20230515   clang
x86_64                        randconfig-x071   clang
x86_64               randconfig-x072-20230515   clang
x86_64               randconfig-x073-20230515   clang
x86_64                        randconfig-x073   clang
x86_64               randconfig-x074-20230515   clang
x86_64               randconfig-x075-20230515   clang
x86_64                        randconfig-x075   clang
x86_64               randconfig-x076-20230515   clang
x86_64               randconfig-x081-20230515   clang
x86_64               randconfig-x082-20230515   clang
x86_64                        randconfig-x082   clang
x86_64               randconfig-x083-20230515   clang
x86_64               randconfig-x084-20230515   clang
x86_64                        randconfig-x084   clang
x86_64               randconfig-x085-20230515   clang
x86_64               randconfig-x086-20230515   clang
x86_64                        randconfig-x086   clang
x86_64               randconfig-x091-20230515   gcc  
x86_64               randconfig-x092-20230515   gcc  
x86_64                        randconfig-x092   gcc  
x86_64               randconfig-x093-20230515   gcc  
x86_64               randconfig-x094-20230515   gcc  
x86_64                        randconfig-x094   gcc  
x86_64               randconfig-x095-20230515   gcc  
x86_64               randconfig-x096-20230515   gcc  
x86_64                        randconfig-x096   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa       buildonly-randconfig-r004-20230515   gcc  
xtensa       buildonly-randconfig-r006-20230515   gcc  
xtensa               randconfig-r003-20230515   gcc  
xtensa               randconfig-r013-20230515   gcc  
xtensa               randconfig-r014-20230516   gcc  
xtensa               randconfig-r022-20230515   gcc  
xtensa               randconfig-r026-20230515   gcc  
xtensa               randconfig-r036-20230515   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
