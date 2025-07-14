Return-Path: <linux-erofs+bounces-614-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A532B03F07
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Jul 2025 14:54:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bgj1x3yTHz3bt2;
	Mon, 14 Jul 2025 22:54:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752497653;
	cv=none; b=UH0wS1/aSxlr3sPgfVMpKZX5UfPH+gsssLWKquAENEQ8FNYOzi0wtdgM386qB7p9hdK1gy8CAmnge/XwdSeP51sTLQqaOcTr3K0l7hv5GshIpSW1ERo5QcYCoOmbDwgWwUqgqi5NEPBUb1sdq1BHnq+CnJUMj+vVToXiYMOqcBrw/3q/8d3Y3s2F99xCmjoW1Y0ddzH1RjfPL0uCHnGLj01jm6PJHNPiG/qOXUlBlzKXiO4YViK0QzHPULKFUKVa5zepfSQ3BSuw2knkW/MsF029+7OiD2Wnir/H2rO+Va+Jt0InzVEbrGkkyRom5NrPGyGu62L8/Pip+FAwcmOsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752497653; c=relaxed/relaxed;
	bh=hSndiL/0BiHmhg4jHhvjXVWModYIQYo64D9738Ldro0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BuxDWgMZpDM4bgVxc3JrqhU2kMQRrITVmoYyFw/+5UNCKJDRF4J1KIY1wvNqwOfFar+uJ7vnHJ8lh2ga4DMVo4P552EqVR/dxXOOuCLWyY8yE9AOobGZyqylzC4uQr98yWxo5XpxvKdqSdvhbpSFbp3gGIMUFdxHJcfKZqWsg+VJGlMXhgSEGuo5hGmYvdOu0qOMXSiz9lzEG7lBnUgZwWDtbtjfvdCuw7BZcx8iJAzrxnmcK+yIu/95dSK41QhrV61sAH1pxVceU1VwfFixQerPcKu2c7uQzwjjilexLeJSs3u2ILRVZtrS2H5IIOAVGDd7FAfRvGRl00qakyfHLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VQZdoAKI; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VQZdoAKI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bgj1v1rVGz30Lt
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Jul 2025 22:54:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752497651; x=1784033651;
  h=date:from:to:cc:subject:message-id;
  bh=jeTsKq6lazLFZlSg7eiJk86R6kdiNewa6Z/cnJ4eVI8=;
  b=VQZdoAKIxjqVFh35P6niWTVhjgksDOWE+EFXQt8+xdXETMI2HzeK2KCX
   Mnp+iikFQ51jsrYJHAR/A3FM3vuY9cahJuWm75Q5uumB/XB4BfuFB4IQi
   PTaXmyAY/EjDiyHzFdCohkxV+nhdUSD/fmLLOVaFFpITL3pEevnQnQFm3
   Lrp/fi2eietoZNEKDP9y4fKwbdu50GzmbkNdDlvAhS8FFEJhUZKJQ76sy
   7ckEBggkjQHJZbJJhOyDdvkJERmPmJw8w2rWX6mVa6ZI64B443jXSPuJI
   hATlv9ZFTnlOuXzgsvvHArXl8bPTUrx7AmboeVosFUcK6hZBSF/xvV6e2
   Q==;
X-CSE-ConnectionGUID: VOt+J+z6QIyUkTIQ75bVcA==
X-CSE-MsgGUID: QldvDWt3Q6C0p4IEWDeFAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54557779"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="54557779"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 05:54:05 -0700
X-CSE-ConnectionGUID: WgEivBKBRvKKwNsDUMVvsQ==
X-CSE-MsgGUID: 4xysx8kGSNOXtWbZZOZwAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="187931691"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 Jul 2025 05:54:05 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubIh0-0008sh-25;
	Mon, 14 Jul 2025 12:54:02 +0000
Date: Mon, 14 Jul 2025 20:53:48 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 26654adaadfa841ec9de08f5141144fc2f13bce4
Message-ID: <202507142035.J3dwDto9-lkp@intel.com>
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
branch HEAD: 26654adaadfa841ec9de08f5141144fc2f13bce4  erofs: do sanity check on m->type in z_erofs_load_compact_lcluster()

elapsed time: 727m

configs tested: 133
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                          axs103_defconfig    gcc-15.1.0
arc                      axs103_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20250714    gcc-8.5.0
arc                   randconfig-002-20250714    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250714    clang-21
arm                   randconfig-002-20250714    gcc-8.5.0
arm                   randconfig-003-20250714    clang-21
arm                   randconfig-004-20250714    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250714    gcc-13.4.0
arm64                 randconfig-002-20250714    gcc-8.5.0
arm64                 randconfig-003-20250714    gcc-8.5.0
arm64                 randconfig-004-20250714    gcc-14.3.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250714    gcc-10.5.0
csky                  randconfig-002-20250714    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250714    clang-21
hexagon               randconfig-002-20250714    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250714    gcc-12
i386        buildonly-randconfig-002-20250714    clang-20
i386        buildonly-randconfig-003-20250714    gcc-12
i386        buildonly-randconfig-004-20250714    gcc-12
i386        buildonly-randconfig-005-20250714    gcc-12
i386        buildonly-randconfig-006-20250714    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250714    gcc-15.1.0
loongarch             randconfig-002-20250714    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       m5208evb_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                     loongson1b_defconfig    clang-21
mips                   sb1250_swarm_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250714    gcc-12.4.0
nios2                 randconfig-002-20250714    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250714    gcc-8.5.0
parisc                randconfig-002-20250714    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                      chrp32_defconfig    clang-19
powerpc                       eiger_defconfig    clang-21
powerpc               randconfig-001-20250714    gcc-10.5.0
powerpc               randconfig-002-20250714    gcc-10.5.0
powerpc               randconfig-003-20250714    gcc-8.5.0
powerpc                         wii_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250714    clang-16
powerpc64             randconfig-002-20250714    gcc-8.5.0
powerpc64             randconfig-003-20250714    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250714    gcc-8.5.0
riscv                 randconfig-002-20250714    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250714    clang-21
s390                  randconfig-002-20250714    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250714    gcc-12.4.0
sh                    randconfig-002-20250714    gcc-11.5.0
sh                           se7780_defconfig    gcc-15.1.0
sh                              ul2_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250714    gcc-8.5.0
sparc                 randconfig-002-20250714    gcc-8.5.0
sparc64                          alldefconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250714    clang-21
sparc64               randconfig-002-20250714    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250714    gcc-12
um                    randconfig-002-20250714    gcc-11
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250714    gcc-12
x86_64      buildonly-randconfig-002-20250714    clang-20
x86_64      buildonly-randconfig-003-20250714    gcc-12
x86_64      buildonly-randconfig-004-20250714    gcc-12
x86_64      buildonly-randconfig-005-20250714    clang-20
x86_64      buildonly-randconfig-006-20250714    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250714    gcc-8.5.0
xtensa                randconfig-002-20250714    gcc-12.4.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

