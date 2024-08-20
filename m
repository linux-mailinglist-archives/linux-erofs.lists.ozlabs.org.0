Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE56957BAF
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2024 04:54:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WnvFB6ycCz2y8Z
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2024 12:54:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lIFP5ETO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WnvF62gmKz2xdR
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2024 12:54:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724122458; x=1755658458;
  h=date:from:to:cc:subject:message-id;
  bh=BSsDizDbS5odtp6vLcF8Ab3ZPiQosIzPiKPBC6yTpro=;
  b=lIFP5ETO4QovQCBXE/sPgLJ8dvXNYREp+Mv+oRaTFjHqPhWQxlvb/yVk
   5eo1NLHmx24qUC0t6YLneWLGBiHY4tM5eEVwy3lCE7qp1mcvICZKQoJDL
   2dWZXdVxKHF1xLvkoXdsQRJyxQZroWUP6j52RzR90d1/UAF/rpGxbaQ34
   ILmolfotmSYWWAMlUEU+p9wEHkkBHxHSn+PGwiRxpB7skjzRR2+/Dc9sv
   V4Qh1afFMXpZmZhuK33yfOAFCB5LbOxBiBVg9sb96tH2Vv5fjinP/Qe61
   vru8Y2GY1UlaX/Oehbf05hev5Gn5sFEcvh7JKZ6wPC0gcFOpe80K9F1R7
   w==;
X-CSE-ConnectionGUID: SxZA3y4lQs2oMWHoWP6x8w==
X-CSE-MsgGUID: 6WuuQQl4RpiAp6AKx6Gicg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33066500"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="33066500"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 19:54:13 -0700
X-CSE-ConnectionGUID: C2vpTb9MSf2Moxde9CeckQ==
X-CSE-MsgGUID: crrvOB8CRtq40XmXmSEbvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="61133222"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 19 Aug 2024 19:54:12 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgF0b-0009e6-1Y;
	Tue, 20 Aug 2024 02:54:09 +0000
Date: Tue, 20 Aug 2024 10:53:43 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 e080a26725fb36f535f22ea42694c60ab005fb2e
Message-ID: <202408201039.olgNWL6s-lkp@intel.com>
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
branch HEAD: e080a26725fb36f535f22ea42694c60ab005fb2e  erofs: allow large folios for compressed files

elapsed time: 1063m

