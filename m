Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F92A6E135A
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Apr 2023 19:19:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Py5tF3mcQz3fCn
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Apr 2023 03:19:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KXLztjdw;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KXLztjdw;
	dkim-atps=neutral
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Py5t70Lbvz3f5g
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Apr 2023 03:19:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681406383; x=1712942383;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=w78Abzu/5s8RnB1pODhW/1f93N8HCZCI1D3E2dCB7No=;
  b=KXLztjdwvxq6wrJ2/SAAT5wmQT7/I4681yVxZo35NkfOquhiJPyuU6x6
   Qz2NuLKhFrCS1wUdzqrFkKNbfc/tw4LjoGB470ov4TQdGZJt5KXkEozCj
   571qFMKkwQ2sWSRWk/qPU9Q5CMQ1xOfg/vMKyl320JV8Fhf+oyKDQ4fmU
   j139ohBqzQEUXXUsxMXC6t0oWFXxGzUPin9LKEgOfDHaihpO8rKxvEfJk
   bm6aPwek/QcDtGGf7xqelwG3XYcht5GUSKWOJTFk+mQEzodu6jyp4BcGq
   EjAkN+/nbAqg1n/kaveqA/i1HhZPKX8kX33aMBw4LtClBtd+EnIQOQ55A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="323873370"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="323873370"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 10:19:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="758777816"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="758777816"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 13 Apr 2023 10:18:58 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pn0b3-000YqL-2t;
	Thu, 13 Apr 2023 17:18:57 +0000
Date: Fri, 14 Apr 2023 01:18:03 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 061f485e4144b82ae3143176e58b03184b45dfc6
Message-ID: <6438394b.kjCc70f2auw5b5Bu%lkp@intel.com>
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
branch HEAD: 061f485e4144b82ae3143176e58b03184b45dfc6  erofs: enable long extended attribute name prefixes

elapsed time: 727m

