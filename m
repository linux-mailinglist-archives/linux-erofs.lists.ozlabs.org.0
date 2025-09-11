Return-Path: <linux-erofs+bounces-1017-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3D0B529DC
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Sep 2025 09:28:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cMq0K2h6Sz2xnn;
	Thu, 11 Sep 2025 17:28:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757575681;
	cv=none; b=NBvIBDoU7U4FWGOZB76368R91O403Vds3tnd1tadw7MS6H2ltlsxfs8wmoBJqAOaR3G6pOMwbKQO/lDDB3aFPfCaxrw3zU1iRrz0IPBWOGpxwy1t4zVuZncPy+ENKk0pd/tcX3R5vnJjozF6h+LAwgICZpMmQwMDq/he1WoJi5+sBChZDS9stWZi+K+nq4GN7ODR5DiNk8LOBQ1agO6Kyk6Md/NPUI/b435GO0TEYTZwpeKmPwhuyj6PGoA4hg54BH65BdMW1c8sFPRG8LWPKZaQrbE6iEwhvN13fnIRkPW5Zkzv/0Enk5aN8ChD/D0+CXTedkDH6YX0JABFpgLUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757575681; c=relaxed/relaxed;
	bh=8y7zJ9BU4t6tzU5/OdRQf4jUJpvpXP4amsR9KJP8acc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=o06byLJs6m9qGCy14SIMAQvs9RFdY7Vr79RFpVWbcSsYCaDKx+uonNik9sPhMtXctFcgrFZM5ppqOZ19Ob4im2dvg2zdtFH2Ibu4hfP/5GT8RdBLwt87HGYxQtQhZr1KD5LxTJQCBGrn16/S2CC1l7kIAeCSVQunLFyOA7rcdqZjg3a2sa7xz8W/Tb3OS2Og6buEj0KFErj2H5O04JqvMLpL3MDpzXVxKF/gS2hIBtdtQrRxWycJ6yBg/rGyC5c0yI3cXr7/ryBsivWNFp4IJsVf6i1rOUR0Z2Th68zHYUtaKF/QteIj8EQaWqhMo8+0DvDKEeEwmzGCEPWEiR9HDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UpLw9W11; dkim-atps=neutral; spf=pass (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UpLw9W11;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cMq0G74kmz2xd6
	for <linux-erofs@lists.ozlabs.org>; Thu, 11 Sep 2025 17:27:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757575679; x=1789111679;
  h=date:from:to:cc:subject:message-id;
  bh=Nr1XpBzrmqkDo+0TJ3zlto3Kbq8P7H1MSoy4gWdKScQ=;
  b=UpLw9W11m0oYZ18FoZGwAh2kSfRxRABZVMYPH2wjLjvJdxZz0l7GdWR5
   xnZZjwbDOdww1Tqenq8bFKMKHBU4CZ7bftK+kjkzngA2Onz/k2TGDQ6Qc
   46NkD/OWPyUypIAPGM45hBH99NpCgT+s6A9TbtXYJY0pnXJeK7kMKsFxT
   7L5WBmi0XKt8BdoOv/HRVylkOxHpwIcV0yBX1tSOT6ARWTNN6VIgGmtfK
   kcgaHNkl95tCMAxMa2tpDdSYHHtwcpfLkQiw5IIthjpchxvdlZwJ+ybGW
   M+CCbQieKO+Ko++CZEkUJ+Im/JX/0tfvX2SfVVZ9HZw9vFfSybifHQMv3
   A==;
X-CSE-ConnectionGUID: GQUt8rUXQFqSh3GeimPVFg==
X-CSE-MsgGUID: d9KtjpAKRrCH4zvnatE1Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="58939622"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="58939622"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 00:27:53 -0700
X-CSE-ConnectionGUID: z1B/dsW/RmyQBrvUecgW1g==
X-CSE-MsgGUID: +klvU9koQt6ne9ZYtg7odQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="173177391"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 11 Sep 2025 00:27:52 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwbif-00007p-2J;
	Thu, 11 Sep 2025 07:27:49 +0000
Date: Thu, 11 Sep 2025 15:27:07 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 181993bb0d626cf88cc803f4356ce5c5abe86278
Message-ID: <202509111557.5wm1R2Qi-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 181993bb0d626cf88cc803f4356ce5c5abe86278  erofs: fix runtime warning on truncate_folio_batch_exceptionals()

elapsed time: 1481m

configs tested: 161
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250910    gcc-13.4.0
arc                   randconfig-001-20250911    gcc-8.5.0
arc                   randconfig-002-20250910    gcc-8.5.0
arc                   randconfig-002-20250911    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250910    gcc-8.5.0
arm                   randconfig-001-20250911    clang-22
arm                   randconfig-002-20250910    gcc-8.5.0
arm                   randconfig-002-20250911    gcc-14.3.0
arm                   randconfig-003-20250910    clang-16
arm                   randconfig-003-20250911    clang-22
arm                   randconfig-004-20250910    gcc-8.5.0
arm                   randconfig-004-20250911    clang-16
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250910    clang-22
arm64                 randconfig-001-20250911    gcc-13.4.0
arm64                 randconfig-002-20250910    clang-22
arm64                 randconfig-002-20250911    gcc-8.5.0
arm64                 randconfig-003-20250910    gcc-9.5.0
arm64                 randconfig-003-20250911    gcc-8.5.0
arm64                 randconfig-004-20250910    gcc-13.4.0
arm64                 randconfig-004-20250911    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250910    gcc-12.5.0
csky                  randconfig-001-20250911    gcc-15.1.0
csky                  randconfig-002-20250910    gcc-15.1.0
csky                  randconfig-002-20250911    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250910    clang-22
hexagon               randconfig-001-20250911    clang-20
hexagon               randconfig-002-20250910    clang-22
hexagon               randconfig-002-20250911    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250910    gcc-14
i386        buildonly-randconfig-001-20250911    clang-20
i386        buildonly-randconfig-002-20250910    gcc-13
i386        buildonly-randconfig-002-20250911    clang-20
i386        buildonly-randconfig-003-20250910    clang-20
i386        buildonly-randconfig-003-20250911    clang-20
i386        buildonly-randconfig-004-20250910    clang-20
i386        buildonly-randconfig-004-20250911    clang-20
i386        buildonly-randconfig-005-20250910    gcc-14
i386        buildonly-randconfig-005-20250911    clang-20
i386        buildonly-randconfig-006-20250910    clang-20
i386        buildonly-randconfig-006-20250911    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250910    clang-18
loongarch             randconfig-001-20250911    gcc-15.1.0
loongarch             randconfig-002-20250910    clang-18
loongarch             randconfig-002-20250911    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250910    gcc-11.5.0
nios2                 randconfig-001-20250911    gcc-11.5.0
nios2                 randconfig-002-20250910    gcc-9.5.0
nios2                 randconfig-002-20250911    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250910    gcc-10.5.0
parisc                randconfig-001-20250911    gcc-8.5.0
parisc                randconfig-002-20250910    gcc-9.5.0
parisc                randconfig-002-20250911    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250910    gcc-8.5.0
powerpc               randconfig-001-20250911    gcc-8.5.0
powerpc               randconfig-002-20250910    gcc-8.5.0
powerpc               randconfig-002-20250911    gcc-15.1.0
powerpc               randconfig-003-20250910    clang-22
powerpc               randconfig-003-20250911    gcc-8.5.0
powerpc64             randconfig-001-20250911    clang-22
powerpc64             randconfig-002-20250910    gcc-11.5.0
powerpc64             randconfig-002-20250911    gcc-11.5.0
powerpc64             randconfig-003-20250910    clang-22
powerpc64             randconfig-003-20250911    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250910    clang-22
riscv                 randconfig-002-20250910    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250910    clang-22
s390                  randconfig-002-20250910    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250910    gcc-15.1.0
sh                    randconfig-002-20250910    gcc-12.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250910    gcc-8.5.0
sparc                 randconfig-002-20250910    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250910    gcc-8.5.0
sparc64               randconfig-002-20250910    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250910    clang-22
um                    randconfig-002-20250910    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250910    gcc-14
x86_64      buildonly-randconfig-001-20250911    gcc-14
x86_64      buildonly-randconfig-002-20250910    clang-20
x86_64      buildonly-randconfig-002-20250911    gcc-14
x86_64      buildonly-randconfig-003-20250910    gcc-14
x86_64      buildonly-randconfig-003-20250911    clang-20
x86_64      buildonly-randconfig-004-20250910    clang-20
x86_64      buildonly-randconfig-004-20250911    clang-20
x86_64      buildonly-randconfig-005-20250910    gcc-14
x86_64      buildonly-randconfig-005-20250911    clang-20
x86_64      buildonly-randconfig-006-20250910    clang-20
x86_64      buildonly-randconfig-006-20250911    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250910    gcc-8.5.0
xtensa                randconfig-002-20250910    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

