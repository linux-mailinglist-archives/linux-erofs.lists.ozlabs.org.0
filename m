Return-Path: <linux-erofs+bounces-2815-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABeALB24uWnJMQIAu9opvQ
	(envelope-from <linux-erofs+bounces-2815-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 21:22:53 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72072B2327
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 21:22:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fb3L11BkZz2xS3;
	Wed, 18 Mar 2026 07:22:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773778969;
	cv=none; b=Q44rcJsZUWTY14RMaJ6wqv/tVH+Mcg38n6FW5RB58E9o9PlmOrxTjxzVllExcC3BEWAjEaVStmt/9jTcudkhap2NsBSp0JQWLGOryDkuG2SrgTLjydLnn6cuRAg5Y7MKatJ9A4YAHDTmeXB72a0ko0vm+6oL6kQ4LEKCNF6nKCn6e5SQ0QibEx8lJ35KJ37QuJxfOayeq3yJvyzkq+oWtPH9WjzAyF3Wwg0OVRIoN5tIt6LnMuu48r6s+6hN+5uGGPFNthP5yla7ZulipLOFPNLrRGXnVAmc0oAc6JfyEpOpfqgzjH3MAt5F0Ha/m8P3pwXdX8qI4WWQ3QzdDxt/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773778969; c=relaxed/relaxed;
	bh=tBD0scVEBwlNfWS4d1Y3NlLCDZmtLJ2E6z5xY40UF3Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dRi5a2hJBs56tpa8REG6gy/y4UXKxm5hyVOMFabTUqzJjUK0zonhmXNwsqq30YN8E/5o7qBfiatRY2GGg4omHX9G7Z7WwYyP+8+0UoXIANXlu+t5CbiGQuLicyZ16gtYz/IYaPSFNNRbZYa2oRgi2/Lq7TNuaHnLxytKFJOybsr2Lz5sp5RTNh7WsW/dnGCgd0pZRRGTppzl4PMKAT1K3fIBdWdm7+plt4k5/jr+zvcD9w1IlkWWcNVmeRU1aNe1WCpHP2lg+mcXiVGJ+2BHI+urR/Ma+Ea0Jf6vim8hDMR7sOLKopo06iOtjoR8b4JcDMT+oDvrIx3rKb0IIWchaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CnBgs+Rb; dkim-atps=neutral; spf=pass (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CnBgs+Rb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fb3Kx3FWnz2xQr
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 07:22:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773778966; x=1805314966;
  h=date:from:to:cc:subject:message-id;
  bh=8oMTRWUkoxme4/+z7kMxNJrP5xcjEWcZEH/eO9FuVyM=;
  b=CnBgs+RbL57wzAhbTJedLUNelJfWnjIhXTvbHZ4F1SrWoIpcZsiEHRys
   LlDWdBf6NmKAg6a6PpmRRbJmkiwpp2ngfxYP30/zcge79R311fF8gLOLz
   lt6qtxfzoK3hNuB8kT1Ut7/hsmf07XZtQjkrw9DoIyzxJ0P/h9zsdlnAz
   /ZRwcFK5Y0Uj7wHeg1tbXHpkfW1yEVyCUieIjTZV5qYHDZVaEBeH0sPwg
   bIvvyFxNzYqTAhDwifzffSeAE5lgE+Fi8xeU27Y6W3Vdy93rv1prrrMPO
   RUnbH43cL6AE/dQFvs5NyUH0/evJTy22Js+83cCMZxBlE66fTATQcYn4C
   A==;
X-CSE-ConnectionGUID: EgPgzBbeScev7aQpktx6gg==
X-CSE-MsgGUID: EkXYGl5yTxmD2Dega+p6zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74524162"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="74524162"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 13:22:40 -0700
X-CSE-ConnectionGUID: /2GbwkyeTXejPqABz2/9Hw==
X-CSE-MsgGUID: PiQC5LgbScaHWccMgkoJoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="222354912"
Received: from lkp-server01.sh.intel.com (HELO 63737dd503cb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 17 Mar 2026 13:22:38 -0700
Received: from kbuild by 63737dd503cb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2avy-000000001w9-2WGo;
	Tue, 17 Mar 2026 20:22:34 +0000
Date: Wed, 18 Mar 2026 04:22:07 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:fixes] BUILD SUCCESS
 e2147eccab5524e6e5c41c48a01f69c94a30eef6
Message-ID: <202603180401.r3nU3qCG-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2815-lists,linux-erofs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: C72072B2327
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git fixes
branch HEAD: e2147eccab5524e6e5c41c48a01f69c94a30eef6  erofs: add GFP_NOIO in the bio completion if needed

elapsed time: 829m

configs tested: 157
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
arc                   randconfig-001-20260317    clang-23
arc                   randconfig-002-20260317    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                      jornada720_defconfig    clang-23
arm                   randconfig-001-20260317    clang-23
arm                   randconfig-002-20260317    clang-23
arm                   randconfig-003-20260317    clang-23
arm                   randconfig-004-20260317    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260317    gcc-8.5.0
hexagon               randconfig-002-20260317    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260317    clang-20
i386        buildonly-randconfig-002-20260317    clang-20
i386        buildonly-randconfig-003-20260317    clang-20
i386        buildonly-randconfig-004-20260317    clang-20
i386        buildonly-randconfig-005-20260317    clang-20
i386        buildonly-randconfig-006-20260317    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260317    gcc-14
i386                  randconfig-002-20260317    gcc-14
i386                  randconfig-003-20260317    gcc-14
i386                  randconfig-004-20260317    gcc-14
i386                  randconfig-005-20260317    gcc-14
i386                  randconfig-006-20260317    gcc-14
i386                  randconfig-007-20260317    gcc-14
i386                  randconfig-011-20260317    clang-20
i386                  randconfig-012-20260317    clang-20
i386                  randconfig-013-20260317    clang-20
i386                  randconfig-014-20260317    clang-20
i386                  randconfig-015-20260317    clang-20
i386                  randconfig-016-20260317    clang-20
i386                  randconfig-017-20260317    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260317    gcc-8.5.0
loongarch             randconfig-002-20260317    gcc-8.5.0
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
mips                 decstation_r4k_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260317    gcc-8.5.0
nios2                 randconfig-002-20260317    gcc-8.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260317    gcc-8.5.0
parisc                randconfig-002-20260317    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260317    gcc-8.5.0
powerpc               randconfig-002-20260317    gcc-8.5.0
powerpc64             randconfig-001-20260317    gcc-8.5.0
powerpc64             randconfig-002-20260317    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260317    gcc-10.5.0
riscv                 randconfig-002-20260317    gcc-10.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260317    gcc-10.5.0
s390                  randconfig-002-20260317    gcc-10.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260317    gcc-10.5.0
sh                    randconfig-002-20260317    gcc-10.5.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260317    gcc-12.5.0
sparc                 randconfig-002-20260317    gcc-12.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260317    gcc-12.5.0
sparc64               randconfig-002-20260317    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260317    gcc-12.5.0
um                    randconfig-002-20260317    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260317    clang-20
x86_64                randconfig-002-20260317    clang-20
x86_64                randconfig-003-20260317    clang-20
x86_64                randconfig-004-20260317    clang-20
x86_64                randconfig-005-20260317    clang-20
x86_64                randconfig-006-20260317    clang-20
x86_64                randconfig-011-20260317    clang-20
x86_64                randconfig-012-20260317    clang-20
x86_64                randconfig-013-20260317    clang-20
x86_64                randconfig-014-20260317    clang-20
x86_64                randconfig-015-20260317    clang-20
x86_64                randconfig-016-20260317    clang-20
x86_64                randconfig-071-20260317    clang-20
x86_64                randconfig-072-20260317    clang-20
x86_64                randconfig-073-20260317    clang-20
x86_64                randconfig-074-20260317    clang-20
x86_64                randconfig-075-20260317    clang-20
x86_64                randconfig-076-20260317    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260317    gcc-12.5.0
xtensa                randconfig-002-20260317    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

