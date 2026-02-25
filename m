Return-Path: <linux-erofs+bounces-2416-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PDSFvNxn2llcAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2416-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Feb 2026 23:04:35 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742E219E215
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Feb 2026 23:04:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLpXc0j6Mz3fHP;
	Thu, 26 Feb 2026 09:04:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772057072;
	cv=none; b=E8lguKuoqyoEX3TcHVC/c+o0Kx3uUtAHLqHIM+Ak7gNtLu6Kd9CdYC+XU6njXI66a4CqXLBcAr3l6i712RE9+CgOD+exGn805iYS0q4wlMn/st5dsXfgcapBaVWBQM1YDOfh5kpcDEAjy3/84KODNQOz3Aa/eXMD4/jpLri6Dqil1CXeztSOGIyfjdC7fG5C3Ww3R11vSixG8btNJh990ei52unFFGr6DbfN3iR1CSgS0/8fIFxxwZl9xJimEtxsUBk2p2IUAjfO92uC8E8sKyWMkcIYWPjJfrD7X3DV0BWa8VYuPK5z6RX2axey6pYsbpAVnTQ2MJ6rC0KX1Y3fSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772057072; c=relaxed/relaxed;
	bh=E2wb7IdN1R71NLCB+z+hwPyBNtwT1bQuXfHi6hcoum0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZFdt9vC+fJCbH5S8fAFMry5+lz3iNbJSIPd+PidclQM7q3VwtHojBwVyweZ1PqyO6BI17YG4X0FNYz/QqH4DRcv9SlOwQSbP1WdlrW1rFckfWqj427FUx6bvYihQaVWuc9Nqh3zCnA4NzM3AFqgTnVrgLW8fhOkd+wKgEQFeGWQm1c08VVJbFzLcZEcvkoHHpEUNvpE14K2+FLURzuauSKSGK+NHy3fPNjJAxILc/TGNgS22B+3PXwONwQg2PMkhDuQXZNcVsoA0rKoIjpR/oKx6C2qEQS8xZ4bvIsEydYqkidQW/DRkh9RZPWuIVl7BVIgUUHrvQKnggNK+dMTovw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QLtav1uO; dkim-atps=neutral; spf=pass (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QLtav1uO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLpXW63s7z3fGT
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Feb 2026 09:04:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772057069; x=1803593069;
  h=date:from:to:cc:subject:message-id;
  bh=zSgyTLR9dnyYeQlNsdToVhm5ngih/FxtoGxI6c/abDY=;
  b=QLtav1uOcX0jjnoqqTql8eHrRrKBdKpFVmcdKW7L2zhsVFPbQKiaz+pl
   PJLh0ngCTewDTGmIh39X7oD0uu6qK1lsRJBnB8dSIpzN9cpV4kCm/ncHP
   xX9txuhmTHMxdMQkphUyPuvYO7mkhfq38z7uWM+0J9m8GC+hB3WY6KJpe
   x2xEc30YTfnkZpWnPmi4QJuF4Eq1UDlEpSa5aSM/JR76ocP6rtkTUXw+v
   PMWsqR0/OmDIRu1Kl9KeMlqW5BAXQcMFjBiHdLfW1lwbJABFMy8hBM0Vh
   H7356dodmod46AzppWE0TLOZ6H7+2Lr7FabR6Wmydh9rx0YDhWqtCca61
   A==;
X-CSE-ConnectionGUID: npWXRvPZTNC9wVMQ7yagWA==
X-CSE-MsgGUID: Gj74tJmlQXOe/VTHV+wgnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="84566753"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="84566753"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 14:04:22 -0800
X-CSE-ConnectionGUID: mQpri4X7RL6qy/rkIsppNw==
X-CSE-MsgGUID: E7HzqgMHQASFGGCfa4uJ1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="220991655"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 25 Feb 2026 14:04:20 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvMzR-000000007TB-3kG4;
	Wed, 25 Feb 2026 22:04:17 +0000
Date: Thu, 26 Feb 2026 06:03:32 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 4a2d046e4b13202a6301a993961f5b30ae4d7119
Message-ID: <202602260624.pO8cfi53-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2416-lists,linux-erofs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 742E219E215
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 4a2d046e4b13202a6301a993961f5b30ae4d7119  erofs: fix interlaced plain identification for encoded extents

elapsed time: 728m

configs tested: 354
configs skipped: 3

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
arc                   randconfig-001-20260225    gcc-8.5.0
arc                   randconfig-001-20260226    gcc-15.2.0
arc                   randconfig-002-20260225    gcc-8.5.0
arc                   randconfig-002-20260226    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                       aspeed_g5_defconfig    gcc-15.2.0
arm                          collie_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                            dove_defconfig    gcc-15.2.0
arm                          gemini_defconfig    gcc-15.2.0
arm                           h3600_defconfig    gcc-15.2.0
arm                            mmp2_defconfig    gcc-15.2.0
arm                       multi_v4t_defconfig    clang-16
arm                       omap2plus_defconfig    gcc-15.2.0
arm                   randconfig-001-20260225    gcc-8.5.0
arm                   randconfig-001-20260226    gcc-15.2.0
arm                   randconfig-002-20260225    gcc-8.5.0
arm                   randconfig-002-20260226    gcc-15.2.0
arm                   randconfig-003-20260225    gcc-8.5.0
arm                   randconfig-003-20260226    gcc-15.2.0
arm                   randconfig-004-20260225    gcc-8.5.0
arm                   randconfig-004-20260226    gcc-15.2.0
arm                        shmobile_defconfig    gcc-15.2.0
arm                         socfpga_defconfig    gcc-15.2.0
arm                           spitz_defconfig    gcc-15.2.0
arm                           sunxi_defconfig    gcc-15.2.0
arm                       versatile_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260225    gcc-9.5.0
arm64                 randconfig-001-20260226    gcc-14.3.0
arm64                 randconfig-002-20260225    clang-23
arm64                 randconfig-002-20260225    gcc-9.5.0
arm64                 randconfig-002-20260226    gcc-14.3.0
arm64                 randconfig-003-20260225    gcc-13.4.0
arm64                 randconfig-003-20260225    gcc-9.5.0
arm64                 randconfig-003-20260226    gcc-14.3.0
arm64                 randconfig-004-20260225    gcc-12.5.0
arm64                 randconfig-004-20260225    gcc-9.5.0
arm64                 randconfig-004-20260226    gcc-14.3.0
csky                             alldefconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260225    gcc-14.3.0
csky                  randconfig-001-20260225    gcc-9.5.0
csky                  randconfig-001-20260226    gcc-14.3.0
csky                  randconfig-002-20260225    gcc-13.4.0
csky                  randconfig-002-20260225    gcc-9.5.0
csky                  randconfig-002-20260226    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260225    clang-23
hexagon               randconfig-001-20260226    clang-23
hexagon               randconfig-002-20260225    clang-23
hexagon               randconfig-002-20260226    clang-23
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260225    clang-20
i386        buildonly-randconfig-001-20260226    gcc-14
i386        buildonly-randconfig-002-20260225    clang-20
i386        buildonly-randconfig-002-20260226    gcc-14
i386        buildonly-randconfig-003-20260225    clang-20
i386        buildonly-randconfig-003-20260225    gcc-14
i386        buildonly-randconfig-003-20260226    gcc-14
i386        buildonly-randconfig-004-20260225    clang-20
i386        buildonly-randconfig-004-20260226    gcc-14
i386        buildonly-randconfig-005-20260225    clang-20
i386        buildonly-randconfig-005-20260226    gcc-14
i386        buildonly-randconfig-006-20260225    clang-20
i386        buildonly-randconfig-006-20260226    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260225    clang-20
i386                  randconfig-001-20260225    gcc-14
i386                  randconfig-001-20260226    clang-20
i386                  randconfig-002-20260225    gcc-14
i386                  randconfig-002-20260226    clang-20
i386                  randconfig-003-20260225    clang-20
i386                  randconfig-003-20260225    gcc-14
i386                  randconfig-003-20260226    clang-20
i386                  randconfig-004-20260225    gcc-14
i386                  randconfig-004-20260226    clang-20
i386                  randconfig-005-20260225    clang-20
i386                  randconfig-005-20260225    gcc-14
i386                  randconfig-005-20260226    clang-20
i386                  randconfig-006-20260225    clang-20
i386                  randconfig-006-20260225    gcc-14
i386                  randconfig-006-20260226    clang-20
i386                  randconfig-007-20260225    gcc-14
i386                  randconfig-007-20260226    clang-20
i386                  randconfig-011-20260225    gcc-13
i386                  randconfig-011-20260225    gcc-14
i386                  randconfig-011-20260226    gcc-14
i386                  randconfig-012-20260225    clang-20
i386                  randconfig-012-20260225    gcc-13
i386                  randconfig-012-20260226    gcc-14
i386                  randconfig-013-20260225    gcc-13
i386                  randconfig-013-20260226    gcc-14
i386                  randconfig-014-20260225    gcc-13
i386                  randconfig-014-20260225    gcc-14
i386                  randconfig-014-20260226    gcc-14
i386                  randconfig-015-20260225    clang-20
i386                  randconfig-015-20260225    gcc-13
i386                  randconfig-015-20260226    gcc-14
i386                  randconfig-016-20260225    clang-20
i386                  randconfig-016-20260225    gcc-13
i386                  randconfig-016-20260226    gcc-14
i386                  randconfig-017-20260225    gcc-13
i386                  randconfig-017-20260226    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260225    clang-23
loongarch             randconfig-001-20260226    clang-23
loongarch             randconfig-002-20260225    clang-23
loongarch             randconfig-002-20260226    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         amcore_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                        m5272c3_defconfig    gcc-15.2.0
m68k                        m5407c3_defconfig    gcc-15.2.0
m68k                        mvme16x_defconfig    gcc-15.2.0
m68k                          sun3x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                  decstation_64_defconfig    gcc-15.2.0
mips                           ip22_defconfig    gcc-15.2.0
mips                       lemote2f_defconfig    gcc-15.2.0
mips                   sb1250_swarm_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260225    clang-23
nios2                 randconfig-001-20260226    clang-23
nios2                 randconfig-002-20260225    clang-23
nios2                 randconfig-002-20260226    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                       virt_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260225    clang-19
parisc                randconfig-001-20260225    gcc-15.2.0
parisc                randconfig-001-20260226    clang-16
parisc                randconfig-002-20260225    clang-19
parisc                randconfig-002-20260225    gcc-8.5.0
parisc                randconfig-002-20260226    clang-16
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                    amigaone_defconfig    gcc-15.2.0
powerpc                     asp8347_defconfig    clang-23
powerpc                      chrp32_defconfig    gcc-15.2.0
powerpc                      cm5200_defconfig    clang-23
powerpc                      katmai_defconfig    gcc-15.2.0
powerpc                 mpc8313_rdb_defconfig    gcc-15.2.0
powerpc                  mpc866_ads_defconfig    clang-23
powerpc               randconfig-001-20260225    clang-19
powerpc               randconfig-001-20260225    gcc-12.5.0
powerpc               randconfig-001-20260226    clang-16
powerpc               randconfig-002-20260225    clang-19
powerpc               randconfig-002-20260226    clang-16
powerpc                    sam440ep_defconfig    gcc-15.2.0
powerpc                     skiroot_defconfig    clang-23
powerpc                     tqm8560_defconfig    gcc-15.2.0
powerpc                        warp_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260225    clang-19
powerpc64             randconfig-001-20260225    clang-23
powerpc64             randconfig-001-20260226    clang-16
powerpc64             randconfig-002-20260225    clang-19
powerpc64             randconfig-002-20260225    gcc-15.2.0
powerpc64             randconfig-002-20260226    clang-16
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_k210_defconfig    clang-23
riscv                    nommu_virt_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260225    gcc-12.5.0
riscv                 randconfig-002-20260225    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260225    gcc-12.5.0
s390                  randconfig-002-20260225    gcc-12.5.0
s390                       zfcpdump_defconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                         ap325rxa_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                            hp6xx_defconfig    gcc-15.2.0
sh                          kfr2r09_defconfig    gcc-15.2.0
sh                    randconfig-001-20260225    gcc-12.5.0
sh                    randconfig-002-20260225    gcc-12.5.0
sh                   rts7751r2dplus_defconfig    gcc-15.2.0
sh                          sdk7780_defconfig    gcc-15.2.0
sh                           se7724_defconfig    gcc-15.2.0
sh                   secureedge5410_defconfig    gcc-15.2.0
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sh                   sh7724_generic_defconfig    gcc-15.2.0
sh                        sh7763rdp_defconfig    gcc-15.2.0
sh                             shx3_defconfig    gcc-15.2.0
sh                            titan_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260225    gcc-11.5.0
sparc                 randconfig-001-20260226    gcc-8.5.0
sparc                 randconfig-002-20260225    gcc-11.5.0
sparc                 randconfig-002-20260225    gcc-12.5.0
sparc                 randconfig-002-20260226    gcc-8.5.0
sparc                       sparc64_defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260225    clang-20
sparc64               randconfig-001-20260225    gcc-11.5.0
sparc64               randconfig-001-20260226    gcc-8.5.0
sparc64               randconfig-002-20260225    gcc-11.5.0
sparc64               randconfig-002-20260226    gcc-8.5.0
um                               alldefconfig    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260225    clang-18
um                    randconfig-001-20260225    gcc-11.5.0
um                    randconfig-001-20260226    gcc-8.5.0
um                    randconfig-002-20260225    clang-23
um                    randconfig-002-20260225    gcc-11.5.0
um                    randconfig-002-20260226    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
um                           x86_64_defconfig    gcc-15.2.0
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260225    clang-20
x86_64      buildonly-randconfig-001-20260226    gcc-14
x86_64      buildonly-randconfig-002-20260225    clang-20
x86_64      buildonly-randconfig-002-20260226    gcc-14
x86_64      buildonly-randconfig-003-20260225    clang-20
x86_64      buildonly-randconfig-003-20260226    gcc-14
x86_64      buildonly-randconfig-004-20260225    clang-20
x86_64      buildonly-randconfig-004-20260226    gcc-14
x86_64      buildonly-randconfig-005-20260225    clang-20
x86_64      buildonly-randconfig-005-20260226    gcc-14
x86_64      buildonly-randconfig-006-20260225    clang-20
x86_64      buildonly-randconfig-006-20260226    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260225    gcc-14
x86_64                randconfig-001-20260226    gcc-14
x86_64                randconfig-002-20260225    gcc-14
x86_64                randconfig-002-20260226    gcc-14
x86_64                randconfig-003-20260225    gcc-14
x86_64                randconfig-003-20260226    gcc-14
x86_64                randconfig-004-20260225    gcc-14
x86_64                randconfig-004-20260226    gcc-14
x86_64                randconfig-005-20260225    gcc-14
x86_64                randconfig-005-20260226    gcc-14
x86_64                randconfig-006-20260225    gcc-14
x86_64                randconfig-006-20260226    gcc-14
x86_64                randconfig-011-20260225    gcc-14
x86_64                randconfig-011-20260226    gcc-14
x86_64                randconfig-012-20260225    gcc-14
x86_64                randconfig-012-20260226    gcc-14
x86_64                randconfig-013-20260225    gcc-14
x86_64                randconfig-013-20260226    gcc-14
x86_64                randconfig-014-20260225    gcc-14
x86_64                randconfig-014-20260226    gcc-14
x86_64                randconfig-015-20260225    gcc-14
x86_64                randconfig-015-20260226    gcc-14
x86_64                randconfig-016-20260225    gcc-14
x86_64                randconfig-016-20260226    gcc-14
x86_64                randconfig-071-20260225    clang-20
x86_64                randconfig-071-20260226    gcc-14
x86_64                randconfig-072-20260225    clang-20
x86_64                randconfig-072-20260226    gcc-14
x86_64                randconfig-073-20260225    clang-20
x86_64                randconfig-073-20260226    gcc-14
x86_64                randconfig-074-20260225    clang-20
x86_64                randconfig-074-20260225    gcc-14
x86_64                randconfig-074-20260226    gcc-14
x86_64                randconfig-075-20260225    clang-20
x86_64                randconfig-075-20260225    gcc-14
x86_64                randconfig-075-20260226    gcc-14
x86_64                randconfig-076-20260225    clang-20
x86_64                randconfig-076-20260225    gcc-14
x86_64                randconfig-076-20260226    gcc-14
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
xtensa                randconfig-001-20260225    gcc-11.5.0
xtensa                randconfig-001-20260225    gcc-14.3.0
xtensa                randconfig-001-20260226    gcc-8.5.0
xtensa                randconfig-002-20260225    gcc-11.5.0
xtensa                randconfig-002-20260225    gcc-8.5.0
xtensa                randconfig-002-20260226    gcc-8.5.0
xtensa                         virt_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

