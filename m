Return-Path: <linux-erofs+bounces-1357-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F62CC4350F
	for <lists+linux-erofs@lfdr.de>; Sat, 08 Nov 2025 23:05:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d3qjS4YCBz3bt9;
	Sun,  9 Nov 2025 09:05:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762639500;
	cv=none; b=ju7gXVyQC7KFbgcBJ8yurmURUP26MhtF1295MEDe78cU3MYzILm6qTG0y7wsFiL+KwnCo2ulZWOukXIuZfi+vfaBvJn0g6eyz0MN3d9EtHYJPm5rwpTgqcKIzuecdx8lSCtlPQf6jLLlUF2TiseGiMyT8FHZbtXPRrOZ782SXB1LvID3wsVns4x7vlaMv7hYUerP5JDCZHdSc0GjYtI5oRoYilWwRTx+nGnmSrxlGPCbj9xLXaR9b02oKPGWrl0gBWU07fsY0uZ0/iMKnPxsiIzCAC2Uti9AFK6Oncoor8Ooh2dBISUbjhirpN2hbCILFm+YLL14km4t8TV49dY9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762639500; c=relaxed/relaxed;
	bh=sT7Q/ZtgLe8wwVNvIESXwY8dM9m+AeoTJN9fC7VZCo8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=azcI3ZbZKelZaY/mtp9ngi2WRQIH3TmD0UCjxJ5YZGh9WsrhEdzU89bT+m9S421JzqIBbOwy74MwHvXAnl6aOKYzleWHW7XNrIAxguEX2MKvEceBNX6t3g/3Y+YrtDf8PE+5/lWfh+TD66rOIMrCqf4m+P0nBjY754YUx6F5lABPcWKlyzQyF/GMdkoEvdRaQ3BUjJk2q86qsRP+aDDEkTn2fpCbdo8ia+Vmqz4pwQA4EKk/Uf4k4kmDbuv6Yq7DHah+24u1wo2aOT9Ds502sSymXT687FOC+zpE0hLJkweOsSxiqfyAT1ouJtwKvMhmYXxcynu1QjyJ88HA37tXag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DZUoixyE; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DZUoixyE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d3qjQ11W2z3bcf
	for <linux-erofs@lists.ozlabs.org>; Sun,  9 Nov 2025 09:04:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762639498; x=1794175498;
  h=date:from:to:cc:subject:message-id;
  bh=Z++tMu4AqHFpuxTD4HK75KMkcg2QoibOOXzOrLiN9rM=;
  b=DZUoixyEK+gzsOi2OxLU8VgkQOZ+c8TaURUFFjN94l0lbgMekz4d+Cfz
   27+BkSaK9WNX4K8OpQwwxNcnGqKYWYcpjvEQYtAGutJ6modKQ6gqZ33cb
   ftaaS9O1lpZL526J62sq9eOceIQ1ZNLs9cdGRhvmogA9za4R4rKo2Cdur
   uIgLu8tadMg9brjQm02pIZvgKbS5VQq5d+YBj2R4MIkbr98LSBsgpXWXU
   N91w5eFYF3Mi/wmRfUO06t7eSy7UL5VkuFphJG3bKwcHVI4FTLiSelRNS
   acx003bXGZ30eiSMy3lPtK+DKwT5zWHb9C9jxCPp9Fanzo1kgvGK2kHyc
   w==;
X-CSE-ConnectionGUID: dwWz5h8ASxSXEw63Do9qTg==
X-CSE-MsgGUID: Jj2yOvetTnywUL155TakAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="87378723"
X-IronPort-AV: E=Sophos;i="6.19,290,1754982000"; 
   d="scan'208";a="87378723"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 14:04:52 -0800
X-CSE-ConnectionGUID: ZQAE6v5lSrK4NbqVjIggKw==
X-CSE-MsgGUID: bTkrwH5HT6WsZ3eqi/7QxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,290,1754982000"; 
   d="scan'208";a="189056509"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 08 Nov 2025 14:04:51 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHr3A-0001T7-26;
	Sat, 08 Nov 2025 22:04:48 +0000
