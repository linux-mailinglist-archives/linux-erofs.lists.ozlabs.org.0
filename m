Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E553A8B4F98
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Apr 2024 04:51:07 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MhBRMHvn;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VSSWX4ngmz3cS3
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Apr 2024 12:51:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MhBRMHvn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VSSWL0VSdz3cGc
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Apr 2024 12:50:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714359054; x=1745895054;
  h=date:from:to:cc:subject:message-id;
  bh=CQX21gwA3BH8V91omDktbff9BsvfxbttmqMFpjAmv+c=;
  b=MhBRMHvnaJtqr+QKI3TO55+ntHDZQT2OG4RT6I0EX0qfwYUNXKjtNJz1
   WyPpLHEvQFOZ00mf//IVlBOFJ85dGZPZq1qFlkFTrNocblZXTNTHUWwXA
   c1ZVOhW7QOe9J/TaDkyoh6to8AnsvteiGbvURU09fc2UsGgyx/vJeULoH
   rsKEu6LhGJDN1NfONSqME3qIS07rZ9V56k8D3swdaY9tWv0UQuK8OtzTG
   L39YVSap7KJY8U8AW39x6+XjArp1Cz/YUJOdjOornd9+FA7vSlMElf0JN
   Lk3UxbE6eR9ye8A4h7Qk/ML/otRzkNgZ1BNd10A3w6D2EEJ645ZT0AfSB
   A==;
X-CSE-ConnectionGUID: +3ku6j24RpCLN9u5XA9diw==
X-CSE-MsgGUID: LlR7vociRyK23Fpm8XDCwQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9933985"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="9933985"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 19:50:18 -0700
X-CSE-ConnectionGUID: jmZycRazSbqh1kDYBEFucg==
X-CSE-MsgGUID: O+NFLKwYSv6NTG7gUixp7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="30643903"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 28 Apr 2024 19:50:16 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1H5q-0006te-0y;
	Mon, 29 Apr 2024 02:50:14 +0000
Date: Mon, 29 Apr 2024 10:49:15 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 7af2ae1b1531feab5d38ec9c8f472dc6cceb4606
Message-ID: <202404291011.U7fcvYuY-lkp@intel.com>
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
branch HEAD: 7af2ae1b1531feab5d38ec9c8f472dc6cceb4606  erofs: reliably distinguish block based and fscache mode

elapsed time: 777m

configs tested: 176
configs skipped: 4

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
arc                   randconfig-001-20240428   gcc  
arc                   randconfig-002-20240428   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        keystone_defconfig   gcc  
arm                          pxa168_defconfig   clang
arm                            qcom_defconfig   clang
arm                   randconfig-001-20240428   gcc  
arm                   randconfig-002-20240428   clang
arm                   randconfig-003-20240428   clang
arm                   randconfig-004-20240428   clang
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240428   gcc  
arm64                 randconfig-002-20240428   gcc  
arm64                 randconfig-003-20240428   clang
arm64                 randconfig-004-20240428   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240428   gcc  
csky                  randconfig-002-20240428   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240428   clang
hexagon               randconfig-002-20240428   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240428   gcc  
i386         buildonly-randconfig-002-20240428   clang
i386         buildonly-randconfig-003-20240428   clang
i386         buildonly-randconfig-004-20240428   clang
i386         buildonly-randconfig-005-20240428   clang
i386         buildonly-randconfig-006-20240428   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240428   clang
i386                  randconfig-002-20240428   clang
i386                  randconfig-003-20240428   clang
i386                  randconfig-004-20240428   clang
i386                  randconfig-005-20240428   gcc  
i386                  randconfig-006-20240428   gcc  
i386                  randconfig-011-20240428   gcc  
i386                  randconfig-012-20240428   clang
i386                  randconfig-013-20240428   gcc  
i386                  randconfig-014-20240428   gcc  
i386                  randconfig-015-20240428   clang
i386                  randconfig-016-20240428   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240428   gcc  
loongarch             randconfig-002-20240428   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                       rbtx49xx_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240428   gcc  
nios2                 randconfig-002-20240428   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240428   gcc  
parisc                randconfig-002-20240428   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20240428   clang
powerpc               randconfig-002-20240428   gcc  
powerpc               randconfig-003-20240428   gcc  
powerpc                      tqm8xx_defconfig   clang
powerpc                      walnut_defconfig   gcc  
powerpc64             randconfig-001-20240428   gcc  
powerpc64             randconfig-002-20240428   clang
powerpc64             randconfig-003-20240428   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240428   gcc  
riscv                 randconfig-002-20240428   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240428   clang
s390                  randconfig-002-20240428   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                    randconfig-001-20240428   gcc  
sh                    randconfig-002-20240428   gcc  
sh                           se7343_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240428   gcc  
sparc64               randconfig-002-20240428   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240428   clang
um                    randconfig-002-20240428   clang
um                           x86_64_defconfig   clang
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240428   gcc  
x86_64       buildonly-randconfig-002-20240428   clang
x86_64       buildonly-randconfig-003-20240428   gcc  
x86_64       buildonly-randconfig-004-20240428   clang
x86_64       buildonly-randconfig-005-20240428   gcc  
x86_64       buildonly-randconfig-006-20240428   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240428   gcc  
x86_64                randconfig-002-20240428   clang
x86_64                randconfig-003-20240428   gcc  
x86_64                randconfig-004-20240428   clang
x86_64                randconfig-005-20240428   gcc  
x86_64                randconfig-006-20240428   clang
x86_64                randconfig-011-20240428   gcc  
x86_64                randconfig-012-20240428   clang
x86_64                randconfig-013-20240428   gcc  
x86_64                randconfig-014-20240428   clang
x86_64                randconfig-015-20240428   clang
x86_64                randconfig-016-20240428   gcc  
x86_64                randconfig-071-20240428   gcc  
x86_64                randconfig-072-20240428   clang
x86_64                randconfig-073-20240428   gcc  
x86_64                randconfig-074-20240428   gcc  
x86_64                randconfig-075-20240428   clang
x86_64                randconfig-076-20240428   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240428   gcc  
xtensa                randconfig-002-20240428   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
