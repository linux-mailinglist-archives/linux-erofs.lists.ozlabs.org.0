Return-Path: <linux-erofs+bounces-3182-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKUpFsrWzmmGqgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3182-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 22:51:22 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 597C438E24B
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 22:51:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmvCV1Wjyz2xls;
	Fri, 03 Apr 2026 07:51:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775163078;
	cv=none; b=jJsfq+4HTrc/OCzyEwSH9GJym0cLPyB/I9bBRnW17zA5y/6mgoNtyw+cpsVbBqSfZODNe5zI7Eoi/B/En+gAxBuv+KzUsJbenHkgDv3d4VAp0DVHNe2/Kabhb8YfDGmNMPreP/cL00aGmPq/W8PlQuGPBYjnZGgA0RnNZNw6JFxULMJ6nRlhdf6Xs/+I6XcFlm5H0E2AFuu2McE/MIcm68qddyoU95Sy160FxccFjZ/kEbEGqE+P2s98FkmacuBEEYIFgIqfJbhO/DO6CKa3eMimdJbkCdPKLslb+yuY1De2MrPjmzmMgMV1OUANbF6H87DLeTU6R4AQEqEvSZU4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775163078; c=relaxed/relaxed;
	bh=IwktOqcXDu3CZzbD9iJQAS/OGM1L9VIxsc+fdmaZxGk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WPYMNo3JsaoAPkwl38P9N2gdoqwAFCQoCXWGNfLRo45qONzH439KbBQl1VtognhGV4A6313YeSw/AGPik+EVw+jf7lsUZiCI0Km5x7iXM+DWBNPbXJmqxXnV7H4y37A8yrPgnrcg+UKM76G5o6Gg8d0AdZ6m1SRDpnpRX95YJaX+qZq/KDqpOgSHukn0L/W7CF9NvqqZsSlWRdYUkrpbJlLJ2ArTkVd6JmOlZoJZCy4Ks+8PZ1/OiLpgEkskRuiZS0FGEy2KiwAx3FR31g0A8syacwYPc5sq8c/ztV7bd6pbRVxHQSySmXu7nV9vJRB5irhzhFZhmziOQRHu5npiyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N1Lzngap; dkim-atps=neutral; spf=temperror (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N1Lzngap;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=temperror (SPF Temporary Error: DNS Timeout) smtp.mailfrom=intel.com (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmvCQ4sF9z2xc8
	for <linux-erofs@lists.ozlabs.org>; Fri, 03 Apr 2026 07:50:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775163075; x=1806699075;
  h=date:from:to:cc:subject:message-id;
  bh=Q15tMPdoB2IAEdP+BhO0ppV6QZNZLqMap1S1mT0uieM=;
  b=N1Lzngap7deM0ECxtM2iyH9pcmPG9pJwV/INhrAr5t0fSZAZ8C/454FN
   3HqHwbIyW9nJldxrcIn0Y9cmhIsaa3LoqDxZNuwA+rBnc4vwmwPJXUHhs
   NqBKUXyrgq+TgZOilBjPWCgpyKcoxv/5ZqUZ2sJ1uJPuTTl2KyTk1cozY
   7npcK3qxPu6eh9GD8xalvlKQwAKaToscLBMfwAMB69lKX4diTem9SA2Hp
   O7Tew68dLRYDAKkoxRP1zga3V2LzBOA6pYPnn+If+JMEGblwVxfXMUQZj
   lyRno3Uzk7eszXGKvM9vA8EuuWnsstX01pKBktIpdW/VTO/Uxc+EHYbvk
   g==;
X-CSE-ConnectionGUID: 3JRpEGiwSDa19P9TmRKbrw==
X-CSE-MsgGUID: 5LtGATpdRhSsBo3rlMLRlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76123102"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="76123102"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 13:50:50 -0700
X-CSE-ConnectionGUID: p09eiaGFQVavtDU4b9YOBQ==
X-CSE-MsgGUID: yhZWMpwkRGGS3gy95A8rGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="265010390"
Received: from lkp-server01.sh.intel.com (HELO 064ad336901d) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 02 Apr 2026 13:50:48 -0700
Received: from kbuild by 064ad336901d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8P02-000000000Qd-09aq;
	Thu, 02 Apr 2026 20:50:46 +0000
Date: Fri, 03 Apr 2026 04:50:06 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 d6250d49da4d8f11afc0d8991c84e0307949f92e
Message-ID: <202604030456.WsPw2Mac-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3182-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 597C438E24B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: d6250d49da4d8f11afc0d8991c84e0307949f92e  erofs: include the trailing NUL in FS_IOC_GETFSLABEL

elapsed time: 746m

configs tested: 216
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260402    gcc-11.5.0
arc                   randconfig-001-20260403    gcc-10.5.0
arc                   randconfig-002-20260402    gcc-11.5.0
arc                   randconfig-002-20260403    gcc-10.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                         orion5x_defconfig    clang-23
arm                   randconfig-001-20260402    gcc-11.5.0
arm                   randconfig-001-20260403    gcc-10.5.0
arm                   randconfig-002-20260402    gcc-11.5.0
arm                   randconfig-002-20260403    gcc-10.5.0
arm                   randconfig-003-20260402    gcc-11.5.0
arm                   randconfig-003-20260403    gcc-10.5.0
arm                   randconfig-004-20260402    gcc-11.5.0
arm                   randconfig-004-20260403    gcc-10.5.0
arm                       spear13xx_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260402    gcc-15.2.0
arm64                 randconfig-001-20260403    gcc-13.4.0
arm64                 randconfig-002-20260402    gcc-15.2.0
arm64                 randconfig-002-20260403    gcc-13.4.0
arm64                 randconfig-003-20260402    gcc-15.2.0
arm64                 randconfig-003-20260403    gcc-13.4.0
arm64                 randconfig-004-20260402    gcc-15.2.0
arm64                 randconfig-004-20260403    gcc-13.4.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260402    gcc-15.2.0
csky                  randconfig-001-20260403    gcc-13.4.0
csky                  randconfig-002-20260402    gcc-15.2.0
csky                  randconfig-002-20260403    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260402    clang-18
hexagon               randconfig-001-20260403    clang-23
hexagon               randconfig-002-20260402    clang-18
hexagon               randconfig-002-20260403    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260402    clang-20
i386        buildonly-randconfig-001-20260403    gcc-14
i386        buildonly-randconfig-002-20260402    clang-20
i386        buildonly-randconfig-002-20260403    gcc-14
i386        buildonly-randconfig-003-20260402    clang-20
i386        buildonly-randconfig-003-20260403    gcc-14
i386        buildonly-randconfig-004-20260402    clang-20
i386        buildonly-randconfig-004-20260403    gcc-14
i386        buildonly-randconfig-005-20260402    clang-20
i386        buildonly-randconfig-005-20260403    gcc-14
i386        buildonly-randconfig-006-20260402    clang-20
i386        buildonly-randconfig-006-20260403    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260402    clang-20
i386                  randconfig-002-20260402    clang-20
i386                  randconfig-003-20260402    clang-20
i386                  randconfig-004-20260402    clang-20
i386                  randconfig-005-20260402    clang-20
i386                  randconfig-006-20260402    clang-20
i386                  randconfig-007-20260402    clang-20
i386                  randconfig-011-20260402    clang-20
i386                  randconfig-012-20260402    clang-20
i386                  randconfig-013-20260402    clang-20
i386                  randconfig-014-20260402    clang-20
i386                  randconfig-015-20260402    clang-20
i386                  randconfig-016-20260402    clang-20
i386                  randconfig-017-20260402    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260402    clang-18
loongarch             randconfig-001-20260403    clang-23
loongarch             randconfig-002-20260402    clang-18
loongarch             randconfig-002-20260403    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260402    clang-18
nios2                 randconfig-001-20260403    clang-23
nios2                 randconfig-002-20260402    clang-18
nios2                 randconfig-002-20260403    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260402    clang-20
parisc                randconfig-001-20260403    gcc-10.5.0
parisc                randconfig-002-20260402    clang-20
parisc                randconfig-002-20260403    gcc-10.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260402    clang-20
powerpc               randconfig-001-20260403    gcc-10.5.0
powerpc               randconfig-002-20260402    clang-20
powerpc               randconfig-002-20260403    gcc-10.5.0
powerpc64             randconfig-001-20260402    clang-20
powerpc64             randconfig-001-20260403    gcc-10.5.0
powerpc64             randconfig-002-20260402    clang-20
powerpc64             randconfig-002-20260403    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260402    clang-23
riscv                 randconfig-002-20260402    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260402    clang-23
s390                  randconfig-002-20260402    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260402    clang-23
sh                    randconfig-002-20260402    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260402    gcc-14
sparc                 randconfig-002-20260402    gcc-14
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260402    gcc-14
sparc64               randconfig-002-20260402    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260402    gcc-14
um                    randconfig-002-20260402    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260402    clang-20
x86_64      buildonly-randconfig-001-20260403    clang-20
x86_64      buildonly-randconfig-002-20260402    clang-20
x86_64      buildonly-randconfig-002-20260403    clang-20
x86_64      buildonly-randconfig-003-20260402    clang-20
x86_64      buildonly-randconfig-003-20260403    clang-20
x86_64      buildonly-randconfig-004-20260402    clang-20
x86_64      buildonly-randconfig-004-20260403    clang-20
x86_64      buildonly-randconfig-005-20260402    clang-20
x86_64      buildonly-randconfig-005-20260403    clang-20
x86_64      buildonly-randconfig-006-20260402    clang-20
x86_64      buildonly-randconfig-006-20260403    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260402    gcc-14
x86_64                randconfig-002-20260402    gcc-14
x86_64                randconfig-003-20260402    gcc-14
x86_64                randconfig-004-20260402    gcc-14
x86_64                randconfig-005-20260402    gcc-14
x86_64                randconfig-006-20260402    gcc-14
x86_64                randconfig-011-20260402    clang-20
x86_64                randconfig-012-20260402    clang-20
x86_64                randconfig-013-20260402    clang-20
x86_64                randconfig-014-20260402    clang-20
x86_64                randconfig-015-20260402    clang-20
x86_64                randconfig-016-20260402    clang-20
x86_64                randconfig-071-20260402    clang-20
x86_64                randconfig-072-20260402    clang-20
x86_64                randconfig-073-20260402    clang-20
x86_64                randconfig-074-20260402    clang-20
x86_64                randconfig-075-20260402    clang-20
x86_64                randconfig-076-20260402    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260402    gcc-14
xtensa                randconfig-002-20260402    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

