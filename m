Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE927EEFCE
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Nov 2023 11:11:54 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PlL+94Yt;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SWt3r4Gsjz3d9B
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Nov 2023 21:11:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PlL+94Yt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.31; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SWt3k0XQnz3cgl
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Nov 2023 21:11:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700215906; x=1731751906;
  h=date:from:to:cc:subject:message-id;
  bh=HSi8iGM+SgFe2geQFWw8dRdh8bjh6yEvGpJKBKzB7cU=;
  b=PlL+94YtkQYe9pv/jJokzHZa9iQCdQpuYn90hPDvVFJi9e01rjt1wzCY
   4SyNWctDCZRCF066yLHLMrAQoGTBb1UGoNwZAgG41aea4dXilY/9dlLY9
   /snBMqmaIW2tRpMvXvhQ/ZJWv0q0ItLmKP0pC4YiiphMoNOrizo/6SNok
   rE6g713Ysq9BBW0qjJw7JUy2W9d8ap/HgpIph2r20cua48+uVvtGbQsdD
   dL26aVrF6AejoLfTMn328RZIA0qZt7vp0eHz5LBCa7wuytfGDMeNxT2r3
   H9tqJiKBLIFYb4vyIrqdVIMSU3SgTwVZdxOqYC8Frx0g69TxY9xSoSaQu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="455572752"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="455572752"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 02:11:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="742051552"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="742051552"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Nov 2023 02:11:38 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r3vot-0002a3-37;
	Fri, 17 Nov 2023 10:11:31 +0000
Date: Fri, 17 Nov 2023 18:10:09 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 f0a7c1f3ece8ec70b0e3ebcbcf7e36ba83518fe1
Message-ID: <202311171806.1mtGoQeL-lkp@intel.com>
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
branch HEAD: f0a7c1f3ece8ec70b0e3ebcbcf7e36ba83518fe1  erofs: fix NULL dereference of dif->bdev_handle in fscache mode

elapsed time: 1560m

