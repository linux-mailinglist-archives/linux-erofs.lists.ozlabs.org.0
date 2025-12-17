Return-Path: <linux-erofs+bounces-1505-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6905BCC6A9C
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Dec 2025 09:55:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dWSL15NxTz2ykV;
	Wed, 17 Dec 2025 19:55:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765961705;
	cv=none; b=HboaMiI/AhfEYBdZp22XlL/CZOweld5v9POu05H5wUcqNnw7+2Ja8NYDzigucjtcZWESzKv1tO9EEyyg1GdhVJm+HGIMvpqkifDIfdsDnrSq5Tku9prN7kl7tXUXFV2GD2w2wVdjgEiwhONTEKAWyV1ZprABDWq62jpH+0oINz7XPnpbsEC4R0Q6tNW5kYKSaOzdK05o1MC8D8i1Q8yBi2ZJdZhHJRRI6lmYEBcbQi/HPlXB0iZePJZyGgsARNkqWGfLk6XjS3iQeQt1B5v1nwfasuSNAiU3ZU5UfpqmbLc5WKbjG3QPhMGwgFrAh8BmZSPpv5ZXrHtBRA21olhAZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765961705; c=relaxed/relaxed;
	bh=9ELsOzzJkmKkJLcQnfjk8QtBfwN8c2wk/i4b4SXUQx0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TCmSWTVAjncwXZlwLUeY8wKfbVyq/G/Xw0xt72zmBDlilsrRRBFo0umEKr0c5KNnu75hxomKI6B5EWqkpBASem4UrViY8PoSkQTffSqsUPuXQ4U6Kb+Aljuv4NHHqF58mJY/D3SNRWhmB+6xhBmG6qIZ20CTjWOaXyZNnz6G06KRirZ+FIoAVeSd61GwSXmW6zVOJLHRMp9ZXK28LVSytMajN+oc3H7gvw69iKzr8hQGbv6CzslNCJukMq4hkjagE9aJV3rFJTHXzT8vUdfEAL5sGP4zIaBC1DP0XzNSBV0J1cSpYpARyqVavIO4TKd4Kx9CZYPd6NVKDYSys+P2uA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KClqLI9x; dkim-atps=neutral; spf=permerror (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KClqLI9x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Two or more type TXT spf records found.) smtp.mailfrom=intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dWSKy5WG1z2yjp
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Dec 2025 19:55:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765961703; x=1797497703;
  h=date:from:to:cc:subject:message-id;
  bh=wln6KQgT3LU5Vgk7+G5kEAY6vmYhJUWVA0Z/AkuEMhU=;
  b=KClqLI9xky+BtOU7g+nyLMjyT+WZXmT2bAerf3kZJSXHmPDdBmjYj8Ul
   sHCo25566HpQ1IFtna3LTc6hexmWsZSHQn+7nkKo/fRIjR+2PuWzGgOps
   cUf1mOrvgHKDMvsV04bTZEv8g+kNiNdlBJ4ZcwPMn7KQXCQm/fUlYTj5h
   JmEU/Fsx3gnbiwRSyj2sZVlcB3MqpzDdzeDdZE4q8uBMJ/ATkQEuhvKJM
   Sq1osnFUbSYsZWWN1BtUTIbXT5tnH+VMHXAwNz4ajbbwyZLjTnSRpN09u
   svxdCDkE4evDMCAVbC7wYnD77jYyrLg8hzmDczJmk0bD5VblJiBdUGbDm
   g==;
X-CSE-ConnectionGUID: Ui9G7EFKTOmb4babzDv3lA==
X-CSE-MsgGUID: G0C7cRSaTBmlKLodwWen4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="71751584"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="71751584"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 00:54:25 -0800
X-CSE-ConnectionGUID: x/t3nhfBQPS9IMR5zmX4JQ==
X-CSE-MsgGUID: HGiOk3/dRA+L9ZaJN7M7Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="197345481"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 17 Dec 2025 00:54:24 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vVnIa-000000000FY-3pOV;
	Wed, 17 Dec 2025 08:54:20 +0000
