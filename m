Return-Path: <linux-erofs+bounces-1347-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9965C2F0C7
	for <lists+linux-erofs@lfdr.de>; Tue, 04 Nov 2025 04:02:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0tXh2lYrz3bf2;
	Tue,  4 Nov 2025 14:02:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762225332;
	cv=none; b=dsrQDOOSJGtL+nQdsuQo996uvlTOpeqeyi1GUrjkj3e1hUy2TL4Cct+/XfIZde7GqsCsG0tmVJGTOzfoe/WMZff4ZgRepC7YIjJ/ARG99yyGxqo5k4WyTNz0dUXRTWewSmvlWf55FQhY5+uMKR5sWbSIOdguqv3lywVrmBGi7V1NEjA0l8AFRDOaTEQxHELwyCI2uWLf0LYaeBdbSaT2Av2AHn7cSKthRc150Gax9D/4h00/5batFunhRnwKNkFrfKtaCxFX8fHYHuyWiMUoDmsaO1LSlJb+hW00HIX2cFCaEaOm7D/KyuAGtRKRFM1t3TzRuKCFv5h5wVdgEZmCig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762225332; c=relaxed/relaxed;
	bh=YXYCy39+c7jU8OrV+QMfxjT+d6FbklYcr7QncMU5s0Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VOjXDqqLkSNxPxz7wynnAtVTXxwRAzslLyr/oTDFD90ynYvoXgxB7Ja2GFbWqABzTkKPOqQXs7ukyhWy4VDKQxD3vqysmRvOE4z+pUDFjq6/0JX/Mj+pNHIuJxrUfJW6D7EkPyzTUzqTv6U0cC27aztMCnUkaJV5KKfdVs6Vjib8R2qKfTrDNQPbswu/3GRc42U9BzBws+LfPYNDGB2UC/2awudYXUDbtnu+3posvxGxlouxo9Ou1SgpOjBNY3se5amjZTeni4WH9lLfJJbdYO43gcS4obIsmPewQtINu2OrNYszAWgFUod2UkMm+FhwlFZ5bKfFr/Ds7d9OKhlnag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R03bjgne; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R03bjgne;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0tXd58xjz3bdQ
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 14:02:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762225329; x=1793761329;
  h=date:from:to:cc:subject:message-id;
  bh=huLuFo6FxbdfUP4+6F1pM14rqaIusjev40ULxLGA2Ck=;
  b=R03bjgneTkpF+hddNVpurWJiB4AicOZdZY/x6SpoMFLKFFbzpCOfQzdZ
   9SDccHK4cMYaigEvGwXCkzxtvwZAG7ZPArcxz67TXiwUhsuWyN95IS07H
   D8Ixi5lLU+IQcSB871NIJjfeVneclgkE3q1WT+kbiHi/d3sxoES47xJ1Y
   XI8488UQvVTceg1veXY1u1o1Z8z5VxYIgHykyHEKMLk4C1p9jBEhc/0aK
   2XsiaE9E9Wc/1+/pUXUNR0zAR4/FeMvm8mP7tvAyROzfYGMkc2z8M1nQU
   m20gjDl04UzKzyd4YJG3jG8RKTvSVigrMZSS08096QDUDgS+vJ4Tnq3W8
   w==;
X-CSE-ConnectionGUID: v5CD4UKdRHeH/m0iXQGP9A==
X-CSE-MsgGUID: 86Q7Wt92T2GjJiFDzCFczg==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="89773568"
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="89773568"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 19:02:04 -0800
X-CSE-ConnectionGUID: kaCXQyCeTNCZmrDviytOzw==
X-CSE-MsgGUID: JQlTLPGkQ0eANZsASgMvSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="217846457"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 03 Nov 2025 19:02:04 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vG7He-000Qn4-2s;
	Tue, 04 Nov 2025 03:01:06 +0000
