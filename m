Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FAC93930B
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2024 19:15:44 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z3c6GrpC;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WSRkP6h5pz3cY8
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jul 2024 03:15:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z3c6GrpC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WSRjr6x7cz3cXb
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jul 2024 03:15:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721668514; x=1753204514;
  h=date:from:to:cc:subject:message-id;
  bh=nGomRu/KgdF4iIsIHKQ61pTTBuiKFujkBYCixjVNAt4=;
  b=Z3c6GrpCZBTqkzz27Kc7D+R7ZSMxDlphoyaYZA+41ViRVnQKwpnS5Frx
   D6LOFaEsTEc/JkMa9kVmhHrZRxVVmHPBSRkrzpdS01BcbkoGMYdlEbTSO
   XyzzHRx5EsEHTE7Zu4OGORFfwuhHGYJkDuezTMM63UXaab401cvKpAGpr
   C2xij3zkW9OHobiCmEcN9L12x4q7GrsUihdyE+M8yjgDYEA2IhM3xv5rF
   U6w+H1JUxRbER7OoBMEmYIfZiLkU0Qu+akPWJGLpYaF3beO3kdrhUJrBe
   EqgITKbDMrOiiAz2U/E3Iwfb54iXWka4vwyl3yJcSon396JuCdxqsrwLr
   A==;
X-CSE-ConnectionGUID: 1sdiq+PwS4mWZL5fCjSC+w==
X-CSE-MsgGUID: u7n3b3xPTR6b0GJ2Bnya/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="19099725"
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="19099725"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 10:14:50 -0700
X-CSE-ConnectionGUID: z6UA/IRTRnO+X/y535YZWw==
X-CSE-MsgGUID: nY5/B5pSRk+LKT6MMJYU8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="51601002"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 22 Jul 2024 10:14:48 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sVwcY-000lG8-0c;
	Mon, 22 Jul 2024 17:14:46 +0000
Date: Tue, 23 Jul 2024 01:14:38 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 63c65795291d40fd8cc9bb0c07fb300f54dceb43
Message-ID: <202407230135.wyw5M1Nl-lkp@intel.com>
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
branch HEAD: 63c65795291d40fd8cc9bb0c07fb300f54dceb43  erofs: fix race in z_erofs_get_gbuf()

elapsed time: 723m

configs tested: 185
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240722   gcc-13.2.0
arc                   randconfig-002-20240722   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-14.1.0
arm                     davinci_all_defconfig   clang-19
arm                                 defconfig   clang-14
arm                      footbridge_defconfig   clang-19
arm                            mps2_defconfig   clang-19
arm                   randconfig-001-20240722   gcc-14.1.0
arm                   randconfig-002-20240722   clang-19
arm                   randconfig-003-20240722   clang-19
arm                   randconfig-004-20240722   clang-19
arm                         socfpga_defconfig   clang-19
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240722   clang-19
arm64                 randconfig-002-20240722   clang-19
arm64                 randconfig-003-20240722   clang-15
arm64                 randconfig-004-20240722   gcc-14.1.0
csky                             alldefconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240722   gcc-14.1.0
csky                  randconfig-002-20240722   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240722   clang-17
hexagon               randconfig-002-20240722   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240722   gcc-13
i386         buildonly-randconfig-002-20240722   gcc-13
i386         buildonly-randconfig-003-20240722   clang-18
i386         buildonly-randconfig-004-20240722   clang-18
i386         buildonly-randconfig-005-20240722   gcc-9
i386         buildonly-randconfig-006-20240722   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240722   clang-18
i386                  randconfig-002-20240722   clang-18
i386                  randconfig-003-20240722   gcc-11
i386                  randconfig-004-20240722   clang-18
i386                  randconfig-005-20240722   clang-18
i386                  randconfig-006-20240722   gcc-13
i386                  randconfig-011-20240722   gcc-13
i386                  randconfig-012-20240722   clang-18
i386                  randconfig-013-20240722   clang-18
i386                  randconfig-014-20240722   clang-18
i386                  randconfig-015-20240722   clang-18
i386                  randconfig-016-20240722   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240722   gcc-14.1.0
loongarch             randconfig-002-20240722   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                        m5307c3_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath79_defconfig   gcc-14.1.0
mips                        bcm63xx_defconfig   clang-19
mips                      fuloong2e_defconfig   clang-19
mips                     loongson1c_defconfig   clang-19
mips                      loongson3_defconfig   gcc-13.2.0
mips                      malta_kvm_defconfig   clang-19
mips                  maltasmvp_eva_defconfig   clang-19
mips                        qi_lb60_defconfig   clang-19
mips                          rb532_defconfig   clang-19
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240722   gcc-14.1.0
nios2                 randconfig-002-20240722   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                generic-32bit_defconfig   gcc-14.1.0
parisc                randconfig-001-20240722   gcc-14.1.0
parisc                randconfig-002-20240722   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                    adder875_defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                     asp8347_defconfig   clang-19
powerpc                      chrp32_defconfig   clang-19
powerpc                   lite5200b_defconfig   clang-19
powerpc                 mpc834x_itx_defconfig   clang-19
powerpc               randconfig-001-20240722   clang-19
powerpc               randconfig-002-20240722   clang-19
powerpc               randconfig-003-20240722   gcc-14.1.0
powerpc64                        alldefconfig   clang-19
powerpc64             randconfig-001-20240722   gcc-14.1.0
powerpc64             randconfig-002-20240722   gcc-14.1.0
powerpc64             randconfig-003-20240722   clang-19
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240722   clang-19
riscv                 randconfig-002-20240722   clang-17
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   gcc-14.1.0
s390                          debug_defconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240722   gcc-14.1.0
s390                  randconfig-002-20240722   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                        apsh4ad0a_defconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                        edosk7705_defconfig   gcc-14.1.0
sh                            hp6xx_defconfig   gcc-14.1.0
sh                          r7785rp_defconfig   gcc-14.1.0
sh                    randconfig-001-20240722   gcc-14.1.0
sh                    randconfig-002-20240722   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240722   gcc-14.1.0
sparc64               randconfig-002-20240722   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240722   gcc-13
um                    randconfig-002-20240722   clang-19
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240722   clang-18
x86_64       buildonly-randconfig-002-20240722   clang-18
x86_64       buildonly-randconfig-003-20240722   clang-18
x86_64       buildonly-randconfig-004-20240722   gcc-13
x86_64       buildonly-randconfig-005-20240722   gcc-13
x86_64       buildonly-randconfig-006-20240722   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240722   gcc-8
x86_64                randconfig-002-20240722   clang-18
x86_64                randconfig-003-20240722   gcc-13
x86_64                randconfig-004-20240722   gcc-13
x86_64                randconfig-005-20240722   clang-18
x86_64                randconfig-006-20240722   gcc-13
x86_64                randconfig-011-20240722   clang-18
x86_64                randconfig-012-20240722   gcc-11
x86_64                randconfig-013-20240722   gcc-9
x86_64                randconfig-014-20240722   gcc-13
x86_64                randconfig-015-20240722   clang-18
x86_64                randconfig-016-20240722   clang-18
x86_64                randconfig-071-20240722   clang-18
x86_64                randconfig-072-20240722   gcc-9
x86_64                randconfig-073-20240722   clang-18
x86_64                randconfig-074-20240722   clang-18
x86_64                randconfig-075-20240722   clang-18
x86_64                randconfig-076-20240722   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                       common_defconfig   gcc-14.1.0
xtensa                  nommu_kc705_defconfig   gcc-14.1.0
xtensa                randconfig-001-20240722   gcc-14.1.0
xtensa                randconfig-002-20240722   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
