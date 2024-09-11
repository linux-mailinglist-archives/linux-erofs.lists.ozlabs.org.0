Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6713D9749D6
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 07:32:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X3Tjl1kKZz2yjR
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 15:32:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726032760;
	cv=none; b=lsfh/yzOstYHiCPV1iY7bXGZbi3iPlTRZTjqeDGnfULvJeQ2yDh2/w6jr5HEaL54BjQwxOsh8kn35x61fQePmDY55toLgtKRnlCkYkKAFBD1sqOI/E2d66NgJlE1MeusIcRdGcvkN0HvmZdDzdL3Xf7xoGQ3zJ2mHfm2O58ExXjjk05FNzRixi6tqy9qQna7BVbS+cWx/1lKZwEDwZ2Eb3o27t/Dd+qXzYCqRzJ82NV59TsyupSwP5d0fM372RsNFNhhvQyab4MMXMvYsavWJ31O1xEA9mScqV8SmvS9eRk/+uesaaHdpIXSXkaNdncBJSFnfo2hSnNxK293ZJhTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726032760; c=relaxed/relaxed;
	bh=CxHokIu0R04vdnUdFDVnX46SOIi9ZvSpDo6MUVUxDLg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kb/9BdpO/roq/snMQJpEQp1lqFWjl9zQd2+pnvQbzhlqsy2npHagrDiRPaMXGqNRAu3jArjJxHGLgUBnBg1oTLATQjE8n/nbF6YxLcKUo3zYRp+SWBmXsYcaZ6GwvowSe5jxtCLM9OvtXggMlX6AoFiGuacMD0UKbrfRzv5fOuHLKQVAm5XdrqlX/JE/VUdaqk8IwngJ1pDXnDwJhJ2dfi2tZ5C2nyuklxoZ73EvK2VF+FSVdQVwvGJRkIfTTwN6pRGdThJwvP7HvGPPKIGN2T/o63ePBpRgrMC6yxB9XF01v44CE2rB3Ls2StLyIX9WFIE5GAMb8B3fu+1+MbzwBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BX4MMSzG; dkim-atps=neutral; spf=pass (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BX4MMSzG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X3Tjg01kvz2xqp
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Sep 2024 15:32:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726032759; x=1757568759;
  h=date:from:to:cc:subject:message-id;
  bh=uIgXEXWr0cdv/1P5gy93eJ7DzTfQ59rE7C+HT53T7ok=;
  b=BX4MMSzGHVio1scs/N34fsmjOcQFcRaYvXtXEGVbGgcyRUme2SyZZnGr
   2e54jEIuTJLkf4DqsoiOaLtn7Peab2fOJs60iZ6FhPKqQvspHeV/A7Iqv
   r4Dbuvha7bxhZplC/vAkgsd0ij7oUrrTJodAi6nO1vybS5HNobMQzHPwf
   E0HRl2av7WSfltlNbeFgwOF6T+jAzmwvKtVHNQSfeDnGf73FHlABMoDoi
   XjP4S2SKEIs4jvDwan0uU8mBtoIB9T0JPX+8z974WtausZFKV121bCbp6
   Bc27In85gMcuo2KOjwuqFKCUAA8xrb6O3o14gcNnrcAFhK6PMdCUpQl/v
   w==;
X-CSE-ConnectionGUID: 7NNG1VOfTvWB40i8AZ236g==
X-CSE-MsgGUID: VUrQ6cTMSI+rYLphZKYCRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24680635"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="24680635"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 22:32:33 -0700
X-CSE-ConnectionGUID: LTiTB60YReW7xlbqxop1iQ==
X-CSE-MsgGUID: LxdNqsJuQwS9+hAXEd6/cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67758347"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 10 Sep 2024 22:32:32 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soFxt-000352-1R;
	Wed, 11 Sep 2024 05:32:29 +0000
Date: Wed, 11 Sep 2024 13:32:01 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 a71f78705a875400b47ebf28131c7ac85192a751
Message-ID: <202409111359.6TlKkmFb-lkp@intel.com>
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
branch HEAD: a71f78705a875400b47ebf28131c7ac85192a751  erofs: allocate more short-lived pages from reserved pool first

elapsed time: 1286m

configs tested: 158
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240911   gcc-13.2.0
arc                   randconfig-002-20240911   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                     davinci_all_defconfig   clang-20
arm                                 defconfig   clang-14
arm                            mps2_defconfig   clang-20
arm                   randconfig-001-20240911   clang-20
arm                   randconfig-002-20240911   clang-20
arm                   randconfig-003-20240911   clang-20
arm                   randconfig-004-20240911   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240911   clang-20
arm64                 randconfig-002-20240911   clang-15
arm64                 randconfig-003-20240911   clang-20
arm64                 randconfig-004-20240911   clang-15
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240911   gcc-14.1.0
csky                  randconfig-002-20240911   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   clang-20
hexagon               randconfig-001-20240911   clang-20
hexagon               randconfig-002-20240911   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240911   clang-18
i386         buildonly-randconfig-002-20240911   gcc-12
i386         buildonly-randconfig-003-20240911   clang-18
i386         buildonly-randconfig-004-20240911   gcc-12
i386         buildonly-randconfig-005-20240911   gcc-12
i386         buildonly-randconfig-006-20240911   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240911   gcc-12
i386                  randconfig-002-20240911   clang-18
i386                  randconfig-003-20240911   clang-18
i386                  randconfig-004-20240911   gcc-12
i386                  randconfig-005-20240911   gcc-12
i386                  randconfig-006-20240911   clang-18
i386                  randconfig-011-20240911   gcc-12
i386                  randconfig-012-20240911   gcc-12
i386                  randconfig-013-20240911   clang-18
i386                  randconfig-014-20240911   clang-18
i386                  randconfig-015-20240911   gcc-12
i386                  randconfig-016-20240911   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240911   gcc-14.1.0
loongarch             randconfig-002-20240911   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       alldefconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240911   gcc-14.1.0
nios2                 randconfig-002-20240911   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240911   gcc-14.1.0
parisc                randconfig-002-20240911   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc               randconfig-001-20240911   clang-20
powerpc               randconfig-002-20240911   gcc-14.1.0
powerpc               randconfig-003-20240911   gcc-14.1.0
powerpc64             randconfig-001-20240911   clang-17
powerpc64             randconfig-002-20240911   clang-15
powerpc64             randconfig-003-20240911   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240911   gcc-14.1.0
riscv                 randconfig-002-20240911   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240911   gcc-14.1.0
s390                  randconfig-002-20240911   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240911   gcc-14.1.0
sh                    randconfig-002-20240911   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240911   gcc-14.1.0
sparc64               randconfig-002-20240911   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240911   clang-15
um                    randconfig-002-20240911   clang-20
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240911   clang-18
x86_64       buildonly-randconfig-002-20240911   clang-18
x86_64       buildonly-randconfig-003-20240911   gcc-12
x86_64       buildonly-randconfig-004-20240911   gcc-12
x86_64       buildonly-randconfig-005-20240911   gcc-12
x86_64       buildonly-randconfig-006-20240911   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240911   gcc-12
x86_64                randconfig-002-20240911   gcc-12
x86_64                randconfig-003-20240911   clang-18
x86_64                randconfig-004-20240911   clang-18
x86_64                randconfig-005-20240911   clang-18
x86_64                randconfig-006-20240911   gcc-12
x86_64                randconfig-011-20240911   clang-18
x86_64                randconfig-012-20240911   clang-18
x86_64                randconfig-013-20240911   gcc-12
x86_64                randconfig-014-20240911   clang-18
x86_64                randconfig-015-20240911   gcc-12
x86_64                randconfig-016-20240911   clang-18
x86_64                randconfig-071-20240911   clang-18
x86_64                randconfig-072-20240911   gcc-11
x86_64                randconfig-073-20240911   clang-18
x86_64                randconfig-074-20240911   clang-18
x86_64                randconfig-075-20240911   gcc-12
x86_64                randconfig-076-20240911   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240911   gcc-14.1.0
xtensa                randconfig-002-20240911   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
