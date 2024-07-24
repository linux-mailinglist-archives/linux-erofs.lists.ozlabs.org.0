Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B623493B8CB
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2024 23:49:54 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C2kXcz0O;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WTnjr4VBFz3clw
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jul 2024 07:49:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C2kXcz0O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WTnjl2M05z3c1L
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Jul 2024 07:49:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721857788; x=1753393788;
  h=date:from:to:cc:subject:message-id;
  bh=MJPCYPOfQY/xhCHjDwai/lLOIcv/BoQREEEO3/vu54A=;
  b=C2kXcz0O+bXQEBTACup+3tK+GWqB8uZQMKo14CyFo+8qXnQaSiSeHcyS
   MEGUiAwIGcLSsO21RafbIkPTjtqDYBVAazQzBxJj4jMtq1l+fK3wRjcgO
   Z34gzUfsbK/WG/qeI19m9CCHe8SaAd/wwNNRebGFfUBuKQSBGbOCsTQIU
   QBSr0wVBfFBidIFxh6lMpSn0yWOXh8h+VpyvUrLuozMoGMEwLDEiT7uWo
   TS1EH9JXi8gt8zRj/xRBf5sEM/wcOqmkNcOhay3IClFhZUAfHTJERtJbY
   dCCoZdIdb13lCR/j4Nq5zIkyLas2Bsal+eElfhPD+lcs3+sl1JW6v4ZkZ
   g==;
X-CSE-ConnectionGUID: +GLn48xWT5il6/43lbg1RA==
X-CSE-MsgGUID: fymy6BlkTF2z+jBaFRVY1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19259399"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="19259399"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 14:49:40 -0700
X-CSE-ConnectionGUID: xYo9RzFgRI6d3R9tQoKrlQ==
X-CSE-MsgGUID: tJ9CAV6gQjmAwdnKuQViPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="57851056"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 24 Jul 2024 14:49:39 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWjrc-000nTA-2H;
	Wed, 24 Jul 2024 21:49:36 +0000
Date: Thu, 25 Jul 2024 05:49:03 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 227ed3562a9ab25cb526281fe99075e2d0c67143
Message-ID: <202407250500.gmcL6yAx-lkp@intel.com>
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
branch HEAD: 227ed3562a9ab25cb526281fe99075e2d0c67143  erofs: convert comma to semicolon

elapsed time: 1071m

