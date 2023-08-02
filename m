Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CB476C3A3
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Aug 2023 05:41:26 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iS3VnBcK;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RFySd1qY2z2ypy
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Aug 2023 13:41:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iS3VnBcK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.115; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (unknown [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RFySW2dfVz2y3Y
	for <linux-erofs@lists.ozlabs.org>; Wed,  2 Aug 2023 13:41:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690947675; x=1722483675;
  h=date:from:to:cc:subject:message-id;
  bh=cgnq0ZoD4dsQ2PKkoI4QbK+ZqN7a57hA3/DgdbuBF3k=;
  b=iS3VnBcKT4L8xbXl53cTXzd6EnnT7Jggv7purMovaaFbr1j4qxNMvh3j
   GzgKx2RlV+UmEzbPFURTi3i3C50vKqvxbAK+K1xql1to+MTWjAgjy8sE1
   xc4FKWGdggHfPuZ2xZuUWe/a6DoK9e9I4ndxEv1p9roxHi8YHRffS83Mk
   Z3wHnsxRHOQDluyxZAv+uTUfEE0Pm66B4ZMeo2txwA9m9jTmriHoCaWee
   qKM91fbWDCz1C9+7Wo7fbynpEIHIlNGQCKlkRMos1ONkPagOyEBbYADAr
   EiFN+p2HizFM6RARUzV+nuPtdRPS4cmJUV0nndq5M4ZCPJm7ASFHfYCHV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="369468495"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="369468495"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 20:41:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="678885292"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="678885292"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Aug 2023 20:41:05 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qR2jQ-0000oi-2g;
	Wed, 02 Aug 2023 03:41:04 +0000
Date: Wed, 02 Aug 2023 11:40:50 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 8c53383377ba43fbf933f58eb6e0772992e78f7f
Message-ID: <202308021148.7nzjbHY3-lkp@intel.com>
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
branch HEAD: 8c53383377ba43fbf933f58eb6e0772992e78f7f  erofs: boost negative xattr lookup with bloom filter

elapsed time: 935m

configs tested: 167
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230731   gcc  
alpha                randconfig-r022-20230731   gcc  
alpha                randconfig-r036-20230801   gcc  
arc                              alldefconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230801   gcc  
arc                  randconfig-r032-20230731   gcc  
arc                  randconfig-r033-20230731   gcc  
arc                  randconfig-r043-20230731   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                  randconfig-r046-20230731   gcc  
arm                          sp7021_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230801   gcc  
arm64                randconfig-r013-20230731   clang
arm64                randconfig-r021-20230731   clang
csky                                defconfig   gcc  
csky                 randconfig-r036-20230731   gcc  
hexagon              randconfig-r041-20230731   clang
hexagon              randconfig-r045-20230731   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230731   gcc  
i386         buildonly-randconfig-r005-20230731   gcc  
i386         buildonly-randconfig-r006-20230731   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230731   gcc  
i386                 randconfig-i001-20230801   gcc  
i386                 randconfig-i002-20230731   gcc  
i386                 randconfig-i002-20230801   gcc  
i386                 randconfig-i003-20230731   gcc  
i386                 randconfig-i003-20230801   gcc  
i386                 randconfig-i004-20230731   gcc  
i386                 randconfig-i004-20230801   gcc  
i386                 randconfig-i005-20230731   gcc  
i386                 randconfig-i005-20230801   gcc  
i386                 randconfig-i006-20230731   gcc  
i386                 randconfig-i006-20230801   gcc  
i386                 randconfig-i011-20230731   clang
i386                 randconfig-i011-20230801   clang
i386                 randconfig-i012-20230731   clang
i386                 randconfig-i012-20230801   clang
i386                 randconfig-i013-20230731   clang
i386                 randconfig-i013-20230801   clang
i386                 randconfig-i014-20230731   clang
i386                 randconfig-i014-20230801   clang
i386                 randconfig-i015-20230731   clang
i386                 randconfig-i015-20230801   clang
i386                 randconfig-i016-20230731   clang
i386                 randconfig-i016-20230801   clang
i386                 randconfig-r004-20230801   gcc  
i386                 randconfig-r014-20230731   clang
i386                 randconfig-r024-20230731   clang
i386                 randconfig-r026-20230731   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230731   gcc  
loongarch            randconfig-r023-20230731   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230801   gcc  
m68k                 randconfig-r006-20230801   gcc  
m68k                 randconfig-r026-20230731   gcc  
microblaze           randconfig-r013-20230731   gcc  
microblaze           randconfig-r023-20230731   gcc  
microblaze           randconfig-r025-20230731   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                          malta_defconfig   clang
mips                malta_qemu_32r6_defconfig   clang
mips                 randconfig-r001-20230801   clang
mips                 randconfig-r022-20230731   gcc  
mips                 randconfig-r035-20230731   clang
nios2                         3c120_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230801   gcc  
nios2                randconfig-r015-20230731   gcc  
openrisc                         alldefconfig   gcc  
openrisc             randconfig-r003-20230801   gcc  
openrisc             randconfig-r012-20230731   gcc  
openrisc             randconfig-r014-20230731   gcc  
openrisc             randconfig-r034-20230801   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                     mpc5200_defconfig   clang
powerpc                 mpc8313_rdb_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                      obs600_defconfig   clang
powerpc              randconfig-r021-20230731   clang
powerpc                     tqm8555_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r034-20230731   gcc  
riscv                randconfig-r042-20230731   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230801   gcc  
s390                 randconfig-r044-20230731   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r003-20230801   gcc  
sh                   randconfig-r005-20230801   gcc  
sh                   randconfig-r011-20230731   gcc  
sh                           se7751_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r033-20230801   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r015-20230731   gcc  
sparc64              randconfig-r031-20230801   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r024-20230731   gcc  
um                   randconfig-r025-20230731   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230731   gcc  
x86_64       buildonly-randconfig-r002-20230731   gcc  
x86_64       buildonly-randconfig-r003-20230731   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r031-20230731   gcc  
x86_64               randconfig-x001-20230731   clang
x86_64               randconfig-x001-20230801   clang
x86_64               randconfig-x002-20230731   clang
x86_64               randconfig-x002-20230801   clang
x86_64               randconfig-x003-20230731   clang
x86_64               randconfig-x003-20230801   clang
x86_64               randconfig-x004-20230731   clang
x86_64               randconfig-x004-20230801   clang
x86_64               randconfig-x005-20230731   clang
x86_64               randconfig-x005-20230801   clang
x86_64               randconfig-x006-20230731   clang
x86_64               randconfig-x006-20230801   clang
x86_64               randconfig-x011-20230731   gcc  
x86_64               randconfig-x012-20230731   gcc  
x86_64               randconfig-x013-20230731   gcc  
x86_64               randconfig-x014-20230731   gcc  
x86_64               randconfig-x015-20230731   gcc  
x86_64               randconfig-x016-20230731   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
