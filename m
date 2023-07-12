Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6AE74FEC4
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jul 2023 07:39:01 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hp6ys/ac;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R16432R3sz3bmj
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jul 2023 15:38:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hp6ys/ac;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R163v74W1z30fl
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Jul 2023 15:38:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689140332; x=1720676332;
  h=date:from:to:cc:subject:message-id;
  bh=DaCHuyb/gJlmAetBdu7+wM9nmEHwOgrLLYQQavL20Xo=;
  b=Hp6ys/acSg9yYwVfO+kxFcAhEuP+f/u+YyK5HjYLBdlgLjgk/93eOojX
   P+FOXJMYe0KZYIb7sQn582RKp98d/lKW4AfiK41A7xTmIOsCtyD2uQkHa
   nLNLmZYn5MEWn0xJK6YueM8bigQpHKb+Z+um5B6ETnVThcR+DFDPsnAOP
   /qI1B6ryJBLGzs5Y3f+f0I49QM1TGHz3M7naXdNVBvGTKJChLJl6/Hym+
   gmJUwyVK2iuGpBtxy1ZzyTFrOmc94I0zeauOZih0zrhzi3ZwAdQA584Qz
   mAexofsY6NEWOCau4vL4boykVjCzS0KdM8tddtHYadJStVT0CkZIZijar
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="345120239"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="345120239"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 22:38:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="751036753"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="751036753"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 11 Jul 2023 22:38:41 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qJSYi-0005Qb-36;
	Wed, 12 Jul 2023 05:38:40 +0000
Date: Wed, 12 Jul 2023 13:37:55 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 18bddc5b67038722cb88fcf51fbf41a0277092cb
Message-ID: <202307121354.dwZRtfmN-lkp@intel.com>
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
branch HEAD: 18bddc5b67038722cb88fcf51fbf41a0277092cb  erofs: fix fsdax unavailability for chunk-based regular files

elapsed time: 725m

