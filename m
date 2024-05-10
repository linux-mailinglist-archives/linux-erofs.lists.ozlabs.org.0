Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4398C198F
	for <lists+linux-erofs@lfdr.de>; Fri, 10 May 2024 00:45:45 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HW3w9qyl;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vb6YK4RFbz3cX6
	for <lists+linux-erofs@lfdr.de>; Fri, 10 May 2024 08:45:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HW3w9qyl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vb6YB37Smz3cW7
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 May 2024 08:45:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715294735; x=1746830735;
  h=date:from:to:cc:subject:message-id;
  bh=qVx2Gxfnm10kZTmnKxUaHhviHCUAocDyX9SY/WSEw9I=;
  b=HW3w9qylKNe/0c7uWfpjx5ofT1eL5mHjlZsy1Lahm4antAL2AMOdWVKM
   j6diGCUtjRi2mxmmV9ZuBlE4554jHIOybO3W4X40m1PG2fDNaLnymsNMl
   B2TQVe4MJkoiwzHUPtKUL6YrJAoGvahGUYYJHYemHjqJRxxu9cAd86JbQ
   WnpLf9ALFHutxsrtevglWgY72O7nbdnvY3+g4m06m88an/vK4Nfx1QVGC
   CrYVn+Qiz9v6SvRLaKKHAL6N6mC7a9ePu7QN0k2Zdfu+iUcY97epO7SaX
   aWIcS8uO/GwFdCkOGFGSg6MtUhSL77AMVZf015Vlr7uxLzQgEM2Dm9kAp
   w==;
X-CSE-ConnectionGUID: iWqaQMX9TqSSU1B65PtSwQ==
X-CSE-MsgGUID: V6jod9PzTzmoQ9+GdRfnyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11417555"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="11417555"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 15:45:29 -0700
X-CSE-ConnectionGUID: ouplH2N+Qnu2ZyGE7C11Kw==
X-CSE-MsgGUID: 7h1PyqCDQy+iG8akiOCwXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="34070583"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 09 May 2024 15:45:27 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5CVx-0005Rv-0B;
	Thu, 09 May 2024 22:45:25 +0000
Date: Fri, 10 May 2024 06:45:05 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 7c35de4df1056a5a1fb4de042197b8f5b1033b61
Message-ID: <202405100603.aZWw5i01-lkp@intel.com>
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
branch HEAD: 7c35de4df1056a5a1fb4de042197b8f5b1033b61  erofs: Zstandard compression support

elapsed time: 1320m

configs tested: 190
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
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240509   gcc  
arc                   randconfig-001-20240510   gcc  
arc                   randconfig-002-20240509   gcc  
arc                   randconfig-002-20240510   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   gcc  
arm                                 defconfig   clang
arm                           imxrt_defconfig   clang
arm                          moxart_defconfig   gcc  
arm                   randconfig-001-20240509   gcc  
arm                   randconfig-001-20240510   gcc  
arm                   randconfig-002-20240510   clang
arm                   randconfig-003-20240510   gcc  
arm                   randconfig-004-20240510   gcc  
arm                         s3c6400_defconfig   gcc  
arm                       spear13xx_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240510   clang
arm64                 randconfig-002-20240510   gcc  
arm64                 randconfig-003-20240509   gcc  
arm64                 randconfig-003-20240510   clang
arm64                 randconfig-004-20240510   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240509   gcc  
csky                  randconfig-001-20240510   gcc  
csky                  randconfig-002-20240509   gcc  
csky                  randconfig-002-20240510   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240510   clang
hexagon               randconfig-002-20240510   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240509   gcc  
i386         buildonly-randconfig-002-20240509   gcc  
i386         buildonly-randconfig-003-20240509   clang
i386         buildonly-randconfig-004-20240509   clang
i386         buildonly-randconfig-005-20240509   gcc  
i386         buildonly-randconfig-006-20240509   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240509   clang
i386                  randconfig-002-20240509   clang
i386                  randconfig-003-20240509   clang
i386                  randconfig-004-20240509   gcc  
i386                  randconfig-005-20240509   clang
i386                  randconfig-006-20240509   gcc  
i386                  randconfig-011-20240509   clang
i386                  randconfig-012-20240509   gcc  
i386                  randconfig-013-20240509   clang
i386                  randconfig-014-20240509   gcc  
i386                  randconfig-015-20240509   gcc  
i386                  randconfig-016-20240509   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240509   gcc  
loongarch             randconfig-001-20240510   gcc  
loongarch             randconfig-002-20240509   gcc  
loongarch             randconfig-002-20240510   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                          multi_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                           xway_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240509   gcc  
nios2                 randconfig-001-20240510   gcc  
nios2                 randconfig-002-20240509   gcc  
nios2                 randconfig-002-20240510   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240509   gcc  
parisc                randconfig-001-20240510   gcc  
parisc                randconfig-002-20240509   gcc  
parisc                randconfig-002-20240510   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc               randconfig-001-20240510   gcc  
powerpc               randconfig-002-20240510   gcc  
powerpc               randconfig-003-20240510   clang
powerpc                  storcenter_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240510   clang
powerpc64             randconfig-002-20240509   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240509   gcc  
riscv                 randconfig-002-20240509   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240509   gcc  
s390                  randconfig-002-20240509   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20240509   gcc  
sh                    randconfig-002-20240509   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240509   gcc  
sparc64               randconfig-002-20240509   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-002-20240509   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240509   clang
x86_64       buildonly-randconfig-002-20240509   clang
x86_64       buildonly-randconfig-002-20240510   clang
x86_64       buildonly-randconfig-003-20240510   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240509   clang
x86_64                randconfig-005-20240509   clang
x86_64                randconfig-006-20240509   clang
x86_64                randconfig-011-20240509   clang
x86_64                randconfig-012-20240509   clang
x86_64                randconfig-014-20240509   clang
x86_64                randconfig-015-20240509   clang
x86_64                randconfig-071-20240509   clang
x86_64                randconfig-072-20240509   clang
x86_64                randconfig-073-20240509   clang
x86_64                randconfig-074-20240509   clang
x86_64                randconfig-075-20240509   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240509   gcc  
xtensa                randconfig-002-20240509   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
