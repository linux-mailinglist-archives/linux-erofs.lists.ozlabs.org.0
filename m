Return-Path: <linux-erofs+bounces-48-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE28A5BA3E
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Mar 2025 08:53:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZBmGl58w3z3bmy;
	Tue, 11 Mar 2025 18:53:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741679615;
	cv=none; b=l3vdwocBDwdxGD2jZ+3Ptez4y0k3z98kUhIsN8Pq7J8sQliUQ4RhAzmSMjipDWXl/Ur7YXf7i4YBYodcxfFIn6FZCQUvcDd0hEJ5qJYgE1CHI0GfxwMSnJKVRjOSrrzuuVJeTYoHDOSdVgJT2z27TWY2CK4fRAsXj+WWPpLfLUnFC1oxrCINpa97k3m7vxmy0B2lm/3a5RGRb9sAnXXwCpxRbPO3OM3oFNz/RwIwC0DSQEgkyQKxgETT7IXwcvQfKOHF/uih7IiGQGcRv5eivRc7Gb+ciVJ1ZaTJBm/u6E82C3negV5o/Sxsfz1ZPkX7TqC/3fQyz6Xe4+JrDContg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741679615; c=relaxed/relaxed;
	bh=WNBQUypHVvRjHciXRxHD9wUv9A6yt/b+3OcP9+e7huE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aemKuXRinL2zvOVcU7VDqf237B/dMYTqK5afOOi4yLeRMrV/V56sPtiKNcI3lp2rUF7sB0g9RzB7jpTG7CICZKnGW/LQWEjZz4rE6AFxS3v5C4az8LKsNukwMCMQDQUAwnYXRQ3hr8GTSGOuMCTRwwk2lU8SXR3ETwiuSzGnBnIw08pelJ0+pXimQvmUTAtC6rMFGRugb8PwZEjzn2UhcsV2fYB2jyjYx+0JULHkW0XId4nLB43epDLW9joy6994h7gbl+c+ovBs4iVx6MIsUg7HFJfnuO7Orgn80NQY/jX7ScO2uaQWEjTEmGFXS5yBVtME4ObEDc/OxZHlp0T7Gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LZJcCXay; dkim-atps=neutral; spf=pass (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LZJcCXay;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZBmGj0PfNz3bmS
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Mar 2025 18:53:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741679614; x=1773215614;
  h=date:from:to:cc:subject:message-id;
  bh=eVPaHCJm/PS1r4ClVdKpoH3rOVcRgQDGYDvG38YDtu8=;
  b=LZJcCXayeTqeJY+7xxnWT54RTlIKYdNw3FTEBZD4UJepAKXciQ3Iihoh
   8VGFWGmFygwlu/Kl3/4nU25L96y34AA7e+t1Serh1BC9Vo01G9tS746Ed
   NJyCNS3nZ8/g7VUWK7jdj+Q3OluS4I1R0yhXD2J6MC9XNQx24SOJos4kz
   x44qgPK1sjGdpxR/K9MEHF3Ebz0g0xqdyFhQ9FfzKa9a7Vo1Dkcbqzvq5
   CuHYZhThIwh5QbZeI20pHwP7T2ogS4sCZZV0CA9pOTGCqdmZjLgSBay8m
   jmGGN5Ls7SQCYKRANeshDSgxzjNZadXkpbdxWnoGQTGFV+wQZZBdEBfEY
   Q==;
X-CSE-ConnectionGUID: LrhrF3pcSAuhozDk5Aolzg==
X-CSE-MsgGUID: DsBjjzENTlKegU/igmH63w==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="46352268"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="46352268"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 00:53:29 -0700
X-CSE-ConnectionGUID: yExDprlFSu2fjpMgdQ6ZeQ==
X-CSE-MsgGUID: lZwXc6MDRKehmbmGWTDUTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="120751125"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 11 Mar 2025 00:53:28 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1truQX-0006Sy-0t;
	Tue, 11 Mar 2025 07:53:25 +0000
Date: Tue, 11 Mar 2025 15:53:24 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 463a645b39e18d8b6ca70d753326e9e9e3dde7c2
Message-ID: <202503111518.aGt5UCk0-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 463a645b39e18d8b6ca70d753326e9e9e3dde7c2  erofs: enable 48-bit layout support

elapsed time: 1214m

configs tested: 210
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250310    gcc-13.2.0
arc                   randconfig-001-20250311    gcc-13.2.0
arc                   randconfig-002-20250310    gcc-13.2.0
arc                   randconfig-002-20250311    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250310    clang-21
arm                   randconfig-001-20250311    gcc-14.2.0
arm                   randconfig-002-20250310    gcc-14.2.0
arm                   randconfig-002-20250311    clang-16
arm                   randconfig-003-20250310    gcc-14.2.0
arm                   randconfig-003-20250311    gcc-14.2.0
arm                   randconfig-004-20250310    clang-21
arm                   randconfig-004-20250311    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250310    clang-19
arm64                 randconfig-001-20250311    gcc-14.2.0
arm64                 randconfig-002-20250310    clang-17
arm64                 randconfig-002-20250311    gcc-14.2.0
arm64                 randconfig-003-20250310    clang-15
arm64                 randconfig-003-20250311    gcc-14.2.0
arm64                 randconfig-004-20250310    clang-17
arm64                 randconfig-004-20250311    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250310    gcc-14.2.0
csky                  randconfig-001-20250311    gcc-14.2.0
csky                  randconfig-002-20250310    gcc-14.2.0
csky                  randconfig-002-20250311    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250310    clang-21
hexagon               randconfig-001-20250311    clang-21
hexagon               randconfig-002-20250310    clang-21
hexagon               randconfig-002-20250311    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250310    clang-19
i386        buildonly-randconfig-001-20250311    clang-19
i386        buildonly-randconfig-001-20250311    gcc-12
i386        buildonly-randconfig-002-20250310    clang-19
i386        buildonly-randconfig-002-20250311    clang-19
i386        buildonly-randconfig-003-20250310    clang-19
i386        buildonly-randconfig-003-20250311    clang-19
i386        buildonly-randconfig-004-20250310    clang-19
i386        buildonly-randconfig-004-20250311    clang-19
i386        buildonly-randconfig-005-20250310    clang-19
i386        buildonly-randconfig-005-20250311    clang-19
i386        buildonly-randconfig-006-20250310    clang-19
i386        buildonly-randconfig-006-20250311    clang-19
i386        buildonly-randconfig-006-20250311    gcc-11
i386                                defconfig    clang-19
i386                  randconfig-001-20250311    gcc-12
i386                  randconfig-002-20250311    gcc-12
i386                  randconfig-003-20250311    gcc-12
i386                  randconfig-004-20250311    gcc-12
i386                  randconfig-005-20250311    gcc-12
i386                  randconfig-006-20250311    gcc-12
i386                  randconfig-007-20250311    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250310    gcc-14.2.0
loongarch             randconfig-001-20250311    gcc-14.2.0
loongarch             randconfig-002-20250310    gcc-14.2.0
loongarch             randconfig-002-20250311    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250310    gcc-14.2.0
nios2                 randconfig-001-20250311    gcc-14.2.0
nios2                 randconfig-002-20250310    gcc-14.2.0
nios2                 randconfig-002-20250311    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250310    gcc-14.2.0
parisc                randconfig-001-20250311    gcc-14.2.0
parisc                randconfig-002-20250310    gcc-14.2.0
parisc                randconfig-002-20250311    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20250310    clang-17
powerpc               randconfig-001-20250311    clang-21
powerpc               randconfig-002-20250310    clang-21
powerpc               randconfig-002-20250311    clang-16
powerpc               randconfig-003-20250310    clang-17
powerpc               randconfig-003-20250311    gcc-14.2.0
powerpc64             randconfig-001-20250310    gcc-14.2.0
powerpc64             randconfig-001-20250311    gcc-14.2.0
powerpc64             randconfig-002-20250310    gcc-14.2.0
powerpc64             randconfig-002-20250311    clang-18
powerpc64             randconfig-003-20250310    gcc-14.2.0
powerpc64             randconfig-003-20250311    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-15
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250310    clang-19
riscv                 randconfig-001-20250311    gcc-14.2.0
riscv                 randconfig-002-20250310    gcc-14.2.0
riscv                 randconfig-002-20250311    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250310    gcc-14.2.0
s390                  randconfig-001-20250311    clang-15
s390                  randconfig-002-20250310    clang-18
s390                  randconfig-002-20250311    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250310    gcc-14.2.0
sh                    randconfig-001-20250311    gcc-14.2.0
sh                    randconfig-002-20250310    gcc-14.2.0
sh                    randconfig-002-20250311    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250310    gcc-14.2.0
sparc                 randconfig-001-20250311    gcc-14.2.0
sparc                 randconfig-002-20250310    gcc-14.2.0
sparc                 randconfig-002-20250311    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250310    gcc-14.2.0
sparc64               randconfig-001-20250311    gcc-14.2.0
sparc64               randconfig-002-20250310    gcc-14.2.0
sparc64               randconfig-002-20250311    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                                allnoconfig    clang-18
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250310    gcc-12
um                    randconfig-001-20250311    gcc-12
um                    randconfig-002-20250310    clang-17
um                    randconfig-002-20250311    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250310    gcc-12
x86_64      buildonly-randconfig-001-20250311    clang-19
x86_64      buildonly-randconfig-001-20250311    gcc-12
x86_64      buildonly-randconfig-002-20250310    clang-19
x86_64      buildonly-randconfig-002-20250311    clang-19
x86_64      buildonly-randconfig-002-20250311    gcc-12
x86_64      buildonly-randconfig-003-20250310    clang-19
x86_64      buildonly-randconfig-003-20250311    clang-19
x86_64      buildonly-randconfig-004-20250310    clang-19
x86_64      buildonly-randconfig-004-20250311    clang-19
x86_64      buildonly-randconfig-005-20250310    clang-19
x86_64      buildonly-randconfig-005-20250311    clang-19
x86_64      buildonly-randconfig-005-20250311    gcc-12
x86_64      buildonly-randconfig-006-20250310    gcc-12
x86_64      buildonly-randconfig-006-20250311    clang-19
x86_64      buildonly-randconfig-006-20250311    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-071-20250311    clang-19
x86_64                randconfig-072-20250311    clang-19
x86_64                randconfig-073-20250311    clang-19
x86_64                randconfig-074-20250311    clang-19
x86_64                randconfig-075-20250311    clang-19
x86_64                randconfig-076-20250311    clang-19
x86_64                randconfig-077-20250311    clang-19
x86_64                randconfig-078-20250311    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250310    gcc-14.2.0
xtensa                randconfig-001-20250311    gcc-14.2.0
xtensa                randconfig-002-20250310    gcc-14.2.0
xtensa                randconfig-002-20250311    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