Date: Wed, 17 Dec 2025 16:53:38 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 e68e6eb58221ce30497c238d37704d230321869d
Message-ID: <202512171632.E1kgMbKa-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	T_SPF_PERMERROR autolearn=disabled version=4.0.1
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
branch HEAD: e68e6eb58221ce30497c238d37704d230321869d  erofs: make z_erofs_crypto[] static

elapsed time: 1448m

configs tested: 281
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.1.0
arc                 nsimosci_hs_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20251217    clang-22
arc                   randconfig-001-20251217    gcc-8.5.0
arc                   randconfig-002-20251217    clang-22
arc                   randconfig-002-20251217    gcc-10.5.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.1.0
arm                     am200epdkit_defconfig    clang-22
arm                         bcm2835_defconfig    clang-22
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.1.0
arm                          ep93xx_defconfig    clang-22
arm                          ixp4xx_defconfig    clang-22
arm                         lpc18xx_defconfig    clang-22
arm                         nhk8815_defconfig    clang-22
arm                   randconfig-001-20251217    clang-18
arm                   randconfig-001-20251217    clang-22
arm                   randconfig-002-20251217    clang-22
arm                   randconfig-003-20251217    clang-22
arm                   randconfig-004-20251217    clang-22
arm                       versatile_defconfig    gcc-15.1.0
arm                    vt8500_v6_v7_defconfig    clang-22
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251217    clang-22
arm64                 randconfig-001-20251217    gcc-8.5.0
arm64                 randconfig-002-20251217    clang-22
arm64                 randconfig-003-20251217    clang-22
arm64                 randconfig-004-20251217    clang-20
arm64                 randconfig-004-20251217    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251217    clang-22
csky                  randconfig-001-20251217    gcc-15.1.0
csky                  randconfig-002-20251217    clang-22
csky                  randconfig-002-20251217    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251216    clang-22
hexagon               randconfig-001-20251217    clang-22
hexagon               randconfig-001-20251217    gcc-11.5.0
hexagon               randconfig-002-20251216    clang-19
hexagon               randconfig-002-20251217    clang-22
hexagon               randconfig-002-20251217    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251217    clang-20
i386        buildonly-randconfig-002-20251217    clang-20
i386        buildonly-randconfig-002-20251217    gcc-14
i386        buildonly-randconfig-003-20251217    clang-20
i386        buildonly-randconfig-003-20251217    gcc-13
i386        buildonly-randconfig-004-20251217    clang-20
i386        buildonly-randconfig-005-20251217    clang-20
i386        buildonly-randconfig-005-20251217    gcc-14
i386        buildonly-randconfig-006-20251217    clang-20
i386        buildonly-randconfig-006-20251217    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251217    clang-20
i386                  randconfig-001-20251217    gcc-14
i386                  randconfig-002-20251217    clang-20
i386                  randconfig-002-20251217    gcc-14
i386                  randconfig-003-20251217    clang-20
i386                  randconfig-003-20251217    gcc-14
i386                  randconfig-004-20251217    gcc-14
i386                  randconfig-005-20251217    gcc-13
i386                  randconfig-005-20251217    gcc-14
i386                  randconfig-006-20251217    clang-20
i386                  randconfig-006-20251217    gcc-14
i386                  randconfig-007-20251217    clang-20
i386                  randconfig-007-20251217    gcc-14
i386                  randconfig-011-20251217    clang-20
i386                  randconfig-011-20251217    gcc-14
i386                  randconfig-012-20251217    clang-20
i386                  randconfig-013-20251217    clang-20
i386                  randconfig-014-20251217    clang-20
i386                  randconfig-015-20251217    clang-20
i386                  randconfig-015-20251217    gcc-14
i386                  randconfig-016-20251217    clang-20
i386                  randconfig-016-20251217    gcc-14
i386                  randconfig-017-20251217    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251216    gcc-15.1.0
loongarch             randconfig-001-20251217    clang-22
loongarch             randconfig-001-20251217    gcc-11.5.0
loongarch             randconfig-002-20251216    clang-22
loongarch             randconfig-002-20251217    clang-22
loongarch             randconfig-002-20251217    gcc-11.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
m68k                            mac_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    clang-22
mips                           ip27_defconfig    gcc-15.1.0
mips                      maltaaprp_defconfig    clang-22
mips                          rb532_defconfig    clang-22
mips                   sb1250_swarm_defconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251216    gcc-8.5.0
nios2                 randconfig-001-20251217    gcc-11.5.0
nios2                 randconfig-002-20251216    gcc-11.5.0
nios2                 randconfig-002-20251217    gcc-11.5.0
nios2                 randconfig-002-20251217    gcc-8.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251217    gcc-15.1.0
parisc                randconfig-001-20251217    gcc-8.5.0
parisc                randconfig-002-20251217    gcc-14.3.0
parisc                randconfig-002-20251217    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251217    gcc-8.5.0
powerpc               randconfig-002-20251217    clang-22
powerpc               randconfig-002-20251217    gcc-8.5.0
powerpc                     tqm8560_defconfig    clang-22
powerpc64             randconfig-001-20251217    gcc-14.3.0
powerpc64             randconfig-001-20251217    gcc-8.5.0
powerpc64             randconfig-002-20251217    clang-18
powerpc64             randconfig-002-20251217    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251217    clang-18
riscv                 randconfig-001-20251217    gcc-14.3.0
riscv                 randconfig-002-20251217    clang-18
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251217    clang-18
s390                  randconfig-001-20251217    gcc-10.5.0
s390                  randconfig-002-20251217    clang-18
s390                  randconfig-002-20251217    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251217    clang-18
sh                    randconfig-001-20251217    gcc-15.1.0
sh                    randconfig-002-20251217    clang-18
sh                    randconfig-002-20251217    gcc-12.5.0
sh                          sdk7780_defconfig    gcc-15.1.0
sh                           se7721_defconfig    gcc-15.1.0
sh                           se7750_defconfig    clang-22
sh                   sh7770_generic_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251217    gcc-15.1.0
sparc                 randconfig-002-20251217    gcc-15.1.0
sparc64                          alldefconfig    clang-22
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251217    clang-20
sparc64               randconfig-001-20251217    gcc-15.1.0
sparc64               randconfig-002-20251217    gcc-12.5.0
sparc64               randconfig-002-20251217    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251217    clang-22
um                    randconfig-001-20251217    gcc-15.1.0
um                    randconfig-002-20251217    clang-22
um                    randconfig-002-20251217    gcc-15.1.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251217    clang-20
x86_64      buildonly-randconfig-001-20251217    gcc-14
x86_64      buildonly-randconfig-002-20251217    clang-20
x86_64      buildonly-randconfig-002-20251217    gcc-14
x86_64      buildonly-randconfig-003-20251217    gcc-13
x86_64      buildonly-randconfig-003-20251217    gcc-14
x86_64      buildonly-randconfig-004-20251217    gcc-14
x86_64      buildonly-randconfig-005-20251217    gcc-14
x86_64      buildonly-randconfig-006-20251217    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251217    clang-20
x86_64                randconfig-002-20251217    clang-20
x86_64                randconfig-002-20251217    gcc-14
x86_64                randconfig-003-20251217    clang-20
x86_64                randconfig-004-20251217    clang-20
x86_64                randconfig-005-20251217    clang-20
x86_64                randconfig-006-20251217    clang-20
x86_64                randconfig-006-20251217    gcc-14
x86_64                randconfig-011-20251217    clang-20
x86_64                randconfig-011-20251217    gcc-14
x86_64                randconfig-012-20251217    gcc-14
x86_64                randconfig-013-20251217    clang-20
x86_64                randconfig-013-20251217    gcc-14
x86_64                randconfig-014-20251217    gcc-14
x86_64                randconfig-015-20251217    gcc-14
x86_64                randconfig-016-20251217    gcc-14
x86_64                randconfig-071-20251217    clang-20
x86_64                randconfig-071-20251217    gcc-14
x86_64                randconfig-072-20251217    gcc-13
x86_64                randconfig-072-20251217    gcc-14
x86_64                randconfig-073-20251217    gcc-14
x86_64                randconfig-074-20251217    clang-20
x86_64                randconfig-074-20251217    gcc-14
x86_64                randconfig-075-20251217    clang-20
x86_64                randconfig-075-20251217    gcc-14
x86_64                randconfig-076-20251217    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20251217    gcc-15.1.0
xtensa                randconfig-001-20251217    gcc-8.5.0
xtensa                randconfig-002-20251217    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

