Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6532F6B7A3E
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Mar 2023 15:23:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PZzRK1L16z3c79
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Mar 2023 01:23:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O1SJ0G5K;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O1SJ0G5K;
	dkim-atps=neutral
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PZzRB2L1mz3bfw
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Mar 2023 01:23:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678717414; x=1710253414;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+1C4CGmIOUEfpGyQH1QBUvJOQ0ORS6WG24PiEgFwsVA=;
  b=O1SJ0G5KFNr/RVP+mz2EccwL40Eri4qqfP5TOK22F5sSsUjQMapNW2h+
   OkyyRCtWDNO4hF4eP+KH4wJrOSETXdB6CZ/PG4BZJ2BjDwK/v5EBmz3Bn
   2VvUWySYdwF+nNWCGDAb/v8u9y081ZVWBuUJUk+5ZOkVvB0eBnDbD0jYT
   daIPITd+rL95XDgZeERyh4l1RjocorW9zSmR0vEzV6sHJckVsIpYvYqg8
   iqrXIY2sdFN4tCRqQrk1Y5c+vJsKx4Synn3T0psK5zyTjpgdrmIKIMKBT
   5vxL0wt/l0QVVbR70TepaC3wU2wWDteyccIQwIFxqcmMjBql71WfWjWAy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="317543874"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="317543874"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 07:23:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="802461007"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="802461007"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Mar 2023 07:23:23 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pbj58-0005kK-2K;
	Mon, 13 Mar 2023 14:23:22 +0000
Date: Mon, 13 Mar 2023 22:23:20 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 8abb522e5988e35dc60162401eedef732f85ca3f
Message-ID: <640f31d8.wnQuTAdqoCQ8vFaS%lkp@intel.com>
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
branch HEAD: 8abb522e5988e35dc60162401eedef732f85ca3f  erofs: set block size to the on-disk block size

elapsed time: 722m

