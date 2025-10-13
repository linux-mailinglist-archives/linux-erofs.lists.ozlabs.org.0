Return-Path: <linux-erofs+bounces-1177-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 91314BD13F4
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Oct 2025 04:48:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4clMGc1nxTz301G;
	Mon, 13 Oct 2025 13:48:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760323688;
	cv=none; b=k0IB2gJ+bHAO2NSkjSmAJeWpefee1m8SXvGEWxwFCx92HamqLm1UUVO9dEkzPFNA8RrXUVGZbxsNIrkjVQrWZy0GIYkW95hvchb8/LMuIaZQzW5ICJM9SEsiwMIlA+13E6TbH1+JO6Y2NiMzeofNmgdAfETfLE0NhDlxkdbx374efHf56U8on81yAmSjOwCsWMmhjfOkyAFF9wfWeK5EgxKIiEhcdHNOCaycy30NuIkNwRYx6rj6kfoEZN31se0Z7L1mYxT+S2BRTJbGzELv7Rrswsl88J+LZ47Ei3guGcGr7FvtVj12IKZ1t1Bq02lVAueW99DFlDQoqIaolLZDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760323688; c=relaxed/relaxed;
	bh=wbw/ou8D8+T7dbFuSTrHCbjCy+J4E4dUKg+GQ9HJM9o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=j3bOF2/Wyp+EkL8JTes5eb0ArPyeQKEQfziMPKo3voW9WBRUYKKKYNS2QVB/mabs36xcK7vZeJxWEBDK3CehN4FPTJPAw6iZNQVDIMgXEUlhrM2JwTfvMquryuesVk0fB7ukm2eX85NWkvyUkOz36P/bOJdBG0zJEVeG994TCFdfNqW3b1DZ65wnKYLeRQ/jlw43uCtpQKDaONP71A5oZlBq5BYNbOMmRNTx3mLvf6XQoKTWc2G0MZtYlFgHb1Z9FqWaTmgrutf/Y9oohHSpaaO+NJ1/rcUdtbAcD8E1DTVhD88fPJ1lS0knUqwxvssKzHrXaU10AdKx1MBkH2UTww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VPq2CQw5; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VPq2CQw5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4clMGY65dGz2xQ0
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 Oct 2025 13:48:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760323687; x=1791859687;
  h=date:from:to:cc:subject:message-id;
  bh=0AVWRAU5X6E14l4ZnO8ek4eAo5id8TY8lBLCi1uVILY=;
  b=VPq2CQw5ek1+tn/668NVCxEB6IhJKJRL5UyTj6Ipd6fXbSODcec0cWkQ
   EROHtvGsNPcLycSWVab8aPf+77uaQk4O5phGGVCtGDA1mTTFgX9gOoFcR
   +oxXyDNO2pybOb2j8QfKhiK+bs4Tx5FF3XpmRieVpOcEho4fwXJpQv86Y
   LJFn88Gg1ImP6d1leCrEplbDnlX9/yx6XUqtQZjx85kkjffNVuT/NRdVq
   uJ/ih/NOXXDdempr8ZihForFEqLZzIlfwuPBQ0clXdOqKV0LIrhs5LorW
   a09bHtO4NuNVS7x3KjKl9bitkz0ROX8W4TCX9WxvYox47hmsieL9UATVf
   w==;
X-CSE-ConnectionGUID: lg63mxYaTfy6WXzYeMhwIg==
X-CSE-MsgGUID: tomedRYpQhOixjHVDDRYCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="85083956"
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; 
   d="scan'208";a="85083956"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2025 19:48:02 -0700
X-CSE-ConnectionGUID: fWzUkBb4TyaJb15ci8Amcw==
X-CSE-MsgGUID: yvDgtcjoRXqdrx8qk7PVMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; 
   d="scan'208";a="185891056"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 12 Oct 2025 19:48:00 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v88bN-00007r-3A;
	Mon, 13 Oct 2025 02:47:57 +0000
