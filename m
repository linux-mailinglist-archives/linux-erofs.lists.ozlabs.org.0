Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D0C94B035
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2024 21:01:36 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YGfQfbY1;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WfKK96YyYz3dJM
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2024 05:01:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YGfQfbY1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WfKK33bsDz3bhD
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 Aug 2024 05:01:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723057288; x=1754593288;
  h=date:from:to:cc:subject:message-id;
  bh=oQqs+o2n+2ctRbXWwtsuRMyBnFSkTmRfGy2BVI/HJso=;
  b=YGfQfbY1S7Kw9TGr42jk2RJLA8C4/pJZAJkrCFD7HT6YWRZ9t56e0tWz
   rtrcpzthM8UNteHWMdODG/Y0nSjiViZ/esc0v/lWsGNd5Z2uPt4yRg67M
   mt6C776X9zzM3SMHHMgPjzbYxyC1koQyJkpUfrf5NeVJkCnbOmKbmc0e0
   PUDMz/M63SrgYrHr6n8ivb7dQGWNYsJL3SeiykG0nyY51LvSq9TesI+Yb
   MIb8jGgAJ0KrWq1oZHD+W0iKae/Q6+E6TNk/nlQ7lGRfll/SMOPSwzkkx
   6RtixcD1E/rbQ21YyGo43fxA1CR6BQIRwUTFCV5J0ucjv0Y5oANEyI+cw
   g==;
X-CSE-ConnectionGUID: fRFjwgKzSAOiQ+txK5hQLg==
X-CSE-MsgGUID: ndG5yPrPQsSW9L8v4fMflg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21031508"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="21031508"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 12:01:23 -0700
X-CSE-ConnectionGUID: 0R2B8ZzxS9SonSbJNz4cFw==
X-CSE-MsgGUID: xQvWs212QlmMmckTQmTzyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="57655788"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 07 Aug 2024 12:01:22 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbluQ-0005dg-2z;
	Wed, 07 Aug 2024 19:01:18 +0000
Date: Thu, 08 Aug 2024 03:01:02 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 cb890c4388d3bc02c7e87a706ea11d7b869016b6
Message-ID: <202408080359.n1aoaXDu-lkp@intel.com>
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
branch HEAD: cb890c4388d3bc02c7e87a706ea11d7b869016b6  erofs: get rid of check_layout_compatibility()

elapsed time: 732m

configs tested: 168
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240807   gcc-13.2.0
arc                   randconfig-002-20240807   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                   randconfig-001-20240807   clang-20
arm                   randconfig-002-20240807   gcc-14.1.0
arm                   randconfig-003-20240807   gcc-14.1.0
arm                   randconfig-004-20240807   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240807   gcc-14.1.0
arm64                 randconfig-002-20240807   clang-17
arm64                 randconfig-003-20240807   clang-15
arm64                 randconfig-004-20240807   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240807   gcc-14.1.0
csky                  randconfig-002-20240807   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240807   clang-14
hexagon               randconfig-002-20240807   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240807   clang-18
i386         buildonly-randconfig-002-20240807   clang-18
i386         buildonly-randconfig-003-20240807   gcc-12
i386         buildonly-randconfig-004-20240807   clang-18
i386         buildonly-randconfig-005-20240807   clang-18
i386         buildonly-randconfig-006-20240807   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240807   gcc-12
i386                  randconfig-002-20240807   clang-18
i386                  randconfig-003-20240807   clang-18
i386                  randconfig-004-20240807   gcc-12
i386                  randconfig-005-20240807   gcc-12
i386                  randconfig-006-20240807   clang-18
i386                  randconfig-011-20240807   clang-18
i386                  randconfig-012-20240807   gcc-11
i386                  randconfig-013-20240807   clang-18
i386                  randconfig-014-20240807   clang-18
i386                  randconfig-015-20240807   clang-18
i386                  randconfig-016-20240807   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240807   gcc-14.1.0
loongarch             randconfig-002-20240807   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240807   gcc-14.1.0
nios2                 randconfig-002-20240807   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240807   gcc-14.1.0
parisc                randconfig-002-20240807   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc               randconfig-001-20240807   clang-20
powerpc               randconfig-002-20240807   clang-20
powerpc               randconfig-003-20240807   gcc-14.1.0
powerpc64             randconfig-001-20240807   clang-15
powerpc64             randconfig-002-20240807   gcc-14.1.0
powerpc64             randconfig-003-20240807   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   clang-20
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240807   clang-20
riscv                 randconfig-002-20240807   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240807   gcc-14.1.0
s390                  randconfig-002-20240807   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240807   gcc-14.1.0
sh                    randconfig-002-20240807   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240807   gcc-14.1.0
sparc64               randconfig-002-20240807   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-12
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240807   gcc-12
um                    randconfig-002-20240807   clang-20
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240807   clang-18
x86_64       buildonly-randconfig-002-20240807   clang-18
x86_64       buildonly-randconfig-003-20240807   clang-18
x86_64       buildonly-randconfig-004-20240807   clang-18
x86_64       buildonly-randconfig-005-20240807   clang-18
x86_64       buildonly-randconfig-006-20240807   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240807   clang-18
x86_64                randconfig-002-20240807   gcc-12
x86_64                randconfig-003-20240807   clang-18
x86_64                randconfig-004-20240807   gcc-12
x86_64                randconfig-005-20240807   gcc-12
x86_64                randconfig-006-20240807   gcc-12
x86_64                randconfig-011-20240807   clang-18
x86_64                randconfig-012-20240807   gcc-12
x86_64                randconfig-013-20240807   gcc-12
x86_64                randconfig-014-20240807   gcc-12
x86_64                randconfig-015-20240807   clang-18
x86_64                randconfig-016-20240807   clang-18
x86_64                randconfig-071-20240807   clang-18
x86_64                randconfig-072-20240807   clang-18
x86_64                randconfig-073-20240807   gcc-12
x86_64                randconfig-074-20240807   clang-18
x86_64                randconfig-075-20240807   gcc-12
x86_64                randconfig-076-20240807   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240807   gcc-14.1.0
xtensa                randconfig-002-20240807   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