configs tested: 193
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r016-20230312   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230312   gcc  
arc          buildonly-randconfig-r003-20230313   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r013-20230312   gcc  
arc                  randconfig-r013-20230313   gcc  
arc                  randconfig-r023-20230313   gcc  
arc                  randconfig-r032-20230312   gcc  
arc                  randconfig-r043-20230312   gcc  
arc                  randconfig-r043-20230313   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r005-20230312   clang
arm                                 defconfig   gcc  
arm                  randconfig-r004-20230312   gcc  
arm                  randconfig-r005-20230312   gcc  
arm                  randconfig-r012-20230312   clang
arm                  randconfig-r046-20230312   clang
arm                  randconfig-r046-20230313   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230313   gcc  
arm64        buildonly-randconfig-r006-20230313   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230312   clang
arm64                randconfig-r004-20230312   clang
arm64                randconfig-r011-20230312   gcc  
arm64                randconfig-r015-20230313   clang
arm64                randconfig-r022-20230312   gcc  
arm64                randconfig-r036-20230312   clang
csky                                defconfig   gcc  
csky                 randconfig-r033-20230313   gcc  
csky                 randconfig-r036-20230312   gcc  
hexagon      buildonly-randconfig-r004-20230312   clang
hexagon              randconfig-r003-20230313   clang
hexagon              randconfig-r006-20230313   clang
hexagon              randconfig-r023-20230313   clang
hexagon              randconfig-r041-20230312   clang
hexagon              randconfig-r041-20230313   clang
hexagon              randconfig-r045-20230312   clang
hexagon              randconfig-r045-20230313   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r002-20230313   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230313   gcc  
i386                 randconfig-a002-20230313   gcc  
i386                 randconfig-a003-20230313   gcc  
i386                 randconfig-a004-20230313   gcc  
i386                 randconfig-a005-20230313   gcc  
i386                 randconfig-a006-20230313   gcc  
i386                 randconfig-a011-20230313   clang
i386                          randconfig-a011   clang
i386                 randconfig-a012-20230313   clang
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230313   clang
i386                          randconfig-a013   clang
i386                 randconfig-a014-20230313   clang
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230313   clang
i386                          randconfig-a015   clang
i386                 randconfig-a016-20230313   clang
i386                          randconfig-a016   gcc  
i386                 randconfig-r002-20230313   gcc  
i386                 randconfig-r005-20230313   gcc  
i386                 randconfig-r035-20230313   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230313   gcc  
ia64                 randconfig-r006-20230313   gcc  
ia64                 randconfig-r012-20230312   gcc  
ia64                 randconfig-r031-20230312   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230313   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r034-20230312   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r005-20230312   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230312   gcc  
m68k                 randconfig-r004-20230313   gcc  
m68k                 randconfig-r005-20230312   gcc  
m68k                 randconfig-r016-20230313   gcc  
microblaze   buildonly-randconfig-r001-20230312   gcc  
microblaze   buildonly-randconfig-r002-20230312   gcc  
microblaze   buildonly-randconfig-r006-20230312   gcc  
microblaze           randconfig-r006-20230312   gcc  
microblaze           randconfig-r011-20230312   gcc  
microblaze           randconfig-r035-20230312   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r003-20230313   clang
mips                 randconfig-r001-20230312   gcc  
mips                 randconfig-r003-20230313   clang
mips                 randconfig-r021-20230313   gcc  
mips                 randconfig-r022-20230313   gcc  
mips                 randconfig-r023-20230312   clang
mips                 randconfig-r025-20230312   clang
nios2        buildonly-randconfig-r001-20230313   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230312   gcc  
nios2                randconfig-r012-20230313   gcc  
nios2                randconfig-r015-20230312   gcc  
nios2                randconfig-r025-20230313   gcc  
nios2                randconfig-r026-20230312   gcc  
openrisc     buildonly-randconfig-r001-20230313   gcc  
openrisc     buildonly-randconfig-r003-20230312   gcc  
openrisc     buildonly-randconfig-r005-20230313   gcc  
openrisc             randconfig-r026-20230312   gcc  
parisc       buildonly-randconfig-r002-20230312   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r034-20230313   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r002-20230312   clang
powerpc              randconfig-r033-20230312   clang
powerpc              randconfig-r036-20230313   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230312   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230313   gcc  
riscv                randconfig-r014-20230312   gcc  
riscv                randconfig-r022-20230312   gcc  
riscv                randconfig-r025-20230312   gcc  
riscv                randconfig-r026-20230313   clang
riscv                randconfig-r031-20230313   gcc  
riscv                randconfig-r042-20230312   gcc  
riscv                randconfig-r042-20230313   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r011-20230313   clang
s390                 randconfig-r024-20230313   clang
s390                 randconfig-r044-20230312   gcc  
s390                 randconfig-r044-20230313   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230313   gcc  
sh           buildonly-randconfig-r006-20230313   gcc  
sh                   randconfig-r035-20230312   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230312   gcc  
sparc                randconfig-r024-20230312   gcc  
sparc                randconfig-r025-20230313   gcc  
sparc64      buildonly-randconfig-r006-20230312   gcc  
sparc64              randconfig-r001-20230313   gcc  
sparc64              randconfig-r032-20230312   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230313   gcc  
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230313   gcc  
x86_64                        randconfig-a002   gcc  
x86_64               randconfig-a003-20230313   gcc  
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230313   gcc  
x86_64                        randconfig-a004   gcc  
x86_64               randconfig-a005-20230313   gcc  
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230313   gcc  
x86_64                        randconfig-a006   gcc  
x86_64               randconfig-a011-20230313   clang
x86_64               randconfig-a012-20230313   clang
x86_64               randconfig-a013-20230313   clang
x86_64               randconfig-a014-20230313   clang
x86_64               randconfig-a015-20230313   clang
x86_64               randconfig-a016-20230313   clang
x86_64               randconfig-r002-20230313   gcc  
x86_64               randconfig-r014-20230313   clang
x86_64               randconfig-r024-20230313   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230312   gcc  
xtensa               randconfig-r015-20230312   gcc  
xtensa               randconfig-r016-20230312   gcc  
xtensa               randconfig-r021-20230313   gcc  
xtensa               randconfig-r023-20230312   gcc  
xtensa               randconfig-r031-20230312   gcc  
xtensa               randconfig-r032-20230313   gcc  
xtensa               randconfig-r033-20230312   gcc  
xtensa               randconfig-r034-20230312   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
