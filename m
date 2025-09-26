Return-Path: <linux-erofs+bounces-1112-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48B9BA25B2
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Sep 2025 06:03:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXxkq2g7nz300F;
	Fri, 26 Sep 2025 14:02:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758859379;
	cv=none; b=BDhexnAlnO4QX229n/Io+6wpVEGR5hJS6UgtqcKKfZR5n6gdLMEZPQcIbLkIad8zS3iWyhT1GXqmJDlUFGPoGLQvc9/r6hs7DkFiPU83S0OgKFbf3kNRmpNNZ4NZi3t4/i7qC8b2kQTAY5zaqHjidg4ysnJ9ENOfQcGAuCn8mtOj6ix0wbrJ3en3NbgyBvsQmRDzcTtV628EZ3XzSdhSQVpG5e/Ra2LGP3HOE+fiJXkDBpgH3jMUPK0br8H5+qMtKNs0fdGX8QFl9pLVZavZdGWZ1EFc+LQ7ZkxucI7h2uP6SSBtSAW+sae0k03latQb75HTjBi697dQF9438B6P+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758859379; c=relaxed/relaxed;
	bh=1EVe4YLbvRvUxIBOvQBsDZPDaHoJs0uremjQs4Ch8hQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kns43ewJkrGQQyk/t9lk/VFW5SMLVKOyjE7FuXg6xcB77iF/eKdmC1yujGUpZOqbP2S939euvZiImEq9JrI+SlnRY//8jTrAhdgKYzub/IS5SO20H0DnQgtx+Hz5MBoNiM9hArz0EDU+8Olk8hrhVENrSu3J8tY6dogWZ2NyROIjd8nM8KTlo2yLDHwDcRNcGHh6/nk0D4HxcutKwcj/SOyVAyAOyB8lh9EbfEWZ3GxV78ztbN2nBI/r7v99+LP1DMpz8Pr2OHZd9QuDopr8aOHbVAcaQWATSlSvZ5JA4avWwpNEInJ2ZQy4zdE0XuAC3qUrYgmH8dIGHAVl8/Vm+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h5HwFQV8; dkim-atps=neutral; spf=pass (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h5HwFQV8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cXxkn08hYz2ySm
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Sep 2025 14:02:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758859377; x=1790395377;
  h=date:from:to:cc:subject:message-id;
  bh=WwI4loO/PlNG0uMYRMeDimp5+CErOAs7VxGBiGcfz5g=;
  b=h5HwFQV8ZIl/pl+IvT1oIBL3ESOYNOrWZn1bi55dWkop4ti2ZLUp4W4c
   pE3glySo3y+axq44ztyCt9m0UyMo6lch0jMKHwrNOHYIv8C+5dDcQwnse
   le6VXPNqcyvIIKUeadgBM1C2KqUomj56kZyCl/Ca6uNKGaluYhuD1L6nP
   n1Cw1Flx+rdyYbslPxZYipGqDERDrCMI6mChxLeHZNU+VzY3gxX6zsa34
   QgD+u8O79dBArAEDMYd/ZFiCWnm3RUYEohZ9USIvZ2pY1QbvJ0NzawEch
   t2/V6KSKKynvNY8ogm6sQhbkdMYJ7azautW2Y+bG4Pg4ItiHlAJ7ioqz7
   Q==;
X-CSE-ConnectionGUID: bdfRqVk3SFyKxQHyBOMZgg==
X-CSE-MsgGUID: XJmj1Jf9QQ2EBLUy08hpTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65000914"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65000914"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 21:02:52 -0700
X-CSE-ConnectionGUID: /t1h2RqEQOmvRbBIRJ5qGQ==
X-CSE-MsgGUID: iAG3/wO4TRyp9rECQgcnoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="181801447"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 25 Sep 2025 21:02:51 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1zfV-0005se-09;
	Fri, 26 Sep 2025 04:02:49 +0000
Date: Fri, 26 Sep 2025 12:02:41 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 e2d3af0d64e5fe2ee269e8f082642f82bcca3903
Message-ID: <202509261235.jUz2CzPg-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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
branch HEAD: e2d3af0d64e5fe2ee269e8f082642f82bcca3903  erofs: drop redundant sanity check for ztailpacking inline

elapsed time: 1455m

configs tested: 115
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250925    gcc-13.4.0
arc                   randconfig-002-20250925    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                         axm55xx_defconfig    clang-22
arm                         nhk8815_defconfig    clang-22
arm                   randconfig-001-20250925    gcc-11.5.0
arm                   randconfig-002-20250925    gcc-10.5.0
arm                   randconfig-003-20250925    gcc-8.5.0
arm                   randconfig-004-20250925    gcc-14.3.0
arm                        realview_defconfig    clang-16
arm                        shmobile_defconfig    gcc-15.1.0
arm                           stm32_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250925    gcc-11.5.0
arm64                 randconfig-002-20250925    gcc-15.1.0
arm64                 randconfig-003-20250925    clang-19
arm64                 randconfig-004-20250925    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250925    gcc-14.3.0
csky                  randconfig-002-20250925    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250925    clang-22
hexagon               randconfig-002-20250925    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20250925    clang-20
i386        buildonly-randconfig-002-20250925    clang-20
i386        buildonly-randconfig-003-20250925    gcc-14
i386        buildonly-randconfig-004-20250925    gcc-14
i386        buildonly-randconfig-005-20250925    clang-20
i386        buildonly-randconfig-006-20250925    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250925    clang-18
loongarch             randconfig-002-20250925    gcc-12.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                         10m50_defconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20250925    gcc-8.5.0
nios2                 randconfig-002-20250925    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                randconfig-001-20250925    gcc-8.5.0
parisc                randconfig-002-20250925    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          g5_defconfig    gcc-15.1.0
powerpc                      mgcoge_defconfig    clang-22
powerpc                   motionpro_defconfig    clang-22
powerpc               randconfig-001-20250925    clang-22
powerpc               randconfig-002-20250925    gcc-8.5.0
powerpc               randconfig-003-20250925    gcc-8.5.0
powerpc                     skiroot_defconfig    clang-22
powerpc64             randconfig-001-20250925    clang-22
powerpc64             randconfig-002-20250925    gcc-14.3.0
powerpc64             randconfig-003-20250925    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250925    clang-22
riscv                 randconfig-002-20250925    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250925    gcc-15.1.0
s390                  randconfig-002-20250925    gcc-13.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                        edosk7705_defconfig    gcc-15.1.0
sh                             espt_defconfig    gcc-15.1.0
sh                    randconfig-001-20250925    gcc-15.1.0
sh                    randconfig-002-20250925    gcc-13.4.0
sh                          rsk7201_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250925    gcc-15.1.0
sparc                 randconfig-002-20250925    gcc-12.5.0
sparc64               randconfig-001-20250925    gcc-10.5.0
sparc64               randconfig-002-20250925    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250925    gcc-14
um                    randconfig-002-20250925    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250925    clang-20
x86_64      buildonly-randconfig-002-20250925    gcc-14
x86_64      buildonly-randconfig-003-20250925    gcc-14
x86_64      buildonly-randconfig-004-20250925    clang-20
x86_64      buildonly-randconfig-005-20250925    clang-20
x86_64      buildonly-randconfig-006-20250925    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                generic_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250925    gcc-12.5.0
xtensa                randconfig-002-20250925    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

