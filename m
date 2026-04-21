Return-Path: <linux-erofs+bounces-3343-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gH0DHZ3j5mmr1gEAu9opvQ
	(envelope-from <linux-erofs+bounces-3343-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2026 04:40:29 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4DA4358E5
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2026 04:40:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g066110rcz2xlK;
	Tue, 21 Apr 2026 12:40:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776739225;
	cv=none; b=SkWhLF78s30Bfvb/iUZ0YKhtIoEOcDoKnvGKmUvZ1R6HT5Dsn150iS1SOugyyMQy0zB7Zzqv7wBW8HZP2mpmiddPogSIabKfRPZhYTmQqEIUhCoOtaLG+Ssq7WJ3uvo7E+UM02K8IOLT5knS+ocNMA29lV185SlA83U9dAEzOBqI1FIfkjD/xMwitvGnJZMILcnp41PS/AHAJkV4nciCZ7ftKwqQJunhwNpPK1Se6bCekPV3w3qk/NGc46RhGZ91bHU1Av6Ujn49KFBZy0XEO+B+fWCIM1Ad6L+1i6LYha91sKBOvxjvt+ZHZtyzaWrud6B7+9zKe780LmEWgOvqGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776739225; c=relaxed/relaxed;
	bh=6EQCkRf0s4b0vg4advPMOpmoHrfANcIsCFG39Ru00oM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ezYMM42v2KylQ4lHHt2r4oWaLq/+pIMtxgi80Bx90zVW155NQBRo3RQ0GJ93k0Em1Ch0fvdFUsYNeuJngNmdiLew7R991V/LKI14MWsF8mL9/LIY0cTcrBXbZfdiUaf/MTxYhwHRfVWbShojybl/WFoUIBOIKQ74Pc3jbtVgSCN3SpdZWTjnyVo/FoFk0nIYX6r+g23gW1zal5mIMOZLF68TgSRpCW4+i7U2Pudkd2QPiigOfx6uFsAzbvPpmTMMiJKKy2SqOBAJuR4BkND6vtqx8gjdJZrzgl70bIxJeszTSqIqd64UH6S7328haEFtXlFMyzUzf4rABmvXBlWrHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Qaeq++3g; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Qaeq++3g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g065x6951z2xc8
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Apr 2026 12:40:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776739222; x=1808275222;
  h=date:from:to:cc:subject:message-id;
  bh=aW9+zNYnh93or2KIqv9t7LdWyaSlkbedzmYjIRpfbew=;
  b=Qaeq++3g0lX0lezHTEjBcrZ8OsV+f0FXdR7GJgvEcfr5meE++InJBpXj
   qJTMFMOMc0yqJStEwHMPH2NRg2zeTzouGzKJAMlHVMYmNEEUUbAJTjFpM
   BLBMqLF/I5UlT2QUgBjebZ8XTx5BximJiQSN5S7Cl02iONnK45vV3jwVt
   J2Ea2/D5wOl2WLeMEj0ETYBx5KDLZ95z9wAerisQfZgNcXK4BCAhzFFKV
   8ZEWDbMtoDaChPV/HYaVu342rjzKcatxp9pMBBxhcg/MX56N8GvDWsLYd
   c+nhOFQhFXqvSC1ua/tdkqm7pv9GCMs+KShPQxgbU+hbSydlMPzusXvxi
   w==;
X-CSE-ConnectionGUID: 88S8jG1bSYuOiO2F2ifSaQ==
X-CSE-MsgGUID: Cayu91zOSj2fbm/dp0BxoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88364192"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="88364192"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 19:40:16 -0700
X-CSE-ConnectionGUID: TDad6wAZTQSCxJwZmXeZNQ==
X-CSE-MsgGUID: VkwdHUQDRCu9IggdacH5mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="228737869"
Received: from lkp-server01.sh.intel.com (HELO 7e48d0ff8e22) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 20 Apr 2026 19:40:14 -0700
Received: from kbuild by 7e48d0ff8e22 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wF124-0000000037Q-02uv;
	Tue, 21 Apr 2026 02:40:12 +0000
Date: Tue, 21 Apr 2026 10:39:29 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 004f8d440c74d889f2f54514e4d33c18c0a12252
Message-ID: <202604211020.uraoHONG-lkp@intel.com>
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
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3343-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 1D4DA4358E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 004f8d440c74d889f2f54514e4d33c18c0a12252  erofs: unify lcn as u64 for 32-bit platforms

elapsed time: 758m

configs tested: 165
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260420    gcc-8.5.0
arc                   randconfig-002-20260420    gcc-14.3.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260420    gcc-8.5.0
arm                   randconfig-002-20260420    gcc-12.5.0
arm                   randconfig-003-20260420    clang-23
arm                   randconfig-004-20260420    clang-23
arm                           sunxi_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260420    clang-23
arm64                 randconfig-002-20260420    clang-23
arm64                 randconfig-003-20260420    gcc-8.5.0
arm64                 randconfig-004-20260420    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260420    gcc-9.5.0
csky                  randconfig-002-20260420    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260420    clang-20
hexagon               randconfig-002-20260420    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260420    clang-20
i386        buildonly-randconfig-002-20260420    gcc-14
i386        buildonly-randconfig-003-20260420    clang-20
i386        buildonly-randconfig-004-20260420    clang-20
i386        buildonly-randconfig-005-20260420    gcc-14
i386        buildonly-randconfig-006-20260420    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260421    clang-20
i386                  randconfig-002-20260421    clang-20
i386                  randconfig-003-20260421    clang-20
i386                  randconfig-004-20260421    clang-20
i386                  randconfig-005-20260421    clang-20
i386                  randconfig-006-20260421    clang-20
i386                  randconfig-007-20260421    clang-20
i386                  randconfig-011-20260420    clang-20
i386                  randconfig-012-20260420    gcc-14
i386                  randconfig-013-20260420    gcc-14
i386                  randconfig-014-20260420    clang-20
i386                  randconfig-015-20260420    clang-20
i386                  randconfig-016-20260420    gcc-14
i386                  randconfig-017-20260420    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260420    gcc-15.2.0
loongarch             randconfig-002-20260420    clang-18
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260420    gcc-8.5.0
nios2                 randconfig-002-20260420    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260420    gcc-11.5.0
parisc                randconfig-002-20260420    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                       ppc64_defconfig    clang-23
powerpc               randconfig-001-20260420    gcc-8.5.0
powerpc               randconfig-002-20260420    clang-16
powerpc64             randconfig-001-20260420    clang-19
powerpc64             randconfig-002-20260420    clang-18
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260421    clang-23
riscv                 randconfig-002-20260421    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260421    gcc-11.5.0
s390                  randconfig-002-20260421    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260421    gcc-15.2.0
sh                    randconfig-002-20260421    gcc-11.5.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260420    gcc-15.2.0
sparc                 randconfig-001-20260421    gcc-15.2.0
sparc                 randconfig-002-20260420    gcc-8.5.0
sparc                 randconfig-002-20260421    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260421    gcc-9.5.0
sparc64               randconfig-002-20260420    clang-23
sparc64               randconfig-002-20260421    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260421    clang-23
um                    randconfig-002-20260421    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260420    gcc-14
x86_64      buildonly-randconfig-002-20260420    clang-20
x86_64      buildonly-randconfig-003-20260420    gcc-14
x86_64      buildonly-randconfig-004-20260420    gcc-14
x86_64      buildonly-randconfig-005-20260420    gcc-14
x86_64      buildonly-randconfig-006-20260420    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260420    clang-20
x86_64                randconfig-002-20260420    clang-20
x86_64                randconfig-003-20260420    gcc-13
x86_64                randconfig-004-20260420    gcc-14
x86_64                randconfig-005-20260420    clang-20
x86_64                randconfig-006-20260420    gcc-14
x86_64                randconfig-011-20260420    gcc-14
x86_64                randconfig-012-20260420    gcc-14
x86_64                randconfig-013-20260420    clang-20
x86_64                randconfig-014-20260420    gcc-14
x86_64                randconfig-015-20260420    clang-20
x86_64                randconfig-016-20260420    clang-20
x86_64                randconfig-071-20260420    gcc-14
x86_64                randconfig-072-20260420    gcc-14
x86_64                randconfig-073-20260420    gcc-14
x86_64                randconfig-074-20260420    gcc-14
x86_64                randconfig-075-20260420    clang-20
x86_64                randconfig-076-20260420    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260421    gcc-15.2.0
xtensa                randconfig-002-20260421    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