configs tested: 244
configs skipped: 23

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r006-20230410   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r016-20230409   gcc  
alpha                randconfig-r022-20230412   gcc  
alpha                randconfig-r022-20230413   gcc  
alpha                randconfig-r024-20230413   gcc  
alpha                randconfig-r034-20230409   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230409   gcc  
arc          buildonly-randconfig-r006-20230410   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230409   gcc  
arc                  randconfig-r005-20230409   gcc  
arc                  randconfig-r005-20230413   gcc  
arc                  randconfig-r032-20230413   gcc  
arc                  randconfig-r034-20230413   gcc  
arc                  randconfig-r043-20230412   gcc  
arc                  randconfig-r043-20230413   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r002-20230409   clang
arm          buildonly-randconfig-r005-20230409   clang
arm                                 defconfig   gcc  
arm                         mv78xx0_defconfig   clang
arm                  randconfig-r002-20230413   clang
arm                  randconfig-r012-20230409   clang
arm                  randconfig-r021-20230413   gcc  
arm                  randconfig-r023-20230413   gcc  
arm                  randconfig-r031-20230413   clang
arm                  randconfig-r033-20230410   gcc  
arm                  randconfig-r046-20230412   clang
arm                  randconfig-r046-20230413   gcc  
arm64                            allyesconfig   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230409   clang
arm64        buildonly-randconfig-r005-20230409   clang
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230410   clang
arm64                randconfig-r016-20230410   gcc  
arm64                randconfig-r024-20230413   clang
arm64                randconfig-r032-20230410   clang
arm64                randconfig-r035-20230409   clang
arm64                randconfig-r035-20230413   gcc  
arm64                randconfig-r036-20230413   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r012-20230409   gcc  
csky                 randconfig-r013-20230409   gcc  
csky                 randconfig-r021-20230410   gcc  
csky                 randconfig-r025-20230413   gcc  
csky                 randconfig-r031-20230409   gcc  
hexagon      buildonly-randconfig-r003-20230410   clang
hexagon      buildonly-randconfig-r004-20230410   clang
hexagon              randconfig-r003-20230413   clang
hexagon              randconfig-r005-20230409   clang
hexagon              randconfig-r005-20230410   clang
hexagon              randconfig-r011-20230409   clang
hexagon              randconfig-r012-20230413   clang
hexagon              randconfig-r024-20230412   clang
hexagon              randconfig-r026-20230409   clang
hexagon              randconfig-r031-20230409   clang
hexagon              randconfig-r033-20230409   clang
hexagon              randconfig-r041-20230412   clang
hexagon              randconfig-r041-20230413   clang
hexagon              randconfig-r045-20230412   clang
hexagon              randconfig-r045-20230413   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230410   clang
i386                 randconfig-a002-20230410   clang
i386                 randconfig-a003-20230410   clang
i386                 randconfig-a004-20230410   clang
i386                 randconfig-a005-20230410   clang
i386                 randconfig-a006-20230410   clang
i386                 randconfig-a011-20230410   gcc  
i386                          randconfig-a011   clang
i386                 randconfig-a012-20230410   gcc  
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230410   gcc  
i386                          randconfig-a013   clang
i386                 randconfig-a014-20230410   gcc  
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                          randconfig-a015   clang
i386                 randconfig-a016-20230410   gcc  
i386                          randconfig-a016   gcc  
i386                 randconfig-r036-20230410   clang
ia64                             allmodconfig   gcc  
ia64                         bigsur_defconfig   gcc  
ia64         buildonly-randconfig-r001-20230410   gcc  
ia64         buildonly-randconfig-r005-20230413   gcc  
ia64         buildonly-randconfig-r006-20230409   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230410   gcc  
ia64                 randconfig-r013-20230413   gcc  
ia64                 randconfig-r024-20230410   gcc  
ia64                 randconfig-r025-20230413   gcc  
ia64                 randconfig-r036-20230413   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230410   gcc  
loongarch    buildonly-randconfig-r006-20230409   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230410   gcc  
loongarch            randconfig-r004-20230409   gcc  
loongarch            randconfig-r014-20230410   gcc  
loongarch            randconfig-r032-20230409   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230409   gcc  
m68k                 randconfig-r006-20230413   gcc  
m68k                 randconfig-r011-20230413   gcc  
m68k                 randconfig-r016-20230413   gcc  
m68k                 randconfig-r026-20230413   gcc  
microblaze   buildonly-randconfig-r001-20230413   gcc  
microblaze   buildonly-randconfig-r002-20230410   gcc  
microblaze   buildonly-randconfig-r006-20230413   gcc  
microblaze           randconfig-r001-20230413   gcc  
microblaze           randconfig-r005-20230410   gcc  
microblaze           randconfig-r022-20230413   gcc  
microblaze           randconfig-r025-20230409   gcc  
microblaze           randconfig-r032-20230410   gcc  
microblaze           randconfig-r033-20230413   gcc  
microblaze           randconfig-r035-20230409   gcc  
microblaze           randconfig-r036-20230410   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           mtx1_defconfig   clang
mips                 randconfig-r004-20230410   gcc  
mips                 randconfig-r011-20230410   clang
mips                 randconfig-r016-20230409   clang
mips                 randconfig-r031-20230410   gcc  
mips                 randconfig-r035-20230410   gcc  
nios2                         10m50_defconfig   gcc  
nios2        buildonly-randconfig-r004-20230409   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230410   gcc  
nios2                randconfig-r013-20230410   gcc  
nios2                randconfig-r014-20230409   gcc  
nios2                randconfig-r024-20230409   gcc  
nios2                randconfig-r033-20230413   gcc  
openrisc     buildonly-randconfig-r002-20230409   gcc  
openrisc     buildonly-randconfig-r005-20230410   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc             randconfig-r003-20230409   gcc  
openrisc             randconfig-r006-20230410   gcc  
openrisc             randconfig-r021-20230412   gcc  
parisc       buildonly-randconfig-r001-20230410   gcc  
parisc       buildonly-randconfig-r003-20230410   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230409   gcc  
parisc               randconfig-r004-20230413   gcc  
parisc               randconfig-r015-20230409   gcc  
parisc               randconfig-r023-20230413   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r003-20230410   clang
powerpc              randconfig-r034-20230409   clang
powerpc              randconfig-r034-20230413   gcc  
powerpc              randconfig-r035-20230410   clang
powerpc              randconfig-r035-20230413   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r004-20230410   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r025-20230410   gcc  
riscv                randconfig-r026-20230413   clang
riscv                randconfig-r036-20230409   clang
riscv                randconfig-r042-20230412   gcc  
riscv                randconfig-r042-20230413   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230409   clang
s390                 randconfig-r004-20230410   clang
s390                 randconfig-r033-20230410   clang
s390                 randconfig-r044-20230412   gcc  
s390                 randconfig-r044-20230413   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230409   gcc  
sh                   randconfig-r011-20230409   gcc  
sh                   randconfig-r012-20230410   gcc  
sh                   randconfig-r013-20230410   gcc  
sh                   randconfig-r016-20230410   gcc  
sh                   randconfig-r021-20230409   gcc  
sh                   randconfig-r022-20230409   gcc  
sparc        buildonly-randconfig-r001-20230409   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230409   gcc  
sparc                randconfig-r032-20230409   gcc  
sparc                randconfig-r033-20230409   gcc  
sparc                randconfig-r036-20230409   gcc  
sparc64              randconfig-r002-20230410   gcc  
sparc64              randconfig-r006-20230409   gcc  
sparc64              randconfig-r012-20230410   gcc  
sparc64              randconfig-r031-20230410   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230410   clang
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230410   clang
x86_64                        randconfig-a002   gcc  
x86_64               randconfig-a003-20230410   clang
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230410   clang
x86_64                        randconfig-a004   gcc  
x86_64               randconfig-a005-20230410   clang
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230410   clang
x86_64                        randconfig-a006   gcc  
x86_64               randconfig-a011-20230410   gcc  
x86_64                        randconfig-a011   gcc  
x86_64               randconfig-a012-20230410   gcc  
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230410   gcc  
x86_64                        randconfig-a013   gcc  
x86_64               randconfig-a014-20230410   gcc  
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230410   gcc  
x86_64                        randconfig-a015   gcc  
x86_64               randconfig-a016-20230410   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-r014-20230410   gcc  
x86_64               randconfig-r034-20230410   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r003-20230409   gcc  
xtensa       buildonly-randconfig-r003-20230413   gcc  
xtensa       buildonly-randconfig-r004-20230413   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa               randconfig-r003-20230410   gcc  
xtensa               randconfig-r015-20230410   gcc  
xtensa               randconfig-r023-20230410   gcc  
xtensa               randconfig-r034-20230410   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
