Return-Path: <linux-erofs+bounces-3002-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA1BMv0DxGnOvQQAu9opvQ
	(envelope-from <linux-erofs+bounces-3002-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 16:49:17 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187EE3286B4
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 16:49:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgrtb0blqz2yS4;
	Thu, 26 Mar 2026 02:49:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774453751;
	cv=none; b=KwCUv06NKpLZswgK6r7f+p98xOAHAq/HIj2q1dYMX+/rhDhk/ZbHOPQRbEVUdS/ut9W2Ktp/S9tZuujtXrV3tp4otvAr7qRkhSBBzdM1/s7gZTdzMezwLLiOhtXAkAojbrsZ5zm3cwBG0kDrAGHjVA1aHaAyYArnm9hOfRyJoQ9FrT3aaZpTxnF9KEpDsy7KxCLlOAo4UQCIA2UyXPPKWXTeJqSxskMGhYQH44Zdk6ze25+AA6Afa1zyAENT2N/Zcuw1rUjv5iqNR3zsqvnYCaAjSi/95n5IchITRmrIWUjAutGYyT9C5VnBUOLCqOWkYx+GfV7CdcK7itCUBh/iew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774453751; c=relaxed/relaxed;
	bh=VZMcgRIbWWCXEBoL6hlGJT5vd1de0epOl9HflPA+N1w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=igj3lqeELlCGA9cuhoMuaUpkzO8f8xT31M1m2L5WqNeIS4a+yqFzq5PMBW27M+pA4vBj3gXvB3yK8npJrWA5dIFsNJ4YoLjeHiHmj/DlwTLXrd6CG9D8Bzq5qXI8qaqd8zYxfPc8K2p+jb9xrJCe6/b2mwx6n1zzVwYWsjWMKPcn2cqBRQM/3wnsM0t3fvSZdaB4lUNTt8k4kwEdYXrO6idfRddbfVzcPKU/3ebzpSQSH3vOd19iv1FOPtUXcbllNzfjwwqVN7DCzQ5p4ySUWBXe0L0yiJy7BkfXVMK80Ub4hfSYszqcKMNYVQjLewS14B14r0/nSS65LCSF/m2Z6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jWSDtGjX; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jWSDtGjX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgrtX2kqsz2xSX
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 02:49:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774453749; x=1805989749;
  h=date:from:to:cc:subject:message-id;
  bh=5X6/jV5A6Hri3AnBfIzJ9BKx2ttolpXJDLkLMVzVnN0=;
  b=jWSDtGjXP9isUylMkox0QgkdJeCt3rcdUQWzKd6ckAlPz1IqKMk9gnxz
   SwzP9pJguiwyynV9Eopb2A9W8+v071U2kL/T6fgvwraZU663ocETBlta4
   O66Byd7GOxer/OsR+iUHRK6mY1xPFFrAxY996fijw7amyRZaPdnzHmbKJ
   Z6lti+U/NKGa6F8FWTGupqztX4p1FqDLC16hXsa06TGYk3GFY7riMAzoI
   xRXH0meVBlNXZ6Kb6q6jQRondS9EOUmhzMrRkOYc/AlsdN+UPHMlKIJPY
   Coo5c6b13FVBBUroZLPiXMKqKxc7K1ZHyB/hUfM8G9un/mYGcW+XyTSN6
   g==;
X-CSE-ConnectionGUID: Mz36fEfYSS6nmnqL5YeooQ==
X-CSE-MsgGUID: N2Zkp/d+Rs6YKektoP53FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="98115575"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="98115575"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 08:49:04 -0700
X-CSE-ConnectionGUID: ZO00ceYsRjudqUto2pX8yg==
X-CSE-MsgGUID: W2z0p6zgT0ClMYvh2suuLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="224672693"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 25 Mar 2026 08:49:01 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5QTa-000000007Aj-2TTC;
	Wed, 25 Mar 2026 15:48:58 +0000
Date: Wed, 25 Mar 2026 23:48:29 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 2f0407ed923b7eb363424033fc12fe253da139c4
Message-ID: <202603252321.ibGzUJLU-lkp@intel.com>
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
	TAGGED_FROM(0.00)[bounces-3002-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 187EE3286B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 2f0407ed923b7eb363424033fc12fe253da139c4  erofs: fix .fadvise() for page cache sharing

elapsed time: 762m

configs tested: 183
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
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260325    gcc-8.5.0
arc                   randconfig-002-20260325    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                       netwinder_defconfig    gcc-15.2.0
arm                   randconfig-001-20260325    gcc-8.5.0
arm                   randconfig-002-20260325    gcc-8.5.0
arm                   randconfig-003-20260325    gcc-8.5.0
arm                   randconfig-004-20260325    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260325    clang-23
arm64                 randconfig-002-20260325    clang-23
arm64                 randconfig-003-20260325    clang-23
arm64                 randconfig-004-20260325    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260325    clang-23
csky                  randconfig-002-20260325    clang-23
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260325    gcc-11.5.0
hexagon               randconfig-002-20260325    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260325    gcc-14
i386        buildonly-randconfig-002-20260325    gcc-14
i386        buildonly-randconfig-003-20260325    gcc-14
i386        buildonly-randconfig-004-20260325    gcc-14
i386        buildonly-randconfig-005-20260325    gcc-14
i386        buildonly-randconfig-006-20260325    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260325    clang-20
i386                  randconfig-002-20260325    clang-20
i386                  randconfig-003-20260325    clang-20
i386                  randconfig-004-20260325    clang-20
i386                  randconfig-005-20260325    clang-20
i386                  randconfig-006-20260325    clang-20
i386                  randconfig-007-20260325    clang-20
i386                  randconfig-011-20260325    clang-20
i386                  randconfig-012-20260325    clang-20
i386                  randconfig-013-20260325    clang-20
i386                  randconfig-014-20260325    clang-20
i386                  randconfig-015-20260325    clang-20
i386                  randconfig-016-20260325    clang-20
i386                  randconfig-017-20260325    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260325    gcc-11.5.0
loongarch             randconfig-002-20260325    gcc-11.5.0
m68k                             alldefconfig    gcc-15.2.0
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
nios2                 randconfig-001-20260325    gcc-11.5.0
nios2                 randconfig-002-20260325    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                       virt_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260325    clang-23
parisc                randconfig-002-20260325    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260325    clang-23
powerpc               randconfig-002-20260325    clang-23
powerpc64             randconfig-001-20260325    clang-23
powerpc64             randconfig-002-20260325    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260325    gcc-8.5.0
riscv                 randconfig-002-20260325    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260325    gcc-8.5.0
s390                  randconfig-002-20260325    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260325    gcc-8.5.0
sh                    randconfig-002-20260325    gcc-8.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260325    gcc-13
sparc                 randconfig-002-20260325    gcc-13
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260325    gcc-13
sparc64               randconfig-002-20260325    gcc-13
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260325    gcc-13
um                    randconfig-002-20260325    gcc-13
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260325    gcc-14
x86_64      buildonly-randconfig-002-20260325    gcc-14
x86_64      buildonly-randconfig-003-20260325    gcc-14
x86_64      buildonly-randconfig-004-20260325    gcc-14
x86_64      buildonly-randconfig-005-20260325    gcc-14
x86_64      buildonly-randconfig-006-20260325    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260325    gcc-12
x86_64                randconfig-002-20260325    gcc-12
x86_64                randconfig-003-20260325    gcc-12
x86_64                randconfig-004-20260325    gcc-12
x86_64                randconfig-005-20260325    gcc-12
x86_64                randconfig-006-20260325    gcc-12
x86_64                randconfig-011-20260325    clang-20
x86_64                randconfig-012-20260325    clang-20
x86_64                randconfig-013-20260325    clang-20
x86_64                randconfig-014-20260325    clang-20
x86_64                randconfig-015-20260325    clang-20
x86_64                randconfig-016-20260325    clang-20
x86_64                randconfig-071-20260325    gcc-14
x86_64                randconfig-072-20260325    gcc-14
x86_64                randconfig-073-20260325    gcc-14
x86_64                randconfig-074-20260325    gcc-14
x86_64                randconfig-075-20260325    gcc-14
x86_64                randconfig-076-20260325    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260325    gcc-13
xtensa                randconfig-002-20260325    gcc-13

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

