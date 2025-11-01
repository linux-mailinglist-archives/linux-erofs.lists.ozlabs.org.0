Return-Path: <linux-erofs+bounces-1310-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDC4C278F7
	for <lists+linux-erofs@lfdr.de>; Sat, 01 Nov 2025 08:18:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cz8MP2W5Yz3bW7;
	Sat,  1 Nov 2025 18:18:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761981489;
	cv=none; b=PPcEYp2HJ8LC2NRuyrIVEVkS/31gPVPYJl6Aj50IN/sN0ZNwjMMywmU8UeYRSZnjZj8nGEP/2eTWoYwDgv6wS1PWi+4YJGoOeqoHInqUpOdPNpTBf7O3ubA9gxwyqJ7VE6FhZ6v9v3keJlCmBgOdTh/rDiscPhyzTIaUNQtNHksoYZDtqV3x2axbahljvWfXQ5GlCVXCBSlcGu6Cbyz5yGlu+yvqfi6PRnPXmJX20Bb10ILr0rXG8J9IkRN4FI7+ogUWo5TRmlOhX1iP2wnIEHZiQa6vfxpNDhyFFDY6gnequ5oJSJs43rnoEld5nBdNHkc67y7akM4qJOWGJBZNkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761981489; c=relaxed/relaxed;
	bh=bCc22ZFXXaAetuj/pTVQdEOrJd3tylvTW4QNubFKhVo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TngKp475jVOQld0dMfnkp99RWK4JfZHy//KFpmWS8/2RW2idh/KTRnbHTzDvWvxqpDMZTu0ORseMcC8QqU7NBSTuZmfxamGG6MyhBnuAnV2/RWMJhK+V+YtAHouoU8OIKaHGPVIVhzZU1u9IgdRYZVx6cHDw2htZkk9UVgpwtIAFaRkblvnGfAruBeC4zyt3jbPHOv3fYEb4lYrecJbLTyNfclg82V67Io1Xu8DHIoyW0MDrN9U4F/ClMClLsGoTvFPAuelRg7QMdTmI2Hrywr1AK6qL53d6bDrDCag9uwwbx+G5ARAys15lG4l3aUEPWMhODddHUjPVa/GRhNHYPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XyDpMlWj; dkim-atps=neutral; spf=pass (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XyDpMlWj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cz8MM0YjBz2yrX
	for <linux-erofs@lists.ozlabs.org>; Sat,  1 Nov 2025 18:18:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761981487; x=1793517487;
  h=date:from:to:cc:subject:message-id;
  bh=hCH4kV+Yu4hJBG5+ktGAc0TRq74lLEyXounFth317cU=;
  b=XyDpMlWjNaJq7YEin2+usr3SUODwsalxPn/OLZ1BDjscD3ljne2u9O2T
   KdXtIlH86xMTaCl2UEkEmkP+UdZBHnswymYm1uJH/65zZut4NOHd298eX
   4k7Jv+b7XN332opoG6xwiV+6LOkC4syP5IcR/ZQnrhGwM4eyGN0tz7M7T
   s46L1j1Ed+iQr7+MnN4A+yBrXSi23aozeTSedsiBNA7ZwiR9kAtxJOuvF
   dLhXAK2R6/gmvS8cUtkHOtsh6ymARxoBuiHOsErLlSo1fUntYpmUpKGBo
   /VwKjUrWK/grDfhTv+0piRKFAFmMc+vJIaxMU9q5AgTSBM/kaUybQhejd
   Q==;
X-CSE-ConnectionGUID: /l6aZX8hTHWvO9NAgtv+7Q==
X-CSE-MsgGUID: tfVlWPXlTM6d/+KDRVYwFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="74740105"
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="74740105"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 00:18:03 -0700
X-CSE-ConnectionGUID: S+gW+LzJQhW38tmqC+fItg==
X-CSE-MsgGUID: zQ5/WTjPQTKkmCzuiP7a5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="217254237"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 01 Nov 2025 00:18:01 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vF5s3-000NzI-0H;
	Sat, 01 Nov 2025 07:17:56 +0000
Date: Sat, 01 Nov 2025 15:17:41 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD REGRESSION
 3bf692888f2707392872a69cd125c800778e72e2
Message-ID: <202511011535.jwKGGzRN-lkp@intel.com>
User-Agent: s-nail v14.9.25
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 3bf692888f2707392872a69cd125c800778e72e2  erofs: avoid infinite loop due to incomplete zstd-compressed data

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202511010331.SSF687V8-lkp@intel.com

    ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against local symbol; recompile with -fPIC