configs tested: 277
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
arc                   randconfig-001-20231116   gcc  
arc                   randconfig-001-20231117   gcc  
arc                   randconfig-002-20231116   gcc  
arc                   randconfig-002-20231117   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                           h3600_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                          pxa168_defconfig   clang
arm                          pxa3xx_defconfig   gcc  
arm                   randconfig-001-20231116   gcc  
arm                   randconfig-001-20231117   gcc  
arm                   randconfig-002-20231116   gcc  
arm                   randconfig-002-20231117   gcc  
arm                   randconfig-003-20231116   gcc  
arm                   randconfig-003-20231117   gcc  
arm                   randconfig-004-20231116   gcc  
arm                   randconfig-004-20231117   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231116   gcc  
arm64                 randconfig-001-20231117   gcc  
arm64                 randconfig-002-20231116   gcc  
arm64                 randconfig-002-20231117   gcc  
arm64                 randconfig-003-20231116   gcc  
arm64                 randconfig-003-20231117   gcc  
arm64                 randconfig-004-20231116   gcc  
arm64                 randconfig-004-20231117   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231116   gcc  
csky                  randconfig-001-20231117   gcc  
csky                  randconfig-002-20231116   gcc  
csky                  randconfig-002-20231117   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231116   gcc  
i386         buildonly-randconfig-001-20231117   gcc  
i386         buildonly-randconfig-002-20231116   gcc  
i386         buildonly-randconfig-002-20231117   gcc  
i386         buildonly-randconfig-003-20231116   gcc  
i386         buildonly-randconfig-003-20231117   gcc  
i386         buildonly-randconfig-004-20231116   gcc  
i386         buildonly-randconfig-004-20231117   gcc  
i386         buildonly-randconfig-005-20231116   gcc  
i386         buildonly-randconfig-005-20231117   gcc  
i386         buildonly-randconfig-006-20231116   gcc  
i386         buildonly-randconfig-006-20231117   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231116   gcc  
i386                  randconfig-001-20231117   gcc  
i386                  randconfig-002-20231116   gcc  
i386                  randconfig-002-20231117   gcc  
i386                  randconfig-003-20231116   gcc  
i386                  randconfig-003-20231117   gcc  
i386                  randconfig-004-20231116   gcc  
i386                  randconfig-004-20231117   gcc  
i386                  randconfig-005-20231116   gcc  
i386                  randconfig-005-20231117   gcc  
i386                  randconfig-006-20231116   gcc  
i386                  randconfig-006-20231117   gcc  
i386                  randconfig-011-20231116   gcc  
i386                  randconfig-011-20231117   gcc  
i386                  randconfig-012-20231116   gcc  
i386                  randconfig-012-20231117   gcc  
i386                  randconfig-013-20231116   gcc  
i386                  randconfig-013-20231117   gcc  
i386                  randconfig-014-20231116   gcc  
i386                  randconfig-014-20231117   gcc  
i386                  randconfig-015-20231116   gcc  
i386                  randconfig-015-20231117   gcc  
i386                  randconfig-016-20231116   gcc  
i386                  randconfig-016-20231117   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231116   gcc  
loongarch             randconfig-001-20231117   gcc  
loongarch             randconfig-002-20231116   gcc  
loongarch             randconfig-002-20231117   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231116   gcc  
nios2                 randconfig-001-20231117   gcc  
nios2                 randconfig-002-20231116   gcc  
nios2                 randconfig-002-20231117   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20231116   gcc  
parisc                randconfig-001-20231117   gcc  
parisc                randconfig-002-20231116   gcc  
parisc                randconfig-002-20231117   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                     mpc512x_defconfig   clang
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc               randconfig-001-20231116   gcc  
powerpc               randconfig-001-20231117   gcc  
powerpc               randconfig-002-20231116   gcc  
powerpc               randconfig-002-20231117   gcc  
powerpc               randconfig-003-20231116   gcc  
powerpc               randconfig-003-20231117   gcc  
powerpc                     tqm8548_defconfig   gcc  
powerpc64             randconfig-001-20231116   gcc  
powerpc64             randconfig-001-20231117   gcc  
powerpc64             randconfig-002-20231116   gcc  
powerpc64             randconfig-002-20231117   gcc  
powerpc64             randconfig-003-20231116   gcc  
powerpc64             randconfig-003-20231117   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20231116   gcc  
riscv                 randconfig-001-20231117   gcc  
riscv                 randconfig-002-20231116   gcc  
riscv                 randconfig-002-20231117   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231116   gcc  
s390                  randconfig-001-20231117   gcc  
s390                  randconfig-002-20231116   gcc  
s390                  randconfig-002-20231117   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                    randconfig-001-20231116   gcc  
sh                    randconfig-001-20231117   gcc  
sh                    randconfig-002-20231116   gcc  
sh                    randconfig-002-20231117   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                            titan_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231116   gcc  
sparc64               randconfig-001-20231117   gcc  
sparc64               randconfig-002-20231116   gcc  
sparc64               randconfig-002-20231117   gcc  
um                               allmodconfig   gcc  
um                                allnoconfig   gcc  
um                               allyesconfig   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231116   gcc  
um                    randconfig-001-20231117   gcc  
um                    randconfig-002-20231116   gcc  
um                    randconfig-002-20231117   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231116   gcc  
x86_64       buildonly-randconfig-001-20231117   gcc  
x86_64       buildonly-randconfig-002-20231116   gcc  
x86_64       buildonly-randconfig-002-20231117   gcc  
x86_64       buildonly-randconfig-003-20231116   gcc  
x86_64       buildonly-randconfig-003-20231117   gcc  
x86_64       buildonly-randconfig-004-20231116   gcc  
x86_64       buildonly-randconfig-004-20231117   gcc  
x86_64       buildonly-randconfig-005-20231116   gcc  
x86_64       buildonly-randconfig-005-20231117   gcc  
x86_64       buildonly-randconfig-006-20231116   gcc  
x86_64       buildonly-randconfig-006-20231117   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231116   gcc  
x86_64                randconfig-001-20231117   gcc  
x86_64                randconfig-002-20231116   gcc  
x86_64                randconfig-002-20231117   gcc  
x86_64                randconfig-003-20231116   gcc  
x86_64                randconfig-003-20231117   gcc  
x86_64                randconfig-004-20231116   gcc  
x86_64                randconfig-004-20231117   gcc  
x86_64                randconfig-005-20231116   gcc  
x86_64                randconfig-005-20231117   gcc  
x86_64                randconfig-006-20231116   gcc  
x86_64                randconfig-006-20231117   gcc  
x86_64                randconfig-011-20231116   gcc  
x86_64                randconfig-011-20231117   gcc  
x86_64                randconfig-012-20231116   gcc  
x86_64                randconfig-012-20231117   gcc  
x86_64                randconfig-013-20231116   gcc  
x86_64                randconfig-013-20231117   gcc  
x86_64                randconfig-014-20231116   gcc  
x86_64                randconfig-014-20231117   gcc  
x86_64                randconfig-015-20231116   gcc  
x86_64                randconfig-015-20231117   gcc  
x86_64                randconfig-016-20231116   gcc  
x86_64                randconfig-016-20231117   gcc  
x86_64                randconfig-071-20231116   gcc  
x86_64                randconfig-071-20231117   gcc  
x86_64                randconfig-072-20231116   gcc  
x86_64                randconfig-072-20231117   gcc  
x86_64                randconfig-073-20231116   gcc  
x86_64                randconfig-073-20231117   gcc  
x86_64                randconfig-074-20231116   gcc  
x86_64                randconfig-074-20231117   gcc  
x86_64                randconfig-075-20231116   gcc  
x86_64                randconfig-075-20231117   gcc  
x86_64                randconfig-076-20231116   gcc  
x86_64                randconfig-076-20231117   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                              defconfig   gcc  
xtensa                randconfig-001-20231116   gcc  
xtensa                randconfig-001-20231117   gcc  
xtensa                randconfig-002-20231116   gcc  
xtensa                randconfig-002-20231117   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
