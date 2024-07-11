Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A041292E42C
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Jul 2024 12:07:39 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Eu+ZXLN+;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WKVlV0bQ4z3cZr
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Jul 2024 20:07:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Eu+ZXLN+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WKVlP0WBSz3cXd
	for <linux-erofs@lists.ozlabs.org>; Thu, 11 Jul 2024 20:07:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720692449; x=1752228449;
  h=date:from:to:cc:subject:message-id;
  bh=DKZ8LvtoIZ2N4WulDFSzDCT2KsQz4CGYbtipTG75tc4=;
  b=Eu+ZXLN+32PyMoIsx/bhMWkg0SC5j3LesJoBR0vhlGJwxgUwX5FRuVqP
   xTNgTtccC4tJxuME97QNdzbjGXL5RQoUfs/DOkKIS14C2CF4qKfFf5KO2
   rXZYvhWh2Y3JAIAk7BW9Pw2kKW1DzcrIY4hmZA6ZI5YXUFKiLhEikHuNz
   L8he8GQldhFAnCPIu7SjssKVeEA2QR3+VisHpDreustjo/P2kQeoj1bP/
   4kr1nuPU7YyVd60N6soSD8qTL8J5v7VYmqbZU+ImpBzbXuMBUkHQwiVUE
   uIuIjj4iJdhiaNkTCjvnA7gLJK/VQD6na/4ArVDwyyx1US3n9fdXKlDVb
   A==;
X-CSE-ConnectionGUID: uYtehwpkQ/W4FFQEtGIHSw==
X-CSE-MsgGUID: lPOXHKKMSweOMiDVBUigUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="21825829"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="21825829"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 03:07:20 -0700
X-CSE-ConnectionGUID: VtWJnYkSTsaunp0WuGzwlg==
X-CSE-MsgGUID: jaPXewr6SpOfquX3zg3jSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="53686302"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 11 Jul 2024 03:07:19 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRqho-000Z80-21;
	Thu, 11 Jul 2024 10:07:16 +0000
Date: Thu, 11 Jul 2024 18:06:32 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 1c076f1f4d7fc7cfb45dba10b3b49d574b4c4c28
Message-ID: <202407111830.YwngKmSF-lkp@intel.com>
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
branch HEAD: 1c076f1f4d7fc7cfb45dba10b3b49d574b4c4c28  erofs: get rid of z_erofs_map_blocks_iter_* tracepoints

elapsed time: 1349m

