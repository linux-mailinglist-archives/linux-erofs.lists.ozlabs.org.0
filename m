Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 762836D2A1B
	for <lists+linux-erofs@lfdr.de>; Fri, 31 Mar 2023 23:45:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PpDNl0c21z3fVX
	for <lists+linux-erofs@lfdr.de>; Sat,  1 Apr 2023 08:45:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J7iwOEwl;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J7iwOEwl;
	dkim-atps=neutral
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PpDNc0FxWz3cMj
	for <linux-erofs@lists.ozlabs.org>; Sat,  1 Apr 2023 08:45:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680299120; x=1711835120;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=txLoCPzn5b8AVfTDyLsrr6YtUpTgJCqXULNAQB9Oh1E=;
  b=J7iwOEwlwly6pWpFOZc4Q18N2Hubm70fs9/mnCJOC+JpZyD23Wu53JJC
   2LPgPeZQk0FJ5i0f9CoIE2DaarMS5SYbmzuv5UeD5M65zoiDObO3AX1rI
   nqEfmsLnDMy2YfE6eKZIkw49EDm7lAgGsjLUcXOfPhK/y+RK7+4DoDUIc
   4HpT9Ty/LZG+xb+FxffUJpB2+bqkle4oDOt850gLSgjj8b9OrEYl+pJMl
   s9UMqJ4/J0xXjUNcHu373V1wSUjkc7l6dUnOV3loZc2tZ42Fz8hRaejBs
   BoZKGbGFt/jUByVWoORbbX8zraE04llYK7QlxZ9OFqhxmxdKXjCqvoUPm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="341582272"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="341582272"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 14:45:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="678756713"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="678756713"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 31 Mar 2023 14:44:59 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1piMYM-000MCX-0I;
	Fri, 31 Mar 2023 21:44:58 +0000
Date: Sat, 01 Apr 2023 05:44:00 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 c44ce28f4bc87e4bfa675e22c137f7822d690052
Message-ID: <64275420.l6BKyZtrps+NTLV3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
branch HEAD: c44ce28f4bc87e4bfa675e22c137f7822d690052  erofs: simplify erofs_xattr_generic_get()

elapsed time: 814m

