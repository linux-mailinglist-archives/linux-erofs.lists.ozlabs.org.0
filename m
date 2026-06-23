Return-Path: <linux-erofs+bounces-3742-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FNmSC2LeOmrRJQgAu9opvQ
	(envelope-from <linux-erofs+bounces-3742-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 21:28:34 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FE06B9B44
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 21:28:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=H+tf20Kn;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3742-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3742-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glFV63c43z2yQG;
	Wed, 24 Jun 2026 05:28:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782242910;
	cv=none; b=VuuGz0oLkUsQprrqzNDwvtiAb4MEObeHPOMgHHB0n5NhZJu4pzNOtP78BgOKslPeNYoffSDc9FYSLkZ1tLXPrFz1kYDcjPhHZp0gpIRw7uuksb/oQ97lcuM7lr2oZKY+5hlnxLxjDPk+aXHMKjPODDzJkTgW+qAyqhIuOfYJfWZaVE5Kx9TP7qxtKy25m/0Rz+Dp8HFB3JNIMRe2cQdsBgERSIfMWmC1R423F/oGkgw4p2bJ8n3trnyQ5QzypyDOjjCehcX+QFkvx/1FGi2uciLhaqR2j92k1gdxbGV3cpQ7CVg2n3nLD+QZtGMgs9O+kZkV9N2b95qbmsu9kvn6PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782242910; c=relaxed/relaxed;
	bh=UUN6x2uk8GHSvONiFJJ4O+BbqcLy+hrJ55TjRIbPnEM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OubdIgNrxmIZ6ltlp/xTUsCuXTFMio02731YXxydmv/Os1FmhpdM1LzLKjGTo4h18oWLJSoPqV92pURfxOoiwC1v/sQnJl/cEsRi5elHgtGNGomca0TS63UwwzzGdGWadFpIEuhjfBMrGuVlbtK+FI/wg2TXboLreVtIwQr+9+btmHhwyI2Quy5j0jOW1DUkmMGE41rfE7psZMrDT2uIRxZ3GrBgkowNlUMzRRS0XpWggUGVRNeLLyCPvXdYaTuzj7MVYxk3x2nIPqmTCWB9Zh2F1UJKVv/65MXaNyu526FwDko0yyP8Wk1z5bezQgFC2seQ2jSa4qJL0lG3QtiHsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H+tf20Kn; dkim-atps=neutral; spf=pass (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
X-Greylist: delayed 65 seconds by postgrey-1.37 at boromir; Wed, 24 Jun 2026 05:28:26 AEST
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glFV267cQz2y7r
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jun 2026 05:28:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782242907; x=1813778907;
  h=date:from:to:cc:subject:message-id;
  bh=e1oUhUhXmnPTSh3gXHQ/bRtfNg6dMOIAPz+WFU6ySHA=;
  b=H+tf20Knezx/uBl/04PkOzn2y9XpUZe2gErzxSkB4SYkLUPHPpKQGH1c
   hpxhRyyvCx+AqO3q1+eqN/uj1mkE/PZVQvOuu7YYBc8cXbJe0zLSp/WQz
   Odg5BjAJWv8h7/LoDVSXMAnVSruWSNXKFqC7Fs0oG9wagU/pxV49RstT/
   JcGnHml2GWjNngiVD6PO7hxaBiLgfljeGuBHoxoWf3qBNMmb2DnCA6FJL
   oYpUCFxRR1dfU2bljp4AsqlJLTtpn+/zeUZYRHO/F5S4ygfhNcx2TB98V
   T4oemNo3GpG1C790ZTP7ftDfvpJ2Lt/aEywMwfo2GYtfJbW6PwfiWJdD2
   A==;
X-CSE-ConnectionGUID: 9COdCwT0SUuenQKkWY8A+Q==
X-CSE-MsgGUID: t6ZQd+O1SU2ABBuYFJxYtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="94388273"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="94388273"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 12:27:16 -0700
X-CSE-ConnectionGUID: g+D+vISCQ324G6rHAgWN5w==
X-CSE-MsgGUID: jsk8Uy+3TOO2d77IsoYusA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="247270393"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 23 Jun 2026 12:27:14 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wc6m7-000000002qx-2h7o;
	Tue, 23 Jun 2026 19:27:11 +0000
Date: Wed, 24 Jun 2026 03:26:25 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 79c05bcda6f0a501699cc96052aa7edbc6928521
Message-ID: <202606240314.6fMylsOx-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3742-lists,linux-erofs=lfdr.de];
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
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,intel.com:from_mime,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4FE06B9B44

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 79c05bcda6f0a501699cc96052aa7edbc6928521  netfs,cachefiles: sunset ondemand mode

elapsed time: 918m

configs tested: 264
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260623    clang-23
arc                   randconfig-002-20260623    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                         assabet_defconfig    clang-22
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260623    clang-23
arm                   randconfig-002-20260623    clang-23
arm                   randconfig-003-20260623    clang-23
arm                   randconfig-004-20260623    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260623    clang-23
arm64                 randconfig-001-20260623    gcc-14.3.0
arm64                 randconfig-001-20260624    clang-21
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260623    clang-23
arm64                 randconfig-002-20260623    gcc-14.3.0
arm64                 randconfig-002-20260624    clang-21
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260623    clang-23
arm64                 randconfig-003-20260623    gcc-14.3.0
arm64                 randconfig-003-20260624    clang-21
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260623    clang-23
arm64                 randconfig-004-20260623    gcc-14.3.0
arm64                 randconfig-004-20260624    clang-21
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260623    clang-23
csky                  randconfig-001-20260623    gcc-14.3.0
csky                  randconfig-001-20260624    clang-21
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260623    clang-23
csky                  randconfig-002-20260623    gcc-14.3.0
csky                  randconfig-002-20260624    clang-21
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260623    clang-23
hexagon               randconfig-001-20260623    gcc-8.5.0
hexagon               randconfig-002-20260623    clang-18
hexagon               randconfig-002-20260623    gcc-8.5.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260623    gcc-14
i386        buildonly-randconfig-002-20260623    gcc-14
i386        buildonly-randconfig-003-20260623    gcc-14
i386        buildonly-randconfig-004-20260623    gcc-14
i386        buildonly-randconfig-005-20260623    gcc-14
i386        buildonly-randconfig-006-20260623    gcc-14
i386                                defconfig    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260623    clang-22
i386                  randconfig-002-20260623    clang-22
i386                  randconfig-003-20260623    clang-22
i386                  randconfig-004-20260623    clang-22
i386                  randconfig-005-20260623    clang-22
i386                  randconfig-006-20260623    clang-22
i386                  randconfig-007-20260623    clang-22
i386                  randconfig-011-20260623    gcc-14
i386                  randconfig-012-20260623    gcc-14
i386                  randconfig-013-20260623    gcc-14
i386                  randconfig-014-20260623    gcc-14
i386                  randconfig-015-20260623    gcc-14
i386                  randconfig-016-20260623    gcc-14
i386                  randconfig-017-20260623    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260623    gcc-14.3.0
loongarch             randconfig-001-20260623    gcc-8.5.0
loongarch             randconfig-002-20260623    gcc-16.1.0
loongarch             randconfig-002-20260623    gcc-8.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260623    gcc-8.5.0
nios2                 randconfig-002-20260623    gcc-8.5.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-11.5.0
parisc                randconfig-001-20260623    gcc-11.5.0
parisc                         randconfig-002    gcc-11.5.0
parisc                randconfig-002-20260623    gcc-11.5.0
parisc                randconfig-002-20260623    gcc-8.5.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                        randconfig-001    gcc-11.5.0
powerpc               randconfig-001-20260623    clang-23
powerpc               randconfig-001-20260623    gcc-11.5.0
powerpc                        randconfig-002    gcc-11.5.0
powerpc               randconfig-002-20260623    clang-23
powerpc               randconfig-002-20260623    gcc-11.5.0
powerpc64                      randconfig-001    gcc-11.5.0
powerpc64             randconfig-001-20260623    clang-23
powerpc64             randconfig-001-20260623    gcc-11.5.0
powerpc64                      randconfig-002    gcc-11.5.0
powerpc64             randconfig-002-20260623    gcc-11.5.0
powerpc64             randconfig-002-20260623    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-8.5.0
riscv                 randconfig-001-20260623    clang-23
riscv                 randconfig-001-20260623    gcc-8.5.0
riscv                          randconfig-002    gcc-8.5.0
riscv                 randconfig-002-20260623    gcc-8.5.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-8.5.0
s390                  randconfig-001-20260623    gcc-15.2.0
s390                  randconfig-001-20260623    gcc-8.5.0
s390                           randconfig-002    gcc-8.5.0
s390                  randconfig-002-20260623    clang-19
s390                  randconfig-002-20260623    gcc-8.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-8.5.0
sh                    randconfig-001-20260623    gcc-16.1.0
sh                    randconfig-001-20260623    gcc-8.5.0
sh                             randconfig-002    gcc-8.5.0
sh                    randconfig-002-20260623    gcc-16.1.0
sh                    randconfig-002-20260623    gcc-8.5.0
sh                           se7724_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-8.5.0
sparc                 randconfig-001-20260623    gcc-8.5.0
sparc                          randconfig-002    gcc-8.5.0
sparc                 randconfig-002-20260623    gcc-11.5.0
sparc                 randconfig-002-20260623    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260623    gcc-8.5.0
sparc64                        randconfig-002    gcc-8.5.0
sparc64               randconfig-002-20260623    clang-21
sparc64               randconfig-002-20260623    gcc-8.5.0
um                               allmodconfig    clang-17
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-8.5.0
um                    randconfig-001-20260623    clang-23
um                    randconfig-001-20260623    gcc-8.5.0
um                             randconfig-002    gcc-8.5.0
um                    randconfig-002-20260623    gcc-14
um                    randconfig-002-20260623    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260623    clang-22
x86_64      buildonly-randconfig-002-20260623    clang-22
x86_64      buildonly-randconfig-003-20260623    clang-22
x86_64      buildonly-randconfig-004-20260623    clang-22
x86_64      buildonly-randconfig-005-20260623    clang-22
x86_64      buildonly-randconfig-006-20260623    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260623    gcc-14
x86_64                randconfig-002-20260623    gcc-14
x86_64                randconfig-003-20260623    gcc-14
x86_64                randconfig-004-20260623    gcc-14
x86_64                randconfig-005-20260623    gcc-14
x86_64                randconfig-006-20260623    gcc-14
x86_64                randconfig-011-20260623    gcc-14
x86_64                randconfig-012-20260623    gcc-14
x86_64                randconfig-013-20260623    gcc-14
x86_64                randconfig-014-20260623    gcc-14
x86_64                randconfig-015-20260623    gcc-14
x86_64                randconfig-016-20260623    gcc-14
x86_64                         randconfig-071    gcc-14
x86_64                randconfig-071-20260623    gcc-14
x86_64                         randconfig-072    gcc-14
x86_64                randconfig-072-20260623    gcc-14
x86_64                         randconfig-073    gcc-14
x86_64                randconfig-073-20260623    gcc-14
x86_64                         randconfig-074    gcc-14
x86_64                randconfig-074-20260623    gcc-14
x86_64                         randconfig-075    gcc-14
x86_64                randconfig-075-20260623    gcc-14
x86_64                         randconfig-076    gcc-14
x86_64                randconfig-076-20260623    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260623    gcc-8.5.0
xtensa                         randconfig-002    gcc-8.5.0
xtensa                randconfig-002-20260623    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

