Return-Path: <linux-erofs+bounces-2324-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9E5EIjr1k2lM+AEAu9opvQ
	(envelope-from <linux-erofs+bounces-2324-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Feb 2026 05:57:30 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0F6148BE3
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Feb 2026 05:57:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fFS783gZtz2xjP;
	Tue, 17 Feb 2026 15:57:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771304244;
	cv=none; b=nZHnPTwScYLiih02AwC37lrHLiWt76WyFRXbZSNqFUcc9ZQLBe4Ta3tZtx9s0npAIDpQ8V/zKodGX26g4MU9vQRdVnGVJMfAXzNPk8rtrz6H2QckjGJ69Pp40IzExMP6e9wIXOzkGwtmgBqmVglfhpg2W6kTGTD1lMI0Cv9ZnofeF3ND4KU1DqCURO8VrYiqSWHVgdJOg9Vs2HPkXfqUrE5Yz20Kv5BFERW5l1SmDO29rB1Y7PZMrJoHx8qsdLRZqaYJDgs3csPg5X9sFHObZeVQalAzOf8PaKdyPYMfU8B+zh6MPtHZO9fcpvrnG/3tThwN3dKK43P9bGPDPkxvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771304244; c=relaxed/relaxed;
	bh=ucfgYnTdf2fD+GZOecGy2rXiLtBTa6sWUTKlw2IpCVk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Q8C5id/bQwZ95ssLdzxQzgNInngJj8acr43xNIXGjdlC4z/vzz5gG7tWq6NBo2kbbibMcoDh63eA/2ZcDUPR1v3Z0VkVpUJ8TlIY6OmrKZ3KDAu7/FR3Bd0RBhSJ3ig3lhEgcS5NN5vOZxI66J9lVlfJya+x3H7jR/v72yBaqNtNo/4g2TdFjhncxLQKHMfnM6dy93MHf+YY23jRPWUGISRxkjgiV7mM1XDHyhqSMYNMt6TpSS32gcfKqLgg5vqj2iXiELF61zSvP+HaBHIH1c1RM5wABNErD/i+Fo3IsqZMBv2JAyNvoZX2ANcG+m4B+fthW/pNRqQgYYWrfn5CiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jraxLeyi; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jraxLeyi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fFS7564cZz2xN5
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Feb 2026 15:57:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771304242; x=1802840242;
  h=date:from:to:cc:subject:message-id;
  bh=97Bg8Wzn+4ENn1JcfVanruRzTPfk8UIdRq9+LIRfTBs=;
  b=jraxLeyiJFQZ2N0PdCQ+3m1hfXpXKGfacp123zi1cB2hj/N78alCPnQW
   RDE2YU8tUkbE9TWQgSZNsmSmw3GFb3C19F7lCa1BnmLjNWG9E1AcrGBiY
   NPMinqYI2q5y77VVgsyDY2M9YUhTNDw5nWO0yh4e4/yA6d15EtmXVRcaX
   9mWsnJXqck3tGfUr7/ZLPxYeaUWz1FvqxB+ysODWqL1XspoJx3msQoyDj
   WCQfqe7fm1P4CYZ4ZMjcOTjnC9yz6jTL84g27yWkZi2T0C/W1qemJ8jb4
   +poqdk3ZJkBNkEBptgMFoaxWDUTgL79zak/fTIwSdX56dzXTzFKuW7lMt
   w==;
X-CSE-ConnectionGUID: OGnQ/xIXQCmpWIUOuhHpdA==
X-CSE-MsgGUID: U7JEPC3LQTCIA+FcZmaxog==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="97832618"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="97832618"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 20:57:15 -0800
X-CSE-ConnectionGUID: tyYRvYRwR8+sydgru5d21A==
X-CSE-MsgGUID: BmdWyvZ2Qka4q0/6svu4Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="218310521"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 16 Feb 2026 20:57:13 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vsD95-000000010cd-2JAb;
	Tue, 17 Feb 2026 04:57:11 +0000
Date: Tue, 17 Feb 2026 12:56:45 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 4423ffceceae1caefc3dbb40431015fcbf08cce9
Message-ID: <202602171237.u21m8ljt-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2324-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: DA0F6148BE3
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 4423ffceceae1caefc3dbb40431015fcbf08cce9  erofs: allow sharing page cache with the same aops only

elapsed time: 813m

configs tested: 241
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                        nsimosci_defconfig    gcc-15.2.0
arc                   randconfig-001-20260217    gcc-11.5.0
arc                   randconfig-002-20260217    gcc-11.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         at91_dt_defconfig    gcc-15.2.0
arm                         bcm2835_defconfig    gcc-15.2.0
arm                        clps711x_defconfig    clang-23
arm                          collie_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          exynos_defconfig    clang-23
arm                           h3600_defconfig    gcc-14
arm                        keystone_defconfig    gcc-14
arm                            mps2_defconfig    clang-23
arm                        multi_v7_defconfig    clang-23
arm                          pxa3xx_defconfig    gcc-15.2.0
arm                   randconfig-001-20260217    gcc-11.5.0
arm                   randconfig-002-20260217    gcc-11.5.0
arm                   randconfig-003-20260217    gcc-11.5.0
arm                   randconfig-004-20260217    gcc-11.5.0
arm                           sama5_defconfig    gcc-15.2.0
arm                        spear6xx_defconfig    gcc-15.2.0
arm                           spitz_defconfig    gcc-15.2.0
arm                           u8500_defconfig    clang-23
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260217    clang-23
arm64                 randconfig-002-20260217    clang-23
arm64                 randconfig-003-20260217    clang-23
arm64                 randconfig-004-20260217    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260217    clang-23
csky                  randconfig-002-20260217    clang-23
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260217    clang-23
hexagon               randconfig-002-20260217    clang-23
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260217    clang-20
i386        buildonly-randconfig-002-20260217    clang-20
i386        buildonly-randconfig-003-20260217    clang-20
i386        buildonly-randconfig-004-20260217    clang-20
i386        buildonly-randconfig-005-20260217    clang-20
i386        buildonly-randconfig-006-20260217    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260217    gcc-14
i386                  randconfig-002-20260217    gcc-14
i386                  randconfig-003-20260217    gcc-14
i386                  randconfig-004-20260217    gcc-14
i386                  randconfig-005-20260217    gcc-14
i386                  randconfig-006-20260217    gcc-14
i386                  randconfig-007-20260217    gcc-14
i386                  randconfig-011-20260217    clang-20
i386                  randconfig-012-20260217    clang-20
i386                  randconfig-013-20260217    clang-20
i386                  randconfig-014-20260217    clang-20
i386                  randconfig-015-20260217    clang-20
i386                  randconfig-016-20260217    clang-20
i386                  randconfig-017-20260217    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260217    clang-23
loongarch             randconfig-002-20260217    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         apollo_defconfig    clang-23
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-15.2.0
m68k                        m5307c3_defconfig    clang-23
m68k                        mvme16x_defconfig    gcc-15.2.0
m68k                           virt_defconfig    gcc-15.2.0
microblaze                       alldefconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath79_defconfig    gcc-14
mips                 decstation_r4k_defconfig    clang-23
mips                          eyeq6_defconfig    clang-23
mips                           ip28_defconfig    gcc-15.2.0
mips                      malta_kvm_defconfig    gcc-15.2.0
mips                        qi_lb60_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260217    clang-23
nios2                 randconfig-002-20260217    clang-23
openrisc                         alldefconfig    clang-23
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                generic-64bit_defconfig    gcc-15.2.0
parisc                randconfig-001-20260217    clang-19
parisc                randconfig-002-20260217    clang-19
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      arches_defconfig    gcc-15.2.0
powerpc                   currituck_defconfig    gcc-15.2.0
powerpc                    ge_imp3a_defconfig    gcc-15.2.0
powerpc                       holly_defconfig    clang-23
powerpc                    mvme5100_defconfig    gcc-15.2.0
powerpc                      pasemi_defconfig    clang-23
powerpc                      ppc6xx_defconfig    clang-23
powerpc               randconfig-001-20260217    clang-19
powerpc               randconfig-002-20260217    clang-19
powerpc                    sam440ep_defconfig    gcc-15.2.0
powerpc                     stx_gp3_defconfig    clang-23
powerpc                     taishan_defconfig    clang-23
powerpc                         wii_defconfig    clang-23
powerpc                 xes_mpc85xx_defconfig    clang-23
powerpc                 xes_mpc85xx_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260217    clang-19
powerpc64             randconfig-002-20260217    clang-19
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_k210_defconfig    gcc-15.2.0
riscv                    nommu_virt_defconfig    gcc-14
riscv                 randconfig-001-20260217    gcc-10.5.0
riscv                 randconfig-002-20260217    gcc-10.5.0
s390                             alldefconfig    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260217    gcc-10.5.0
s390                  randconfig-002-20260217    gcc-10.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                        edosk7705_defconfig    gcc-15.2.0
sh                            hp6xx_defconfig    gcc-14
sh                    randconfig-001-20260217    gcc-10.5.0
sh                    randconfig-002-20260217    gcc-10.5.0
sh                          rsk7264_defconfig    gcc-14
sh                           se7724_defconfig    clang-23
sh                        sh7763rdp_defconfig    clang-23
sh                        sh7785lcr_defconfig    gcc-15.2.0
sh                          urquell_defconfig    gcc-15.2.0
sparc                            alldefconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260217    gcc-12.5.0
sparc                 randconfig-002-20260217    gcc-12.5.0
sparc64                          alldefconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260217    gcc-12.5.0
sparc64               randconfig-002-20260217    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             i386_defconfig    gcc-15.2.0
um                    randconfig-001-20260217    gcc-12.5.0
um                    randconfig-002-20260217    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           alldefconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260217    gcc-14
x86_64      buildonly-randconfig-002-20260217    gcc-14
x86_64      buildonly-randconfig-003-20260217    gcc-14
x86_64      buildonly-randconfig-004-20260217    gcc-14
x86_64      buildonly-randconfig-005-20260217    gcc-14
x86_64      buildonly-randconfig-006-20260217    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260217    clang-20
x86_64                randconfig-002-20260217    clang-20
x86_64                randconfig-003-20260217    clang-20
x86_64                randconfig-004-20260217    clang-20
x86_64                randconfig-005-20260217    clang-20
x86_64                randconfig-006-20260217    clang-20
x86_64                randconfig-011-20260217    gcc-14
x86_64                randconfig-012-20260217    gcc-14
x86_64                randconfig-013-20260217    gcc-14
x86_64                randconfig-014-20260217    gcc-14
x86_64                randconfig-015-20260217    gcc-14
x86_64                randconfig-016-20260217    gcc-14
x86_64                randconfig-071-20260217    gcc-14
x86_64                randconfig-072-20260217    gcc-14
x86_64                randconfig-073-20260217    gcc-14
x86_64                randconfig-074-20260217    gcc-14
x86_64                randconfig-075-20260217    gcc-14
x86_64                randconfig-076-20260217    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260217    gcc-12.5.0
xtensa                randconfig-002-20260217    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

