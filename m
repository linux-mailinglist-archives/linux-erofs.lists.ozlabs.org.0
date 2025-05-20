Return-Path: <linux-erofs+bounces-349-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38A9ABCDE8
	for <lists+linux-erofs@lfdr.de>; Tue, 20 May 2025 05:32:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b1g9Y4NBFz30Vv;
	Tue, 20 May 2025 13:32:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747711969;
	cv=none; b=Xb8/cF+0l5s+MpL5W2sG3DMOu2yfMWOa1ykkN88TYHmOxRFRlU2vD9eZH7K3vbu5UGJyZOqjSw+QVXJYvxk8W1CK0IheJ+uJariUZPVmx7MvclWOt5rvPJarRSUvsnFKhxsS606fBACAqc2LBYy7wzzRO2kwNMFvAAY0a+T28wc8YMhFFoDTQPob8t8MoPTJY4KLW6qkJ0ghwjKbNoTADwyIeknyl4bD1vYj6WqPbrV58FgbRpvnK+MWI/ZXLuTJvXX4I1vnh4Xv7mlCsi7LrdbkrtUE9dvwzY/DnnZH1l4+DTnrHLhsIsopIAnCifxKzUSi+mul9y5mE0CHYCJokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747711969; c=relaxed/relaxed;
	bh=tk21wogWCi56ZLFYCQcZYimbHhRo4tiXjqWbk+Fm8Ac=;
	h=Date:From:To:Cc:Subject:Message-ID; b=G3JzO8cRLtHqhXQ8H4LKL1owsE64WjhN39d1FPOt3w/XK2TLQk1LiQRzevRsyxdXZ+doGrVG/leIyBKBMherXjcaFgI39rwQRYMRheSgLsBPo4ot/DglNQJxH8W4+a38XXRpRyT4VMeycom4Fw4hk78S3RQKz7CmqHpiI3bI2hcLlORjNYTDyFUYoVetMppgr1h9qPqWkt6ohAYfiNlD6Mt8sODGAYBMNzmASReWq208V12/vmFA+ufDbf6jTyNkVrx/CGJYrkbuHf7VfWtcLhTy8V4A0y6aj37IKEk9yb4FIilQ260Do7o0J51vUPTIU/V8DGkkn+1V1/+yopc6Vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H5D7nk0K; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H5D7nk0K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b1g9X4lycz2yVt
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 May 2025 13:32:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747711969; x=1779247969;
  h=date:from:to:cc:subject:message-id;
  bh=ZthYRdbrdMwN9BmJ8nBVA2M4gOetEMMtMH94aABHidw=;
  b=H5D7nk0KWkE3KQjGTLENvIPjtq/bpr7xEE5kWFENhQkqj+LNb6gDtqOt
   9VDi06yj6MAmACKJrwZhSLyusA+EGMmYhzvVSrU0GQl54O2wfPTCamA7M
   EcddbnFHvEMZU7jA82XL5irXjsrQi3K+KPse+L6iCjkh/lyr6pCZ98Njg
   H6y4ibSQzT1FOH8kB52n+Dhu6oPkXi4hGN58zf1UwQ0fcz84BPoF0J+dP
   DPa9rYHMf45JUssYGaerAmHmgCgwkvlVtqOo7CX9cCBrluTbS/ipdEV6e
   ZFpgOFuEtHUa5yQCpxXZ6a+0zD5P6Q4QlQZ5kbaS413VeSLZW2idqSGOJ
   g==;
X-CSE-ConnectionGUID: bd1YfUVfSCiPPiFOCE3aRw==
X-CSE-MsgGUID: HekG01/0QBaG+/wlYg2eJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="48880630"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="48880630"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 20:32:45 -0700
X-CSE-ConnectionGUID: a+nYKg2bRj69y7dsbbVtKQ==
X-CSE-MsgGUID: rYhFAZHFT2+CGpTBSho8TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144310663"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 19 May 2025 20:32:44 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHDia-000M80-2q;
	Tue, 20 May 2025 03:32:40 +0000
Date: Tue, 20 May 2025 11:31:47 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 c94d54dab9f0b0c7be830cab0ab7c831ecc2b497
Message-ID: <202505201137.UUeCFeu0-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: c94d54dab9f0b0c7be830cab0ab7c831ecc2b497  erofs: add 'fsoffset' mount option to specify filesystem offset