Date: Mon, 13 Oct 2025 10:47:46 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 767c5be0d3dce60e94b0a1c017c5563a6af2ad3f
Message-ID: <202510131040.KDPlJuDw-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
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
branch HEAD: 767c5be0d3dce60e94b0a1c017c5563a6af2ad3f  erofs: fix crafted invalid cases for encoded extents

elapsed time: 725m

configs tested: 156
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251012    gcc-8.5.0
arc                   randconfig-002-20251012    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                       imx_v6_v7_defconfig    clang-16
arm                   randconfig-001-20251012    clang-19
arm                   randconfig-002-20251012    gcc-10.5.0
arm                   randconfig-003-20251012    clang-20
arm                   randconfig-004-20251012    gcc-10.5.0
arm                           sama7_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251012    gcc-8.5.0
arm64                 randconfig-002-20251012    clang-22
arm64                 randconfig-003-20251012    gcc-14.3.0
arm64                 randconfig-004-20251012    clang-22
csky                             alldefconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251012    gcc-15.1.0
csky                  randconfig-002-20251012    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251012    clang-22
hexagon               randconfig-002-20251012    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251012    clang-20
i386        buildonly-randconfig-002-20251012    clang-20
i386        buildonly-randconfig-003-20251012    gcc-14
i386        buildonly-randconfig-004-20251012    clang-20
i386        buildonly-randconfig-005-20251012    clang-20
i386        buildonly-randconfig-006-20251012    gcc-14
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251012    gcc-12.5.0
loongarch             randconfig-002-20251012    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    clang-22
mips                           gcw0_defconfig    clang-22
mips                       rbtx49xx_defconfig    gcc-15.1.0
mips                           xway_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251012    gcc-11.5.0
nios2                 randconfig-002-20251012    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251012    gcc-14.3.0
parisc                randconfig-002-20251012    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                 mpc837x_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251012    gcc-12.5.0
powerpc               randconfig-002-20251012    clang-22
powerpc               randconfig-003-20251012    gcc-14.3.0
powerpc                     tqm8548_defconfig    clang-22
powerpc64             randconfig-001-20251012    clang-22
powerpc64             randconfig-002-20251012    gcc-12.5.0
powerpc64             randconfig-003-20251012    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251012    clang-22
riscv                 randconfig-001-20251013    clang-22
riscv                 randconfig-002-20251012    clang-22
riscv                 randconfig-002-20251013    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251012    gcc-8.5.0
s390                  randconfig-001-20251013    gcc-8.5.0
s390                  randconfig-002-20251012    clang-17
s390                  randconfig-002-20251013    clang-22
s390                       zfcpdump_defconfig    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        edosk7760_defconfig    gcc-15.1.0
sh                          polaris_defconfig    gcc-15.1.0
sh                    randconfig-001-20251012    gcc-15.1.0
sh                    randconfig-001-20251013    gcc-10.5.0
sh                    randconfig-002-20251012    gcc-9.5.0
sh                    randconfig-002-20251013    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251012    gcc-15.1.0
sparc                 randconfig-001-20251013    gcc-8.5.0
sparc                 randconfig-002-20251012    gcc-15.1.0
sparc                 randconfig-002-20251013    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251012    clang-20
sparc64               randconfig-001-20251013    clang-20
sparc64               randconfig-002-20251012    gcc-11.5.0
sparc64               randconfig-002-20251013    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251012    clang-22
um                    randconfig-001-20251013    gcc-14
um                    randconfig-002-20251012    clang-22
um                    randconfig-002-20251013    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251012    gcc-14
x86_64      buildonly-randconfig-002-20251012    gcc-14
x86_64      buildonly-randconfig-003-20251012    gcc-14
x86_64      buildonly-randconfig-004-20251012    gcc-14
x86_64      buildonly-randconfig-005-20251012    clang-20
x86_64      buildonly-randconfig-006-20251012    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                          iss_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251012    gcc-8.5.0
xtensa                randconfig-001-20251013    gcc-11.5.0
xtensa                randconfig-002-20251012    gcc-11.5.0
xtensa                randconfig-002-20251013    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