configs tested: 263
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                      axs103_smp_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240724   gcc-13.2.0
arc                   randconfig-002-20240724   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                       aspeed_g5_defconfig   gcc-14.1.0
arm                     davinci_all_defconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                            hisi_defconfig   gcc-13.2.0
arm                        multi_v5_defconfig   gcc-13.2.0
arm                           omap1_defconfig   gcc-14.1.0
arm                   randconfig-001-20240724   clang-19
arm                   randconfig-001-20240724   gcc-13.2.0
arm                   randconfig-002-20240724   clang-19
arm                   randconfig-002-20240724   gcc-13.2.0
arm                   randconfig-003-20240724   clang-19
arm                   randconfig-003-20240724   gcc-13.2.0
arm                   randconfig-004-20240724   gcc-13.2.0
arm                   randconfig-004-20240724   gcc-14.1.0
arm                       spear13xx_defconfig   gcc-14.1.0
arm                           spitz_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240724   gcc-13.2.0
arm64                 randconfig-001-20240724   gcc-14.1.0
arm64                 randconfig-002-20240724   gcc-13.2.0
arm64                 randconfig-002-20240724   gcc-14.1.0
arm64                 randconfig-003-20240724   gcc-13.2.0
arm64                 randconfig-003-20240724   gcc-14.1.0
arm64                 randconfig-004-20240724   gcc-13.2.0
arm64                 randconfig-004-20240724   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240724   gcc-13.2.0
csky                  randconfig-001-20240724   gcc-14.1.0
csky                  randconfig-002-20240724   gcc-13.2.0
csky                  randconfig-002-20240724   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240724   clang-19
hexagon               randconfig-002-20240724   clang-19
i386                             alldefconfig   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240724   clang-18
i386         buildonly-randconfig-001-20240725   gcc-13
i386         buildonly-randconfig-002-20240724   clang-18
i386         buildonly-randconfig-002-20240724   gcc-9
i386         buildonly-randconfig-002-20240725   gcc-13
i386         buildonly-randconfig-003-20240724   clang-18
i386         buildonly-randconfig-003-20240725   gcc-13
i386         buildonly-randconfig-004-20240724   clang-18
i386         buildonly-randconfig-004-20240725   gcc-13
i386         buildonly-randconfig-005-20240724   clang-18
i386         buildonly-randconfig-005-20240725   gcc-13
i386         buildonly-randconfig-006-20240724   clang-18
i386         buildonly-randconfig-006-20240725   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240724   clang-18
i386                  randconfig-001-20240725   gcc-13
i386                  randconfig-002-20240724   clang-18
i386                  randconfig-002-20240725   gcc-13
i386                  randconfig-003-20240724   clang-18
i386                  randconfig-003-20240725   gcc-13
i386                  randconfig-004-20240724   clang-18
i386                  randconfig-004-20240724   gcc-9
i386                  randconfig-004-20240725   gcc-13
i386                  randconfig-005-20240724   clang-18
i386                  randconfig-005-20240725   gcc-13
i386                  randconfig-006-20240724   clang-18
i386                  randconfig-006-20240725   gcc-13
i386                  randconfig-011-20240724   clang-18
i386                  randconfig-011-20240724   gcc-13
i386                  randconfig-011-20240725   gcc-13
i386                  randconfig-012-20240724   clang-18
i386                  randconfig-012-20240725   gcc-13
i386                  randconfig-013-20240724   clang-18
i386                  randconfig-013-20240724   gcc-13
i386                  randconfig-013-20240725   gcc-13
i386                  randconfig-014-20240724   clang-18
i386                  randconfig-014-20240724   gcc-8
i386                  randconfig-014-20240725   gcc-13
i386                  randconfig-015-20240724   clang-18
i386                  randconfig-015-20240724   gcc-13
i386                  randconfig-015-20240725   gcc-13
i386                  randconfig-016-20240724   clang-18
i386                  randconfig-016-20240725   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240724   gcc-13.2.0
loongarch             randconfig-001-20240724   gcc-14.1.0
loongarch             randconfig-002-20240724   gcc-13.2.0
loongarch             randconfig-002-20240724   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                        m5272c3_defconfig   gcc-13.2.0
m68k                          sun3x_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                         bigsur_defconfig   gcc-14.1.0
mips                      fuloong2e_defconfig   gcc-13.2.0
mips                           gcw0_defconfig   gcc-13.2.0
mips                       lemote2f_defconfig   gcc-13.2.0
mips                      pic32mzda_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240724   gcc-13.2.0
nios2                 randconfig-001-20240724   gcc-14.1.0
nios2                 randconfig-002-20240724   gcc-13.2.0
nios2                 randconfig-002-20240724   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240724   gcc-13.2.0
parisc                randconfig-001-20240724   gcc-14.1.0
parisc                randconfig-002-20240724   gcc-13.2.0
parisc                randconfig-002-20240724   gcc-14.1.0
parisc64                         alldefconfig   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-14.1.0
powerpc                     ksi8560_defconfig   gcc-14.1.0
powerpc                 mpc837x_rdb_defconfig   gcc-14.1.0
powerpc                     mpc83xx_defconfig   gcc-13.2.0
powerpc                      pmac32_defconfig   gcc-14.1.0
powerpc                      ppc44x_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240724   clang-19
powerpc               randconfig-001-20240724   gcc-13.2.0
powerpc               randconfig-002-20240724   gcc-13.2.0
powerpc               randconfig-002-20240724   gcc-14.1.0
powerpc               randconfig-003-20240724   clang-19
powerpc               randconfig-003-20240724   gcc-13.2.0
powerpc                     redwood_defconfig   gcc-14.1.0
powerpc                     taishan_defconfig   gcc-13.2.0
powerpc                     tqm8560_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240724   clang-19
powerpc64             randconfig-001-20240724   gcc-13.2.0
powerpc64             randconfig-002-20240724   gcc-13.2.0
powerpc64             randconfig-002-20240724   gcc-14.1.0
powerpc64             randconfig-003-20240724   clang-19
powerpc64             randconfig-003-20240724   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   clang-19
riscv                               defconfig   gcc-14.1.0
riscv             nommu_k210_sdcard_defconfig   gcc-14.1.0
riscv                    nommu_virt_defconfig   gcc-14.1.0
riscv                 randconfig-001-20240724   gcc-13.2.0
riscv                 randconfig-001-20240724   gcc-14.1.0
riscv                 randconfig-002-20240724   gcc-13.2.0
riscv                 randconfig-002-20240724   gcc-14.1.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240724   gcc-13.2.0
s390                  randconfig-001-20240724   gcc-14.1.0
s390                  randconfig-002-20240724   clang-19
s390                  randconfig-002-20240724   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                            hp6xx_defconfig   gcc-13.2.0
sh                               j2_defconfig   gcc-13.2.0
sh                            migor_defconfig   gcc-14.1.0
sh                          r7785rp_defconfig   gcc-13.2.0
sh                    randconfig-001-20240724   gcc-13.2.0
sh                    randconfig-001-20240724   gcc-14.1.0
sh                    randconfig-002-20240724   gcc-13.2.0
sh                    randconfig-002-20240724   gcc-14.1.0
sh                          sdk7780_defconfig   gcc-13.2.0
sh                           se7705_defconfig   gcc-13.2.0
sh                        sh7763rdp_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240724   gcc-13.2.0
sparc64               randconfig-001-20240724   gcc-14.1.0
sparc64               randconfig-002-20240724   gcc-13.2.0
sparc64               randconfig-002-20240724   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240724   clang-15
um                    randconfig-001-20240724   gcc-13.2.0
um                    randconfig-002-20240724   gcc-13
um                    randconfig-002-20240724   gcc-13.2.0
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240724   clang-18
x86_64       buildonly-randconfig-002-20240724   clang-18
x86_64       buildonly-randconfig-003-20240724   clang-18
x86_64       buildonly-randconfig-004-20240724   clang-18
x86_64       buildonly-randconfig-005-20240724   clang-18
x86_64       buildonly-randconfig-006-20240724   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240724   clang-18
x86_64                randconfig-002-20240724   clang-18
x86_64                randconfig-003-20240724   clang-18
x86_64                randconfig-004-20240724   clang-18
x86_64                randconfig-005-20240724   clang-18
x86_64                randconfig-006-20240724   clang-18
x86_64                randconfig-011-20240724   clang-18
x86_64                randconfig-012-20240724   clang-18
x86_64                randconfig-013-20240724   clang-18
x86_64                randconfig-014-20240724   clang-18
x86_64                randconfig-015-20240724   clang-18
x86_64                randconfig-016-20240724   clang-18
x86_64                randconfig-071-20240724   clang-18
x86_64                randconfig-072-20240724   clang-18
x86_64                randconfig-073-20240724   clang-18
x86_64                randconfig-074-20240724   clang-18
x86_64                randconfig-075-20240724   clang-18
x86_64                randconfig-076-20240724   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240724   gcc-13.2.0
xtensa                randconfig-001-20240724   gcc-14.1.0
xtensa                randconfig-002-20240724   gcc-13.2.0
xtensa                randconfig-002-20240724   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
