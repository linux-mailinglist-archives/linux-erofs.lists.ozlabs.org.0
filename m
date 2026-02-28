Return-Path: <linux-erofs+bounces-2444-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPtcJ/RFomn31QQAu9opvQ
	(envelope-from <linux-erofs+bounces-2444-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Feb 2026 02:33:40 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8AF1BFBFF
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Feb 2026 02:33:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fN74w6G81z30BR;
	Sat, 28 Feb 2026 12:33:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772242416;
	cv=none; b=Dz9NyE3fxQVNqhGYt0kmbew+lpApC/2gPIqf3Ti/e2lkij1CB1HGJ2JzuswExLQOqIXr1lZXWaqaS0ciY3AVYxf//7MHm2HAWxzt1/A446cDTgMJ5hsPiO3gNDsa6ECQ63D0mLRRYMUHIdJKdWlgf1CHL1Vz3K0zuh5SP0B4jr1dBqU3vHlUP8Qnu+NbofP51eeL6IuY1FcgyxXe0YPAiyaKlzr/HYQ44uGeLrhrHVUalP3MGgh4BHQGv/ZQtjDNwi7GK9ZuMG3Fi22AFz2UrCWlDLfWJJA9mkwL3xa+OdOe1XW/wlfqauKKqq5mBqoI0CQ1oV4nyBQJ82ZyLi775Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772242416; c=relaxed/relaxed;
	bh=odT8/g3TjJuYV0n4ZSnqa0mvFRaGk83HRxitrp7c3pA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CTmHLMLV4+/DFSmZjUeaAkwBtrQvrRkuPWPsnqq2tsssoZn9LJ7CXfAaYx+/uFM5JOA5RTppD9wsH0hZOuJtIza8jrk1yMlBu6UtnIdJv2httdP5QIdkiINdExJVKzicwsYkbiovWaHyVzfOlw5Z1lzCdsGtNyLuAY1wG+fEvz4d5bT+4WSQOyKTUg0B1nsD0CL+zEhhnORafY6aWXhw3KSR0nNIxUkOCsFaMcbOtA42YyUoj3/og2kKyhsnQefz8TGvYfVB8ofvYDo4pTKdQGuEpy8pNkapR2MNDfKx/uDwPvtnl9uiuRXA8UH+opVSSagFHCDtpSxjEN9mk+n80w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OdCQMYa8; dkim-atps=neutral; spf=temperror (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OdCQMYa8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=temperror (SPF Temporary Error: DNS Timeout) smtp.mailfrom=intel.com (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fN74q5D0kz2xlj
	for <linux-erofs@lists.ozlabs.org>; Sat, 28 Feb 2026 12:33:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772242412; x=1803778412;
  h=date:from:to:cc:subject:message-id;
  bh=RQz8quVBCRqoxDMIDbTh6WLCwWSTvZoK8ejBsQo0d3E=;
  b=OdCQMYa8vSNgAX3Bv0zVZ+7jgXWOdge/SLAl4GWBxZlGDFX4AnUGTj/H
   9z7ZDRTh6y0LzNLcbLiaw6s7uHmFVhMDu0cFcNFQqiLnrpyda2/ECgOmt
   HXjuYXa52iRoAEOytY4d/dHjbwisPSUfAOPdG6F6f8ipqB4aNDSj3MjPc
   3lY3g+JDm0e6APRd7t929RCcXoYUAtNoDoRReIzeK2W1uDrNqMxo2JT5W
   p2d48W+F/qyTrJYNsJ0pioDNMfpfJjcZag7kS6OZuyNKRqmGByeKu76aj
   eWmPrF+XqijmO7HqhM3Lj7jYu3u0vRryhbYye5AHcCHE+P+H9GymmDc49
   Q==;
X-CSE-ConnectionGUID: aDQSQA6QQCiCW6T5kGZDOg==
X-CSE-MsgGUID: BTQt+qPeTtiM1tj3Uexuiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73237549"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="73237549"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 17:33:07 -0800
X-CSE-ConnectionGUID: YCRSXKjKTmC1uqTk32/5Uw==
X-CSE-MsgGUID: fp6KaHqYRw+9BMe0kPmT2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="247562711"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 27 Feb 2026 17:33:06 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vw9CY-00000000BEj-2lkf;
	Sat, 28 Feb 2026 01:33:02 +0000
Date: Sat, 28 Feb 2026 09:32:27 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 5accc861ea0dc0ab8cf02fed17f88f05cf514a34
Message-ID: <202602280919.L2jWZbcs-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2444-lists,linux-erofs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 9F8AF1BFBFF
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 5accc861ea0dc0ab8cf02fed17f88f05cf514a34  erofs: set fileio bio failed in short read case

elapsed time: 898m

configs tested: 373
configs skipped: 10

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
arc                      axs103_smp_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                         haps_hs_defconfig    gcc-15.2.0
arc                     haps_hs_smp_defconfig    clang-23
arc                        nsimosci_defconfig    gcc-15.2.0
arc                   randconfig-001-20260227    gcc-8.5.0
arc                   randconfig-001-20260228    gcc-14.3.0
arc                   randconfig-002-20260227    gcc-8.5.0
arc                   randconfig-002-20260228    gcc-14.3.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         axm55xx_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                           h3600_defconfig    gcc-15.2.0
arm                       imx_v4_v5_defconfig    gcc-14
arm                       imx_v6_v7_defconfig    gcc-15.2.0
arm                          ixp4xx_defconfig    gcc-15.2.0
arm                        keystone_defconfig    gcc-15.2.0
arm                            mmp2_defconfig    gcc-15.2.0
arm                        multi_v5_defconfig    clang-23
arm                        multi_v7_defconfig    gcc-15.2.0
arm                        mvebu_v5_defconfig    gcc-15.2.0
arm                   randconfig-001-20260227    gcc-14.3.0
arm                   randconfig-001-20260227    gcc-8.5.0
arm                   randconfig-001-20260228    gcc-14.3.0
arm                   randconfig-002-20260227    clang-23
arm                   randconfig-002-20260227    gcc-8.5.0
arm                   randconfig-002-20260228    gcc-14.3.0
arm                   randconfig-003-20260227    gcc-15.2.0
arm                   randconfig-003-20260227    gcc-8.5.0
arm                   randconfig-003-20260228    gcc-14.3.0
arm                   randconfig-004-20260227    clang-23
arm                   randconfig-004-20260227    gcc-8.5.0
arm                   randconfig-004-20260228    gcc-14.3.0
arm                         s3c6400_defconfig    gcc-15.2.0
arm                           u8500_defconfig    gcc-15.2.0
arm                    vt8500_v6_v7_defconfig    gcc-15.2.0
arm                         wpcm450_defconfig    clang-23
arm64                            alldefconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260227    clang-23
arm64                 randconfig-001-20260228    clang-23
arm64                 randconfig-002-20260227    clang-23
arm64                 randconfig-002-20260228    clang-23
arm64                 randconfig-003-20260227    clang-23
arm64                 randconfig-003-20260228    clang-23
arm64                 randconfig-004-20260227    clang-23
arm64                 randconfig-004-20260228    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260227    clang-23
csky                  randconfig-001-20260228    clang-23
csky                  randconfig-002-20260227    clang-23
csky                  randconfig-002-20260228    clang-23
hexagon                          alldefconfig    gcc-14
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260227    clang-23
hexagon               randconfig-001-20260228    clang-23
hexagon               randconfig-002-20260227    clang-23
hexagon               randconfig-002-20260228    clang-23
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260227    clang-20
i386        buildonly-randconfig-001-20260228    clang-20
i386        buildonly-randconfig-002-20260227    clang-20
i386        buildonly-randconfig-002-20260228    clang-20
i386        buildonly-randconfig-003-20260227    clang-20
i386        buildonly-randconfig-003-20260227    gcc-14
i386        buildonly-randconfig-003-20260228    clang-20
i386        buildonly-randconfig-004-20260227    clang-20
i386        buildonly-randconfig-004-20260227    gcc-14
i386        buildonly-randconfig-004-20260228    clang-20
i386        buildonly-randconfig-005-20260227    clang-20
i386        buildonly-randconfig-005-20260228    clang-20
i386        buildonly-randconfig-006-20260227    clang-20
i386        buildonly-randconfig-006-20260228    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260227    clang-20
i386                  randconfig-001-20260228    gcc-14
i386                  randconfig-002-20260227    clang-20
i386                  randconfig-002-20260228    gcc-14
i386                  randconfig-003-20260227    clang-20
i386                  randconfig-003-20260227    gcc-14
i386                  randconfig-003-20260228    gcc-14
i386                  randconfig-004-20260227    clang-20
i386                  randconfig-004-20260227    gcc-14
i386                  randconfig-004-20260228    gcc-14
i386                  randconfig-005-20260227    clang-20
i386                  randconfig-005-20260227    gcc-12
i386                  randconfig-005-20260228    gcc-14
i386                  randconfig-006-20260227    clang-20
i386                  randconfig-006-20260227    gcc-14
i386                  randconfig-006-20260228    gcc-14
i386                  randconfig-007-20260227    clang-20
i386                  randconfig-007-20260228    gcc-14
i386                  randconfig-011-20260227    clang-20
i386                  randconfig-011-20260227    gcc-14
i386                  randconfig-011-20260228    gcc-14
i386                  randconfig-012-20260227    gcc-14
i386                  randconfig-012-20260228    gcc-14
i386                  randconfig-013-20260227    clang-20
i386                  randconfig-013-20260227    gcc-14
i386                  randconfig-013-20260228    gcc-14
i386                  randconfig-014-20260227    gcc-14
i386                  randconfig-014-20260228    gcc-14
i386                  randconfig-015-20260227    gcc-13
i386                  randconfig-015-20260227    gcc-14
i386                  randconfig-015-20260228    gcc-14
i386                  randconfig-016-20260227    clang-20
i386                  randconfig-016-20260227    gcc-14
i386                  randconfig-016-20260228    gcc-14
i386                  randconfig-017-20260227    gcc-14
i386                  randconfig-017-20260228    gcc-14
loongarch                        alldefconfig    gcc-15.2.0
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260227    clang-23
loongarch             randconfig-001-20260227    gcc-15.2.0
loongarch             randconfig-001-20260228    clang-23
loongarch             randconfig-002-20260227    clang-20
loongarch             randconfig-002-20260227    clang-23
loongarch             randconfig-002-20260228    clang-23
m68k                             alldefconfig    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-14
m68k                        m5272c3_defconfig    gcc-15.2.0
m68k                        mvme16x_defconfig    gcc-15.2.0
m68k                            q40_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                      mmu_defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           ci20_defconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                     decstation_defconfig    gcc-15.2.0
mips                          eyeq5_defconfig    gcc-14
mips                           ip30_defconfig    gcc-15.2.0
mips                      loongson1_defconfig    gcc-15.2.0
mips                malta_qemu_32r6_defconfig    gcc-15.2.0
mips                          rm200_defconfig    gcc-15.2.0
nios2                         10m50_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260227    clang-23
nios2                 randconfig-001-20260227    gcc-11.5.0
nios2                 randconfig-001-20260228    clang-23
nios2                 randconfig-002-20260227    clang-23
nios2                 randconfig-002-20260227    gcc-11.5.0
nios2                 randconfig-002-20260228    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                 simple_smp_defconfig    gcc-15.2.0
openrisc                       virt_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260227    clang-17
parisc                randconfig-001-20260227    gcc-8.5.0
parisc                randconfig-001-20260228    gcc-8.5.0
parisc                randconfig-002-20260227    clang-17
parisc                randconfig-002-20260227    gcc-8.5.0
parisc                randconfig-002-20260228    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                     akebono_defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      arches_defconfig    clang-23
powerpc                      bamboo_defconfig    gcc-15.2.0
powerpc                   bluestone_defconfig    gcc-15.2.0
powerpc                        cell_defconfig    gcc-14
powerpc                   currituck_defconfig    gcc-15.2.0
powerpc                      ep88xc_defconfig    gcc-15.2.0
powerpc                        fsp2_defconfig    gcc-15.2.0
powerpc                    gamecube_defconfig    gcc-15.2.0
powerpc                        icon_defconfig    gcc-15.2.0
powerpc                   motionpro_defconfig    gcc-15.2.0
powerpc                     mpc5200_defconfig    clang-23
powerpc                     mpc83xx_defconfig    gcc-15.2.0
powerpc                  mpc866_ads_defconfig    clang-23
powerpc                     powernv_defconfig    gcc-15.2.0
powerpc                       ppc64_defconfig    gcc-15.2.0
powerpc                         ps3_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260227    clang-17
powerpc               randconfig-001-20260227    gcc-11.5.0
powerpc               randconfig-001-20260228    gcc-8.5.0
powerpc               randconfig-002-20260227    clang-17
powerpc               randconfig-002-20260228    gcc-8.5.0
powerpc                    sam440ep_defconfig    gcc-15.2.0
powerpc                     taishan_defconfig    gcc-15.2.0
powerpc                      tqm8xx_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260227    clang-17
powerpc64             randconfig-001-20260227    gcc-10.5.0
powerpc64             randconfig-001-20260228    gcc-8.5.0
powerpc64             randconfig-002-20260227    clang-17
powerpc64             randconfig-002-20260227    gcc-14.3.0
powerpc64             randconfig-002-20260228    gcc-8.5.0
riscv                            alldefconfig    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260227    gcc-12.5.0
riscv                 randconfig-001-20260228    gcc-15.2.0
riscv                 randconfig-002-20260227    gcc-12.5.0
riscv                 randconfig-002-20260228    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260227    gcc-12.5.0
s390                  randconfig-001-20260228    gcc-15.2.0
s390                  randconfig-002-20260227    gcc-12.5.0
s390                  randconfig-002-20260228    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                ecovec24-romimage_defconfig    gcc-15.2.0
sh                             espt_defconfig    gcc-14
sh                          landisk_defconfig    gcc-15.2.0
sh                    randconfig-001-20260227    gcc-12.5.0
sh                    randconfig-001-20260228    gcc-15.2.0
sh                    randconfig-002-20260227    gcc-12.5.0
sh                    randconfig-002-20260228    gcc-15.2.0
sh                          sdk7780_defconfig    gcc-15.2.0
sh                           se7724_defconfig    gcc-15.2.0
sh                           sh2007_defconfig    clang-23
sh                              ul2_defconfig    gcc-14
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260227    clang-23
sparc                 randconfig-001-20260228    gcc-9.5.0
sparc                 randconfig-002-20260227    clang-23
sparc                 randconfig-002-20260228    gcc-9.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260227    clang-23
sparc64               randconfig-001-20260228    gcc-9.5.0
sparc64               randconfig-002-20260227    clang-23
sparc64               randconfig-002-20260228    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260227    clang-23
um                    randconfig-001-20260228    gcc-9.5.0
um                    randconfig-002-20260227    clang-23
um                    randconfig-002-20260228    gcc-9.5.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260227    gcc-14
x86_64      buildonly-randconfig-001-20260228    gcc-14
x86_64      buildonly-randconfig-002-20260227    gcc-14
x86_64      buildonly-randconfig-002-20260228    gcc-14
x86_64      buildonly-randconfig-003-20260227    gcc-14
x86_64      buildonly-randconfig-003-20260228    gcc-14
x86_64      buildonly-randconfig-004-20260227    gcc-14
x86_64      buildonly-randconfig-004-20260228    gcc-14
x86_64      buildonly-randconfig-005-20260227    gcc-14
x86_64      buildonly-randconfig-005-20260228    gcc-14
x86_64      buildonly-randconfig-006-20260227    gcc-14
x86_64      buildonly-randconfig-006-20260228    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260227    gcc-13
x86_64                randconfig-001-20260228    gcc-14
x86_64                randconfig-002-20260227    gcc-13
x86_64                randconfig-002-20260228    gcc-14
x86_64                randconfig-003-20260227    gcc-13
x86_64                randconfig-003-20260228    gcc-14
x86_64                randconfig-004-20260227    gcc-13
x86_64                randconfig-004-20260228    gcc-14
x86_64                randconfig-005-20260227    gcc-13
x86_64                randconfig-005-20260228    gcc-14
x86_64                randconfig-006-20260227    gcc-13
x86_64                randconfig-006-20260228    gcc-14
x86_64                randconfig-011-20260227    gcc-14
x86_64                randconfig-011-20260228    gcc-14
x86_64                randconfig-012-20260227    gcc-14
x86_64                randconfig-012-20260228    gcc-14
x86_64                randconfig-013-20260227    clang-20
x86_64                randconfig-013-20260227    gcc-14
x86_64                randconfig-013-20260228    gcc-14
x86_64                randconfig-014-20260227    clang-20
x86_64                randconfig-014-20260227    gcc-14
x86_64                randconfig-014-20260228    gcc-14
x86_64                randconfig-015-20260227    clang-20
x86_64                randconfig-015-20260227    gcc-14
x86_64                randconfig-015-20260228    gcc-14
x86_64                randconfig-016-20260227    gcc-14
x86_64                randconfig-016-20260228    gcc-14
x86_64                randconfig-071-20260227    gcc-14
x86_64                randconfig-071-20260228    gcc-14
x86_64                randconfig-072-20260227    gcc-14
x86_64                randconfig-072-20260228    gcc-14
x86_64                randconfig-073-20260227    gcc-14
x86_64                randconfig-073-20260228    gcc-14
x86_64                randconfig-074-20260227    gcc-14
x86_64                randconfig-074-20260228    gcc-14
x86_64                randconfig-075-20260227    gcc-14
x86_64                randconfig-075-20260228    gcc-14
x86_64                randconfig-076-20260227    gcc-14
x86_64                randconfig-076-20260228    gcc-14
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
xtensa                  cadence_csp_defconfig    gcc-15.2.0
xtensa                  nommu_kc705_defconfig    clang-23
xtensa                randconfig-001-20260227    clang-23
xtensa                randconfig-001-20260228    gcc-9.5.0
xtensa                randconfig-002-20260227    clang-23
xtensa                randconfig-002-20260228    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