Error/Warning ids grouped by kconfigs:

recent_errors
`-- powerpc-randconfig-002-20251101
    `-- ld.lld:error:relocation-R_PPC_ADDR16_HI-cannot-be-used-against-local-symbol-recompile-with-fPIC

elapsed time: 1468m

configs tested: 168
configs skipped: 3

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251031    gcc-8.5.0
arc                   randconfig-002-20251031    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20251031    gcc-14.3.0
arm                   randconfig-002-20251031    clang-22
arm                   randconfig-003-20251031    gcc-11.5.0
arm                   randconfig-004-20251031    clang-22
arm                          sp7021_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    clang-22
arm64                 randconfig-001-20251101    gcc-8.5.0
arm64                 randconfig-002-20251101    clang-22
arm64                 randconfig-003-20251101    clang-17
arm64                 randconfig-004-20251101    gcc-14.3.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                  randconfig-001-20251101    gcc-15.1.0
csky                  randconfig-002-20251101    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251031    clang-22
hexagon               randconfig-002-20251031    clang-22
i386                             alldefconfig    gcc-14
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251101    clang-20
i386        buildonly-randconfig-002-20251101    gcc-13
i386        buildonly-randconfig-003-20251101    clang-20
i386        buildonly-randconfig-004-20251101    gcc-14
i386        buildonly-randconfig-005-20251101    clang-20
i386        buildonly-randconfig-006-20251101    clang-20
i386                  randconfig-001-20251101    clang-20
i386                  randconfig-002-20251101    gcc-14
i386                  randconfig-003-20251101    gcc-14
i386                  randconfig-004-20251101    clang-20
i386                  randconfig-005-20251101    clang-20
i386                  randconfig-006-20251101    clang-20
i386                  randconfig-007-20251101    gcc-14
i386                  randconfig-011-20251101    gcc-14
i386                  randconfig-012-20251101    clang-20
i386                  randconfig-013-20251101    gcc-14
i386                  randconfig-014-20251101    clang-20
i386                  randconfig-015-20251101    clang-20
i386                  randconfig-016-20251101    gcc-14
i386                  randconfig-017-20251101    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251031    gcc-15.1.0
loongarch             randconfig-002-20251031    gcc-14.3.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                       m5249evb_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251031    gcc-9.5.0
nios2                 randconfig-002-20251031    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251101    gcc-11.5.0
parisc                randconfig-002-20251101    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                 linkstation_defconfig    clang-20
powerpc               randconfig-001-20251101    gcc-11.5.0
powerpc               randconfig-002-20251101    clang-22
powerpc64             randconfig-001-20251101    gcc-11.5.0
powerpc64             randconfig-002-20251101    clang-20
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251031    gcc-8.5.0
riscv                 randconfig-002-20251031    clang-17
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251031    clang-16
s390                  randconfig-002-20251031    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251031    gcc-14.3.0
sh                    randconfig-002-20251031    gcc-14.3.0
sh                   secureedge5410_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251101    gcc-15.1.0
sparc                 randconfig-002-20251101    gcc-14.3.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251101    gcc-15.1.0
sparc64               randconfig-002-20251101    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251101    clang-16
um                    randconfig-002-20251101    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251101    clang-20
x86_64      buildonly-randconfig-002-20251101    gcc-14
x86_64      buildonly-randconfig-003-20251101    gcc-13
x86_64      buildonly-randconfig-004-20251101    clang-20
x86_64      buildonly-randconfig-005-20251101    gcc-13
x86_64      buildonly-randconfig-006-20251101    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251101    clang-20
x86_64                randconfig-002-20251101    gcc-14
x86_64                randconfig-003-20251101    gcc-14
x86_64                randconfig-004-20251101    gcc-14
x86_64                randconfig-005-20251101    clang-20
x86_64                randconfig-006-20251101    clang-20
x86_64                randconfig-011-20251101    clang-20
x86_64                randconfig-012-20251101    gcc-14
x86_64                randconfig-013-20251101    clang-20
x86_64                randconfig-014-20251101    gcc-14
x86_64                randconfig-015-20251101    clang-20
x86_64                randconfig-016-20251101    gcc-14
x86_64                randconfig-071-20251101    clang-20
x86_64                randconfig-072-20251101    clang-20
x86_64                randconfig-073-20251101    gcc-14
x86_64                randconfig-074-20251101    clang-20
x86_64                randconfig-075-20251101    clang-20
x86_64                randconfig-076-20251101    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                  cadence_csp_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251101    gcc-13.4.0
xtensa                randconfig-002-20251101    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

