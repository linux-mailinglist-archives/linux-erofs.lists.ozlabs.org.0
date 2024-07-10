Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D499292CB72
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jul 2024 08:56:33 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ieYThWUp;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WJpYW423Mz3cXw
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jul 2024 16:56:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ieYThWUp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WJpYP3pBLz30XZ
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Jul 2024 16:56:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720594586; x=1752130586;
  h=date:from:to:cc:subject:message-id;
  bh=M7tNFIcHfrlVy9RK2zfdhMjv5wRDSeLJPFyKDM8kZBo=;
  b=ieYThWUpYxv4ZxZDIbz97VGz82Zbnt4ESyVmX652fL+/Sx18pLSvZ8a2
   ZgMG3ZIkmrVJMJs9JIVvEvsY1QF9OFDaRel7AD+IvEipvrLcv6ZTtifR2
   oOEUYnl+H7jXUxMVqGLyEY8dMzVHeCYhXrJ/rudSD2gB8PyU0Up1LuFUf
   h4vJOwP8MpKhaA2Dr5OdesJNM/0EluEPPRKkqRp36urKTkpsMjWtiaQVR
   TKTYIK49yJdP9WzwbOj3IRvjifEYREIhPjJUPZaj3ic8nr6csuIgWR5Y7
   YbuG7sCxDLlOvO1irF3qXk4wg5G6m9TBH3Azi2wb3qGvOZI1+T4ZWptqB
   Q==;
X-CSE-ConnectionGUID: dMckJXx/SIC2xjZ++ehLcA==
X-CSE-MsgGUID: oYfMmqlsRs+Wsb+UGczWnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="35325371"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="35325371"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 23:56:19 -0700
X-CSE-ConnectionGUID: BIlhHa5VQNexoHbIaRR7QQ==
X-CSE-MsgGUID: H2c3WHKfSmSTouk2EBCqxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48109637"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 09 Jul 2024 23:56:17 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRRFP-000XZF-0R;
	Wed, 10 Jul 2024 06:56:15 +0000
Date: Wed, 10 Jul 2024 14:56:09 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 84a2ceefff99633d8f88c7c1f9bbd2c139b8f805
Message-ID: <202407101407.NmulJbSQ-lkp@intel.com>
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
branch HEAD: 84a2ceefff99633d8f88c7c1f9bbd2c139b8f805  erofs: tidy up stream decompressors

elapsed time: 1176m

configs tested: 177
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240710   gcc-13.2.0
arc                   randconfig-002-20240710   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            hisi_defconfig   gcc-13.2.0
arm                          ixp4xx_defconfig   gcc-13.2.0
arm                          pxa910_defconfig   gcc-13.2.0
arm                   randconfig-001-20240710   gcc-13.2.0
arm                   randconfig-002-20240710   gcc-13.2.0
arm                   randconfig-003-20240710   gcc-13.2.0
arm                   randconfig-004-20240710   gcc-13.2.0
arm                        realview_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240710   gcc-13.2.0
arm64                 randconfig-002-20240710   gcc-13.2.0
arm64                 randconfig-003-20240710   gcc-13.2.0
arm64                 randconfig-004-20240710   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240710   gcc-13.2.0
csky                  randconfig-002-20240710   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240710   clang-18
i386         buildonly-randconfig-002-20240710   clang-18
i386         buildonly-randconfig-003-20240710   clang-18
i386         buildonly-randconfig-004-20240710   clang-18
i386         buildonly-randconfig-005-20240710   clang-18
i386         buildonly-randconfig-006-20240710   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240710   clang-18
i386                  randconfig-002-20240710   clang-18
i386                  randconfig-003-20240710   clang-18
i386                  randconfig-004-20240710   clang-18
i386                  randconfig-005-20240710   clang-18
i386                  randconfig-006-20240710   clang-18
i386                  randconfig-011-20240710   clang-18
i386                  randconfig-012-20240710   clang-18
i386                  randconfig-013-20240710   clang-18
i386                  randconfig-014-20240710   clang-18
i386                  randconfig-015-20240710   clang-18
i386                  randconfig-016-20240710   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240710   gcc-13.2.0
loongarch             randconfig-002-20240710   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5249evb_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240710   gcc-13.2.0
nios2                 randconfig-002-20240710   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240710   gcc-13.2.0
parisc                randconfig-002-20240710   gcc-13.2.0
parisc64                         alldefconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-13.2.0
powerpc                      katmai_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240710   gcc-13.2.0
powerpc               randconfig-002-20240710   gcc-13.2.0
powerpc               randconfig-003-20240710   gcc-13.2.0
powerpc                     tqm8548_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240710   gcc-13.2.0
powerpc64             randconfig-002-20240710   gcc-13.2.0
powerpc64             randconfig-003-20240710   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                    nommu_virt_defconfig   gcc-13.2.0
riscv                 randconfig-001-20240710   gcc-13.2.0
riscv                 randconfig-002-20240710   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240710   gcc-13.2.0
s390                  randconfig-002-20240710   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                        dreamcast_defconfig   gcc-13.2.0
sh                        edosk7705_defconfig   gcc-13.2.0
sh                    randconfig-001-20240710   gcc-13.2.0
sh                    randconfig-002-20240710   gcc-13.2.0
sh                          rsk7264_defconfig   gcc-13.2.0
sh                           se7780_defconfig   gcc-13.2.0
sh                            titan_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240710   gcc-13.2.0
sparc64               randconfig-002-20240710   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240710   gcc-13.2.0
um                    randconfig-002-20240710   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240710   clang-18
x86_64       buildonly-randconfig-002-20240710   clang-18
x86_64       buildonly-randconfig-003-20240710   clang-18
x86_64       buildonly-randconfig-004-20240710   clang-18
x86_64       buildonly-randconfig-005-20240710   clang-18
x86_64       buildonly-randconfig-006-20240710   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240710   clang-18
x86_64                randconfig-002-20240710   clang-18
x86_64                randconfig-003-20240710   clang-18
x86_64                randconfig-004-20240710   clang-18
x86_64                randconfig-005-20240710   clang-18
x86_64                randconfig-006-20240710   clang-18
x86_64                randconfig-011-20240710   clang-18
x86_64                randconfig-012-20240710   clang-18
x86_64                randconfig-013-20240710   clang-18
x86_64                randconfig-014-20240710   clang-18
x86_64                randconfig-015-20240710   clang-18
x86_64                randconfig-016-20240710   clang-18
x86_64                randconfig-071-20240710   clang-18
x86_64                randconfig-072-20240710   clang-18
x86_64                randconfig-073-20240710   clang-18
x86_64                randconfig-074-20240710   clang-18
x86_64                randconfig-075-20240710   clang-18
x86_64                randconfig-076-20240710   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240710   gcc-13.2.0
xtensa                randconfig-002-20240710   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
