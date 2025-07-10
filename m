Return-Path: <linux-erofs+bounces-575-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F37D9AFFA70
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Jul 2025 09:10:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bd5bH574zz30MY;
	Thu, 10 Jul 2025 17:10:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752131435;
	cv=none; b=jS8kOJuVyBcCRXLUl0X9ct2BestKkkcBvMrfzYxJ1W2t8qSsx347kr/vEH+UPkQS89QTCi3lydT76WmupDZwv2z8AtgA5Mqr9xrxCuDOWsbZD6UweDLkjuSNWZ05ZbWNC/dwpOmZiCcUWDYuFMYKnEkf83Uw5zOsN8PCVCyMtpqHPGlAjIAn070e5TqY3bopYgQIf8CAqp+mw35RdYhc6XUDbFLPXX08wkseuYt7u+EojHkcXOOlHrPhKxyW90DL7KoG24C1fI83QhSR1ouHHzjAKWSg7OcccAOvRDqUHuoAEuiLS8gTkdvvkQMNdZL+iQn4+7rzMih+sfte4B8B7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752131435; c=relaxed/relaxed;
	bh=8xKj6mAiHzoUIrTOw3YtC1fPYuERr6X1yV4QSZ3Exkg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QQZsr4O49DtR2qPY9DHYGa3uxLOOigSbnGwjx90s9AWrNz0CvkiVUbh3eUlzF9ipGgJJy1Px4REwO95b6sAo6dFhAKmTtT5DkLNwFE1YMAqzGxD0OPLy/NkhJV/qP4s45XXu/+Z0vzGntPzBNfGWbgpjNhdGVmKTnVmIDmerrB45u6+UB7uTo9PuHDnXwv/tiQbIHJDQIRtL1Aiyejl2mIBYvUKDeal6+H+mfOMdob/34qsUd3TsyzNVqOE0viW+FKAHmENG3RpqTd4wJszwKKn0EoMe4aLe5uXuRIr1ymOCXLrcI1k01gZ+EHQncr9raYPErLqLuW0qaD6VFcIjiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VN1ibVS8; dkim-atps=neutral; spf=pass (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VN1ibVS8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bd5bF2Fhpz2yYJ
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Jul 2025 17:10:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752131434; x=1783667434;
  h=date:from:to:cc:subject:message-id;
  bh=mOeIyX1vbCg8EEnPJz7nC/BjI2CClLcqmGxpKHNLNXw=;
  b=VN1ibVS8m/I8KNnnNBOmK67yUPXuf7Uj4bKmTGdAoNB8sCecY6fWPN/k
   3jl0jFqv1TVQ+aHo98Fyh5riqiJA82I4UzgdqEat0p/iA+0Z5NOtsYArA
   9a/cZOYgucLopBFvb2ody2gJ6x+8fWKljVc1V+yKB7GjpVFS6VzPXjrFf
   3ifyMrCYXMwhvCoTEPQSQV6cXDySUQcvRLnpJaysnAtSo5wjsNbq1RTdU
   ujClwFmYZ/aTpWBOWnmnEQusfWdC3vTsyI/36TC+3MdA4tLU8BBOoUErk
   U76OjelhRGW8O3TVXJcAFmN1i0I8pqnsnhjjs9jyRNPn52GEncbQtonj6
   A==;
X-CSE-ConnectionGUID: avVtOYatRhuCzwW433Gr2Q==
X-CSE-MsgGUID: gisPUflnQUOH3JXXMdrzTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="65853569"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="65853569"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 00:10:28 -0700
X-CSE-ConnectionGUID: Xa0a7INdQsis0yk8UOpfbQ==
X-CSE-MsgGUID: OgpQZuHNT/Say3MBNd9n3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="155404325"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 Jul 2025 00:10:26 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZlQG-0004dr-1C;
	Thu, 10 Jul 2025 07:10:24 +0000
Date: Thu, 10 Jul 2025 15:09:39 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 720a556a42a8925e36bcf78735b9b73cf1bff41a
Message-ID: <202507101527.5lDfRBVi-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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
branch HEAD: 720a556a42a8925e36bcf78735b9b73cf1bff41a  erofs: do sanity check on m->type in z_erofs_load_compact_lcluster()

elapsed time: 1458m

configs tested: 134
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250709    gcc-8.5.0
arc                   randconfig-002-20250709    gcc-11.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                          exynos_defconfig    clang-21
arm                            qcom_defconfig    clang-21
arm                   randconfig-001-20250709    gcc-12.4.0
arm                   randconfig-002-20250709    gcc-10.5.0
arm                   randconfig-003-20250709    clang-21
arm                   randconfig-004-20250709    clang-21
arm                       spear13xx_defconfig    gcc-15.1.0
arm                        spear6xx_defconfig    clang-21
arm                           tegra_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250709    clang-21
arm64                 randconfig-002-20250709    gcc-15.1.0
arm64                 randconfig-003-20250709    clang-21
arm64                 randconfig-004-20250709    gcc-10.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250709    gcc-15.1.0
csky                  randconfig-002-20250709    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250709    clang-19
hexagon               randconfig-002-20250709    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250709    gcc-12
i386        buildonly-randconfig-002-20250709    clang-20
i386        buildonly-randconfig-003-20250709    clang-20
i386        buildonly-randconfig-004-20250709    clang-20
i386        buildonly-randconfig-005-20250709    gcc-12
i386        buildonly-randconfig-006-20250709    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250709    gcc-15.1.0
loongarch             randconfig-002-20250709    gcc-12.4.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          sun3x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          rb532_defconfig    clang-18
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250709    gcc-14.2.0
nios2                 randconfig-002-20250709    gcc-14.2.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                  or1klitex_defconfig    gcc-15.1.0
openrisc                       virt_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250709    gcc-15.1.0
parisc                randconfig-002-20250709    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                      cm5200_defconfig    clang-21
powerpc                  iss476-smp_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250709    gcc-8.5.0
powerpc               randconfig-002-20250709    clang-21
powerpc               randconfig-003-20250709    clang-21
powerpc64             randconfig-001-20250709    gcc-10.5.0
powerpc64             randconfig-002-20250709    gcc-10.5.0
powerpc64             randconfig-003-20250709    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv             nommu_k210_sdcard_defconfig    gcc-15.1.0
riscv                 randconfig-001-20250709    gcc-10.5.0
riscv                 randconfig-002-20250709    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250709    clang-17
s390                  randconfig-002-20250709    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250709    gcc-10.5.0
sh                    randconfig-002-20250709    gcc-14.3.0
sh                           se7619_defconfig    gcc-15.1.0
sh                             shx3_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250709    gcc-15.1.0
sparc                 randconfig-002-20250709    gcc-10.3.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250709    clang-21
sparc64               randconfig-002-20250709    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250709    clang-17
um                    randconfig-002-20250709    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250709    gcc-12
x86_64      buildonly-randconfig-002-20250709    clang-20
x86_64      buildonly-randconfig-003-20250709    gcc-12
x86_64      buildonly-randconfig-004-20250709    gcc-12
x86_64      buildonly-randconfig-005-20250709    clang-20
x86_64      buildonly-randconfig-006-20250709    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250709    gcc-8.5.0
xtensa                randconfig-002-20250709    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