configs tested: 311
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              alldefconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                            hsdk_defconfig   gcc-13.2.0
arc                        nsim_700_defconfig   gcc-13.2.0
arc                   randconfig-001-20240819   gcc-13.2.0
arc                   randconfig-001-20240820   gcc-13.2.0
arc                   randconfig-002-20240819   gcc-13.2.0
arc                   randconfig-002-20240820   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                         assabet_defconfig   gcc-12.4.0
arm                         assabet_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                      footbridge_defconfig   gcc-13.2.0
arm                          pxa3xx_defconfig   gcc-12.4.0
arm                            qcom_defconfig   gcc-12.4.0
arm                   randconfig-001-20240819   gcc-13.2.0
arm                   randconfig-001-20240820   gcc-13.2.0
arm                   randconfig-002-20240819   gcc-13.2.0
arm                   randconfig-002-20240820   gcc-13.2.0
arm                   randconfig-003-20240819   gcc-13.2.0
arm                   randconfig-003-20240820   gcc-13.2.0
arm                   randconfig-004-20240819   gcc-13.2.0
arm                   randconfig-004-20240820   gcc-13.2.0
arm                             rpc_defconfig   gcc-13.2.0
arm                         s3c6400_defconfig   gcc-12.4.0
arm                         s3c6400_defconfig   gcc-13.2.0
arm                           sama5_defconfig   gcc-13.2.0
arm                        spear6xx_defconfig   gcc-12.4.0
arm                           u8500_defconfig   gcc-12.4.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240819   gcc-13.2.0
arm64                 randconfig-001-20240820   gcc-13.2.0
arm64                 randconfig-002-20240819   gcc-13.2.0
arm64                 randconfig-002-20240820   gcc-13.2.0
arm64                 randconfig-003-20240819   gcc-13.2.0
arm64                 randconfig-003-20240820   gcc-13.2.0
arm64                 randconfig-004-20240819   gcc-13.2.0
arm64                 randconfig-004-20240820   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240819   gcc-13.2.0
csky                  randconfig-001-20240820   gcc-13.2.0
csky                  randconfig-002-20240819   gcc-13.2.0
csky                  randconfig-002-20240820   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240819   clang-18
i386         buildonly-randconfig-001-20240820   clang-18
i386         buildonly-randconfig-002-20240819   clang-18
i386         buildonly-randconfig-002-20240819   gcc-12
i386         buildonly-randconfig-002-20240820   clang-18
i386         buildonly-randconfig-003-20240819   clang-18
i386         buildonly-randconfig-003-20240819   gcc-11
i386         buildonly-randconfig-003-20240820   clang-18
i386         buildonly-randconfig-004-20240819   clang-18
i386         buildonly-randconfig-004-20240820   clang-18
i386         buildonly-randconfig-005-20240819   clang-18
i386         buildonly-randconfig-005-20240819   gcc-12
i386         buildonly-randconfig-005-20240820   clang-18
i386         buildonly-randconfig-006-20240819   clang-18
i386         buildonly-randconfig-006-20240819   gcc-12
i386         buildonly-randconfig-006-20240820   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240819   clang-18
i386                  randconfig-001-20240819   gcc-12
i386                  randconfig-001-20240820   clang-18
i386                  randconfig-002-20240819   clang-18
i386                  randconfig-002-20240820   clang-18
i386                  randconfig-003-20240819   clang-18
i386                  randconfig-003-20240819   gcc-12
i386                  randconfig-003-20240820   clang-18
i386                  randconfig-004-20240819   clang-18
i386                  randconfig-004-20240819   gcc-12
i386                  randconfig-004-20240820   clang-18
i386                  randconfig-005-20240819   clang-18
i386                  randconfig-005-20240819   gcc-12
i386                  randconfig-005-20240820   clang-18
i386                  randconfig-006-20240819   clang-18
i386                  randconfig-006-20240819   gcc-12
i386                  randconfig-006-20240820   clang-18
i386                  randconfig-011-20240819   clang-18
i386                  randconfig-011-20240819   gcc-12
i386                  randconfig-011-20240820   clang-18
i386                  randconfig-012-20240819   clang-18
i386                  randconfig-012-20240819   gcc-12
i386                  randconfig-012-20240820   clang-18
i386                  randconfig-013-20240819   clang-18
i386                  randconfig-013-20240819   gcc-12
i386                  randconfig-013-20240820   clang-18
i386                  randconfig-014-20240819   clang-18
i386                  randconfig-014-20240819   gcc-12
i386                  randconfig-014-20240820   clang-18
i386                  randconfig-015-20240819   clang-18
i386                  randconfig-015-20240819   gcc-12
i386                  randconfig-015-20240820   clang-18
i386                  randconfig-016-20240819   clang-18
i386                  randconfig-016-20240820   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240819   gcc-13.2.0
loongarch             randconfig-001-20240820   gcc-13.2.0
loongarch             randconfig-002-20240819   gcc-13.2.0
loongarch             randconfig-002-20240820   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5208evb_defconfig   gcc-13.2.0
m68k                        m5272c3_defconfig   gcc-13.2.0
m68k                            mac_defconfig   gcc-12.4.0
m68k                        stmark2_defconfig   gcc-12.4.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                      bmips_stb_defconfig   gcc-13.2.0
mips                           ip22_defconfig   gcc-13.2.0
mips                      malta_kvm_defconfig   gcc-13.2.0
mips                      maltaaprp_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240819   gcc-13.2.0
nios2                 randconfig-001-20240820   gcc-13.2.0
nios2                 randconfig-002-20240819   gcc-13.2.0
nios2                 randconfig-002-20240820   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240819   gcc-13.2.0
parisc                randconfig-001-20240820   gcc-13.2.0
parisc                randconfig-002-20240819   gcc-13.2.0
parisc                randconfig-002-20240820   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                 canyonlands_defconfig   gcc-13.2.0
powerpc                     ep8248e_defconfig   gcc-13.2.0
powerpc                     kmeter1_defconfig   gcc-12.4.0
powerpc                       maple_defconfig   gcc-13.2.0
powerpc                     mpc5200_defconfig   gcc-13.2.0
powerpc                 mpc8315_rdb_defconfig   gcc-13.2.0
powerpc                 mpc832x_rdb_defconfig   gcc-13.2.0
powerpc                 mpc836x_rdk_defconfig   gcc-12.4.0
powerpc                 mpc837x_rdb_defconfig   gcc-13.2.0
powerpc                  mpc885_ads_defconfig   gcc-13.2.0
powerpc                      ppc64e_defconfig   gcc-13.2.0
powerpc                      ppc6xx_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240819   gcc-13.2.0
powerpc               randconfig-002-20240819   gcc-13.2.0
powerpc               randconfig-003-20240820   gcc-13.2.0
powerpc64             randconfig-001-20240819   gcc-13.2.0
powerpc64             randconfig-002-20240819   gcc-13.2.0
powerpc64             randconfig-002-20240820   gcc-13.2.0
powerpc64             randconfig-003-20240819   gcc-13.2.0
powerpc64             randconfig-003-20240820   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                    nommu_virt_defconfig   gcc-12.4.0
riscv                 randconfig-001-20240819   gcc-13.2.0
riscv                 randconfig-001-20240820   gcc-13.2.0
riscv                 randconfig-002-20240819   gcc-13.2.0
riscv                 randconfig-002-20240820   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240819   gcc-13.2.0
s390                  randconfig-001-20240820   gcc-13.2.0
s390                  randconfig-002-20240819   gcc-13.2.0
s390                  randconfig-002-20240820   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                        apsh4ad0a_defconfig   gcc-12.4.0
sh                                  defconfig   gcc-14.1.0
sh                             espt_defconfig   gcc-13.2.0
sh                 kfr2r09-romimage_defconfig   gcc-13.2.0
sh                          lboxre2_defconfig   gcc-12.4.0
sh                          lboxre2_defconfig   gcc-13.2.0
sh                     magicpanelr2_defconfig   gcc-13.2.0
sh                          r7785rp_defconfig   gcc-12.4.0
sh                    randconfig-001-20240819   gcc-13.2.0
sh                    randconfig-001-20240820   gcc-13.2.0
sh                    randconfig-002-20240819   gcc-13.2.0
sh                    randconfig-002-20240820   gcc-13.2.0
sh                           se7206_defconfig   gcc-12.4.0
sh                           se7619_defconfig   gcc-13.2.0
sh                           se7705_defconfig   gcc-13.2.0
sh                           se7724_defconfig   gcc-13.2.0
sh                            titan_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240819   gcc-13.2.0
sparc64               randconfig-001-20240820   gcc-13.2.0
sparc64               randconfig-002-20240819   gcc-13.2.0
sparc64               randconfig-002-20240820   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240819   gcc-13.2.0
um                    randconfig-001-20240820   gcc-13.2.0
um                    randconfig-002-20240819   gcc-13.2.0
um                    randconfig-002-20240820   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                           alldefconfig   gcc-12.4.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240819   gcc-12
x86_64       buildonly-randconfig-001-20240820   clang-18
x86_64       buildonly-randconfig-002-20240819   gcc-12
x86_64       buildonly-randconfig-002-20240820   clang-18
x86_64       buildonly-randconfig-003-20240819   gcc-12
x86_64       buildonly-randconfig-003-20240820   clang-18
x86_64       buildonly-randconfig-004-20240819   gcc-12
x86_64       buildonly-randconfig-004-20240820   clang-18
x86_64       buildonly-randconfig-005-20240819   gcc-12
x86_64       buildonly-randconfig-005-20240820   clang-18
x86_64       buildonly-randconfig-006-20240819   gcc-12
x86_64       buildonly-randconfig-006-20240820   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240819   gcc-12
x86_64                randconfig-001-20240820   clang-18
x86_64                randconfig-002-20240819   gcc-12
x86_64                randconfig-002-20240820   clang-18
x86_64                randconfig-003-20240819   gcc-12
x86_64                randconfig-003-20240820   clang-18
x86_64                randconfig-004-20240819   gcc-12
x86_64                randconfig-004-20240820   clang-18
x86_64                randconfig-005-20240819   gcc-12
x86_64                randconfig-005-20240820   clang-18
x86_64                randconfig-006-20240819   gcc-12
x86_64                randconfig-006-20240820   clang-18
x86_64                randconfig-011-20240819   gcc-12
x86_64                randconfig-011-20240820   clang-18
x86_64                randconfig-012-20240819   gcc-12
x86_64                randconfig-012-20240820   clang-18
x86_64                randconfig-013-20240819   gcc-12
x86_64                randconfig-013-20240820   clang-18
x86_64                randconfig-014-20240819   gcc-12
x86_64                randconfig-014-20240820   clang-18
x86_64                randconfig-015-20240819   gcc-12
x86_64                randconfig-015-20240820   clang-18
x86_64                randconfig-016-20240819   gcc-12
x86_64                randconfig-016-20240820   clang-18
x86_64                randconfig-071-20240819   gcc-12
x86_64                randconfig-071-20240820   clang-18
x86_64                randconfig-072-20240819   gcc-12
x86_64                randconfig-072-20240820   clang-18
x86_64                randconfig-073-20240819   gcc-12
x86_64                randconfig-073-20240820   clang-18
x86_64                randconfig-074-20240819   gcc-12
x86_64                randconfig-074-20240820   clang-18
x86_64                randconfig-075-20240819   gcc-12
x86_64                randconfig-075-20240820   clang-18
x86_64                randconfig-076-20240819   gcc-12
x86_64                randconfig-076-20240820   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240819   gcc-13.2.0
xtensa                randconfig-001-20240820   gcc-13.2.0
xtensa                randconfig-002-20240819   gcc-13.2.0
xtensa                randconfig-002-20240820   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