Date: Sun, 09 Nov 2025 06:04:09 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 f2a12cc3b97f062186568a7b94ddb7aa2ef68140
Message-ID: <202511090604.1ahCshd1-lkp@intel.com>
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
branch HEAD: f2a12cc3b97f062186568a7b94ddb7aa2ef68140  erofs: avoid infinite loop due to incomplete zstd-compressed data

elapsed time: 2925m

configs tested: 90
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
alpha                  allyesconfig    clang-19
arc                    allmodconfig    clang-19
arc                     allnoconfig    gcc-15.1.0
arc                    allyesconfig    clang-19
arc         randconfig-001-20251107    gcc-8.5.0
arc         randconfig-002-20251107    gcc-9.5.0
arm                    allmodconfig    clang-19
arm                     allnoconfig    clang-22
arm                    allyesconfig    clang-19
arm         randconfig-001-20251107    clang-17
arm         randconfig-002-20251107    gcc-13.4.0
arm         randconfig-003-20251107    clang-22
arm         randconfig-004-20251107    gcc-8.5.0
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.1.0
arm64                  allyesconfig    clang-22
csky                   allmodconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
csky                   allyesconfig    gcc-15.1.0
hexagon                allmodconfig    clang-19
hexagon                 allnoconfig    clang-22
hexagon                allyesconfig    clang-19
hexagon     randconfig-001-20251107    clang-22
hexagon     randconfig-002-20251107    clang-22
i386                   allmodconfig    clang-20
i386                    allnoconfig    gcc-14
i386                   allyesconfig    clang-20
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-22
loongarch              allyesconfig    clang-22
loongarch   randconfig-001-20251107    gcc-15.1.0
loongarch   randconfig-002-20251107    clang-19
m68k                   allmodconfig    clang-19
m68k                    allnoconfig    gcc-15.1.0
m68k                   allyesconfig    clang-19
microblaze             allmodconfig    clang-19
microblaze              allnoconfig    gcc-15.1.0
microblaze             allyesconfig    clang-19
mips                   allmodconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
mips                   allyesconfig    gcc-15.1.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
nios2                  allyesconfig    gcc-11.5.0
nios2       randconfig-001-20251107    gcc-11.5.0
nios2       randconfig-002-20251107    gcc-8.5.0
openrisc               allmodconfig    gcc-15.1.0
openrisc                allnoconfig    gcc-15.1.0
openrisc               allyesconfig    gcc-15.1.0
parisc                 allmodconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
parisc                 allyesconfig    gcc-15.1.0
powerpc                allmodconfig    gcc-15.1.0
powerpc                 allnoconfig    gcc-15.1.0
powerpc                allyesconfig    gcc-15.1.0
riscv                  allmodconfig    gcc-15.1.0
riscv                   allnoconfig    gcc-15.1.0
riscv                  allyesconfig    gcc-15.1.0
riscv       randconfig-001-20251107    clang-22
riscv       randconfig-002-20251107    gcc-13.4.0
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-22
s390                   allyesconfig    gcc-15.1.0
s390        randconfig-001-20251107    gcc-8.5.0
s390        randconfig-002-20251107    gcc-15.1.0
sh                     allmodconfig    gcc-15.1.0
sh                      allnoconfig    gcc-15.1.0
sh                     allyesconfig    gcc-15.1.0
sh          randconfig-001-20251107    gcc-13.4.0
sh          randconfig-002-20251107    gcc-11.5.0
sparc                  allmodconfig    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
sparc                  allyesconfig    gcc-15.1.0
sparc64                allmodconfig    clang-22
um                     allmodconfig    clang-19
um                      allnoconfig    clang-22
um                     allyesconfig    clang-19
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                        kexec    clang-20
x86_64                     rhel-9.4    clang-20
x86_64                 rhel-9.4-bpf    gcc-14
x86_64                rhel-9.4-func    clang-20
x86_64          rhel-9.4-kselftests    clang-20
x86_64               rhel-9.4-kunit    gcc-14
x86_64                 rhel-9.4-ltp    gcc-14
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

