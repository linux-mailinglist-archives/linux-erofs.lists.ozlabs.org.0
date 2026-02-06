Return-Path: <linux-erofs+bounces-2277-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J54KbVwhmkYNQQAu9opvQ
	(envelope-from <linux-erofs+bounces-2277-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Feb 2026 23:52:37 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DB2103F73
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Feb 2026 23:52:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f78Vn3PSTz2xpg;
	Sat, 07 Feb 2026 09:52:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770418353;
	cv=none; b=mazvwtyV7lx5EaSxxfvnSo8YY31ww/RUwHYgAVDabwWZJFMVbj/FItjnrHnbVwtxRu8EFklnx17zBWAGJ1fnRsHgyBQ+OjKTxjHO3tNC+5xj4FQdiMgslmFfloKAwvGfTUb2rktgyt2FC9smTrveIFcGx84SkADThsAYYs2rpqZCgcQ1bi7I0Yt2jSks7wRVzcOcFklAH7pMNR3pkgAiXRxE4J9aq2b1cwmx/HT/+63MDH4u5sKmSRN5XRGOooITef0cZQJCwiA0xa2mwDgAGv25RhM/CbijE3EipbHYFIjNgwdpNkCszfp9q2b1lpaYWWJRnhDGKE0nqOh15blYuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770418353; c=relaxed/relaxed;
	bh=XaSWKJBRMgZeeMQTTbHTPKX0Rp3cHOSN3l9HIFXDDjg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iK8QqI5vzzyPdq4g3xPSeA1CsRlf0Z1XWjzWm/Fkk57ga9xqLNQ6k4h9H+/SAke7Kd0FP+G0aYvSBcfeD8RgzroKlqH80uM7moOEqbjrwIDXIIlWYu6gipnG9inK8CfH9f+8jAen9HE12Cev/UQRfh67RA5bJbHjZQoNepVYf1E5nKKWZs/OTBoL6Q4koTf6x+HTX8GPBdfbTRCXK05udu3bnt3e/Yjx4IohbINSQeLG98t4SsyJfFue0w+E6vNIMgIRCHQ36tTex3OodSePEtUp8dN0tWh+z5bzkVU0MEG4PYacU9vLA2cOV4Sv8Qme2on1wniQawlLXpyEp/nblA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nK0taJ3q; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nK0taJ3q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f78Vk5MSWz2xWJ
	for <linux-erofs@lists.ozlabs.org>; Sat, 07 Feb 2026 09:52:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770418351; x=1801954351;
  h=date:from:to:cc:subject:message-id;
  bh=JIAAjZheZCSgOCkTwbWck+ovHkUibcBMoTIVIBY7/fE=;
  b=nK0taJ3qOTMElDpo4mcsuOIM37+Qe8V4rBLQkRr2UhHY+N/CbkXiO/NJ
   MVrRy+XdVSHiRDQL1pSQnJzHW6Ogsgmz4YJXALq9iTQjLH1joYYJ1sCxu
   COZEf/H2+HNLinUpt28MSfyKN/6Req1dZBZf8sAOAPRTfurzPnfInw2TX
   jalGLw6FX08xMUVEQ7v3XSEhA05rBl/GHjVe5LScBodRkXTWhcBWdbwtH
   S7n5i4CJoqMp6k0G52WhWVbSA/2ghvrf/RDpp01UroJfbYue16osCPteq
   gXvYezeIezOFH8wE+gsfCXU4Cehk5MPzaLx3TEqUxH7PXD18yTpPu64vG
   w==;
X-CSE-ConnectionGUID: mz07Fc4+T+6lsV7aRDPMsg==
X-CSE-MsgGUID: ITseBRJtQ+OJpK1gzYUQrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="59198420"
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="59198420"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 14:52:22 -0800
X-CSE-ConnectionGUID: pgyzUpjqQQqyoS6yRhKWsA==
X-CSE-MsgGUID: BUTlckN4QGyOdGY5aFkmDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="215968867"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 06 Feb 2026 14:52:21 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voUgU-00000000lEi-1KGT;
	Fri, 06 Feb 2026 22:52:18 +0000
Date: Sat, 07 Feb 2026 06:51:44 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 1caf50ce4af096d0280d59a31abdd85703cd995c
Message-ID: <202602070635.fPZ6KxPY-lkp@intel.com>
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2277-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 06DB2103F73
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 1caf50ce4af096d0280d59a31abdd85703cd995c  erofs: fix UAF issue for file-backed mounts w/ directio option

elapsed time: 918m

configs tested: 297
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.2.0
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                          axs101_defconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                        nsimosci_defconfig    gcc-15.2.0
arc                   randconfig-001-20260206    gcc-8.5.0
arc                   randconfig-001-20260207    gcc-8.5.0
arc                   randconfig-002-20260206    gcc-8.5.0
arc                   randconfig-002-20260207    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                        clps711x_defconfig    clang-22
arm                     davinci_all_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                            dove_defconfig    gcc-15.2.0
arm                        keystone_defconfig    gcc-11.5.0
arm                         lpc18xx_defconfig    gcc-11.5.0
arm                        multi_v5_defconfig    gcc-15.2.0
arm                   randconfig-001-20260206    gcc-8.5.0
arm                   randconfig-001-20260207    gcc-8.5.0
arm                   randconfig-002-20260206    gcc-8.5.0
arm                   randconfig-002-20260207    gcc-8.5.0
arm                   randconfig-003-20260206    gcc-8.5.0
arm                   randconfig-003-20260207    gcc-8.5.0
arm                   randconfig-004-20260206    gcc-8.5.0
arm                   randconfig-004-20260207    gcc-8.5.0
arm                         s5pv210_defconfig    gcc-15.2.0
arm                           sama5_defconfig    clang-22
arm                          sp7021_defconfig    clang-22
arm                         vf610m4_defconfig    clang-22
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260206    gcc-13.4.0
arm64                 randconfig-001-20260207    gcc-15.2.0
arm64                 randconfig-002-20260206    gcc-13.4.0
arm64                 randconfig-002-20260207    gcc-15.2.0
arm64                 randconfig-003-20260206    gcc-13.4.0
arm64                 randconfig-003-20260207    gcc-15.2.0
arm64                 randconfig-004-20260206    gcc-13.4.0
arm64                 randconfig-004-20260207    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260206    gcc-13.4.0
csky                  randconfig-001-20260207    gcc-15.2.0
csky                  randconfig-002-20260206    gcc-13.4.0
csky                  randconfig-002-20260207    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260206    clang-22
hexagon               randconfig-001-20260207    clang-22
hexagon               randconfig-002-20260206    clang-22
hexagon               randconfig-002-20260207    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260206    clang-20
i386        buildonly-randconfig-001-20260207    clang-20
i386        buildonly-randconfig-002-20260206    clang-20
i386        buildonly-randconfig-002-20260207    clang-20
i386        buildonly-randconfig-003-20260206    clang-20
i386        buildonly-randconfig-003-20260207    clang-20
i386        buildonly-randconfig-004-20260206    clang-20
i386        buildonly-randconfig-004-20260207    clang-20
i386        buildonly-randconfig-005-20260206    clang-20
i386        buildonly-randconfig-005-20260207    clang-20
i386        buildonly-randconfig-006-20260206    clang-20
i386        buildonly-randconfig-006-20260207    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260206    gcc-14
i386                  randconfig-001-20260207    clang-20
i386                  randconfig-002-20260206    gcc-14
i386                  randconfig-002-20260207    clang-20
i386                  randconfig-003-20260206    gcc-14
i386                  randconfig-003-20260207    clang-20
i386                  randconfig-004-20260206    gcc-14
i386                  randconfig-004-20260207    clang-20
i386                  randconfig-005-20260206    gcc-14
i386                  randconfig-005-20260207    clang-20
i386                  randconfig-006-20260206    gcc-14
i386                  randconfig-006-20260207    clang-20
i386                  randconfig-007-20260206    gcc-14
i386                  randconfig-007-20260207    clang-20
i386                  randconfig-011-20260206    clang-20
i386                  randconfig-012-20260206    clang-20
i386                  randconfig-013-20260206    clang-20
i386                  randconfig-014-20260206    clang-20
i386                  randconfig-015-20260206    clang-20
i386                  randconfig-016-20260206    clang-20
i386                  randconfig-017-20260206    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260206    clang-22
loongarch             randconfig-001-20260207    clang-22
loongarch             randconfig-002-20260206    clang-22
loongarch             randconfig-002-20260207    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                          hp300_defconfig    gcc-15.2.0
m68k                           sun3_defconfig    gcc-11.5.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath25_defconfig    clang-22
mips                           gcw0_defconfig    clang-22
mips                           ip27_defconfig    gcc-15.2.0
mips                           ip32_defconfig    clang-22
mips                           ip32_defconfig    gcc-15.2.0
mips                      maltaaprp_defconfig    clang-22
mips                          rb532_defconfig    clang-22
nios2                         3c120_defconfig    gcc-11.5.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260206    clang-22
nios2                 randconfig-001-20260207    clang-22
nios2                 randconfig-002-20260206    clang-22
nios2                 randconfig-002-20260207    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                  or1klitex_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260206    gcc-8.5.0
parisc                randconfig-001-20260207    gcc-14.3.0
parisc                randconfig-002-20260206    gcc-8.5.0
parisc                randconfig-002-20260207    gcc-14.3.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      arches_defconfig    gcc-15.2.0
powerpc                      chrp32_defconfig    clang-22
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc                 mpc837x_rdb_defconfig    gcc-15.2.0
powerpc                     powernv_defconfig    gcc-15.2.0
powerpc                      ppc44x_defconfig    clang-22
powerpc                      ppc6xx_defconfig    gcc-11.5.0
powerpc               randconfig-001-20260206    gcc-8.5.0
powerpc               randconfig-001-20260207    gcc-14.3.0
powerpc               randconfig-002-20260206    gcc-8.5.0
powerpc               randconfig-002-20260207    gcc-14.3.0
powerpc                      tqm8xx_defconfig    gcc-11.5.0
powerpc64             randconfig-001-20260206    gcc-8.5.0
powerpc64             randconfig-001-20260207    gcc-14.3.0
powerpc64             randconfig-002-20260206    gcc-8.5.0
powerpc64             randconfig-002-20260207    gcc-14.3.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260206    clang-22
riscv                 randconfig-001-20260207    clang-18
riscv                 randconfig-002-20260206    clang-22
riscv                 randconfig-002-20260207    clang-18
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260206    clang-22
s390                  randconfig-001-20260207    clang-18
s390                  randconfig-002-20260206    clang-22
s390                  randconfig-002-20260207    clang-18
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                             espt_defconfig    gcc-15.2.0
sh                    randconfig-001-20260206    clang-22
sh                    randconfig-001-20260207    clang-18
sh                    randconfig-002-20260206    clang-22
sh                    randconfig-002-20260207    clang-18
sh                      rts7751r2d1_defconfig    gcc-15.2.0
sh                           se7343_defconfig    gcc-15.2.0
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sh                        sh7763rdp_defconfig    gcc-15.2.0
sh                  sh7785lcr_32bit_defconfig    clang-22
sh                        sh7785lcr_defconfig    gcc-15.2.0
sh                            shmin_defconfig    gcc-15.2.0
sh                             shx3_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260206    gcc-12.5.0
sparc                 randconfig-001-20260207    gcc-15.2.0
sparc                 randconfig-002-20260206    gcc-12.5.0
sparc                 randconfig-002-20260207    gcc-15.2.0
sparc64                          alldefconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260206    gcc-12.5.0
sparc64               randconfig-001-20260207    gcc-15.2.0
sparc64               randconfig-002-20260206    gcc-12.5.0
sparc64               randconfig-002-20260207    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260206    gcc-12.5.0
um                    randconfig-001-20260207    gcc-15.2.0
um                    randconfig-002-20260206    gcc-12.5.0
um                    randconfig-002-20260207    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260206    gcc-14
x86_64      buildonly-randconfig-001-20260207    gcc-14
x86_64      buildonly-randconfig-002-20260206    gcc-14
x86_64      buildonly-randconfig-002-20260207    gcc-14
x86_64      buildonly-randconfig-003-20260206    gcc-14
x86_64      buildonly-randconfig-003-20260207    gcc-14
x86_64      buildonly-randconfig-004-20260206    gcc-14
x86_64      buildonly-randconfig-004-20260207    gcc-14
x86_64      buildonly-randconfig-005-20260206    gcc-14
x86_64      buildonly-randconfig-005-20260207    gcc-14
x86_64      buildonly-randconfig-006-20260206    gcc-14
x86_64      buildonly-randconfig-006-20260207    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260206    gcc-14
x86_64                randconfig-001-20260207    clang-20
x86_64                randconfig-002-20260206    gcc-14
x86_64                randconfig-002-20260207    clang-20
x86_64                randconfig-003-20260206    gcc-14
x86_64                randconfig-003-20260207    clang-20
x86_64                randconfig-004-20260206    gcc-14
x86_64                randconfig-004-20260207    clang-20
x86_64                randconfig-005-20260206    gcc-14
x86_64                randconfig-005-20260207    clang-20
x86_64                randconfig-006-20260206    gcc-14
x86_64                randconfig-006-20260207    clang-20
x86_64                randconfig-011-20260206    gcc-14
x86_64                randconfig-012-20260206    gcc-14
x86_64                randconfig-013-20260206    gcc-14
x86_64                randconfig-014-20260206    gcc-14
x86_64                randconfig-015-20260206    gcc-14
x86_64                randconfig-016-20260206    gcc-14
x86_64                randconfig-071-20260206    gcc-14
x86_64                randconfig-072-20260206    gcc-14
x86_64                randconfig-073-20260206    gcc-14
x86_64                randconfig-074-20260206    gcc-14
x86_64                randconfig-075-20260206    gcc-14
x86_64                randconfig-076-20260206    gcc-14
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
xtensa                  audio_kc705_defconfig    clang-22
xtensa                  nommu_kc705_defconfig    gcc-11.5.0
xtensa                randconfig-001-20260206    gcc-12.5.0
xtensa                randconfig-001-20260207    gcc-15.2.0
xtensa                randconfig-002-20260206    gcc-12.5.0
xtensa                randconfig-002-20260207    gcc-15.2.0
xtensa                    smp_lx200_defconfig    clang-22
xtensa                    smp_lx200_defconfig    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