Date: Tue, 04 Nov 2025 10:55:40 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 bb163a3997477c84c3e0cde42de7dba62bce3be8
Message-ID: <202511041035.UPwcxsNo-lkp@intel.com>
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
branch HEAD: bb163a3997477c84c3e0cde42de7dba62bce3be8  erofs: avoid infinite loop due to incomplete zstd-compressed data

elapsed time: 1299m

configs tested: 148
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20251103    gcc-9.5.0
arc                   randconfig-002-20251103    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                           imxrt_defconfig    clang-22
arm                      jornada720_defconfig    clang-22
arm                   randconfig-001-20251103    clang-22
arm                   randconfig-002-20251103    clang-16
arm                   randconfig-003-20251103    gcc-14.3.0
arm                   randconfig-004-20251103    clang-22
arm                       spear13xx_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    clang-22
arm64                 randconfig-001-20251103    clang-22
arm64                 randconfig-002-20251103    gcc-13.4.0
arm64                 randconfig-003-20251103    gcc-14.3.0
arm64                 randconfig-004-20251103    gcc-8.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                  randconfig-001-20251103    gcc-15.1.0
csky                  randconfig-002-20251103    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251103    clang-22
hexagon               randconfig-002-20251103    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251103    gcc-14
i386        buildonly-randconfig-002-20251103    clang-20
i386        buildonly-randconfig-003-20251103    clang-20
i386        buildonly-randconfig-004-20251103    gcc-14
i386        buildonly-randconfig-005-20251103    gcc-14
i386        buildonly-randconfig-006-20251103    gcc-13
i386                  randconfig-001-20251103    clang-20
i386                  randconfig-002-20251103    gcc-14
i386                  randconfig-003-20251103    gcc-14
i386                  randconfig-004-20251103    clang-20
i386                  randconfig-005-20251103    gcc-14
i386                  randconfig-006-20251103    clang-20
i386                  randconfig-007-20251103    gcc-14
loongarch                        alldefconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    clang-22
loongarch             randconfig-001-20251103    gcc-12.5.0
loongarch             randconfig-002-20251103    gcc-14.3.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                           ip30_defconfig    gcc-15.1.0
mips                        maltaup_defconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    gcc-11.5.0
nios2                 randconfig-001-20251103    gcc-11.5.0
nios2                 randconfig-002-20251103    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                randconfig-001-20251103    gcc-14.3.0
parisc                randconfig-002-20251103    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   lite5200b_defconfig    clang-22
powerpc                 mpc8315_rdb_defconfig    clang-22
powerpc               mpc834x_itxgp_defconfig    clang-22
powerpc                      pcm030_defconfig    clang-22
powerpc               randconfig-001-20251103    gcc-8.5.0
powerpc               randconfig-002-20251103    clang-20
powerpc                     tqm5200_defconfig    gcc-15.1.0
powerpc                         wii_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251103    clang-22
powerpc64             randconfig-002-20251103    gcc-8.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    gcc-15.1.0
sparc                 randconfig-001-20251103    gcc-15.1.0
sparc                 randconfig-002-20251103    gcc-11.5.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    gcc-15.1.0
sparc64               randconfig-001-20251103    clang-22
sparc64               randconfig-002-20251103    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20251103    clang-19
um                    randconfig-002-20251103    clang-22
x86_64                           alldefconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251103    clang-20
x86_64      buildonly-randconfig-002-20251103    gcc-14
x86_64      buildonly-randconfig-003-20251103    gcc-13
x86_64      buildonly-randconfig-004-20251103    clang-20
x86_64      buildonly-randconfig-005-20251103    gcc-14
x86_64      buildonly-randconfig-006-20251103    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-011-20251103    clang-20
x86_64                randconfig-012-20251103    clang-20
x86_64                randconfig-013-20251103    gcc-14
x86_64                randconfig-014-20251103    gcc-14
x86_64                randconfig-015-20251103    clang-20
x86_64                randconfig-016-20251103    gcc-13
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20251103    gcc-13.4.0
xtensa                randconfig-002-20251103    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