configs tested: 234
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230712   gcc  
alpha                randconfig-r006-20230711   gcc  
alpha                randconfig-r022-20230710   gcc  
alpha                randconfig-r022-20230712   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230711   gcc  
arc                  randconfig-r034-20230712   gcc  
arc                  randconfig-r036-20230712   gcc  
arc                  randconfig-r043-20230711   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                  randconfig-r012-20230712   gcc  
arm                  randconfig-r015-20230712   gcc  
arm                  randconfig-r021-20230710   gcc  
arm                  randconfig-r046-20230711   clang
arm                       spear13xx_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230712   gcc  
arm64                randconfig-r002-20230712   gcc  
arm64                randconfig-r004-20230712   gcc  
arm64                randconfig-r005-20230711   clang
arm64                randconfig-r033-20230710   gcc  
arm64                randconfig-r034-20230710   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230712   gcc  
csky                 randconfig-r004-20230712   gcc  
csky                 randconfig-r006-20230712   gcc  
csky                 randconfig-r026-20230710   gcc  
csky                 randconfig-r031-20230710   gcc  
csky                 randconfig-r036-20230710   gcc  
hexagon              randconfig-r023-20230710   clang
hexagon              randconfig-r033-20230710   clang
hexagon              randconfig-r035-20230710   clang
hexagon              randconfig-r041-20230710   clang
hexagon              randconfig-r041-20230711   clang
hexagon              randconfig-r041-20230712   clang
hexagon              randconfig-r045-20230710   clang
hexagon              randconfig-r045-20230711   clang
hexagon              randconfig-r045-20230712   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230711   clang
i386         buildonly-randconfig-r005-20230711   clang
i386         buildonly-randconfig-r006-20230711   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230710   gcc  
i386                 randconfig-i001-20230711   clang
i386                 randconfig-i001-20230712   gcc  
i386                 randconfig-i002-20230710   gcc  
i386                 randconfig-i002-20230711   clang
i386                 randconfig-i002-20230712   gcc  
i386                 randconfig-i003-20230710   gcc  
i386                 randconfig-i003-20230711   clang
i386                 randconfig-i003-20230712   gcc  
i386                 randconfig-i004-20230710   gcc  
i386                 randconfig-i004-20230711   clang
i386                 randconfig-i004-20230712   gcc  
i386                 randconfig-i005-20230710   gcc  
i386                 randconfig-i005-20230711   clang
i386                 randconfig-i005-20230712   gcc  
i386                 randconfig-i006-20230710   gcc  
i386                 randconfig-i006-20230711   clang
i386                 randconfig-i006-20230712   gcc  
i386                 randconfig-i011-20230711   gcc  
i386                 randconfig-i011-20230712   clang
i386                 randconfig-i012-20230711   gcc  
i386                 randconfig-i012-20230712   clang
i386                 randconfig-i013-20230711   gcc  
i386                 randconfig-i013-20230712   clang
i386                 randconfig-i014-20230711   gcc  
i386                 randconfig-i014-20230712   clang
i386                 randconfig-i015-20230711   gcc  
i386                 randconfig-i015-20230712   clang
i386                 randconfig-i016-20230711   gcc  
i386                 randconfig-i016-20230712   clang
i386                 randconfig-r013-20230712   clang
i386                 randconfig-r014-20230711   gcc  
i386                 randconfig-r024-20230710   clang
i386                 randconfig-r036-20230710   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230712   gcc  
loongarch            randconfig-r006-20230712   gcc  
loongarch            randconfig-r014-20230711   gcc  
loongarch            randconfig-r026-20230712   gcc  
loongarch            randconfig-r032-20230710   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                 randconfig-r004-20230711   gcc  
m68k                 randconfig-r011-20230712   gcc  
m68k                 randconfig-r013-20230711   gcc  
m68k                 randconfig-r013-20230712   gcc  
m68k                 randconfig-r025-20230710   gcc  
m68k                 randconfig-r035-20230712   gcc  
microblaze           randconfig-r003-20230711   gcc  
microblaze           randconfig-r005-20230712   gcc  
microblaze           randconfig-r012-20230711   gcc  
microblaze           randconfig-r015-20230711   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   clang
mips                 randconfig-r024-20230710   gcc  
mips                 randconfig-r031-20230710   clang
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230712   gcc  
nios2                randconfig-r012-20230712   gcc  
nios2                randconfig-r016-20230711   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r006-20230712   gcc  
openrisc             randconfig-r032-20230710   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230712   gcc  
parisc               randconfig-r014-20230712   gcc  
parisc               randconfig-r015-20230711   gcc  
parisc               randconfig-r016-20230712   gcc  
parisc               randconfig-r021-20230712   gcc  
parisc               randconfig-r025-20230710   gcc  
parisc               randconfig-r033-20230712   gcc  
parisc               randconfig-r035-20230712   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r003-20230712   gcc  
powerpc              randconfig-r035-20230710   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230712   gcc  
riscv                randconfig-r042-20230710   clang
riscv                randconfig-r042-20230711   gcc  
riscv                randconfig-r042-20230712   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230712   gcc  
s390                 randconfig-r026-20230710   clang
s390                 randconfig-r044-20230710   clang
s390                 randconfig-r044-20230711   gcc  
s390                 randconfig-r044-20230712   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r011-20230711   gcc  
sh                   randconfig-r021-20230710   gcc  
sh                   randconfig-r023-20230710   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230711   gcc  
sparc                randconfig-r014-20230712   gcc  
sparc                randconfig-r016-20230711   gcc  
sparc                randconfig-r023-20230710   gcc  
sparc                randconfig-r033-20230712   gcc  
sparc64              randconfig-r002-20230711   gcc  
sparc64              randconfig-r012-20230711   gcc  
sparc64              randconfig-r014-20230712   gcc  
sparc64              randconfig-r026-20230710   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r016-20230712   gcc  
um                   randconfig-r024-20230710   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230711   clang
x86_64       buildonly-randconfig-r002-20230711   clang
x86_64       buildonly-randconfig-r003-20230711   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r015-20230712   clang
x86_64               randconfig-r016-20230712   clang
x86_64               randconfig-r021-20230710   clang
x86_64               randconfig-r031-20230712   gcc  
x86_64               randconfig-x001-20230710   clang
x86_64               randconfig-x001-20230711   gcc  
x86_64               randconfig-x001-20230712   clang
x86_64               randconfig-x002-20230710   clang
x86_64               randconfig-x002-20230711   gcc  
x86_64               randconfig-x002-20230712   clang
x86_64               randconfig-x003-20230710   clang
x86_64               randconfig-x003-20230711   gcc  
x86_64               randconfig-x003-20230712   clang
x86_64               randconfig-x004-20230710   clang
x86_64               randconfig-x004-20230711   gcc  
x86_64               randconfig-x004-20230712   clang
x86_64               randconfig-x005-20230710   clang
x86_64               randconfig-x005-20230711   gcc  
x86_64               randconfig-x005-20230712   clang
x86_64               randconfig-x006-20230710   clang
x86_64               randconfig-x006-20230711   gcc  
x86_64               randconfig-x006-20230712   clang
x86_64               randconfig-x011-20230710   gcc  
x86_64               randconfig-x011-20230711   clang
x86_64               randconfig-x011-20230712   gcc  
x86_64               randconfig-x012-20230710   gcc  
x86_64               randconfig-x012-20230711   clang
x86_64               randconfig-x012-20230712   gcc  
x86_64               randconfig-x013-20230710   gcc  
x86_64               randconfig-x013-20230711   clang
x86_64               randconfig-x013-20230712   gcc  
x86_64               randconfig-x014-20230710   gcc  
x86_64               randconfig-x014-20230711   clang
x86_64               randconfig-x014-20230712   gcc  
x86_64               randconfig-x015-20230710   gcc  
x86_64               randconfig-x015-20230711   clang
x86_64               randconfig-x015-20230712   gcc  
x86_64               randconfig-x016-20230710   gcc  
x86_64               randconfig-x016-20230711   clang
x86_64               randconfig-x016-20230712   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r013-20230712   gcc  
xtensa               randconfig-r024-20230712   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
