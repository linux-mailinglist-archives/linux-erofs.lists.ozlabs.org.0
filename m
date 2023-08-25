Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D52788832
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Aug 2023 15:15:42 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TvEdxir5;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RXL6h5Vf4z2ygx
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Aug 2023 23:15:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TvEdxir5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.88; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RXL6X3RlDz2yVw
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Aug 2023 23:15:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692969332; x=1724505332;
  h=date:from:to:cc:subject:message-id;
  bh=j+aQxW52VEEZbYr4raatjhNV6AZVMC1V37BzG6MaPnQ=;
  b=TvEdxir5vk2o2cxM16HCEPQOMlUI9vJyotWkH6WU1K7Q1Ez5yZ+q9hKA
   yLd3+HjaPGRuryZPPIoQVzwbQPebPpGa2LFiTQiwcy2SeQtiaGQd6YjQI
   Pu15KeBKhsZPkvze9sqjCJAYRyhZy1uEkh1Fp5fSXeT3vz404FUzBM9iV
   aSgdzNcGVX8JXDeVnBCGMJDN+wxGs/K/fr7PXN3qtbGoqmRlChem4LrJg
   K7YHb2VvmFl+VYQBpkC3K+bOAhpRWYnHJN7rFOg6ojt5dHrBI5Putn8k6
   NY3thdT2SfD//hiG2QShN7JLCdZDS5hAbrVbyowZ0VKdZVg+fXs+dIt2l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="405709908"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="405709908"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 06:15:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881168662"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 25 Aug 2023 06:15:29 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qZWep-0003b4-1E;
	Fri, 25 Aug 2023 13:15:23 +0000
Date: Fri, 25 Aug 2023 21:15:11 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 91b1ad0815fbb1095c8b9e8a2bf4201186afe304
Message-ID: <202308252109.pMHj7xs5-lkp@intel.com>
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
branch HEAD: 91b1ad0815fbb1095c8b9e8a2bf4201186afe304  erofs: release ztailpacking pclusters properly

elapsed time: 2685m

configs tested: 134
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230824   gcc  
arc                  randconfig-r002-20230824   gcc  
arc                  randconfig-r006-20230824   gcc  
arc                  randconfig-r013-20230824   gcc  
arc                  randconfig-r023-20230824   gcc  
arc                  randconfig-r025-20230824   gcc  
arc                  randconfig-r032-20230824   gcc  
arc                  randconfig-r035-20230824   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230824   gcc  
arm                  randconfig-r011-20230824   gcc  
arm                  randconfig-r023-20230824   gcc  
arm                  randconfig-r024-20230824   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230824   gcc  
arm64                randconfig-r004-20230824   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r012-20230824   gcc  
csky                 randconfig-r015-20230824   gcc  
csky                 randconfig-r036-20230824   gcc  
hexagon               randconfig-001-20230824   clang
hexagon               randconfig-002-20230824   clang
hexagon              randconfig-r011-20230824   clang
hexagon              randconfig-r034-20230824   clang
i386                              allnoconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-r031-20230824   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230824   gcc  
loongarch            randconfig-r005-20230824   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r016-20230824   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r033-20230824   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r014-20230824   gcc  
mips                 randconfig-r021-20230824   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230824   gcc  
nios2                randconfig-r022-20230824   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r026-20230824   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230824   gcc  
parisc               randconfig-r013-20230824   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r003-20230824   gcc  
powerpc64            randconfig-r016-20230824   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230824   gcc  
riscv                randconfig-r004-20230824   gcc  
riscv                randconfig-r015-20230824   clang
riscv                randconfig-r024-20230824   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230824   clang
s390                 randconfig-r022-20230824   clang
s390                 randconfig-r026-20230824   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r002-20230824   gcc  
sh                   randconfig-r031-20230824   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r012-20230824   gcc  
sparc                randconfig-r021-20230824   gcc  
sparc                randconfig-r035-20230824   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r033-20230824   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64               randconfig-r001-20230824   gcc  
x86_64               randconfig-r005-20230824   gcc  
x86_64               randconfig-r032-20230824   gcc  
x86_64               randconfig-r034-20230824   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r006-20230824   gcc  
xtensa               randconfig-r036-20230824   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