configs tested: 237
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240711   gcc-13.2.0
arc                   randconfig-002-20240711   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.3.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.3.0
arm                       aspeed_g4_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                   milbeaut_m10v_defconfig   gcc-13.2.0
arm                            mps2_defconfig   clang-19
arm                            qcom_defconfig   clang-19
arm                   randconfig-001-20240711   clang-19
arm                   randconfig-001-20240711   gcc-13.2.0
arm                   randconfig-002-20240711   gcc-13.2.0
arm                   randconfig-002-20240711   gcc-13.3.0
arm                   randconfig-003-20240711   clang-19
arm                   randconfig-003-20240711   gcc-13.2.0
arm                   randconfig-004-20240711   gcc-13.2.0
arm                   randconfig-004-20240711   gcc-13.3.0
arm                          sp7021_defconfig   clang-19
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   clang-19
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240711   clang-19
arm64                 randconfig-001-20240711   gcc-13.2.0
arm64                 randconfig-002-20240711   gcc-13.2.0
arm64                 randconfig-003-20240711   gcc-13.2.0
arm64                 randconfig-004-20240711   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240711   gcc-13.2.0
csky                  randconfig-001-20240711   gcc-13.3.0
csky                  randconfig-002-20240711   gcc-13.2.0
csky                  randconfig-002-20240711   gcc-13.3.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240711   clang-19
hexagon               randconfig-002-20240711   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240711   gcc-13
i386         buildonly-randconfig-002-20240711   gcc-10
i386         buildonly-randconfig-002-20240711   gcc-13
i386         buildonly-randconfig-003-20240711   gcc-13
i386         buildonly-randconfig-004-20240711   gcc-13
i386         buildonly-randconfig-004-20240711   gcc-8
i386         buildonly-randconfig-005-20240711   gcc-10
i386         buildonly-randconfig-005-20240711   gcc-13
i386         buildonly-randconfig-006-20240711   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240711   gcc-13
i386                  randconfig-002-20240711   gcc-10
i386                  randconfig-002-20240711   gcc-13
i386                  randconfig-003-20240711   gcc-13
i386                  randconfig-003-20240711   gcc-8
i386                  randconfig-004-20240711   gcc-13
i386                  randconfig-005-20240711   clang-18
i386                  randconfig-005-20240711   gcc-13
i386                  randconfig-006-20240711   gcc-13
i386                  randconfig-011-20240711   gcc-13
i386                  randconfig-011-20240711   gcc-9
i386                  randconfig-012-20240711   clang-18
i386                  randconfig-012-20240711   gcc-13
i386                  randconfig-013-20240711   gcc-13
i386                  randconfig-014-20240711   clang-18
i386                  randconfig-014-20240711   gcc-13
i386                  randconfig-015-20240711   clang-18
i386                  randconfig-015-20240711   gcc-13
i386                  randconfig-016-20240711   gcc-13
i386                  randconfig-016-20240711   gcc-9
loongarch                        allmodconfig   gcc-13.3.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240711   gcc-13.2.0
loongarch             randconfig-001-20240711   gcc-13.3.0
loongarch             randconfig-002-20240711   gcc-13.2.0
loongarch             randconfig-002-20240711   gcc-13.3.0
m68k                             allmodconfig   gcc-13.3.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.3.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5249evb_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.3.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.3.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                         db1xxx_defconfig   clang-19
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240711   gcc-13.2.0
nios2                 randconfig-001-20240711   gcc-13.3.0
nios2                 randconfig-002-20240711   gcc-13.2.0
nios2                 randconfig-002-20240711   gcc-13.3.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.3.0
openrisc                         allyesconfig   gcc-13.3.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.3.0
parisc                            allnoconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.3.0
parisc                           allyesconfig   gcc-13.3.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240711   gcc-13.2.0
parisc                randconfig-001-20240711   gcc-13.3.0
parisc                randconfig-002-20240711   gcc-13.2.0
parisc                randconfig-002-20240711   gcc-13.3.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.3.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.3.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-13.3.0
powerpc                      chrp32_defconfig   gcc-13.2.0
powerpc                       ebony_defconfig   clang-19
powerpc                  mpc866_ads_defconfig   gcc-13.2.0
powerpc                      pcm030_defconfig   gcc-13.2.0
powerpc                         ps3_defconfig   clang-19
powerpc               randconfig-001-20240711   gcc-13.2.0
powerpc               randconfig-001-20240711   gcc-13.3.0
powerpc               randconfig-002-20240711   clang-19
powerpc               randconfig-002-20240711   gcc-13.2.0
powerpc               randconfig-003-20240711   clang-19
powerpc               randconfig-003-20240711   gcc-13.2.0
powerpc                     redwood_defconfig   gcc-13.2.0
powerpc                  storcenter_defconfig   gcc-13.2.0
powerpc                     stx_gp3_defconfig   clang-19
powerpc                         wii_defconfig   clang-19
powerpc64             randconfig-001-20240711   gcc-13.2.0
powerpc64             randconfig-001-20240711   gcc-13.3.0
powerpc64             randconfig-002-20240711   clang-16
powerpc64             randconfig-002-20240711   gcc-13.2.0
powerpc64             randconfig-003-20240711   gcc-13.2.0
powerpc64             randconfig-003-20240711   gcc-13.3.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-13.3.0
riscv                             allnoconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.3.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-13.3.0
riscv                               defconfig   gcc-13.2.0
riscv             nommu_k210_sdcard_defconfig   gcc-13.2.0
riscv                 randconfig-001-20240711   clang-14
riscv                 randconfig-001-20240711   gcc-13.2.0
riscv                 randconfig-002-20240711   gcc-13.2.0
riscv                 randconfig-002-20240711   gcc-13.3.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240711   clang-19
s390                  randconfig-001-20240711   gcc-13.2.0
s390                  randconfig-002-20240711   gcc-13.2.0
sh                               allmodconfig   gcc-13.3.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.3.0
sh                                  defconfig   gcc-13.2.0
sh                          polaris_defconfig   gcc-13.2.0
sh                    randconfig-001-20240711   gcc-13.2.0
sh                    randconfig-001-20240711   gcc-13.3.0
sh                    randconfig-002-20240711   gcc-13.2.0
sh                    randconfig-002-20240711   gcc-13.3.0
sh                           se7751_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.3.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240711   gcc-13.2.0
sparc64               randconfig-001-20240711   gcc-13.3.0
sparc64               randconfig-002-20240711   gcc-13.2.0
sparc64               randconfig-002-20240711   gcc-13.3.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240711   gcc-13.2.0
um                    randconfig-001-20240711   gcc-8
um                    randconfig-002-20240711   gcc-13.2.0
um                    randconfig-002-20240711   gcc-8
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240711   clang-18
x86_64       buildonly-randconfig-002-20240711   clang-18
x86_64       buildonly-randconfig-003-20240711   clang-18
x86_64       buildonly-randconfig-004-20240711   clang-18
x86_64       buildonly-randconfig-005-20240711   clang-18
x86_64       buildonly-randconfig-006-20240711   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240711   clang-18
x86_64                randconfig-002-20240711   clang-18
x86_64                randconfig-003-20240711   clang-18
x86_64                randconfig-004-20240711   clang-18
x86_64                randconfig-005-20240711   clang-18
x86_64                randconfig-006-20240711   clang-18
x86_64                randconfig-011-20240711   clang-18
x86_64                randconfig-012-20240711   clang-18
x86_64                randconfig-013-20240711   clang-18
x86_64                randconfig-014-20240711   clang-18
x86_64                randconfig-015-20240711   clang-18
x86_64                randconfig-016-20240711   clang-18
x86_64                randconfig-071-20240711   clang-18
x86_64                randconfig-072-20240711   clang-18
x86_64                randconfig-073-20240711   clang-18
x86_64                randconfig-074-20240711   clang-18
x86_64                randconfig-075-20240711   clang-18
x86_64                randconfig-076-20240711   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  cadence_csp_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240711   gcc-13.2.0
xtensa                randconfig-001-20240711   gcc-13.3.0
xtensa                randconfig-002-20240711   gcc-13.2.0
xtensa                randconfig-002-20240711   gcc-13.3.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
