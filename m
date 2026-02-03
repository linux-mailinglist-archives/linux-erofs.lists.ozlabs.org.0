Return-Path: <linux-erofs+bounces-2254-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGzYLF6HgmnDVwMAu9opvQ
	(envelope-from <linux-erofs+bounces-2254-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Feb 2026 00:40:14 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEE6DFCBE
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Feb 2026 00:40:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5Kj43B6Pz2yFQ;
	Wed, 04 Feb 2026 10:40:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770162008;
	cv=none; b=TfDEuu5lXp8aLpmANBSvHEoBrQnLeONw4JkkFnmUxGWya/CKIaV2MUxU22cU98ntpp3yaBmR1KAOT1IGvUJPu2SyRdT4rTaQUaECl+e8g+8zsn/QzdojBSvvsmWGFISN/l3sccv1pamNLpUzQF4SchN5vKoUB076CILoIAoI1dFkqpRGSGbOPvH/8xKSEn4izD5gnJaW1s2dtbKTyENL/hbIsp5f5+midie9hyqUxXgW3tZQhk4s2S3aJc+TAq8vNMboTRfPUEwXE2aaZT1RnMFxD4j9zLrhf2eK9kCdErJNZ3z6TpQ3w/q2BJjL36kY95/3d5SUPh/Nj0hGkCafRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770162008; c=relaxed/relaxed;
	bh=yQ21JqtuEX/Cm6Sf06Kd0CTvX41P55rbfJ2w5cQZOlg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bMdQUhCMfd36Dd4NXFZBLxd4iINjoKXQ+KAKEWSNcUz4oafg3W7MTqBXBIfn/w/ophWwPbk9DAbRzMdk05Ld51aW1kpagaqPXqtG4Xky4EbbJAVA8aN8ikGQCiMCHKc3CNgeB9OUkNdRVeCIHrpBt/zM3dtcynvUVzx7HowmQiIppkQRkliNz0aB5Me4J874mPCjH44zLOMNTVe/4kz+/U4xzo71w2qN61tAiG2JlDSKfRVvW1PjD89dWy5PX52QOHSAWWD6jWS0Dal47iUkbYzO9dNfKR+Tx0HwQkASbQYeBcgSBCO1j8VjgmIGPWoknKTvn22vE3JBDANJbCQrQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GJBUoPOT; dkim-atps=neutral; spf=pass (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GJBUoPOT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f5Kj12SB1z2xs4
	for <linux-erofs@lists.ozlabs.org>; Wed, 04 Feb 2026 10:40:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770162005; x=1801698005;
  h=date:from:to:cc:subject:message-id;
  bh=rgym6hfhKgelQYprVzMPRaoXQfLYwfWAtV7K5pXC9p0=;
  b=GJBUoPOTfxe4w4TH8uDkR0LoY4eoEuEch4bKeI1jfUY9edvH14hW94AL
   TKTDyr06q6Ukvgh1OLL/itvy2l+cx4DYt6TCcD8uogQu15kTeLJOZF3Cf
   EkXX4xgUsgD/vLOb17mrTJjkrQ1I6Kig6vsdKTTLV4Ajsf89i13f+pNNW
   J9jC2VJKCAWG9z+za0FT3+BSH588iscogoMrKS+uy/bVeuLedYAlBBhhG
   LbBR3n8HXXOvDLJqG1Y3uLNMiTmmwov2t72rCViY+DDZ9xMc+kIrPIalB
   twqOxt8u3bJ+nHPGP9CslXACnXsUCXMVwGFLfHH90NNX4gRVHTPHb6nOT
   g==;
X-CSE-ConnectionGUID: 2RcH7pANTvqeWDbMFfte3A==
X-CSE-MsgGUID: BYgzBwIhRRuPtKz3EnDtxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="70365040"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="70365040"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 15:39:59 -0800
X-CSE-ConnectionGUID: lvjksvrxRMqPBdL2rkEcVw==
X-CSE-MsgGUID: 77hoL2aBSjWu3rwwHvCRiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="240672080"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Feb 2026 15:39:58 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnPzv-00000000hIq-2m2e;
	Tue, 03 Feb 2026 23:39:55 +0000
Date: Wed, 04 Feb 2026 07:39:50 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 3f17452cbcfafbc67e4c351ab5ff89b9cd20d85f
Message-ID: <202602040742.AwGQ0V8C-lkp@intel.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2254-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 9DEE6DFCBE
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 3f17452cbcfafbc67e4c351ab5ff89b9cd20d85f  erofs: fix inline data read failure for ztailpacking pclusters

elapsed time: 874m

configs tested: 297
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                          axs103_defconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260203    gcc-12.5.0
arc                   randconfig-001-20260203    gcc-8.5.0
arc                   randconfig-001-20260204    gcc-8.5.0
arc                   randconfig-002-20260203    gcc-12.5.0
arc                   randconfig-002-20260204    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                          moxart_defconfig    clang-22
arm                   randconfig-001-20260203    gcc-12.5.0
arm                   randconfig-001-20260203    gcc-8.5.0
arm                   randconfig-001-20260204    gcc-8.5.0
arm                   randconfig-002-20260203    clang-18
arm                   randconfig-002-20260203    gcc-12.5.0
arm                   randconfig-002-20260204    gcc-8.5.0
arm                   randconfig-003-20260203    gcc-10.5.0
arm                   randconfig-003-20260203    gcc-12.5.0
arm                   randconfig-003-20260204    gcc-8.5.0
arm                   randconfig-004-20260203    clang-16
arm                   randconfig-004-20260203    gcc-12.5.0
arm                   randconfig-004-20260204    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260203    gcc-9.5.0
arm64                 randconfig-001-20260204    gcc-11.5.0
arm64                 randconfig-002-20260203    gcc-12.5.0
arm64                 randconfig-002-20260204    gcc-11.5.0
arm64                 randconfig-003-20260203    clang-22
arm64                 randconfig-003-20260204    gcc-11.5.0
arm64                 randconfig-004-20260203    clang-22
arm64                 randconfig-004-20260204    gcc-11.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260203    gcc-15.2.0
csky                  randconfig-001-20260204    gcc-11.5.0
csky                  randconfig-002-20260203    gcc-15.2.0
csky                  randconfig-002-20260204    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260203    clang-22
hexagon               randconfig-001-20260204    gcc-15.2.0
hexagon               randconfig-002-20260203    clang-22
hexagon               randconfig-002-20260204    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260203    gcc-14
i386        buildonly-randconfig-002-20260203    gcc-13
i386        buildonly-randconfig-003-20260203    clang-20
i386        buildonly-randconfig-004-20260203    clang-20
i386        buildonly-randconfig-005-20260203    clang-20
i386        buildonly-randconfig-006-20260203    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260203    clang-20
i386                  randconfig-001-20260204    gcc-14
i386                  randconfig-002-20260203    clang-20
i386                  randconfig-002-20260204    gcc-14
i386                  randconfig-003-20260203    clang-20
i386                  randconfig-003-20260204    gcc-14
i386                  randconfig-004-20260203    clang-20
i386                  randconfig-004-20260204    gcc-14
i386                  randconfig-005-20260203    gcc-14
i386                  randconfig-005-20260204    gcc-14
i386                  randconfig-006-20260203    clang-20
i386                  randconfig-006-20260204    gcc-14
i386                  randconfig-007-20260203    gcc-14
i386                  randconfig-007-20260204    gcc-14
i386                  randconfig-011-20260203    gcc-12
i386                  randconfig-011-20260203    gcc-14
i386                  randconfig-012-20260203    clang-20
i386                  randconfig-012-20260203    gcc-14
i386                  randconfig-013-20260203    clang-20
i386                  randconfig-013-20260203    gcc-14
i386                  randconfig-014-20260203    gcc-14
i386                  randconfig-015-20260203    clang-20
i386                  randconfig-015-20260203    gcc-14
i386                  randconfig-016-20260203    gcc-14
i386                  randconfig-017-20260203    clang-20
i386                  randconfig-017-20260203    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260203    clang-20
loongarch             randconfig-001-20260204    gcc-15.2.0
loongarch             randconfig-002-20260203    clang-22
loongarch             randconfig-002-20260204    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                            gpr_defconfig    clang-22
mips                        vocore2_defconfig    clang-22
nios2                         10m50_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260203    gcc-8.5.0
nios2                 randconfig-001-20260204    gcc-15.2.0
nios2                 randconfig-002-20260203    gcc-8.5.0
nios2                 randconfig-002-20260204    gcc-15.2.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260203    gcc-12.5.0
parisc                randconfig-001-20260204    gcc-8.5.0
parisc                randconfig-002-20260203    gcc-8.5.0
parisc                randconfig-002-20260204    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                     kmeter1_defconfig    clang-22
powerpc               randconfig-001-20260203    clang-22
powerpc               randconfig-001-20260204    gcc-8.5.0
powerpc               randconfig-002-20260203    gcc-10.5.0
powerpc               randconfig-002-20260204    gcc-8.5.0
powerpc64             randconfig-001-20260203    clang-16
powerpc64             randconfig-001-20260204    gcc-8.5.0
powerpc64             randconfig-002-20260203    gcc-8.5.0
powerpc64             randconfig-002-20260204    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv             nommu_k210_sdcard_defconfig    clang-22
riscv                 randconfig-001-20260203    clang-22
riscv                 randconfig-001-20260203    gcc-8.5.0
riscv                 randconfig-001-20260204    gcc-8.5.0
riscv                 randconfig-002-20260203    clang-22
riscv                 randconfig-002-20260203    gcc-8.5.0
riscv                 randconfig-002-20260204    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260203    gcc-8.5.0
s390                  randconfig-001-20260204    gcc-8.5.0
s390                  randconfig-002-20260203    clang-22
s390                  randconfig-002-20260203    gcc-8.5.0
s390                  randconfig-002-20260204    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260203    gcc-15.2.0
sh                    randconfig-001-20260203    gcc-8.5.0
sh                    randconfig-001-20260204    gcc-8.5.0
sh                    randconfig-002-20260203    gcc-15.2.0
sh                    randconfig-002-20260203    gcc-8.5.0
sh                    randconfig-002-20260204    gcc-8.5.0
sh                          rsk7201_defconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260203    gcc-8.5.0
sparc                 randconfig-001-20260204    gcc-8.5.0
sparc                 randconfig-002-20260203    gcc-13.4.0
sparc                 randconfig-002-20260204    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260203    clang-22
sparc64               randconfig-001-20260204    gcc-8.5.0
sparc64               randconfig-002-20260203    clang-22
sparc64               randconfig-002-20260204    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260203    clang-22
um                    randconfig-001-20260204    gcc-8.5.0
um                    randconfig-002-20260203    clang-20
um                    randconfig-002-20260204    gcc-8.5.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260203    clang-20
x86_64      buildonly-randconfig-002-20260203    clang-20
x86_64      buildonly-randconfig-003-20260203    clang-20
x86_64      buildonly-randconfig-004-20260203    clang-20
x86_64      buildonly-randconfig-004-20260203    gcc-14
x86_64      buildonly-randconfig-005-20260203    clang-20
x86_64      buildonly-randconfig-005-20260203    gcc-13
x86_64      buildonly-randconfig-006-20260203    clang-20
x86_64      buildonly-randconfig-006-20260203    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260203    clang-20
x86_64                randconfig-001-20260204    gcc-14
x86_64                randconfig-002-20260203    gcc-14
x86_64                randconfig-002-20260204    gcc-14
x86_64                randconfig-003-20260203    clang-20
x86_64                randconfig-003-20260204    gcc-14
x86_64                randconfig-004-20260203    gcc-14
x86_64                randconfig-004-20260204    gcc-14
x86_64                randconfig-005-20260203    gcc-12
x86_64                randconfig-005-20260204    gcc-14
x86_64                randconfig-006-20260203    gcc-14
x86_64                randconfig-006-20260204    gcc-14
x86_64                randconfig-011-20260203    gcc-14
x86_64                randconfig-011-20260204    clang-20
x86_64                randconfig-012-20260203    clang-20
x86_64                randconfig-012-20260204    clang-20
x86_64                randconfig-013-20260203    gcc-14
x86_64                randconfig-013-20260204    clang-20
x86_64                randconfig-014-20260203    gcc-14
x86_64                randconfig-014-20260204    clang-20
x86_64                randconfig-015-20260203    gcc-14
x86_64                randconfig-015-20260204    clang-20
x86_64                randconfig-016-20260203    clang-20
x86_64                randconfig-016-20260204    clang-20
x86_64                randconfig-071-20260203    clang-20
x86_64                randconfig-071-20260204    gcc-14
x86_64                randconfig-072-20260203    gcc-13
x86_64                randconfig-072-20260204    gcc-14
x86_64                randconfig-073-20260203    gcc-14
x86_64                randconfig-073-20260204    gcc-14
x86_64                randconfig-074-20260203    gcc-14
x86_64                randconfig-074-20260204    gcc-14
x86_64                randconfig-075-20260203    gcc-13
x86_64                randconfig-075-20260204    gcc-14
x86_64                randconfig-076-20260203    gcc-14
x86_64                randconfig-076-20260204    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20260203    gcc-14.3.0
xtensa                randconfig-001-20260204    gcc-8.5.0
xtensa                randconfig-002-20260203    gcc-13.4.0
xtensa                randconfig-002-20260204    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

