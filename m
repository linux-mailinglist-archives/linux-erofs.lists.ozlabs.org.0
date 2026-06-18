Return-Path: <linux-erofs+bounces-3668-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XwbIDRaiM2r+EQYAu9opvQ
	(envelope-from <linux-erofs+bounces-3668-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 09:45:26 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B02A69E2FC
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 09:45:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=L0F0CdLJ;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3668-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3668-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggt7603zYz2xM7;
	Thu, 18 Jun 2026 17:45:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781768721;
	cv=none; b=Eywi5DlDuLUB0pqflO1fGaisAMpV3+wabWV2C/+QROyFUV77+K+bL0GKr2Ic2PD5pFIZ5Cnk8WtEQBxEzF3SLSBdrMISqA+CJ3IoVGg8PgNuJtbTFSQGQJeUhTETwHczYMZugRi4cTn+iDlaSw+dwkNGDVnRqJ9ouinRBd6LA1E1/WZWVLGQ7BLViAtGH7yYi9BECmKvrepKN7eP5179RLNmsFhjFZS+3lyychKxtvXrubnsDsokKGQVLPkpnuMNuxSud2WmDqQMPVdet5sIPVkzWpC6zGBaqdQUO0pXgECNQ2clWdJ5osVC6TRKG6qtD9m+BkklYMjfK5O+i7GYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781768721; c=relaxed/relaxed;
	bh=Gq6G4Sod32/spPv0UkUYxCO1lHCblfbq9H5oZck3cjs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gt4c+avhIdocfR3qjeUavTv0VR5UNG6zpdvdvVcbyw96Gzge9uN4HR81gH34umWtJ57ThDaueiNEx3J0u9y8u0ih4BXjr5nh2B52kkVa8PVH7R2p029dOM/OAILeg77iafcr2pnaf1usDFYwWIpfgbK+tguvG3d6a+qnp5XYNMYCW6aneetg21jfOmyQW3GOavUfCoaXkYhsjxyl+d4WI7t/chEHYCoGjEyU6DrIITVGpK99/TQE5CaxZ4Oqzv4LbXZ44/TXsmPG/pEpat3VgaweT8APLgBGE8kJTPiNyK7NYX20X22+7zMCgKP2P6uj1DU6EIFhizyha0FYuMp26w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L0F0CdLJ; dkim-atps=neutral; spf=pass (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggt725Spzz2xC3
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jun 2026 17:45:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781768719; x=1813304719;
  h=date:from:to:cc:subject:message-id;
  bh=h2KSmVgyhQaalaIOpGat4PDSme4JrLGIuRF51p6anKo=;
  b=L0F0CdLJkl4fdWJ0vW+v7Fr/h2tvFQ3/XujL7iYeXsE2Yg8xsSAIlu61
   WBHatr9vzhzEk2L75w8k5uARGMocaBMDaQPBXBov9aIoJWcraU1t27E1d
   sJJ++mtXjvrs4NTv6HxVuOBcnd2hVDi64jD5rpFkcOFgnpDNJ9ci0GQMK
   9Y8QosoSV1MHrmmw+HIqCKrNuhW3MlBh76thbMcUpC536tZIuWp3wDoaI
   5SKRYKqX/Ca+eeXp82HBo/X2eTwPNqbLX4f1f6dWqsieNOZtjM6eDPAgj
   VquQcXEVyXb7mxM1h17lPtZ04HVyfsJr6CLfQeyHR/ANTXPsnWWv4J8If
   w==;
X-CSE-ConnectionGUID: KwuYjPkCRZeLhutuTqZcWw==
X-CSE-MsgGUID: E+lQnZRxQc+jrEHOZ616oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="86509932"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="86509932"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 00:45:12 -0700
X-CSE-ConnectionGUID: uIl0XrRuR6yVeuQ8iXNVPA==
X-CSE-MsgGUID: XZ264nabRlWk+Eq6bY9RIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="252191551"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 18 Jun 2026 00:45:11 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wa7Qx-00000000VLq-2MAC;
	Thu, 18 Jun 2026 07:45:07 +0000
Date: Thu, 18 Jun 2026 15:44:38 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 99980e9a7eca5ba3f4a2892acb0ccdcc7fe1dd8f
Message-ID: <202606181527.7TvNOB2e-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3668-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: 7B02A69E2FC

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 99980e9a7eca5ba3f4a2892acb0ccdcc7fe1dd8f  erofs: introduce erofs_map_chunks()

elapsed time: 1266m

configs tested: 303
configs skipped: 14

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
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-16.1.0
arc                   randconfig-001-20260617    gcc-16.1.0
arc                   randconfig-001-20260618    gcc-15.2.0
arc                            randconfig-002    gcc-16.1.0
arc                   randconfig-002-20260617    gcc-16.1.0
arc                   randconfig-002-20260618    gcc-15.2.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                       multi_v4t_defconfig    clang-19
arm                          pxa3xx_defconfig    clang-17
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260617    gcc-16.1.0
arm                   randconfig-001-20260618    gcc-15.2.0
arm                            randconfig-002    gcc-16.1.0
arm                   randconfig-002-20260617    gcc-16.1.0
arm                   randconfig-002-20260618    gcc-15.2.0
arm                            randconfig-003    gcc-16.1.0
arm                   randconfig-003-20260617    gcc-16.1.0
arm                   randconfig-003-20260618    gcc-15.2.0
arm                            randconfig-004    gcc-16.1.0
arm                   randconfig-004-20260617    gcc-16.1.0
arm                   randconfig-004-20260618    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    gcc-15.2.0
arm64                 randconfig-001-20260617    gcc-12.5.0
arm64                 randconfig-001-20260618    gcc-15.2.0
arm64                          randconfig-002    gcc-15.2.0
arm64                 randconfig-002-20260617    gcc-12.5.0
arm64                 randconfig-002-20260618    gcc-15.2.0
arm64                          randconfig-003    gcc-15.2.0
arm64                 randconfig-003-20260617    gcc-12.5.0
arm64                 randconfig-003-20260618    gcc-15.2.0
arm64                          randconfig-004    gcc-15.2.0
arm64                 randconfig-004-20260617    gcc-12.5.0
arm64                 randconfig-004-20260618    gcc-15.2.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    gcc-15.2.0
csky                  randconfig-001-20260617    gcc-12.5.0
csky                  randconfig-001-20260618    gcc-15.2.0
csky                           randconfig-002    gcc-15.2.0
csky                  randconfig-002-20260617    gcc-12.5.0
csky                  randconfig-002-20260618    gcc-15.2.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260617    clang-17
hexagon               randconfig-001-20260618    clang-23
hexagon               randconfig-002-20260617    clang-17
hexagon               randconfig-002-20260618    clang-23
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260617    gcc-14
i386        buildonly-randconfig-001-20260618    gcc-14
i386        buildonly-randconfig-002-20260617    gcc-14
i386        buildonly-randconfig-002-20260618    gcc-14
i386        buildonly-randconfig-003-20260617    gcc-14
i386        buildonly-randconfig-003-20260618    gcc-14
i386        buildonly-randconfig-004-20260617    gcc-14
i386        buildonly-randconfig-004-20260618    gcc-14
i386        buildonly-randconfig-005-20260617    gcc-14
i386        buildonly-randconfig-005-20260618    gcc-14
i386        buildonly-randconfig-006-20260617    gcc-14
i386        buildonly-randconfig-006-20260618    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260617    gcc-13
i386                  randconfig-001-20260618    clang-22
i386                  randconfig-002-20260617    gcc-13
i386                  randconfig-002-20260618    clang-22
i386                  randconfig-003-20260617    gcc-13
i386                  randconfig-003-20260618    clang-22
i386                  randconfig-004-20260617    gcc-13
i386                  randconfig-004-20260618    clang-22
i386                  randconfig-005-20260617    gcc-13
i386                  randconfig-005-20260618    clang-22
i386                  randconfig-006-20260617    gcc-13
i386                  randconfig-006-20260618    clang-22
i386                  randconfig-007-20260617    gcc-13
i386                  randconfig-007-20260618    clang-22
i386                  randconfig-011-20260617    clang-22
i386                  randconfig-011-20260618    clang-22
i386                  randconfig-012-20260617    clang-22
i386                  randconfig-012-20260618    clang-22
i386                  randconfig-013-20260617    clang-22
i386                  randconfig-013-20260618    clang-22
i386                  randconfig-014-20260617    clang-22
i386                  randconfig-014-20260618    clang-22
i386                  randconfig-015-20260617    clang-22
i386                  randconfig-015-20260618    clang-22
i386                  randconfig-016-20260617    clang-22
i386                  randconfig-016-20260618    clang-22
i386                  randconfig-017-20260617    clang-22
i386                  randconfig-017-20260618    clang-22
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260617    clang-17
loongarch             randconfig-001-20260618    clang-23
loongarch             randconfig-002-20260617    clang-17
loongarch             randconfig-002-20260618    clang-23
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
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260617    clang-17
nios2                 randconfig-001-20260618    clang-23
nios2                 randconfig-002-20260617    clang-17
nios2                 randconfig-002-20260618    clang-23
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc         de0_nano_multicore_defconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    clang-23
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260617    gcc-15.2.0
parisc                randconfig-001-20260618    gcc-16.1.0
parisc                randconfig-002-20260617    gcc-15.2.0
parisc                randconfig-002-20260618    gcc-16.1.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                          g5_defconfig    gcc-16.1.0
powerpc               randconfig-001-20260617    gcc-15.2.0
powerpc               randconfig-001-20260618    gcc-16.1.0
powerpc               randconfig-002-20260617    gcc-15.2.0
powerpc               randconfig-002-20260618    gcc-16.1.0
powerpc64             randconfig-001-20260617    gcc-15.2.0
powerpc64             randconfig-001-20260618    gcc-16.1.0
powerpc64             randconfig-002-20260617    gcc-15.2.0
powerpc64             randconfig-002-20260618    gcc-16.1.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-16.1.0
riscv                 randconfig-001-20260617    gcc-16.1.0
riscv                 randconfig-001-20260618    gcc-13.4.0
riscv                          randconfig-002    gcc-16.1.0
riscv                 randconfig-002-20260617    gcc-16.1.0
riscv                 randconfig-002-20260618    gcc-13.4.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-16.1.0
s390                  randconfig-001-20260617    gcc-16.1.0
s390                  randconfig-001-20260618    gcc-13.4.0
s390                           randconfig-002    gcc-16.1.0
s390                  randconfig-002-20260617    gcc-16.1.0
s390                  randconfig-002-20260618    gcc-13.4.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                               allyesconfig    clang-23
sh                         ap325rxa_defconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-16.1.0
sh                    randconfig-001-20260617    gcc-16.1.0
sh                    randconfig-001-20260618    gcc-13.4.0
sh                             randconfig-002    gcc-16.1.0
sh                    randconfig-002-20260617    gcc-16.1.0
sh                    randconfig-002-20260618    gcc-13.4.0
sh                           se7619_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260617    gcc-16.1.0
sparc                 randconfig-001-20260618    gcc-14.3.0
sparc                 randconfig-002-20260617    gcc-16.1.0
sparc                 randconfig-002-20260618    gcc-14.3.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260617    gcc-16.1.0
sparc64               randconfig-001-20260618    gcc-14.3.0
sparc64               randconfig-002-20260617    gcc-16.1.0
sparc64               randconfig-002-20260618    gcc-14.3.0
um                               allmodconfig    clang-17
um                               allmodconfig    clang-23
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260617    gcc-16.1.0
um                    randconfig-001-20260618    gcc-14.3.0
um                    randconfig-002-20260617    gcc-16.1.0
um                    randconfig-002-20260618    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    clang-22
x86_64      buildonly-randconfig-001-20260617    clang-22
x86_64      buildonly-randconfig-001-20260618    clang-22
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260617    clang-22
x86_64      buildonly-randconfig-002-20260618    clang-22
x86_64               buildonly-randconfig-003    clang-22
x86_64      buildonly-randconfig-003-20260617    clang-22
x86_64      buildonly-randconfig-003-20260618    clang-22
x86_64               buildonly-randconfig-004    clang-22
x86_64      buildonly-randconfig-004-20260617    clang-22
x86_64      buildonly-randconfig-004-20260618    clang-22
x86_64               buildonly-randconfig-005    clang-22
x86_64      buildonly-randconfig-005-20260617    clang-22
x86_64      buildonly-randconfig-005-20260618    clang-22
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260617    clang-22
x86_64      buildonly-randconfig-006-20260618    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    clang-22
x86_64                randconfig-001-20260617    clang-22
x86_64                randconfig-001-20260618    clang-22
x86_64                         randconfig-002    clang-22
x86_64                randconfig-002-20260617    clang-22
x86_64                randconfig-002-20260618    clang-22
x86_64                         randconfig-003    clang-22
x86_64                randconfig-003-20260617    clang-22
x86_64                randconfig-003-20260618    clang-22
x86_64                         randconfig-004    clang-22
x86_64                randconfig-004-20260617    clang-22
x86_64                randconfig-004-20260618    clang-22
x86_64                         randconfig-005    clang-22
x86_64                randconfig-005-20260617    clang-22
x86_64                randconfig-005-20260618    clang-22
x86_64                         randconfig-006    clang-22
x86_64                randconfig-006-20260617    clang-22
x86_64                randconfig-006-20260618    clang-22
x86_64                randconfig-011-20260617    clang-22
x86_64                randconfig-011-20260618    gcc-14
x86_64                randconfig-012-20260617    clang-22
x86_64                randconfig-012-20260618    gcc-14
x86_64                randconfig-013-20260617    clang-22
x86_64                randconfig-013-20260618    gcc-14
x86_64                randconfig-014-20260617    clang-22
x86_64                randconfig-014-20260618    gcc-14
x86_64                randconfig-015-20260617    clang-22
x86_64                randconfig-015-20260618    gcc-14
x86_64                randconfig-016-20260617    clang-22
x86_64                randconfig-016-20260618    gcc-14
x86_64                         randconfig-071    gcc-13
x86_64                randconfig-071-20260617    gcc-13
x86_64                randconfig-071-20260618    clang-22
x86_64                         randconfig-072    gcc-13
x86_64                randconfig-072-20260617    gcc-13
x86_64                randconfig-072-20260618    clang-22
x86_64                         randconfig-073    gcc-13
x86_64                randconfig-073-20260617    gcc-13
x86_64                randconfig-073-20260618    clang-22
x86_64                         randconfig-074    gcc-13
x86_64                randconfig-074-20260617    gcc-13
x86_64                randconfig-074-20260618    clang-22
x86_64                         randconfig-075    gcc-13
x86_64                randconfig-075-20260617    gcc-13
x86_64                randconfig-075-20260618    clang-22
x86_64                         randconfig-076    gcc-13
x86_64                randconfig-076-20260617    gcc-13
x86_64                randconfig-076-20260618    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260617    gcc-16.1.0
xtensa                randconfig-001-20260618    gcc-14.3.0
xtensa                randconfig-002-20260617    gcc-16.1.0
xtensa                randconfig-002-20260618    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

