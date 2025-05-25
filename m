Return-Path: <linux-erofs+bounces-365-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CD7AC36C3
	for <lists+linux-erofs@lfdr.de>; Sun, 25 May 2025 22:36:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b59fQ0hf9z2xlM;
	Mon, 26 May 2025 06:36:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748205390;
	cv=none; b=EfKfkhpRgst6pkLggmHQqvDgAeSaYiW80MBYiK+USxg0+RPvqx1BgeNLCIGzqXp+ijnhmi+62X5G7VGyZft6b54CPlLmUXwK4ZhG+H1poXVYEozzFzS2TJ4gIUNo/N+QLez1i1U4tepikavRC5YSmMAHl3GHQzwF7Y9caOYFLCUeovj+V+6uOIOLaXMX185PcJMCLJBOMYkuz/HinBSmKAPo0VmDeY38JHNKbewHFGH8exjArmMzbdAnsCWb6mjeCD8xnuxkmNiKaenzFNlZtE/AQZ0PmQAFoVfkRIp1YddBa8rJr0ItRyOLkuC29LiPbtHmLVHOqlj6SmSE55LEAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748205390; c=relaxed/relaxed;
	bh=L3vuUk1mz4EV+r32ElYF+UGvzaqtCaXmFqRqwp4cU1k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=B4JWUx7tXbQK07owy3uw79wSQSI+532JzW3hU11h9mWuP+vUb1MXqeAi8aS6ziucchoLx5+M/EaYgoMGI4WhX5YRRlKm7/qSEbukTIl36DlysD9c+9ZCn2tckcYTEHu3p1b0iojfIS/HmUougq0l3Nnfj7VvQwIjB2i+Bgzv3arugvDB4YVd7ZyPzlyy3qwcG/eZWC6n3sy2zxm4WnDDCnuLtwaxreAbUjY8MSkRfEicvwjM5pxV7Yj6WqHsubiERzbu8rwEMhfNdIxEihdWY6/hXA6BZo+8mmv5fkWWlznSRPhxQ+ZHBXPUUAuNS6GKvuhvo404WjlB+yvwNdknag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZXXBbVNp; dkim-atps=neutral; spf=pass (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZXXBbVNp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b59fN0jb8z2xlL
	for <linux-erofs@lists.ozlabs.org>; Mon, 26 May 2025 06:36:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748205388; x=1779741388;
  h=date:from:to:cc:subject:message-id;
  bh=2ml9F8v1+0LuIm40PvTvVgFsPbuA5OckLBoQgaWVCTs=;
  b=ZXXBbVNpBBY+8soeOr6P/lFixvK7p9Nsf3Di45qjUQjE/vYwSzer7kbh
   Wczoiu5Lriu+kJQZ6mj1WfIJ/b2A5LgWUJcLzTdnE+Vmh4HqBHNEYpwo+
   tTbBHiuwFxchpo8mmwnwPgRww6JHh3WoOxd892uyK1DMXLt4+LEKWijLb
   /Wd8BEEc0iTAVqyVNd3X2RXmvL1pDDFDQi4s4ee1odLIyYMlinrJnnIxj
   6idsKEUAhwNweJ3jZGY1To60wWMTo+bvabf3UG4XjMl0+keyfD8JGvREq
   X7uLlNn+ZGFXrvMeSO4O0bls+2WOKHjSDYh5AjTK5tmTm/3ZT1llnlgOS
   w==;
X-CSE-ConnectionGUID: lu7VEPjlS5uKeGzknS6dHA==
X-CSE-MsgGUID: FpL/Ktj8RPq5VyLxqRo1Sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="52804377"
X-IronPort-AV: E=Sophos;i="6.15,314,1739865600"; 
   d="scan'208";a="52804377"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2025 13:36:23 -0700
X-CSE-ConnectionGUID: 1R6ff4kHRqCjXgo7jdenZQ==
X-CSE-MsgGUID: fIJrpCh6TRCPd0eq/FRgnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,314,1739865600"; 
   d="scan'208";a="142644272"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 25 May 2025 13:36:22 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uJI4x-000RzY-2V;
	Sun, 25 May 2025 20:36:19 +0000
Date: Mon, 26 May 2025 04:35:37 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 b4a29efc51461edf1a02e9da656d4480cabd24b0
Message-ID: <202505260427.Bj214WvC-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: b4a29efc51461edf1a02e9da656d4480cabd24b0  erofs: support DEFLATE decompression by using Intel QAT

elapsed time: 756m

configs tested: 149
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                        nsimosci_defconfig    gcc-14.2.0
arc                   randconfig-001-20250525    gcc-12.4.0
arc                   randconfig-002-20250525    gcc-8.5.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g4_defconfig    clang-21
arm                         at91_dt_defconfig    clang-21
arm                                 defconfig    clang-21
arm                      integrator_defconfig    clang-21
arm                   randconfig-001-20250525    clang-21
arm                   randconfig-002-20250525    clang-21
arm                   randconfig-003-20250525    gcc-8.5.0
arm                   randconfig-004-20250525    gcc-7.5.0
arm                             rpc_defconfig    clang-18
arm                        spear6xx_defconfig    clang-21
arm                           stm32_defconfig    gcc-14.2.0
arm                           tegra_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250525    clang-21
arm64                 randconfig-002-20250525    gcc-8.5.0
arm64                 randconfig-003-20250525    gcc-6.5.0
arm64                 randconfig-004-20250525    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250525    gcc-14.2.0
csky                  randconfig-002-20250525    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250525    clang-19
hexagon               randconfig-002-20250525    clang-21
i386                             alldefconfig    gcc-12
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250525    gcc-11
i386        buildonly-randconfig-002-20250525    clang-20
i386        buildonly-randconfig-003-20250525    gcc-12
i386        buildonly-randconfig-004-20250525    gcc-12
i386        buildonly-randconfig-005-20250525    gcc-12
i386        buildonly-randconfig-006-20250525    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250525    gcc-15.1.0
loongarch             randconfig-002-20250525    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250525    gcc-6.5.0
nios2                 randconfig-002-20250525    gcc-10.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250525    gcc-7.5.0
parisc                randconfig-002-20250525    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                     asp8347_defconfig    clang-21
powerpc                       holly_defconfig    clang-21
powerpc               mpc834x_itxgp_defconfig    clang-21
powerpc               randconfig-001-20250525    clang-16
powerpc               randconfig-002-20250525    clang-21
powerpc               randconfig-003-20250525    clang-21
powerpc64             randconfig-001-20250525    clang-21
powerpc64             randconfig-002-20250525    clang-18
powerpc64             randconfig-003-20250525    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250525    clang-21
riscv                 randconfig-002-20250525    clang-21
s390                             alldefconfig    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250525    clang-19
s390                  randconfig-002-20250525    gcc-7.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250525    gcc-6.5.0
sh                    randconfig-002-20250525    gcc-14.2.0
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sh                   secureedge5410_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250525    gcc-6.5.0
sparc                 randconfig-002-20250525    gcc-10.3.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250525    gcc-7.5.0
sparc64               randconfig-002-20250525    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250525    clang-18
um                    randconfig-002-20250525    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250525    clang-20
x86_64      buildonly-randconfig-002-20250525    clang-20
x86_64      buildonly-randconfig-003-20250525    clang-20
x86_64      buildonly-randconfig-004-20250525    gcc-12
x86_64      buildonly-randconfig-005-20250525    clang-20
x86_64      buildonly-randconfig-006-20250525    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                generic_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250525    gcc-9.3.0
xtensa                randconfig-002-20250525    gcc-15.1.0
xtensa                    xip_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

