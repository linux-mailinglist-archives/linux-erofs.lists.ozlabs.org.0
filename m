Return-Path: <linux-erofs+bounces-3739-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2h99BF6TOmo7AggAu9opvQ
	(envelope-from <linux-erofs+bounces-3739-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 16:08:30 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1744D6B7BEA
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 16:08:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=inqBZSDC;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3739-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3739-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gl6Np4HrVz2y71;
	Wed, 24 Jun 2026 00:08:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782223706;
	cv=none; b=MWXlcrTq59jtlLzKxWmcwsn8ico3JCEyO6Raj2VrTdPJOqwtNSqeqBJbfUscF2KIV1wW6jhgPxLp4xvHiyzhtYdwRXB9rbPAooUwodEpytVa5djzR0OKyZOEU6b6WW6BAsCcb5V4DxK5CjZgpMkLv+G3KMSAKZkEv/3a+71Wf7rK1uBEXxYKrHtF/JYh/7P/viWqTfzbZrGK9r6AAxXJ01/vjsTFtp5Yfr2cABLxQdyLoaaAXsMdMKMhseIafYmUz11l/QRhEsaWkSBYbjdGmk0pOFA4c28OVIo6++wQ1smKsA5Wv4JAQ3d5QtTg7o7P6cIlQdUmSzI0YQv5O460gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782223706; c=relaxed/relaxed;
	bh=71MaGw2+hHfv++P386Bz1pN1Ufpd1rCkwnz1bD/0qtk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=k7MhlNselBBIEICoSy8z8t5yjvQFuG6PhgHQ3TGGX8/ipmgujml0Dp8my6zCzluAmVRAsxF/tEJGtvuPBkEMpoDKiGPiyB8YMTFr724OOENoe5chTj99SpO3psYLpoFfaMc7LiDObT7t/wsVxvVQGa8pjtQyXrOkOxKhYs29li3Rel/GRnl0u9rhlQR3+AZxcZHBJ6DUP9Acs4ig7J07PfflpXrRVFSlDcZjYPHt0HRvnx+17JEz9JEkkfPr2ew1cgnlIZJK3zhnraeknk30e2IMb/EhmCZsQhk2u4FzhJOlAEjIlHaYuaHV06zWh59QUxgyuAVfWtNt+R7oIPJ5hw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=inqBZSDC; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl6Nk42Fsz2xM7
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jun 2026 00:08:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782223704; x=1813759704;
  h=date:from:to:cc:subject:message-id;
  bh=IfyFl+a2lWVvtx2MRbH7rrswHeFDn5psUfu5ht6Jw14=;
  b=inqBZSDCjuZOcOj5fvyc/dlBIIMwgJ79ahTavPxENOKZ+XJ5WoUce0Vh
   zOh4BFOZKBhFSkpL7i3ArnwxIhNOjguyvDgvEzsU+9GX/JC5ymdbkLkB+
   XiZ6pX95/3M8uS31A54/0JaiE6tLVUesdaMEMBFJuMYX0wwUWCsRmcSp6
   /kmGHkbAy1IYb/Fxm8o55+wb5s6DWhn2TIigFy4ZQoUUSs6J/H02fgGw3
   tVDbr+FqcHFq8szfhiw/Eq3wOeJx7VKijFiNdzLySqHBCXr38hXDKS3J/
   Q6pgpQ+0m48NML6zFHVrNja9B/cB823HDLEhcnFuGmSN2Ht7KLaP2BSlJ
   A==;
X-CSE-ConnectionGUID: g4YubPgaTK+vES94tSOtuA==
X-CSE-MsgGUID: 54TlwNagRJSHFvihYOyBlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="105759128"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="105759128"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 07:08:17 -0700
X-CSE-ConnectionGUID: SIWuzzWCSkqh8O4/c6ijxg==
X-CSE-MsgGUID: IiFf+WrrTGGACcI11oFtDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="249561860"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 23 Jun 2026 07:08:15 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wc1nQ-000000002ad-0RSZ;
	Tue, 23 Jun 2026 14:08:12 +0000
Date: Tue, 23 Jun 2026 22:08:08 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 803d09a554055aba160a62abd1e4b1260b899dc1
Message-ID: <202606232257.qYlI2zQ1-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3739-lists,linux-erofs=lfdr.de];
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
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,intel.com:dkim,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1744D6B7BEA

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 803d09a554055aba160a62abd1e4b1260b899dc1  erofs: handle 48-bit blocks_hi for compressed inodes

elapsed time: 1102m

