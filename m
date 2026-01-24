Return-Path: <linux-erofs+bounces-2217-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id s8wZOvFPdGkX4gAAu9opvQ
	(envelope-from <linux-erofs+bounces-2217-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Jan 2026 05:52:01 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9E77C832
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Jan 2026 05:51:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dyj7v3r7zz2xSN;
	Sat, 24 Jan 2026 15:51:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769230315;
	cv=none; b=Xbvw4jeuyAmZ7HyA1WdAQXdQJKQaCFwgVE/mrHFYuojx6Ex33BJG514oKmP0utvlqQGho9NhzjO0+cr37caFrU4ADIWF31MQsLLqmRN8VHJwEl2xLwXAKF+7OYbDP7EqYCXfl1nu+61APWTGdrrjd2vha4z0WNZTdlpJG3KFSz374sAN1GRFVITTvxc7ODxUTYZFFso9TVNPiuHHiffFLSER7sr/eHt/vkhFGgcwfOY4aiwnuE89uMM9uXXf6UbKlMMgK62jf3d1LfFW/0BSbmmO0cEDEg36PU49kK4V0PmkMvOf4h3pDxr8bDhggQGTt6qVnaDvEe3ZBRiuAeFP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769230315; c=relaxed/relaxed;
	bh=6zSJqzHlNgMgMI4rxhjPumDAGEQBTWOY9UJoJzsYWDs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=X5Ro3X5/VJQb8BRDUX1v0CbsvhlnEj0m4v2si6wF5RHA1mZC58uyh8C3nASB7tkvt3MAjm+OM0z86Iu62q8Uuq3E6+fkpPjMGc773Wn87XLFlqDjDYJkZ+bn6tekUKhd+la91T8G8TI5xl0199aWDAPlhCoL03qJFHOva3swGqTwGDBa30goHThiI8vWN4NtqzV/OVsIjZlJtyRPLIa46ePZ8HPtZ2XQ/DjOvIdrBKQAluoJjQzqwSSNk5EmMxqdPx1pTaVIyM55BhnfFlyq1XiIIFmIS2Fe7wxlVkdoJoRv+S32XpA/lzasJ1m0CqdBo1RzD1oowOI2ve1rnEhHJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HR/raycv; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HR/raycv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dyj7r5649z2x9M
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Jan 2026 15:51:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769230313; x=1800766313;
  h=date:from:to:cc:subject:message-id;
  bh=+VLq1Du/3WZsjWuPmwykGO/IxkWHEEfkRRS0W90z98U=;
  b=HR/raycvKUkTjU8vnq8g04/EQ2XzsvbpzUddIDcsSS44HNd9cIT4M4Ke
   3+UwxOXM+U5uxfYpK+TSIYjv7MIS9TsYW0xrAym7fTXw1+GlmgzaSeamW
   wVwW3KMJEEt9/WMTRwqHAl9HEXZvThRmEgSfOCQyknbdQ42S/bq38BlT8
   PQxwvO13z46OrHWSl5VKQLAMH9gKgyliow2BzHtiZeRoPavLOBgTNofv2
   k+eZGrQw+yqhDqVSNv4MSq3R4V0IUrksmM4iHq09sr+GsoEVVY3yBtY0H
   PF+H+FS8hZlpGrI3iaJEA1YDiI8ZDpvU/RDBAe0XFBZaIXTmRwBnH5cQK
   A==;
X-CSE-ConnectionGUID: ege8ok/rR3eAzVX86FMzZg==
X-CSE-MsgGUID: Js6VfFI6S/CwmX5DNFkChQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="95944497"
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="95944497"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 20:51:47 -0800
X-CSE-ConnectionGUID: nnOnastWQAStRgYqNuf80A==
X-CSE-MsgGUID: I+2FUSggT2+hrk08593wtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="238453344"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 23 Jan 2026 20:51:46 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjVcd-00000000UqZ-40RB;
	Sat, 24 Jan 2026 04:51:43 +0000
Date: Sat, 24 Jan 2026 12:51:02 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 d86d7817c042dd651d47b1873f4b6eaefbedd890
Message-ID: <202601241257.gClqpHaK-lkp@intel.com>
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
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2217-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: DC9E77C832
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: d86d7817c042dd651d47b1873f4b6eaefbedd890  erofs: implement .fadvise for page cache share

elapsed time: 996m

configs tested: 305
configs skipped: 5

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
arc                      axs103_smp_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                        nsim_700_defconfig    gcc-15.2.0
arc                   randconfig-001-20260124    clang-18
arc                   randconfig-001-20260124    gcc-14.3.0
arc                   randconfig-002-20260124    clang-18
arc                   randconfig-002-20260124    gcc-13.4.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          gemini_defconfig    gcc-15.2.0
arm                       imx_v4_v5_defconfig    gcc-15.2.0
arm                       multi_v4t_defconfig    clang-16
arm                          pxa168_defconfig    clang-16
arm                          pxa168_defconfig    gcc-15.2.0
arm                   randconfig-001-20260124    clang-18
arm                   randconfig-001-20260124    gcc-8.5.0
arm                   randconfig-002-20260124    clang-18
arm                   randconfig-002-20260124    clang-22
arm                   randconfig-003-20260124    clang-18
arm                   randconfig-004-20260124    clang-18
arm                   randconfig-004-20260124    gcc-15.2.0
arm                           sama7_defconfig    clang-16
arm                        spear3xx_defconfig    gcc-15.2.0
arm                           tegra_defconfig    gcc-15.2.0
arm                       versatile_defconfig    gcc-15.2.0
arm                    vt8500_v6_v7_defconfig    gcc-15.2.0
arm64                            alldefconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260123    gcc-15.2.0
arm64                 randconfig-001-20260124    clang-22
arm64                 randconfig-001-20260124    gcc-15.2.0
arm64                 randconfig-002-20260123    gcc-13.4.0
arm64                 randconfig-002-20260124    clang-22
arm64                 randconfig-002-20260124    gcc-15.2.0
arm64                 randconfig-003-20260123    gcc-10.5.0
arm64                 randconfig-003-20260124    clang-22
arm64                 randconfig-003-20260124    gcc-15.2.0
arm64                 randconfig-004-20260123    gcc-13.4.0
arm64                 randconfig-004-20260124    gcc-15.2.0
arm64                 randconfig-004-20260124    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260123    gcc-15.2.0
csky                  randconfig-001-20260124    gcc-13.4.0
csky                  randconfig-001-20260124    gcc-15.2.0
csky                  randconfig-002-20260123    gcc-15.2.0
csky                  randconfig-002-20260124    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260124    gcc-15.2.0
hexagon               randconfig-002-20260124    gcc-15.2.0
i386                             alldefconfig    clang-16
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260123    clang-20
i386        buildonly-randconfig-001-20260124    gcc-14
i386        buildonly-randconfig-002-20260123    gcc-14
i386        buildonly-randconfig-002-20260124    gcc-14
i386        buildonly-randconfig-003-20260123    gcc-14
i386        buildonly-randconfig-003-20260124    gcc-14
i386        buildonly-randconfig-004-20260123    gcc-14
i386        buildonly-randconfig-004-20260124    gcc-14
i386        buildonly-randconfig-005-20260123    clang-20
i386        buildonly-randconfig-005-20260124    gcc-14
i386        buildonly-randconfig-006-20260123    clang-20
i386        buildonly-randconfig-006-20260124    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260124    gcc-14
i386                  randconfig-002-20260124    gcc-14
i386                  randconfig-003-20260124    gcc-14
i386                  randconfig-004-20260124    gcc-14
i386                  randconfig-005-20260124    gcc-14
i386                  randconfig-006-20260124    gcc-14
i386                  randconfig-007-20260124    gcc-14
i386                  randconfig-011-20260123    clang-20
i386                  randconfig-011-20260124    clang-20
i386                  randconfig-012-20260123    gcc-14
i386                  randconfig-012-20260124    clang-20
i386                  randconfig-013-20260123    gcc-14
i386                  randconfig-013-20260124    clang-20
i386                  randconfig-014-20260123    clang-20
i386                  randconfig-014-20260124    clang-20
i386                  randconfig-015-20260123    gcc-14
i386                  randconfig-015-20260124    clang-20
i386                  randconfig-016-20260123    clang-20
i386                  randconfig-016-20260124    clang-20
i386                  randconfig-017-20260123    gcc-14
i386                  randconfig-017-20260124    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260124    gcc-15.2.0
loongarch             randconfig-002-20260124    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                       m5475evb_defconfig    gcc-15.2.0
m68k                           virt_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                malta_qemu_32r6_defconfig    clang-16
mips                  maltasmvp_eva_defconfig    gcc-15.2.0
mips                        maltaup_defconfig    gcc-15.2.0
mips                    maltaup_xpa_defconfig    gcc-15.2.0
mips                        qi_lb60_defconfig    clang-16
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260124    gcc-15.2.0
nios2                 randconfig-002-20260124    gcc-15.2.0
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
parisc                randconfig-001-20260123    gcc-12.5.0
parisc                randconfig-001-20260124    gcc-8.5.0
parisc                randconfig-002-20260123    gcc-8.5.0
parisc                randconfig-002-20260124    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                 linkstation_defconfig    gcc-15.2.0
powerpc                   motionpro_defconfig    gcc-15.2.0
powerpc                     ppa8548_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260123    clang-22
powerpc               randconfig-001-20260124    gcc-8.5.0
powerpc               randconfig-002-20260123    clang-22
powerpc               randconfig-002-20260124    gcc-8.5.0
powerpc64             randconfig-001-20260123    gcc-8.5.0
powerpc64             randconfig-001-20260124    gcc-8.5.0
powerpc64             randconfig-002-20260123    gcc-13.4.0
powerpc64             randconfig-002-20260124    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260124    gcc-8.5.0
riscv                 randconfig-002-20260124    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260124    gcc-15.2.0
s390                  randconfig-001-20260124    gcc-8.5.0
s390                  randconfig-002-20260124    gcc-15.2.0
s390                  randconfig-002-20260124    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                        edosk7705_defconfig    gcc-15.2.0
sh                            migor_defconfig    gcc-15.2.0
sh                          r7780mp_defconfig    clang-16
sh                    randconfig-001-20260124    gcc-15.2.0
sh                    randconfig-001-20260124    gcc-8.5.0
sh                    randconfig-002-20260124    gcc-13.4.0
sh                    randconfig-002-20260124    gcc-8.5.0
sh                   secureedge5410_defconfig    clang-16
sh                           sh2007_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260124    gcc-13.4.0
sparc                 randconfig-002-20260124    gcc-13.4.0
sparc                       sparc64_defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260124    gcc-13.4.0
sparc64               randconfig-002-20260124    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260124    gcc-13.4.0
um                    randconfig-002-20260124    gcc-13.4.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           alldefconfig    gcc-15.2.0
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260123    clang-20
x86_64      buildonly-randconfig-001-20260124    clang-20
x86_64      buildonly-randconfig-002-20260123    clang-20
x86_64      buildonly-randconfig-002-20260124    clang-20
x86_64      buildonly-randconfig-003-20260123    clang-20
x86_64      buildonly-randconfig-003-20260124    clang-20
x86_64      buildonly-randconfig-004-20260123    clang-20
x86_64      buildonly-randconfig-004-20260124    clang-20
x86_64      buildonly-randconfig-005-20260123    clang-20
x86_64      buildonly-randconfig-005-20260124    clang-20
x86_64      buildonly-randconfig-006-20260123    gcc-14
x86_64      buildonly-randconfig-006-20260124    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260123    clang-20
x86_64                randconfig-001-20260124    gcc-13
x86_64                randconfig-002-20260123    gcc-14
x86_64                randconfig-002-20260124    gcc-13
x86_64                randconfig-003-20260123    gcc-14
x86_64                randconfig-003-20260124    gcc-13
x86_64                randconfig-004-20260123    gcc-14
x86_64                randconfig-004-20260124    gcc-13
x86_64                randconfig-005-20260123    gcc-14
x86_64                randconfig-005-20260124    gcc-13
x86_64                randconfig-006-20260123    gcc-14
x86_64                randconfig-006-20260124    gcc-13
x86_64                randconfig-011-20260123    gcc-13
x86_64                randconfig-011-20260124    gcc-12
x86_64                randconfig-011-20260124    gcc-14
x86_64                randconfig-012-20260123    gcc-14
x86_64                randconfig-012-20260124    gcc-12
x86_64                randconfig-012-20260124    gcc-14
x86_64                randconfig-013-20260123    clang-20
x86_64                randconfig-013-20260124    clang-20
x86_64                randconfig-013-20260124    gcc-12
x86_64                randconfig-014-20260123    gcc-14
x86_64                randconfig-014-20260124    gcc-12
x86_64                randconfig-015-20260123    gcc-14
x86_64                randconfig-015-20260124    gcc-12
x86_64                randconfig-015-20260124    gcc-14
x86_64                randconfig-016-20260123    gcc-13
x86_64                randconfig-016-20260124    gcc-12
x86_64                randconfig-016-20260124    gcc-14
x86_64                randconfig-071-20260123    clang-20
x86_64                randconfig-071-20260124    gcc-14
x86_64                randconfig-072-20260123    clang-20
x86_64                randconfig-072-20260124    gcc-14
x86_64                randconfig-073-20260123    gcc-14
x86_64                randconfig-073-20260124    gcc-14
x86_64                randconfig-074-20260123    gcc-13
x86_64                randconfig-074-20260124    gcc-14
x86_64                randconfig-075-20260123    clang-20
x86_64                randconfig-075-20260124    gcc-14
x86_64                randconfig-076-20260123    gcc-14
x86_64                randconfig-076-20260124    gcc-14
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
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260124    gcc-13.4.0
xtensa                randconfig-002-20260124    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

