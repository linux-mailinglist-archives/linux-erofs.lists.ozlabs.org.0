Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E58A89E1BD
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Apr 2024 19:44:09 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K5bkN2rp;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VDYHC0tQXz3dWr
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Apr 2024 03:44:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K5bkN2rp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VDYH60HK6z3dRY
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Apr 2024 03:43:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712684643; x=1744220643;
  h=date:from:to:cc:subject:message-id;
  bh=GDAqZELOrUK293Uv+IKf0hNMqiuO8lnSDUtCeoQIDYc=;
  b=K5bkN2rp+2P2/PovUwjHbAnvnAPw2E/1VrjsvbLP9SekxwHLqW0wQrx9
   ZtKhE+sq6lA7WzEw4wCKifnzODn3G4ebFv8N1YnAwkis7S4vl7bP4B1GT
   mA0lpZtzjZTusIL3dOl1M1fRJz38RjSaJ2sTQFL9CZVz0aO8SVxSZ2wfO
   elSU17ieXRV878eZrN5WoZt2mKwsMo37aer/yufqKrfOeH5rL7JvSIOeT
   4NIp7eVe1typPy/KVc6i679SLhDdZGUV/rPLuUS5/MKN0/VHE2+CmQY0U
   xVczBYXJEC3UNBZK/uj5CgjVWan9ZogguHI8mMYfA1afIdLJvXXfMVyjF
   w==;
X-CSE-ConnectionGUID: yENVVq8YQDykGBnL5i6yJg==
X-CSE-MsgGUID: JCqDTaAbSCG8o9DWzRgQFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19165385"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19165385"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 10:43:56 -0700
X-CSE-ConnectionGUID: LChqESO4Q+WBpnXsUSWIMg==
X-CSE-MsgGUID: 7s2K4bSCRziSt9ks582Htw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="51290041"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 09 Apr 2024 10:43:54 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruFVg-0006NC-0M;
	Tue, 09 Apr 2024 17:43:52 +0000
Date: Wed, 10 Apr 2024 01:43:35 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 38bac6fb80a823c4c48cdd5e8fd06568c8bdda7c
Message-ID: <202404100134.ygBUI1dh-lkp@intel.com>
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
branch HEAD: 38bac6fb80a823c4c48cdd5e8fd06568c8bdda7c  erofs: add a reserved buffer pool for lz4 decompression

elapsed time: 1049m

configs tested: 154
configs skipped: 3

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
arc                   randconfig-001-20240409   gcc  
arc                   randconfig-002-20240409   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240409   gcc  
arm                   randconfig-004-20240409   gcc  
arm                           sunxi_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240409   gcc  
arm64                 randconfig-002-20240409   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240409   gcc  
csky                  randconfig-002-20240409   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-003-20240409   gcc  
i386         buildonly-randconfig-005-20240409   gcc  
i386         buildonly-randconfig-006-20240409   gcc  
i386                                defconfig   clang
i386                  randconfig-002-20240409   gcc  
i386                  randconfig-004-20240409   gcc  
i386                  randconfig-005-20240409   gcc  
i386                  randconfig-011-20240409   gcc  
i386                  randconfig-015-20240409   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240409   gcc  
loongarch             randconfig-002-20240409   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240409   gcc  
nios2                 randconfig-002-20240409   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240409   gcc  
parisc                randconfig-002-20240409   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                  iss476-smp_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-002-20240409   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc64             randconfig-001-20240409   gcc  
powerpc64             randconfig-003-20240409   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-002-20240409   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240409   gcc  
s390                  randconfig-002-20240409   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                    randconfig-001-20240409   gcc  
sh                    randconfig-002-20240409   gcc  
sh                           se7705_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240409   gcc  
sparc64               randconfig-002-20240409   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-002-20240409   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240409   clang
x86_64       buildonly-randconfig-002-20240409   clang
x86_64       buildonly-randconfig-005-20240409   clang
x86_64       buildonly-randconfig-006-20240409   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240409   clang
x86_64                randconfig-002-20240409   clang
x86_64                randconfig-005-20240409   clang
x86_64                randconfig-006-20240409   clang
x86_64                randconfig-012-20240409   clang
x86_64                randconfig-014-20240409   clang
x86_64                randconfig-072-20240409   clang
x86_64                randconfig-073-20240409   clang
x86_64                randconfig-074-20240409   clang
x86_64                randconfig-075-20240409   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20240409   gcc  
xtensa                randconfig-002-20240409   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
