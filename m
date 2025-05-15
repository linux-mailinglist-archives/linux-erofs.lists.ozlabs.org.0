Return-Path: <linux-erofs+bounces-329-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0986AAB923E
	for <lists+linux-erofs@lfdr.de>; Fri, 16 May 2025 00:21:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zz4SM60jZz2xs7;
	Fri, 16 May 2025 08:21:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747347699;
	cv=none; b=fLVg8stMfbjqOHl5AIGrxFwa+3HvLOmEaSCjSq4gfARV6QtN+/iT9UOUMyJzB0HEYU/l4PQ4+p8Vxy+fGCrLJeoZXAjqer3NzL5LyEXgPf0smPedK+NzH10KrGAzbYhPuVXzWvV+/42lKz/3wkHK07uRrLERVbWtZx0jsyvZr586cx7nuSvzRtpdixrAa3G+ExnGk5S6ovlP9VmuJyYOvkG2TzhdF3XxEhZn+9FRSqmfo9qv0PJFizjlSqPGG5yhgV0M/zELiyu3Bd92WsFkfWaNN0/g+JoTkVl9QOUL1tkKHTes78ufu4W244Ws/4ZL3UFV7aIGkf3U4Es+2jhYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747347699; c=relaxed/relaxed;
	bh=wYUQ1G3hpkH+jZfQduraYG6E1v2BSqv7DKuhyVHqQPI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CYCFO/chd95Js0EbxMHOylk/RH5v95I31HvEaI4+AXsLrNOx4yRbJtyJJkHkErUibQ21TJqcsclmMDf6QUetsR7nkkONjXuLHwLlEFC8RI5HI27KoucVQLGczYSdXa59MCXnGcikaG4VzAtVXC6vJ3SRIhR/ekrzipj/zolUl5yf5dV52S+ilTUl5GAK3BzXzCyTx6XXxAa92S41K0hzSVRKiiPDBc1GzChyTmy+ihhB/Wv/9Cc7Ms9pTM/11q0Im8xnCOpeRAC6zlMCMQJsbGUj0/4MFNTELc4XL3e0wwKBlDLlptjHHP8dyLYRxHOtzp8cOO7zYuZ3fWMqxY07/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L4CsyvQ9; dkim-atps=neutral; spf=pass (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L4CsyvQ9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zz4SK3lGpz2xqD
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 May 2025 08:21:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747347698; x=1778883698;
  h=date:from:to:cc:subject:message-id;
  bh=mhNVDM4H+cEHBKbXU4n5krUlq63evbilEC0kf7hWVwM=;
  b=L4CsyvQ9LStxg7m0swxkAS8fDNy2e2AefcghG9RQqU7Af4IhhtRQW/dU
   dj0FX1q9qTtVRo4AE6U/asiF7NgwBNBOuXqcYLOvSM/ZmSIdAe3NpTp8J
   B1DazjQ/Tu+gNfmrZ1EukaZzlR6NqIjv1H1UlvDcJulpaRD6CvoY2u3Fy
   MLAN/SKXd6o/NgBsTm5jgi6HWVlyj8ku03aMuGsU2ZMNBYO+HWyBhGbxy
   nM3eZp+RIFH9hKylB0b3H3ruiZxwVsfL0LGfqTFCJKjq1sMlPjqPIsGvj
   zrfy7cyzc2nWxDY0o++CLF9Hdjk/QiOQAu0HR0LtTjpGTwhoGTOhh/hlc
   Q==;
X-CSE-ConnectionGUID: X32YxeKJQ/GepXaPUWBfdw==
X-CSE-MsgGUID: Rik/zWKYQOOsmH5JsiuKBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49002113"
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="49002113"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 15:21:33 -0700
X-CSE-ConnectionGUID: ucQDullmQvCkSBeJ1qAgNw==
X-CSE-MsgGUID: xWUISXVKQeKjL/t84iwJCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="138901759"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 15 May 2025 15:21:31 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFgxE-000Ino-2Y;
	Thu, 15 May 2025 22:21:28 +0000
Date: Fri, 16 May 2025 06:20:37 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 9748f2f54f66743ac77275c34886a9f890e18409
Message-ID: <202505160627.hl7ToMcR-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 9748f2f54f66743ac77275c34886a9f890e18409  erofs: avoid using multiple devices with different type

elapsed time: 1088m

configs tested: 210
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              alldefconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250515    gcc-12.4.0
arc                   randconfig-001-20250515    gcc-6.5.0
arc                   randconfig-002-20250515    gcc-14.2.0
arc                   randconfig-002-20250515    gcc-6.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-14.2.0
arm                   randconfig-001-20250515    clang-21
arm                   randconfig-001-20250515    gcc-6.5.0
arm                   randconfig-002-20250515    gcc-6.5.0
arm                   randconfig-002-20250515    gcc-8.5.0
arm                   randconfig-003-20250515    gcc-6.5.0
arm                   randconfig-003-20250515    gcc-8.5.0
arm                   randconfig-004-20250515    clang-21
arm                   randconfig-004-20250515    gcc-6.5.0
arm                         vf610m4_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250515    clang-21
arm64                 randconfig-001-20250515    gcc-6.5.0
arm64                 randconfig-002-20250515    clang-21
arm64                 randconfig-002-20250515    gcc-6.5.0
arm64                 randconfig-003-20250515    clang-20
arm64                 randconfig-003-20250515    gcc-6.5.0
arm64                 randconfig-004-20250515    gcc-6.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250515    gcc-14.2.0
csky                  randconfig-002-20250515    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250515    clang-16
hexagon               randconfig-002-20250515    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250515    gcc-11
i386        buildonly-randconfig-002-20250515    gcc-11
i386        buildonly-randconfig-002-20250515    gcc-12
i386        buildonly-randconfig-003-20250515    clang-20
i386        buildonly-randconfig-003-20250515    gcc-11
i386        buildonly-randconfig-004-20250515    clang-20
i386        buildonly-randconfig-004-20250515    gcc-11
i386        buildonly-randconfig-005-20250515    gcc-11
i386        buildonly-randconfig-005-20250515    gcc-12
i386        buildonly-randconfig-006-20250515    gcc-11
i386                                defconfig    clang-20
i386                  randconfig-011-20250515    gcc-12
i386                  randconfig-012-20250515    gcc-12
i386                  randconfig-013-20250515    gcc-12
i386                  randconfig-014-20250515    gcc-12
i386                  randconfig-015-20250515    gcc-12
i386                  randconfig-016-20250515    gcc-12
i386                  randconfig-017-20250515    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250515    gcc-12.4.0
loongarch             randconfig-002-20250515    gcc-14.2.0
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
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250515    gcc-12.4.0
nios2                 randconfig-002-20250515    gcc-6.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250515    gcc-13.3.0
parisc                randconfig-002-20250515    gcc-13.3.0
parisc64                            defconfig    gcc-14.2.0
powerpc                    adder875_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    gcc-14.2.0
powerpc                      pcm030_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250515    gcc-8.5.0
powerpc               randconfig-002-20250515    gcc-6.5.0
powerpc               randconfig-003-20250515    clang-21
powerpc64             randconfig-001-20250515    clang-21
powerpc64             randconfig-002-20250515    gcc-8.5.0
powerpc64             randconfig-003-20250515    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250515    gcc-8.5.0
riscv                 randconfig-001-20250515    gcc-9.3.0
riscv                 randconfig-002-20250515    gcc-14.2.0
riscv                 randconfig-002-20250515    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250515    clang-21
s390                  randconfig-001-20250515    gcc-9.3.0
s390                  randconfig-002-20250515    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250515    gcc-14.2.0
sh                    randconfig-001-20250515    gcc-9.3.0
sh                    randconfig-002-20250515    gcc-10.5.0
sh                    randconfig-002-20250515    gcc-9.3.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250515    gcc-6.5.0
sparc                 randconfig-001-20250515    gcc-9.3.0
sparc                 randconfig-002-20250515    gcc-10.3.0
sparc                 randconfig-002-20250515    gcc-9.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250515    gcc-9.3.0
sparc64               randconfig-002-20250515    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250515    gcc-12
um                    randconfig-001-20250515    gcc-9.3.0
um                    randconfig-002-20250515    clang-21
um                    randconfig-002-20250515    gcc-9.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250515    clang-20
x86_64      buildonly-randconfig-001-20250515    gcc-12
x86_64      buildonly-randconfig-002-20250515    clang-20
x86_64      buildonly-randconfig-002-20250515    gcc-12
x86_64      buildonly-randconfig-003-20250515    clang-20
x86_64      buildonly-randconfig-003-20250515    gcc-12
x86_64      buildonly-randconfig-004-20250515    clang-20
x86_64      buildonly-randconfig-004-20250515    gcc-12
x86_64      buildonly-randconfig-005-20250515    clang-20
x86_64      buildonly-randconfig-005-20250515    gcc-12
x86_64      buildonly-randconfig-006-20250515    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250515    gcc-12
x86_64                randconfig-002-20250515    gcc-12
x86_64                randconfig-003-20250515    gcc-12
x86_64                randconfig-004-20250515    gcc-12
x86_64                randconfig-005-20250515    gcc-12
x86_64                randconfig-006-20250515    gcc-12
x86_64                randconfig-007-20250515    gcc-12
x86_64                randconfig-008-20250515    gcc-12
x86_64                randconfig-071-20250515    clang-20
x86_64                randconfig-072-20250515    clang-20
x86_64                randconfig-073-20250515    clang-20
x86_64                randconfig-074-20250515    clang-20
x86_64                randconfig-075-20250515    clang-20
x86_64                randconfig-076-20250515    clang-20
x86_64                randconfig-077-20250515    clang-20
x86_64                randconfig-078-20250515    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250515    gcc-14.2.0
xtensa                randconfig-001-20250515    gcc-9.3.0
xtensa                randconfig-002-20250515    gcc-13.3.0
xtensa                randconfig-002-20250515    gcc-9.3.0
xtensa                    xip_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