elapsed time: 789m

configs tested: 136
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                     haps_hs_smp_defconfig    gcc-14.2.0
arc                   randconfig-001-20250519    gcc-12.4.0
arc                   randconfig-001-20250520    gcc-11.5.0
arc                   randconfig-002-20250519    gcc-8.5.0
arc                   randconfig-002-20250520    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                         bcm2835_defconfig    clang-21
arm                            hisi_defconfig    gcc-14.2.0
arm                        mvebu_v7_defconfig    clang-21
arm                   randconfig-001-20250519    clang-18
arm                   randconfig-001-20250520    gcc-6.5.0
arm                   randconfig-002-20250519    clang-21
arm                   randconfig-002-20250520    gcc-10.5.0
arm                   randconfig-003-20250519    clang-20
arm                   randconfig-003-20250520    clang-19
arm                   randconfig-004-20250519    clang-21
arm                   randconfig-004-20250520    gcc-7.5.0
arm                        realview_defconfig    clang-16
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250519    clang-17
arm64                 randconfig-001-20250520    clang-21
arm64                 randconfig-002-20250519    gcc-8.5.0
arm64                 randconfig-002-20250520    gcc-9.5.0
arm64                 randconfig-003-20250519    clang-19
arm64                 randconfig-003-20250520    clang-18
arm64                 randconfig-004-20250519    gcc-8.5.0
arm64                 randconfig-004-20250520    gcc-9.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250519    gcc-10.5.0
csky                  randconfig-002-20250519    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250519    clang-21
hexagon               randconfig-002-20250519    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250519    clang-20
i386        buildonly-randconfig-002-20250519    clang-20
i386        buildonly-randconfig-003-20250519    gcc-12
i386        buildonly-randconfig-004-20250519    gcc-12
i386        buildonly-randconfig-005-20250519    gcc-12
i386        buildonly-randconfig-006-20250519    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250519    gcc-14.2.0
loongarch             randconfig-002-20250519    gcc-12.4.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         db1xxx_defconfig    clang-21
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250519    gcc-14.2.0
nios2                 randconfig-002-20250519    gcc-6.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250519    gcc-7.5.0
parisc                randconfig-002-20250519    gcc-13.3.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                      cm5200_defconfig    clang-21
powerpc                       eiger_defconfig    clang-21
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                     ksi8560_defconfig    gcc-14.2.0
powerpc                   lite5200b_defconfig    clang-21
powerpc                   motionpro_defconfig    clang-21
powerpc               randconfig-001-20250519    gcc-8.5.0
powerpc               randconfig-002-20250519    gcc-6.5.0
powerpc               randconfig-003-20250519    gcc-8.5.0
powerpc64             randconfig-001-20250519    clang-20
powerpc64             randconfig-002-20250519    gcc-6.5.0
powerpc64             randconfig-003-20250519    gcc-6.5.0
riscv                            alldefconfig    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250519    gcc-14.2.0
riscv                 randconfig-002-20250519    clang-17
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250519    gcc-7.5.0
s390                  randconfig-002-20250519    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250519    gcc-12.4.0
sh                    randconfig-002-20250519    gcc-14.2.0
sh                          sdk7786_defconfig    gcc-14.2.0
sh                           sh2007_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250519    gcc-11.5.0
sparc                 randconfig-002-20250519    gcc-7.5.0
sparc64                          alldefconfig    gcc-14.2.0
sparc64               randconfig-001-20250519    gcc-7.5.0
sparc64               randconfig-002-20250519    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250519    gcc-12
um                    randconfig-002-20250519    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250519    clang-20
x86_64      buildonly-randconfig-002-20250519    gcc-12
x86_64      buildonly-randconfig-003-20250519    clang-20
x86_64      buildonly-randconfig-004-20250519    clang-20
x86_64      buildonly-randconfig-005-20250519    gcc-12
x86_64      buildonly-randconfig-006-20250519    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                           alldefconfig    gcc-14.2.0
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250519    gcc-7.5.0
xtensa                randconfig-002-20250519    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