configs tested: 244
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260623    clang-23
arc                   randconfig-002-20260623    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260623    clang-23
arm                   randconfig-002-20260623    clang-23
arm                   randconfig-003-20260623    clang-23
arm                   randconfig-004-20260623    clang-23
arm                           spitz_defconfig    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260623    clang-23
arm64                 randconfig-001-20260623    gcc-14.3.0
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260623    clang-23
arm64                 randconfig-002-20260623    gcc-14.3.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260623    clang-23
arm64                 randconfig-003-20260623    gcc-14.3.0
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260623    clang-23
arm64                 randconfig-004-20260623    gcc-14.3.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260623    clang-23
csky                  randconfig-001-20260623    gcc-14.3.0
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260623    clang-23
csky                  randconfig-002-20260623    gcc-14.3.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260623    gcc-11.5.0
hexagon               randconfig-001-20260623    gcc-8.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260623    gcc-11.5.0
hexagon               randconfig-002-20260623    gcc-8.5.0
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260623    gcc-14
i386        buildonly-randconfig-002-20260623    gcc-14
i386        buildonly-randconfig-003-20260623    gcc-14
i386        buildonly-randconfig-004-20260623    gcc-14
i386        buildonly-randconfig-005-20260623    gcc-14
i386        buildonly-randconfig-006-20260623    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260623    clang-22
i386                  randconfig-002-20260623    clang-22
i386                  randconfig-003-20260623    clang-22
i386                  randconfig-004-20260623    clang-22
i386                  randconfig-005-20260623    clang-22
i386                  randconfig-006-20260623    clang-22
i386                  randconfig-007-20260623    clang-22
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260623    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260623    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260623    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260623    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260623    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260623    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260623    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260623    gcc-11.5.0
loongarch             randconfig-001-20260623    gcc-8.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260623    gcc-11.5.0
loongarch             randconfig-002-20260623    gcc-8.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                                defconfig    clang-23
m68k                       m5249evb_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260623    gcc-11.5.0
nios2                 randconfig-001-20260623    gcc-8.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260623    gcc-11.5.0
nios2                 randconfig-002-20260623    gcc-8.5.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-11.5.0
parisc                randconfig-001-20260623    gcc-11.5.0
parisc                         randconfig-002    gcc-11.5.0
parisc                randconfig-002-20260623    gcc-11.5.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                      ppc44x_defconfig    clang-17
powerpc                        randconfig-001    gcc-11.5.0
powerpc               randconfig-001-20260623    gcc-11.5.0
powerpc                        randconfig-002    gcc-11.5.0
powerpc               randconfig-002-20260623    gcc-11.5.0
powerpc64                      randconfig-001    gcc-11.5.0
powerpc64             randconfig-001-20260623    gcc-11.5.0
powerpc64                      randconfig-002    gcc-11.5.0
powerpc64             randconfig-002-20260623    gcc-11.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-8.5.0
riscv                 randconfig-001-20260623    gcc-8.5.0
riscv                          randconfig-002    gcc-8.5.0
riscv                 randconfig-002-20260623    gcc-8.5.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-8.5.0
s390                  randconfig-001-20260623    gcc-8.5.0
s390                           randconfig-002    gcc-8.5.0
s390                  randconfig-002-20260623    gcc-8.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-8.5.0
sh                    randconfig-001-20260623    gcc-8.5.0
sh                             randconfig-002    gcc-8.5.0
sh                    randconfig-002-20260623    gcc-8.5.0
sh                           se7724_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-8.5.0
sparc                 randconfig-001-20260623    gcc-8.5.0
sparc                          randconfig-002    gcc-8.5.0
sparc                 randconfig-002-20260623    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260623    gcc-8.5.0
sparc64                        randconfig-002    gcc-8.5.0
sparc64               randconfig-002-20260623    gcc-8.5.0
um                               allmodconfig    clang-17
um                               allmodconfig    clang-23
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-8.5.0
um                    randconfig-001-20260623    gcc-8.5.0
um                             randconfig-002    gcc-8.5.0
um                    randconfig-002-20260623    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    clang-22
x86_64      buildonly-randconfig-001-20260623    clang-22
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260623    clang-22
x86_64               buildonly-randconfig-003    clang-22
x86_64      buildonly-randconfig-003-20260623    clang-22
x86_64               buildonly-randconfig-004    clang-22
x86_64      buildonly-randconfig-004-20260623    clang-22
x86_64               buildonly-randconfig-005    clang-22
x86_64      buildonly-randconfig-005-20260623    clang-22
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260623    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    gcc-14
x86_64                randconfig-001-20260623    gcc-14
x86_64                         randconfig-002    gcc-14
x86_64                randconfig-002-20260623    gcc-14
x86_64                         randconfig-003    gcc-14
x86_64                randconfig-003-20260623    gcc-14
x86_64                         randconfig-004    gcc-14
x86_64                randconfig-004-20260623    gcc-14
x86_64                         randconfig-005    gcc-14
x86_64                randconfig-005-20260623    gcc-14
x86_64                         randconfig-006    gcc-14
x86_64                randconfig-006-20260623    gcc-14
x86_64                randconfig-011-20260623    gcc-14
x86_64                randconfig-012-20260623    gcc-14
x86_64                randconfig-013-20260623    gcc-14
x86_64                randconfig-014-20260623    gcc-14
x86_64                randconfig-015-20260623    gcc-14
x86_64                randconfig-016-20260623    gcc-14
x86_64                randconfig-071-20260623    gcc-14
x86_64                randconfig-072-20260623    gcc-14
x86_64                randconfig-073-20260623    gcc-14
x86_64                randconfig-074-20260623    gcc-14
x86_64                randconfig-075-20260623    gcc-14
x86_64                randconfig-076-20260623    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260623    gcc-8.5.0
xtensa                         randconfig-002    gcc-8.5.0
xtensa                randconfig-002-20260623    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

