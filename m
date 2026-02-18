Return-Path: <linux-erofs+bounces-2335-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC4HBrIrlmlPbwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2335-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Feb 2026 22:14:26 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27387159CCB
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Feb 2026 22:14:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fGTlw1djfz2xpk;
	Thu, 19 Feb 2026 08:14:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771449260;
	cv=none; b=jC482yWKgHwDim9sGSl+NXyMfQGwUueQr37+D57d3xwb4yEwaMMUGR8WxyUc79ZrfKkXP1ZEEEnMmAURVB/U0Hsrk6LmtL3RHUTmyvCOiiVdT5FQRsgeq+52n7/G11IeIFxBttrla9XQvDIfaMNINrztv75JbLE38fi3Fz2oQjjEZDLkvFcRjLIBjYzxlf4Oitc1+qd4z4LAUjDRFAgd9v2fyvSYnCh55Q53t6SQipVTnoyBTQEewcaY9oGidlyKXJgXfsh3GDkPFYg+a8FoHPt8SfLhOX2ZiBV+em/XZDTesMxXKPQG41u5mXX7ii8ker5Z0DV1Txp4d5qZgxn02w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771449260; c=relaxed/relaxed;
	bh=ZOYnj+O7Dp155SAegJDeXp5/DJmigaYSMAiU2/LTlgI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bRig4bE8+ZXdWiuZII8NS72BpuvBI3sMxWki9RuBD+pH/lizoVSJwNVcHcWCNz3FiFuhahHuNp9uWUpX+PIoDNi1+M7yEuK51X0wWWO8sxaM/XUUTt9TMB9SqRmcOguo95g/OKMmS2ggN0CN4cdWSXxDM4KsY1Ff9SslbNg18uxsjtsZBNLK3ysupZE7Ao+HGD50tJtHQ+ozDAYLvCZryWnWO2nonAd38SV6IT+rIS0wXrxXyOQ6JpmijAxKibgvsXwqGtdppcUehFCjMZEAyv2ihh7kOgfVM9hsyCfF1Z/MELmp9WG84byEj/4NOCDyc69cDbzPN9t/ILqeDHk3Gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LhKqxyEu; dkim-atps=neutral; spf=pass (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LhKqxyEu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fGTlr6KSbz2xC3
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Feb 2026 08:14:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771449257; x=1802985257;
  h=date:from:to:cc:subject:message-id;
  bh=Uglch/0OtewBnUC2BIA2aQ7a1/tZvoDOCombEwmKHvQ=;
  b=LhKqxyEu9NaiKJmM9+4ilgaVrO08zF4lTKNFNDZ584wJ/xjisWyV/vbV
   dJ53KE9EEKnb4Z/erfbTJ0aFIrJaziQaGASEFo77CWmZRA1cG5xPHFCcG
   CSwb32x73x4t3x8NsPgsJ0AykBoqRZeu8ZzMbh78u9r87QLtzY97qR7Dj
   AVLjemNB904QOlNIxpM/Bl/Qo9d6uAH8SyNKLyAEkGIS60WNNTLokWOtI
   lCNTaOYRIl07OXt5f7KbpcRM7NojnU2WuLd4pRYhCzdkqE84DjDYS98ss
   6QYMUKJaDSXJsrYsYB+yKL5vYbJIutQsU28xlCT5yQId/GT82K8y79yq4
   A==;
X-CSE-ConnectionGUID: Kz0uugEcThip7YxUK5GmbQ==
X-CSE-MsgGUID: 4rxsNhv6Qgam6dHW8igdPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="71557432"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="71557432"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 13:14:11 -0800
X-CSE-ConnectionGUID: Adwdro4VQjuXhDd/8Qf6Yw==
X-CSE-MsgGUID: fNNKHjMlTOqULBzby+gc4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="213402614"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 18 Feb 2026 13:14:09 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vsos3-000000012k6-1ota;
	Wed, 18 Feb 2026 21:14:07 +0000
Date: Thu, 19 Feb 2026 05:13:17 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 3ffed4445ae77110da7fc8031f0e5176484748b7
Message-ID: <202602190509.A7KJ5INV-lkp@intel.com>
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
	TAGGED_FROM(0.00)[bounces-2335-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 27387159CCB
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 3ffed4445ae77110da7fc8031f0e5176484748b7  erofs: allow sharing page cache with the same aops only

elapsed time: 844m

configs tested: 364
configs skipped: 8

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
arc                          axs103_defconfig    gcc-15.2.0
arc                      axs103_smp_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                     haps_hs_smp_defconfig    clang-23
arc                     haps_hs_smp_defconfig    gcc-15.2.0
arc                        nsim_700_defconfig    clang-23
arc                   randconfig-001-20260218    clang-23
arc                   randconfig-001-20260219    clang-23
arc                   randconfig-002-20260218    clang-23
arc                   randconfig-002-20260219    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          exynos_defconfig    clang-23
arm                            hisi_defconfig    gcc-15.2.0
arm                      jornada720_defconfig    clang-23
arm                            mps2_defconfig    clang-23
arm                         mv78xx0_defconfig    gcc-15.2.0
arm                        mvebu_v5_defconfig    clang-23
arm                        neponset_defconfig    gcc-15.2.0
arm                       netwinder_defconfig    clang-23
arm                         orion5x_defconfig    clang-23
arm                            qcom_defconfig    gcc-15.2.0
arm                   randconfig-001-20260218    clang-23
arm                   randconfig-001-20260219    clang-23
arm                   randconfig-002-20260218    clang-23
arm                   randconfig-002-20260219    clang-23
arm                   randconfig-003-20260218    clang-23
arm                   randconfig-003-20260219    clang-23
arm                   randconfig-004-20260218    clang-23
arm                   randconfig-004-20260219    clang-23
arm                         socfpga_defconfig    clang-23
arm                           stm32_defconfig    gcc-15.2.0
arm                       versatile_defconfig    gcc-15.2.0
arm                    vt8500_v6_v7_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260218    clang-23
arm64                 randconfig-001-20260218    gcc-8.5.0
arm64                 randconfig-001-20260219    gcc-8.5.0
arm64                 randconfig-002-20260218    clang-23
arm64                 randconfig-002-20260219    gcc-8.5.0
arm64                 randconfig-003-20260218    clang-23
arm64                 randconfig-003-20260218    gcc-14.3.0
arm64                 randconfig-003-20260219    gcc-8.5.0
arm64                 randconfig-004-20260218    clang-23
arm64                 randconfig-004-20260218    gcc-11.5.0
arm64                 randconfig-004-20260219    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260218    clang-23
csky                  randconfig-001-20260218    gcc-15.2.0
csky                  randconfig-001-20260219    gcc-8.5.0
csky                  randconfig-002-20260218    clang-23
csky                  randconfig-002-20260218    gcc-15.2.0
csky                  randconfig-002-20260219    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260218    clang-16
hexagon               randconfig-001-20260219    clang-17
hexagon               randconfig-002-20260218    clang-16
hexagon               randconfig-002-20260219    clang-17
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260218    clang-20
i386        buildonly-randconfig-001-20260219    gcc-14
i386        buildonly-randconfig-002-20260218    clang-20
i386        buildonly-randconfig-002-20260219    gcc-14
i386        buildonly-randconfig-003-20260218    clang-20
i386        buildonly-randconfig-003-20260219    gcc-14
i386        buildonly-randconfig-004-20260218    clang-20
i386        buildonly-randconfig-004-20260219    gcc-14
i386        buildonly-randconfig-005-20260218    clang-20
i386        buildonly-randconfig-005-20260219    gcc-14
i386        buildonly-randconfig-006-20260218    clang-20
i386        buildonly-randconfig-006-20260219    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260218    clang-20
i386                  randconfig-002-20260218    clang-20
i386                  randconfig-003-20260218    clang-20
i386                  randconfig-004-20260218    clang-20
i386                  randconfig-005-20260218    clang-20
i386                  randconfig-006-20260218    clang-20
i386                  randconfig-007-20260218    clang-20
i386                  randconfig-011-20260218    gcc-12
i386                  randconfig-011-20260218    gcc-14
i386                  randconfig-011-20260219    clang-20
i386                  randconfig-012-20260218    gcc-14
i386                  randconfig-012-20260219    clang-20
i386                  randconfig-013-20260218    clang-20
i386                  randconfig-013-20260218    gcc-14
i386                  randconfig-013-20260219    clang-20
i386                  randconfig-014-20260218    gcc-14
i386                  randconfig-014-20260219    clang-20
i386                  randconfig-015-20260218    gcc-14
i386                  randconfig-015-20260219    clang-20
i386                  randconfig-016-20260218    clang-20
i386                  randconfig-016-20260218    gcc-14
i386                  randconfig-016-20260219    clang-20
i386                  randconfig-017-20260218    gcc-14
i386                  randconfig-017-20260219    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260218    clang-16
loongarch             randconfig-001-20260219    clang-17
loongarch             randconfig-002-20260218    clang-16
loongarch             randconfig-002-20260219    clang-17
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-15.2.0
m68k                        mvme16x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath25_defconfig    clang-23
mips                         bigsur_defconfig    clang-23
mips                         cobalt_defconfig    clang-23
mips                 decstation_r4k_defconfig    clang-23
mips                           ip28_defconfig    gcc-15.2.0
mips                malta_qemu_32r6_defconfig    clang-23
mips                malta_qemu_32r6_defconfig    gcc-15.2.0
mips                      pic32mzda_defconfig    clang-23
mips                          rm200_defconfig    clang-23
mips                   sb1250_swarm_defconfig    gcc-15.2.0
mips                           xway_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260218    clang-16
nios2                 randconfig-001-20260219    clang-17
nios2                 randconfig-002-20260218    clang-16
nios2                 randconfig-002-20260219    clang-17
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc         de0_nano_multicore_defconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260218    gcc-8.5.0
parisc                randconfig-001-20260219    clang-23
parisc                randconfig-002-20260218    gcc-8.5.0
parisc                randconfig-002-20260218    gcc-9.5.0
parisc                randconfig-002-20260219    clang-23
parisc64                            defconfig    clang-19
powerpc                    adder875_defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                    amigaone_defconfig    clang-23
powerpc                      chrp32_defconfig    clang-23
powerpc                      cm5200_defconfig    clang-23
powerpc                   currituck_defconfig    gcc-15.2.0
powerpc                      ep88xc_defconfig    clang-23
powerpc                        fsp2_defconfig    gcc-15.2.0
powerpc                    gamecube_defconfig    gcc-15.2.0
powerpc                        icon_defconfig    gcc-15.2.0
powerpc                      katmai_defconfig    gcc-15.2.0
powerpc                     kmeter1_defconfig    clang-23
powerpc                   lite5200b_defconfig    gcc-15.2.0
powerpc                  mpc885_ads_defconfig    gcc-15.2.0
powerpc                      pcm030_defconfig    clang-23
powerpc                      ppc44x_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260218    clang-23
powerpc               randconfig-001-20260218    gcc-8.5.0
powerpc               randconfig-001-20260219    clang-23
powerpc               randconfig-002-20260218    gcc-8.5.0
powerpc               randconfig-002-20260219    clang-23
powerpc                     redwood_defconfig    clang-23
powerpc                  storcenter_defconfig    clang-23
powerpc                     tqm8540_defconfig    clang-23
powerpc                     tqm8555_defconfig    clang-23
powerpc                        warp_defconfig    clang-23
powerpc                 xes_mpc85xx_defconfig    clang-23
powerpc64             randconfig-001-20260218    gcc-8.5.0
powerpc64             randconfig-001-20260219    clang-23
powerpc64             randconfig-002-20260218    clang-23
powerpc64             randconfig-002-20260218    gcc-8.5.0
powerpc64             randconfig-002-20260219    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260218    clang-23
riscv                 randconfig-001-20260219    clang-17
riscv                 randconfig-002-20260218    clang-23
riscv                 randconfig-002-20260219    clang-17
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260218    clang-23
s390                  randconfig-001-20260219    clang-17
s390                  randconfig-002-20260218    clang-23
s390                  randconfig-002-20260219    clang-17
s390                       zfcpdump_defconfig    gcc-15.2.0
sh                               alldefconfig    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                          kfr2r09_defconfig    gcc-15.2.0
sh                          polaris_defconfig    gcc-15.2.0
sh                          r7785rp_defconfig    gcc-15.2.0
sh                    randconfig-001-20260218    clang-23
sh                    randconfig-001-20260218    gcc-15.2.0
sh                    randconfig-001-20260219    clang-17
sh                    randconfig-002-20260218    clang-23
sh                    randconfig-002-20260218    gcc-13.4.0
sh                    randconfig-002-20260219    clang-17
sh                          rsk7269_defconfig    gcc-15.2.0
sh                           se7619_defconfig    gcc-15.2.0
sh                   sh7770_generic_defconfig    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260218    gcc-10.5.0
sparc                 randconfig-001-20260218    gcc-14.3.0
sparc                 randconfig-001-20260219    gcc-8.5.0
sparc                 randconfig-002-20260218    gcc-10.5.0
sparc                 randconfig-002-20260218    gcc-8.5.0
sparc                 randconfig-002-20260219    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260218    gcc-10.5.0
sparc64               randconfig-001-20260218    gcc-11.5.0
sparc64               randconfig-001-20260219    gcc-8.5.0
sparc64               randconfig-002-20260218    gcc-10.5.0
sparc64               randconfig-002-20260218    gcc-12.5.0
sparc64               randconfig-002-20260219    gcc-8.5.0
um                               alldefconfig    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260218    clang-23
um                    randconfig-001-20260218    gcc-10.5.0
um                    randconfig-001-20260219    gcc-8.5.0
um                    randconfig-002-20260218    gcc-10.5.0
um                    randconfig-002-20260218    gcc-14
um                    randconfig-002-20260219    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260218    gcc-14
x86_64      buildonly-randconfig-001-20260219    gcc-14
x86_64      buildonly-randconfig-002-20260218    clang-20
x86_64      buildonly-randconfig-002-20260218    gcc-14
x86_64      buildonly-randconfig-002-20260219    gcc-14
x86_64      buildonly-randconfig-003-20260218    clang-20
x86_64      buildonly-randconfig-003-20260218    gcc-14
x86_64      buildonly-randconfig-003-20260219    gcc-14
x86_64      buildonly-randconfig-004-20260218    gcc-14
x86_64      buildonly-randconfig-004-20260219    gcc-14
x86_64      buildonly-randconfig-005-20260218    gcc-14
x86_64      buildonly-randconfig-005-20260219    gcc-14
x86_64      buildonly-randconfig-006-20260218    clang-20
x86_64      buildonly-randconfig-006-20260218    gcc-14
x86_64      buildonly-randconfig-006-20260219    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260218    clang-20
x86_64                randconfig-001-20260218    gcc-14
x86_64                randconfig-001-20260219    clang-20
x86_64                randconfig-002-20260218    clang-20
x86_64                randconfig-002-20260218    gcc-14
x86_64                randconfig-002-20260219    clang-20
x86_64                randconfig-003-20260218    gcc-14
x86_64                randconfig-003-20260219    clang-20
x86_64                randconfig-004-20260218    clang-20
x86_64                randconfig-004-20260218    gcc-14
x86_64                randconfig-004-20260219    clang-20
x86_64                randconfig-005-20260218    gcc-14
x86_64                randconfig-005-20260219    clang-20
x86_64                randconfig-006-20260218    clang-20
x86_64                randconfig-006-20260218    gcc-14
x86_64                randconfig-006-20260219    clang-20
x86_64                randconfig-011-20260218    gcc-13
x86_64                randconfig-011-20260219    gcc-14
x86_64                randconfig-012-20260218    gcc-13
x86_64                randconfig-012-20260219    gcc-14
x86_64                randconfig-013-20260218    gcc-13
x86_64                randconfig-013-20260219    gcc-14
x86_64                randconfig-014-20260218    gcc-13
x86_64                randconfig-014-20260219    gcc-14
x86_64                randconfig-015-20260218    gcc-13
x86_64                randconfig-015-20260219    gcc-14
x86_64                randconfig-016-20260218    gcc-13
x86_64                randconfig-016-20260219    gcc-14
x86_64                randconfig-071-20260218    clang-20
x86_64                randconfig-071-20260219    gcc-14
x86_64                randconfig-072-20260218    clang-20
x86_64                randconfig-072-20260219    gcc-14
x86_64                randconfig-073-20260218    clang-20
x86_64                randconfig-073-20260219    gcc-14
x86_64                randconfig-074-20260218    clang-20
x86_64                randconfig-074-20260219    gcc-14
x86_64                randconfig-075-20260218    clang-20
x86_64                randconfig-075-20260219    gcc-14
x86_64                randconfig-076-20260218    clang-20
x86_64                randconfig-076-20260219    gcc-14
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
xtensa                           allyesconfig    gcc-15.2.0
xtensa                       common_defconfig    gcc-15.2.0
xtensa                generic_kc705_defconfig    clang-23
xtensa                randconfig-001-20260218    gcc-10.5.0
xtensa                randconfig-001-20260218    gcc-9.5.0
xtensa                randconfig-001-20260219    gcc-8.5.0
xtensa                randconfig-002-20260218    gcc-10.5.0
xtensa                randconfig-002-20260219    gcc-8.5.0
xtensa                    smp_lx200_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

