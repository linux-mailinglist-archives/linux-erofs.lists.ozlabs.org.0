Return-Path: <linux-erofs+bounces-1490-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B69CB112F
	for <lists+linux-erofs@lfdr.de>; Tue, 09 Dec 2025 21:54:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dQrgX58kcz2yF1;
	Wed, 10 Dec 2025 07:54:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765313656;
	cv=none; b=LmfLnTPcmPZVeS+vnA7wm7fgHYR4Ecl5n9zz2kPnTRZQC0cQOmTqkbaiOZQKQh7GbgxbtyfCUYMsmWE/oX6Q/mMeISavEnw6IRhK5qFUWCOklOj5OdcT5AQw/LB98PXTymkkvcWQvyR7gclOIuVeSMvtLwTToNKVugZsTHOumTdJCqmJg7ZFxuyUBj6bIRSdJmI3vG8x22qQqiDBROAdKIBVc+NX5PWtD5eguJpZ4/kkrUKSQTyCNSKpeygNF47kErVExtnpRKwwCo4IjesU08lda9Qck8Ntcz55Yu1tSamqBWiYBHgVMeradbrVMCrrZU0muwqsgMeej/WB4HyTgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765313656; c=relaxed/relaxed;
	bh=+54yQZ4HGGAFu53+cegzOgxEFANweFrhUg64HS0GJE8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BQaOZrZ0nxi7XprKwZmoZ/0x4UhuFiyJFW97eYjelJmCRiOeBOs1xb7qze+0KC7WOXSJ3gS5/LfNxfzzdoIT5X+DeLzXrySnJog6gkttH0AIbsMbZ9CPqAGJIp+2QrDiHMbH1ZuLMU9QtGw+durwl4uQW1eL/0P2z4sTRL/UCF2tVKXNVqyzs6KRJiQrzx5S24vxuaT6pfzieq2gILYQ56evz8sGBh33sVAQUd8/Qwc65xx4HxKLFlLXuqGWFjrcUva/IytWWHmt4mbawxq34Y0qSZkmsjFoScGy7FoCo9ep1H14eiEWPAVRoZf5GwttwFwQoMhrqU+9+3DT6gaCOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lw/itWJe; dkim-atps=neutral; spf=pass (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lw/itWJe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dQrgT4lvsz2xs1
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Dec 2025 07:54:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765313654; x=1796849654;
  h=date:from:to:cc:subject:message-id;
  bh=LdmqJ+pUa04nV3KY+aJbQ/ompg+K9TkbeFwQkj6cyjM=;
  b=lw/itWJeB+oB9KFHO9v8QuYHyOYOaB08VSPSHi59x+DKepvAoEPr2AVi
   FDGUQOhn/cyOzCU0Ao/qJZGnKQoTv4C/9/hVF/QJSSSwhYVtg+Zu9J1KV
   ti4tOpFm1SmDK3IhszbmDWYLXz1gFA1fXndpWH11+BKJn3yfclkRBat5z
   jCP1alV3QBZAMNA5ZU2SBe+i4tfM/sXTZvzOA1H1Squ3EpHXo7VRS03iU
   4z69JGUYpxFX024Say22CBr1vFy5pBFhW5oAjH1WcXW0/8cIpu4ry1sja
   hZV5JdrHKRtmuPF95Vxd4b0rQZuLL04OXcq4TOb/W2H5kichqn0W26QN/
   w==;
X-CSE-ConnectionGUID: b0AGh/VBRiCIkD3n0Kp1wg==
X-CSE-MsgGUID: L/JB+IteQpugIO0M90V8Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="67448496"
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="67448496"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 12:54:09 -0800
X-CSE-ConnectionGUID: lF0zXdn1RkCiGu9Sd6dEVw==
X-CSE-MsgGUID: hYQhJAl4TVe6dLwuMXx5oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="233734269"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 09 Dec 2025 12:54:08 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vT4ij-000000002FV-26cw;
	Tue, 09 Dec 2025 20:54:05 +0000
Date: Wed, 10 Dec 2025 04:54:03 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 f9999e5b414dea8cd98343c77603061e05ecaaba
Message-ID: <202512100457.49U2vW2T-lkp@intel.com>
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
branch HEAD: f9999e5b414dea8cd98343c77603061e05ecaaba  erofs: Use %pe format specifier for error pointers

elapsed time: 1449m

configs tested: 151
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251209    gcc-13.4.0
arc                   randconfig-002-20251209    gcc-9.5.0
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                            qcom_defconfig    clang-22
arm                   randconfig-001-20251209    clang-19
arm                   randconfig-002-20251209    clang-20
arm                   randconfig-003-20251209    clang-22
arm                   randconfig-004-20251209    clang-22
arm                        shmobile_defconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251209    gcc-8.5.0
arm64                 randconfig-002-20251209    gcc-9.5.0
arm64                 randconfig-003-20251209    clang-22
arm64                 randconfig-004-20251209    gcc-11.5.0
csky                             allmodconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251209    gcc-15.1.0
csky                  randconfig-002-20251209    gcc-15.1.0
hexagon                          alldefconfig    clang-22
hexagon                          allmodconfig    clang-17
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251209    clang-22
hexagon               randconfig-002-20251209    clang-22
i386                             allmodconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251209    clang-20
i386        buildonly-randconfig-002-20251209    clang-20
i386        buildonly-randconfig-003-20251209    gcc-14
i386        buildonly-randconfig-004-20251209    gcc-14
i386        buildonly-randconfig-005-20251209    gcc-14
i386        buildonly-randconfig-006-20251209    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251209    gcc-14
i386                  randconfig-002-20251209    clang-20
i386                  randconfig-003-20251209    clang-20
i386                  randconfig-004-20251209    gcc-14
i386                  randconfig-005-20251209    gcc-14
i386                  randconfig-006-20251209    clang-20
i386                  randconfig-007-20251209    gcc-14
i386                  randconfig-011-20251209    clang-20
i386                  randconfig-012-20251209    clang-20
i386                  randconfig-013-20251209    clang-20
i386                  randconfig-014-20251209    clang-20
i386                  randconfig-015-20251209    clang-20
i386                  randconfig-016-20251209    clang-20
i386                  randconfig-017-20251209    gcc-14
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251209    clang-22
loongarch             randconfig-002-20251209    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251209    gcc-8.5.0
nios2                 randconfig-002-20251209    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251209    gcc-8.5.0
parisc                randconfig-002-20251209    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      arches_defconfig    gcc-15.1.0
powerpc                          g5_defconfig    gcc-15.1.0
powerpc                     mpc512x_defconfig    clang-22
powerpc               randconfig-001-20251209    gcc-14.3.0
powerpc               randconfig-002-20251209    clang-22
powerpc64             randconfig-001-20251209    gcc-14.3.0
powerpc64             randconfig-002-20251209    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251209    clang-22
riscv                 randconfig-002-20251209    clang-18
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251209    gcc-12.5.0
s390                  randconfig-002-20251209    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251209    gcc-14.3.0
sh                    randconfig-002-20251209    gcc-13.4.0
sh                        sh7785lcr_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251209    gcc-11.5.0
sparc                 randconfig-002-20251209    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251209    clang-22
sparc64               randconfig-002-20251209    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251209    gcc-14
um                    randconfig-002-20251209    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251209    clang-20
x86_64      buildonly-randconfig-002-20251209    gcc-14
x86_64      buildonly-randconfig-003-20251209    gcc-14
x86_64      buildonly-randconfig-004-20251209    clang-20
x86_64      buildonly-randconfig-005-20251209    clang-20
x86_64      buildonly-randconfig-006-20251209    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251209    clang-20
x86_64                randconfig-002-20251209    clang-20
x86_64                randconfig-003-20251209    clang-20
x86_64                randconfig-004-20251209    gcc-14
x86_64                randconfig-005-20251209    gcc-14
x86_64                randconfig-006-20251209    gcc-14
x86_64                randconfig-011-20251209    gcc-14
x86_64                randconfig-012-20251209    clang-20
x86_64                randconfig-013-20251209    gcc-14
x86_64                randconfig-014-20251209    clang-20
x86_64                randconfig-015-20251209    clang-20
x86_64                randconfig-016-20251209    clang-20
x86_64                randconfig-071-20251209    clang-20
x86_64                randconfig-072-20251209    gcc-14
x86_64                randconfig-073-20251209    gcc-14
x86_64                randconfig-074-20251209    gcc-14
x86_64                randconfig-075-20251209    gcc-14
x86_64                randconfig-076-20251209    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251209    gcc-13.4.0
xtensa                randconfig-002-20251209    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

