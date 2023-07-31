Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373F9768A64
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Jul 2023 05:41:40 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UwKFUlQV;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RDkYp67G9z2ys2
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Jul 2023 13:41:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UwKFUlQV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.151; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (unknown [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RDkYg56JQz2ykW
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Jul 2023 13:41:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690774888; x=1722310888;
  h=date:from:to:cc:subject:message-id;
  bh=wzxFA7ywB2KaA0fwV3fExuTDs7FXzcuqG89u1JM3mCQ=;
  b=UwKFUlQVT2jaLp6o4Y0oljSTPGthMVVL6LgN4IONYnGKMeDvAsaJXo5s
   dAM+9uCchmlpeba4BoaAqYL0Xa7iGiJzwvefsvUrka5VrbBj1t6jPsNnO
   9AIh2SBMomz/I4JUhEzoQCVxE68bZP2VpM6ucs0bVcutn5IVwmd8n6BXk
   iM2lb76u5LRKZciys6PppC+anjxaJyJvrBp8ntbNtXD/YBg2IGCgUganp
   AS169o40yMPV2t1mVIVagVzI1Yn11tkrupzfo0RCpKWT8Xih4Zc9SoIbq
   e4Yh9V9n0aJf+VTqItpbP3aIsK3lDQWVsJ0Kdr5HGyVRv6K0q4UEbM6Uh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="349213989"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="349213989"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 20:41:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="763201974"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="763201974"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Jul 2023 20:41:18 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qQJmX-0004un-1B;
	Mon, 31 Jul 2023 03:41:17 +0000
Date: Mon, 31 Jul 2023 11:37:17 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 68252fd8890e7b54f9e0634a302f625d345493d1
Message-ID: <202307311116.bojNaoFH-lkp@intel.com>
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
branch HEAD: 68252fd8890e7b54f9e0634a302f625d345493d1  erofs: boost negative xattr lookup with bloom filter

elapsed time: 720m

configs tested: 130
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230730   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r012-20230730   gcc  
arc                  randconfig-r043-20230730   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r036-20230730   gcc  
arm                  randconfig-r046-20230730   clang
arm                        realview_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230730   gcc  
arm64                randconfig-r012-20230730   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230730   gcc  
hexagon              randconfig-r021-20230730   clang
hexagon              randconfig-r025-20230730   clang
hexagon              randconfig-r041-20230730   clang
hexagon              randconfig-r045-20230730   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230730   clang
i386         buildonly-randconfig-r005-20230730   clang
i386         buildonly-randconfig-r006-20230730   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230730   clang
i386                 randconfig-i002-20230730   clang
i386                 randconfig-i003-20230730   clang
i386                 randconfig-i004-20230730   clang
i386                 randconfig-i005-20230730   clang
i386                 randconfig-i006-20230730   clang
i386                 randconfig-i011-20230730   gcc  
i386                 randconfig-i012-20230730   gcc  
i386                 randconfig-i013-20230730   gcc  
i386                 randconfig-i014-20230730   gcc  
i386                 randconfig-i015-20230730   gcc  
i386                 randconfig-i016-20230730   gcc  
i386                 randconfig-r003-20230730   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r013-20230730   gcc  
microblaze           randconfig-r024-20230730   gcc  
microblaze           randconfig-r035-20230730   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                 randconfig-r026-20230730   clang
nios2                               defconfig   gcc  
nios2                randconfig-r023-20230730   gcc  
openrisc             randconfig-r002-20230730   gcc  
openrisc             randconfig-r013-20230730   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r014-20230730   gcc  
parisc               randconfig-r022-20230730   gcc  
parisc               randconfig-r033-20230730   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r001-20230730   clang
powerpc              randconfig-r006-20230730   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r015-20230730   gcc  
riscv                randconfig-r026-20230730   gcc  
riscv                randconfig-r042-20230730   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r014-20230730   gcc  
s390                 randconfig-r016-20230730   gcc  
s390                 randconfig-r044-20230730   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230730   gcc  
sh                   randconfig-r015-20230730   gcc  
sh                   randconfig-r016-20230730   gcc  
sh                   randconfig-r023-20230730   gcc  
sh                   randconfig-r024-20230730   gcc  
sh                   randconfig-r034-20230730   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230730   gcc  
sparc64              randconfig-r032-20230730   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r006-20230730   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230730   clang
x86_64       buildonly-randconfig-r002-20230730   clang
x86_64       buildonly-randconfig-r003-20230730   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r031-20230730   clang
x86_64               randconfig-r034-20230730   clang
x86_64               randconfig-x001-20230730   gcc  
x86_64               randconfig-x002-20230730   gcc  
x86_64               randconfig-x003-20230730   gcc  
x86_64               randconfig-x004-20230730   gcc  
x86_64               randconfig-x005-20230730   gcc  
x86_64               randconfig-x006-20230730   gcc  
x86_64               randconfig-x011-20230730   clang
x86_64               randconfig-x012-20230730   clang
x86_64               randconfig-x013-20230730   clang
x86_64               randconfig-x014-20230730   clang
x86_64               randconfig-x015-20230730   clang
x86_64               randconfig-x016-20230730   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r003-20230730   gcc  
xtensa               randconfig-r004-20230730   gcc  
xtensa               randconfig-r025-20230730   gcc  
xtensa               randconfig-r031-20230730   gcc  
xtensa               randconfig-r033-20230730   gcc  
xtensa               randconfig-r035-20230730   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
