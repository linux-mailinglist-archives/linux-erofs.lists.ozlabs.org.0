Return-Path: <linux-erofs+bounces-1449-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1B0C94078
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Nov 2025 16:11:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dJYXR4M4Dz2yvc;
	Sun, 30 Nov 2025 02:11:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764429079;
	cv=none; b=e/NZzhiF9LLyv2Q0yX3UzLkZomTHLeAkR9Cd6DqdJ9BvKnWNODRzYZn+Z01+VmCGK0QlWG0Em1kBwAKsfOx+UbScd0EsNgcK2a0CTGHfK/7nQxoipSUChayEZ4XP5QjwfqiztPwRbRdnU5atMyFyUpmouYIS4TEGkW7VlHJ2OhRp/GsQxzybi0W5YmmGYN6/eAX7xBIl6hKMYrqpdtHAkJMtX/NErlOS1imaaTHEO96s/ZkGu7Oj+4zSenxo9/nZr5IG3Rtyk45F8bXE7Uzref6brernWES7xch3PfOr2FGEmbr/rEspHl3UbOvqPWNQykAKnLl+JfZhPjzu2xJZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764429079; c=relaxed/relaxed;
	bh=QN9qued6re2oxpSKTaxtaTW9FniAxHBI4kLNP5Il0Nk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SN2GXdWRx9dQkx8q9iAGs0nBXVLo0lOiSFhPztSZfedbAZ1RaF1+511MhOzjgxY4doqNhjIUXLedv/NFRadjEKtNDXkQ/nh9V4AhH5Ihk2TCYlZeMBW9bWuOeZGox65DYUX4lgQYlhOd/fCdoZW9eYWD5NwDfQYGGgFNXtLX6Ezw3H5OdqFzbTw17kr0K64ZbE2zGSu6kK2/J90wW7oSCveezvVSCOPB7kW3CQdYCxo8s9B1pdwqkZXLMbp4bpMf6MTLhObhEs7CF+cNO8iEuVm0EaoKgpFjgfHg7h+w2oi1DksZtda2Xw3oFrvCu01UYZBYuqT9hhbS7mXDjnf6aA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bc9woKoK; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bc9woKoK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dJYXN6bbxz2yvb
	for <linux-erofs@lists.ozlabs.org>; Sun, 30 Nov 2025 02:11:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764429077; x=1795965077;
  h=date:from:to:cc:subject:message-id;
  bh=jl4T6j/sw+AjzENBgYfV0OsEYfVwFDbn4UsuUIszuWg=;
  b=Bc9woKoKt49jKJaxqJwMC+VFjFWuWG2wDznOA4xcZs+lscOLqwfNeeka
   D2u74bAFSHUl0/7TySG/0jyJrix52kmIF+QkMOdl3lsSyv7obGPARp+tf
   XrwFF6ApnFGWCk5Cr5kAg+wPmj5ZjO0SXfbsNsHKPADPkjsTux9O7y4ah
   cCOPEBs6MdSh2hgIFJeOF5TFEf7luUiAgRQIdkHy+0RQSNkYT2p9CpjKZ
   qeAh66iV2jCcjTm+cDNRH1PwprkYni+31Uz0Y1iHeVfyhMoWwWdbpmmEq
   woq3ucwzSmAovL/rVex/ezBkZzzY69ZE/T+2aHwGJdKcGMDowbIhl/La1
   w==;
X-CSE-ConnectionGUID: XmLn8SEeTmauwpcKKRypMw==
X-CSE-MsgGUID: 0hYxh62PREaZC7VOK9uASA==
X-IronPort-AV: E=McAfee;i="6800,10657,11627"; a="91895741"
X-IronPort-AV: E=Sophos;i="6.20,236,1758610800"; 
   d="scan'208";a="91895741"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 07:11:12 -0800
X-CSE-ConnectionGUID: og/8Kf6rSuCntq0avfq6iA==
X-CSE-MsgGUID: KAHXTJ9oSsOY0jQOiPM5hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,236,1758610800"; 
   d="scan'208";a="224373614"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 29 Nov 2025 07:11:10 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vPMbL-000000007H6-2o0i;
	Sat, 29 Nov 2025 15:11:07 +0000
Date: Sat, 29 Nov 2025 23:10:20 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 7f5b9d4481173634aa53a6cb7d0f7b66bcd85ab6
Message-ID: <202511292314.6pJB1svu-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 7f5b9d4481173634aa53a6cb7d0f7b66bcd85ab6  erofs: get rid of raw bi_end_io() usage