configs tested: 244
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230329   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230329   gcc  
alpha                randconfig-r004-20230329   gcc  
alpha                randconfig-r005-20230329   gcc  
alpha                randconfig-r006-20230329   gcc  
alpha                randconfig-r012-20230329   gcc  
alpha                randconfig-r016-20230329   gcc  
alpha                randconfig-r024-20230329   gcc  
alpha                randconfig-r025-20230329   gcc  
alpha                randconfig-r034-20230329   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230329   gcc  
arc          buildonly-randconfig-r005-20230329   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r013-20230329   gcc  
arc                  randconfig-r016-20230329   gcc  
arc                  randconfig-r025-20230329   gcc  
arc                  randconfig-r033-20230329   gcc  
arc                  randconfig-r035-20230329   gcc  
arc                  randconfig-r043-20230329   gcc  
arc                  randconfig-r043-20230331   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                  randconfig-r001-20230329   clang
arm                  randconfig-r002-20230329   clang
arm                  randconfig-r025-20230329   gcc  
arm                  randconfig-r046-20230329   gcc  
arm                  randconfig-r046-20230331   clang
arm                           u8500_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230329   gcc  
arm64        buildonly-randconfig-r002-20230329   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230329   gcc  
arm64                randconfig-r032-20230329   gcc  
arm64                randconfig-r036-20230329   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230329   gcc  
csky                 randconfig-r013-20230331   gcc  
csky                 randconfig-r014-20230329   gcc  
csky                 randconfig-r022-20230329   gcc  
csky                 randconfig-r026-20230329   gcc  
csky                 randconfig-r033-20230329   gcc  
csky                 randconfig-r035-20230329   gcc  
hexagon              randconfig-r003-20230329   clang
hexagon              randconfig-r022-20230329   clang
hexagon              randconfig-r034-20230329   clang
hexagon              randconfig-r041-20230329   clang
hexagon              randconfig-r041-20230330   clang
hexagon              randconfig-r041-20230331   clang
hexagon              randconfig-r045-20230329   clang
hexagon              randconfig-r045-20230330   clang
hexagon              randconfig-r045-20230331   clang
i386                              allnoconfig   gcc  
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
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                      gensparse_defconfig   gcc  
ia64                 randconfig-r012-20230329   gcc  
ia64                 randconfig-r023-20230329   gcc  
ia64                 randconfig-r024-20230329   gcc  
ia64                 randconfig-r025-20230329   gcc  
ia64                 randconfig-r031-20230329   gcc  
ia64                 randconfig-r036-20230329   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r006-20230329   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230330   gcc  
loongarch            randconfig-r005-20230330   gcc  
loongarch            randconfig-r015-20230329   gcc  
loongarch            randconfig-r016-20230331   gcc  
loongarch            randconfig-r021-20230329   gcc  
loongarch            randconfig-r022-20230329   gcc  
loongarch            randconfig-r023-20230329   gcc  
loongarch            randconfig-r036-20230329   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230330   gcc  
m68k                 randconfig-r013-20230329   gcc  
m68k                 randconfig-r015-20230329   gcc  
m68k                 randconfig-r035-20230329   gcc  
m68k                           sun3_defconfig   gcc  
microblaze   buildonly-randconfig-r005-20230329   gcc  
microblaze   buildonly-randconfig-r006-20230329   gcc  
microblaze           randconfig-r011-20230331   gcc  
microblaze           randconfig-r016-20230329   gcc  
microblaze           randconfig-r023-20230329   gcc  
microblaze           randconfig-r024-20230329   gcc  
microblaze           randconfig-r032-20230329   gcc  
microblaze           randconfig-r036-20230329   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips         buildonly-randconfig-r003-20230329   clang
mips         buildonly-randconfig-r004-20230329   clang
mips                            gpr_defconfig   gcc  
mips                 randconfig-r001-20230329   clang
mips                 randconfig-r015-20230329   gcc  
mips                 randconfig-r016-20230329   gcc  
mips                 randconfig-r021-20230329   gcc  
mips                 randconfig-r026-20230329   gcc  
mips                 randconfig-r036-20230329   clang
mips                          rb532_defconfig   gcc  
mips                        vocore2_defconfig   gcc  
nios2        buildonly-randconfig-r004-20230329   gcc  
nios2        buildonly-randconfig-r005-20230329   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230330   gcc  
nios2                randconfig-r006-20230329   gcc  
nios2                randconfig-r012-20230329   gcc  
nios2                randconfig-r014-20230331   gcc  
nios2                randconfig-r016-20230329   gcc  
nios2                randconfig-r024-20230329   gcc  
nios2                randconfig-r026-20230329   gcc  
nios2                randconfig-r031-20230329   gcc  
nios2                randconfig-r033-20230329   gcc  
openrisc     buildonly-randconfig-r003-20230329   gcc  
openrisc     buildonly-randconfig-r006-20230329   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r004-20230329   gcc  
openrisc             randconfig-r006-20230330   gcc  
openrisc             randconfig-r011-20230329   gcc  
openrisc             randconfig-r021-20230329   gcc  
openrisc             randconfig-r036-20230329   gcc  
parisc       buildonly-randconfig-r006-20230329   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230330   gcc  
parisc               randconfig-r006-20230329   gcc  
parisc               randconfig-r014-20230329   gcc  
parisc               randconfig-r015-20230329   gcc  
parisc               randconfig-r022-20230329   gcc  
parisc               randconfig-r025-20230329   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc              randconfig-r032-20230329   gcc  
powerpc              randconfig-r034-20230329   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230329   clang
riscv                               defconfig   gcc  
riscv                randconfig-r016-20230331   gcc  
riscv                randconfig-r022-20230329   clang
riscv                randconfig-r032-20230329   gcc  
riscv                randconfig-r035-20230329   gcc  
riscv                randconfig-r042-20230329   clang
riscv                randconfig-r042-20230330   clang
riscv                randconfig-r042-20230331   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230329   clang
s390                                defconfig   gcc  
s390                 randconfig-r002-20230329   gcc  
s390                 randconfig-r003-20230329   gcc  
s390                 randconfig-r005-20230329   gcc  
s390                 randconfig-r013-20230331   gcc  
s390                 randconfig-r015-20230331   gcc  
s390                 randconfig-r023-20230329   clang
s390                 randconfig-r031-20230329   gcc  
s390                 randconfig-r032-20230329   gcc  
s390                 randconfig-r034-20230329   gcc  
s390                 randconfig-r035-20230329   gcc  
s390                 randconfig-r044-20230329   clang
s390                 randconfig-r044-20230330   clang
s390                 randconfig-r044-20230331   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230329   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                   randconfig-r011-20230331   gcc  
sh                   randconfig-r014-20230329   gcc  
sh                   randconfig-r023-20230329   gcc  
sh                   randconfig-r024-20230329   gcc  
sh                   randconfig-r031-20230329   gcc  
sh                   randconfig-r032-20230329   gcc  
sh                           se7705_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc        buildonly-randconfig-r001-20230329   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230329   gcc  
sparc                randconfig-r015-20230329   gcc  
sparc                randconfig-r022-20230329   gcc  
sparc64      buildonly-randconfig-r003-20230329   gcc  
sparc64              randconfig-r002-20230329   gcc  
sparc64              randconfig-r012-20230329   gcc  
sparc64              randconfig-r013-20230329   gcc  
sparc64              randconfig-r024-20230329   gcc  
sparc64              randconfig-r025-20230329   gcc  
sparc64              randconfig-r031-20230329   gcc  
sparc64              randconfig-r032-20230329   gcc  
sparc64              randconfig-r034-20230329   gcc  
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
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r002-20230329   gcc  
xtensa               randconfig-r011-20230329   gcc  
xtensa               randconfig-r012-20230329   gcc  
xtensa               randconfig-r021-20230329   gcc  
xtensa               randconfig-r026-20230329   gcc  
xtensa               randconfig-r031-20230329   gcc  
xtensa               randconfig-r033-20230329   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
