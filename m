Return-Path: <linux-erofs+bounces-3320-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFwiONFj4WlCswAAu9opvQ
	(envelope-from <linux-erofs+bounces-3320-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Apr 2026 00:33:53 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CFA4153EF
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Apr 2026 00:33:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxXqH15nPz2xly;
	Fri, 17 Apr 2026 08:33:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776378827;
	cv=none; b=jcbJOh2dfaoybu4yfu09RILVzUt7mmhgbp1K0PlirQ+OqIg42SwxKhYaEwTQ+9aBYF2/sHoR1bG2u5wdlttjWHNks+9sKCRf5wKwynqhyDG6+uW5JuSxFCvtElHiYg5gjMoyJ9g24ANN3kJgXJMXK+8SJ4nY4ana+F2DAsnoS3rjRzPpHY5wAUTK/Mc707zDwi5KBKuCnii7iLywzULXZL/6OmotzyMmkul91O76DP8iQxz8yzPHkVth7URbZNGPo97bChXKmfqAHmdE5OYJOFx1T+flpI7aIindQGqZsW8cO4vH3gVWx5qrTwZcMbdNxzuA4VTU3KBDigU0m36KZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776378827; c=relaxed/relaxed;
	bh=Z+42UszWHG0gOMTB2H5WRfsRto8K4NCLJxv2yelzyYI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=blGeDtl0Tzd3L0BPNZAZjdkAeOW+y2zwwTaxn0ElYUUeg090Bj0BeImCKumk8kdK0AohtGjR2qvWz0XVXlAbTp4CKsc92ddpwwd4rXhIPKnford7c/5p577RMNItR9loe4amQnQ/bp2bh29ENEysL5rj3JEEfYiC/bx5hJ1zw4hdCFJbthdjKPpABk3ip4LxbDG99dzapYZe+MPDyWCs5acDoH9V9MHGIl0fYNJpdSl9GnKzWxb+pIHnJjHea/QSkm+PUSs0CDuH5VVrS3lFQBJ8UgMN5RyYdbaNMzz44DbawRN02UgS4G31cPigeZosjjNLBEelZRbV/elo4TjEVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OQVpzWkq; dkim-atps=neutral; spf=pass (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OQVpzWkq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxXqD1Wrjz2xlk
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Apr 2026 08:33:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776378825; x=1807914825;
  h=date:from:to:cc:subject:message-id;
  bh=JCmooeUj6H2vVSM/4SrNB9Qg3wJfRDk5Yk82NI73S2E=;
  b=OQVpzWkqaXsNaIxS+elGHzTWtk4iJdkw1alDt1CaDFaPvlcKy8fa/QOC
   RwMkBpRxu5Ut8kRWqLUr4bNg5u5eBw6LlEBLWq5XVKZpsodF81u/7tYTD
   CMshrrT+T2JNVS/++dAlPBqMCqkjGZi0gmiTQaNQ5HcJsl3VcJHLsZJ79
   5lY6ksh4o5XkhB7HBGeq6eaVIyG/MsGJQIhatd9FH/7u1MgqUp+2HisHq
   btAgXLUmEf4gziPTJXNrMqpnGPc1AvoDn+4DiiiEqYOL9g/efa5ADFn87
   7+oRvg1kMut5CJ3DM48dRPmNdqt6GKDlvXa2HcDBKbbhJoJW+pPE3ureX
   Q==;
X-CSE-ConnectionGUID: RWzonMwBRPy08AvgSwiD3w==
X-CSE-MsgGUID: G7dAIDB2RIyIZb98Mtwzvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="81273104"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="81273104"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 15:33:32 -0700
X-CSE-ConnectionGUID: 1PNvUCUgTOeqvdjn/9A3Ow==
X-CSE-MsgGUID: 6B0ZFL6gTnqvUBFATbpblA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="235232570"
Received: from lkp-server01.sh.intel.com (HELO 7f3b36e5d6a5) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 16 Apr 2026 15:33:31 -0700
Received: from kbuild by 7f3b36e5d6a5 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wDVH5-0000000023w-2KTF;
	Thu, 16 Apr 2026 22:33:27 +0000
Date: Fri, 17 Apr 2026 06:32:49 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 403bb5c8d1c5d77d55c3df6c6050dd0b97ed4779
Message-ID: <202604170640.w6HkLlDW-lkp@intel.com>
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
	TAGGED_FROM(0.00)[bounces-3320-lists,linux-erofs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: D0CFA4153EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 403bb5c8d1c5d77d55c3df6c6050dd0b97ed4779  erofs: fix the out-of-bounds nameoff handling for trailing dirents

elapsed time: 726m

configs tested: 162
configs skipped: 2

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
arc                   randconfig-001-20260416    gcc-14.3.0
arc                   randconfig-002-20260416    gcc-10.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260416    clang-23
arm                   randconfig-002-20260416    gcc-8.5.0
arm                   randconfig-003-20260416    gcc-8.5.0
arm                   randconfig-004-20260416    gcc-11.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260417    clang-19
arm64                 randconfig-002-20260417    clang-23
arm64                 randconfig-003-20260417    clang-23
arm64                 randconfig-004-20260417    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260417    gcc-13.4.0
csky                  randconfig-002-20260417    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260416    clang-23
hexagon               randconfig-002-20260416    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260416    gcc-14
i386        buildonly-randconfig-002-20260416    gcc-12
i386        buildonly-randconfig-003-20260416    clang-20
i386        buildonly-randconfig-004-20260416    clang-20
i386        buildonly-randconfig-005-20260416    clang-20
i386        buildonly-randconfig-006-20260416    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260416    gcc-14
i386                  randconfig-002-20260416    clang-20
i386                  randconfig-003-20260416    clang-20
i386                  randconfig-004-20260416    clang-20
i386                  randconfig-005-20260416    clang-20
i386                  randconfig-006-20260416    clang-20
i386                  randconfig-007-20260416    gcc-14
i386                  randconfig-011-20260416    gcc-14
i386                  randconfig-012-20260416    gcc-14
i386                  randconfig-013-20260416    clang-20
i386                  randconfig-014-20260416    clang-20
i386                  randconfig-015-20260416    clang-20
i386                  randconfig-016-20260416    clang-20
i386                  randconfig-017-20260416    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260416    gcc-15.2.0
loongarch             randconfig-002-20260416    gcc-15.2.0
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
nios2                 randconfig-001-20260416    gcc-8.5.0
nios2                 randconfig-002-20260416    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260416    gcc-10.5.0
parisc                randconfig-002-20260416    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                  mpc866_ads_defconfig    clang-23
powerpc               randconfig-001-20260416    clang-23
powerpc               randconfig-002-20260416    gcc-8.5.0
powerpc64             randconfig-001-20260416    clang-16
powerpc64             randconfig-002-20260416    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260416    gcc-11.5.0
riscv                 randconfig-002-20260416    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260416    clang-23
s390                  randconfig-002-20260416    clang-20
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260416    gcc-9.5.0
sh                    randconfig-002-20260416    gcc-15.2.0
sh                           sh2007_defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260417    gcc-12.5.0
sparc                 randconfig-002-20260417    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260417    clang-20
sparc64               randconfig-002-20260417    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260417    gcc-13
um                    randconfig-002-20260417    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260417    clang-20
x86_64      buildonly-randconfig-002-20260417    clang-20
x86_64      buildonly-randconfig-003-20260417    clang-20
x86_64      buildonly-randconfig-004-20260417    clang-20
x86_64      buildonly-randconfig-005-20260417    clang-20
x86_64      buildonly-randconfig-006-20260417    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260416    gcc-13
x86_64                randconfig-002-20260416    gcc-14
x86_64                randconfig-003-20260416    clang-20
x86_64                randconfig-004-20260416    clang-20
x86_64                randconfig-005-20260416    gcc-14
x86_64                randconfig-006-20260416    gcc-14
x86_64                randconfig-011-20260416    clang-20
x86_64                randconfig-012-20260416    gcc-14
x86_64                randconfig-013-20260416    gcc-14
x86_64                randconfig-014-20260416    gcc-12
x86_64                randconfig-015-20260416    clang-20
x86_64                randconfig-016-20260416    gcc-12
x86_64                randconfig-071-20260416    gcc-14
x86_64                randconfig-072-20260416    gcc-14
x86_64                randconfig-073-20260416    gcc-14
x86_64                randconfig-074-20260416    clang-20
x86_64                randconfig-075-20260416    clang-20
x86_64                randconfig-076-20260416    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260417    gcc-9.5.0
xtensa                randconfig-002-20260417    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