elapsed time: 1449m

configs tested: 117
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251129    gcc-8.5.0
arc                   randconfig-002-20251129    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                         axm55xx_defconfig    clang-22
arm                        keystone_defconfig    gcc-15.1.0
arm                   randconfig-001-20251129    clang-20
arm                   randconfig-002-20251129    gcc-10.5.0
arm                   randconfig-003-20251129    gcc-13.4.0
arm                   randconfig-004-20251129    gcc-8.5.0
arm                             rpc_defconfig    clang-18
arm                        spear3xx_defconfig    clang-17
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251129    clang-22
arm64                 randconfig-002-20251129    clang-22
arm64                 randconfig-003-20251129    gcc-8.5.0
arm64                 randconfig-004-20251129    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251129    gcc-15.1.0
csky                  randconfig-002-20251129    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251129    clang-22
hexagon               randconfig-002-20251129    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251129    clang-20
i386        buildonly-randconfig-002-20251129    clang-20
i386        buildonly-randconfig-003-20251129    gcc-14
i386        buildonly-randconfig-004-20251129    gcc-12
i386        buildonly-randconfig-005-20251129    gcc-14
i386        buildonly-randconfig-006-20251129    clang-20
i386                  randconfig-001-20251129    gcc-14
i386                  randconfig-002-20251129    gcc-12
i386                  randconfig-003-20251129    clang-20
i386                  randconfig-004-20251129    gcc-14
i386                  randconfig-005-20251129    clang-20
i386                  randconfig-006-20251129    clang-20
i386                  randconfig-007-20251129    gcc-14
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251129    gcc-15.1.0
loongarch             randconfig-002-20251129    gcc-14.3.0
m68k                              allnoconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                         rt305x_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20251129    gcc-11.5.0
nios2                 randconfig-002-20251129    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20251129    gcc-10.5.0
parisc                randconfig-002-20251129    gcc-13.4.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                       ebony_defconfig    clang-22
powerpc                 mpc832x_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251129    gcc-8.5.0
powerpc               randconfig-002-20251129    clang-22
powerpc                     tqm8555_defconfig    gcc-15.1.0
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251129    gcc-8.5.0
powerpc64             randconfig-002-20251129    gcc-13.4.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251129    gcc-8.5.0
riscv                 randconfig-002-20251129    gcc-11.5.0
s390                              allnoconfig    clang-22
s390                  randconfig-001-20251129    clang-22
s390                  randconfig-002-20251129    gcc-8.5.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251129    gcc-12.5.0
sh                    randconfig-002-20251129    gcc-15.1.0
sh                   rts7751r2dplus_defconfig    gcc-15.1.0
sh                   sh7724_generic_defconfig    gcc-15.1.0
sh                            shmin_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251129    gcc-8.5.0
sparc                 randconfig-002-20251129    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251129    gcc-8.5.0
sparc64               randconfig-002-20251129    gcc-14.3.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251129    clang-22
um                    randconfig-002-20251129    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251129    gcc-14
x86_64      buildonly-randconfig-002-20251129    clang-20
x86_64      buildonly-randconfig-003-20251129    clang-20
x86_64      buildonly-randconfig-004-20251129    gcc-14
x86_64      buildonly-randconfig-005-20251129    gcc-14
x86_64      buildonly-randconfig-006-20251129    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251129    clang-20
x86_64                randconfig-002-20251129    clang-20
x86_64                randconfig-003-20251129    clang-20
x86_64                randconfig-004-20251129    clang-20
x86_64                randconfig-005-20251129    gcc-14
x86_64                randconfig-006-20251129    clang-20
x86_64                randconfig-011-20251129    gcc-14
x86_64                randconfig-012-20251129    gcc-14
x86_64                randconfig-013-20251129    gcc-14
x86_64                randconfig-014-20251129    clang-20
x86_64                randconfig-015-20251129    gcc-12
x86_64                randconfig-016-20251129    clang-20
x86_64                randconfig-071-20251129    gcc-14
x86_64                randconfig-072-20251129    clang-20
x86_64                randconfig-073-20251129    gcc-14
x86_64                randconfig-074-20251129    gcc-12
x86_64                randconfig-075-20251129    gcc-14
x86_64                randconfig-076-20251129    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  nommu_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251129    gcc-10.5.0
xtensa                randconfig-002-20251129    gcc-14.3.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

