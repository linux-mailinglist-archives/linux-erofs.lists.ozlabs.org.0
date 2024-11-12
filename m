Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74259C5F79
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 18:51:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xnv9D3Xhgz2ygB
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Nov 2024 04:51:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731433867;
	cv=none; b=AhOGhM2FuYBzstR8tm739QMpL7+M6qUiuAgjXJxETZFbNAxFZNNHkoU/wW/QHCTwbpIovm1S3TyJRP3/Pq6boDa0y+3qwyXCne9osjbLNaHp9hn/45iC3sjvAVzUnYPVrftFxuO4qdwidkaOd4fUllmNWKF9dotEtbeMgq2tf3yK/ney5HKnh392G0j1BiMrIVbuvBftn2My0kBvpQsmRSwGyhUUZgHr76O3Aej39a/hliOd+088iqW/d1P2n9QeNhYrYkI/L13Is8A8V9MGYT/zLqtn7qiNi5FfbdfLOWPEtBPldUamvgEno2ag/5dflV59NC6tG6lm9Hk/CLK48g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731433867; c=relaxed/relaxed;
	bh=KvwVNwazX/ERxIo3JUWtJ46P0e7jfvDrQtbY0gA5zKg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=J6CU4f8up1/I0+cQzneWqDPfcsZBUJ0CCWPmtGOKtBuakVA5/qCzNixhMo+oGXUFMRPeg6EK5cONG/3Cig5SXfkX/h/qLwfeWRLk8Tiwqj7WXDnowwbvowuD9UZy5De0UZU6sVeUYxePl9RCbYTstaTz4N7VBJtssjJ1ayAIBZY/2Sl8u+vYuMREaktzGSj4BVC62o97gZn4IdkhHrvBpORqfrUdKwlK3cKJwJ6Qmoz73wTKDAqNItanlCEKDcf3Sw584/uYobnLWuEdaGcpYRufpnssTLNhq6atFeWXFER63WRlXnaode4XsLoxeboqVnAw1I6f86CvqDyhuH5eWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F+/1V7CD; dkim-atps=neutral; spf=pass (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F+/1V7CD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xnv912jc4z2xfb
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Nov 2024 04:50:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731433862; x=1762969862;
  h=date:from:to:cc:subject:message-id;
  bh=YSJDb8j3pynXf/Sz5o0yyM0X40iRxtDx1bJZlvPf8cs=;
  b=F+/1V7CDVclgTV019FQWpNZiYMz6DRFDJYqJe5nD6fp2Lp5rl7ybyUqR
   vylIzIC8593yfF/6PG8Or5L5tgCQMabe4d6iP+i4Iz3cijAXkTSqUSNdi
   OM4LlEsxmWCuofOH/onFhnaEwl6aRgT/uusA/4vC0T2YDKXVhRjBZxrRn
   xAcF2uPAhY+7t6uxGHLR+Tcr19qgvnl1mCJjkSLz2/7SNUERNE18QN9Fp
   kNOMdeil/QiO8m/MlRkwjOE/oOgq5lBeVJS+wYn9k+rGIH7IrMd7YuYAl
   wE7Qmals9leEPQqv7V418BkEOTubRG/H6BvaK9tfhNFd17NCRDVqGFTCk
   Q==;
X-CSE-ConnectionGUID: bxRzR1HTR8C9+RNdDsfsmg==
X-CSE-MsgGUID: oWltixTrQv2UCrbPWsIb3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34991720"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34991720"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 09:50:48 -0800
X-CSE-ConnectionGUID: kPzQZOJUTn6NSUerZG6t1w==
X-CSE-MsgGUID: 0f9HTaQ3SwGWGSLDW6m4QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="92530734"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 12 Nov 2024 09:50:46 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAv2J-0001b9-1v;
	Tue, 12 Nov 2024 17:50:43 +0000
Date: Wed, 13 Nov 2024 01:49:44 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 5826fdd08de499ae60afb3f3c6850276051717ce
Message-ID: <202411130139.a5CgBcvS-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 5826fdd08de499ae60afb3f3c6850276051717ce  erofs: free pclusters if no cached folio is attached

elapsed time: 727m

configs tested: 213
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                        nsimosci_defconfig    clang-20
arc                   randconfig-001-20241112    gcc-13.2.0
arc                   randconfig-001-20241112    gcc-14.2.0
arc                   randconfig-002-20241112    gcc-13.2.0
arc                   randconfig-002-20241112    gcc-14.2.0
arc                           tb10x_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                      footbridge_defconfig    clang-20
arm                          gemini_defconfig    gcc-14.2.0
arm                      integrator_defconfig    gcc-14.2.0
arm                          pxa168_defconfig    gcc-14.2.0
arm                   randconfig-001-20241112    clang-20
arm                   randconfig-001-20241112    gcc-14.2.0
arm                   randconfig-002-20241112    gcc-14.2.0
arm                   randconfig-003-20241112    clang-14
arm                   randconfig-003-20241112    gcc-14.2.0
arm                   randconfig-004-20241112    gcc-14.2.0
arm                           sama5_defconfig    gcc-14.2.0
arm                       spear13xx_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241112    gcc-14.2.0
arm64                 randconfig-002-20241112    clang-20
arm64                 randconfig-002-20241112    gcc-14.2.0
arm64                 randconfig-003-20241112    clang-20
arm64                 randconfig-003-20241112    gcc-14.2.0
arm64                 randconfig-004-20241112    clang-20
arm64                 randconfig-004-20241112    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241112    gcc-14.2.0
csky                  randconfig-002-20241112    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241112    clang-17
hexagon               randconfig-001-20241112    gcc-14.2.0
hexagon               randconfig-002-20241112    clang-20
hexagon               randconfig-002-20241112    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241112    clang-19
i386        buildonly-randconfig-002-20241112    clang-19
i386        buildonly-randconfig-003-20241112    clang-19
i386        buildonly-randconfig-004-20241112    clang-19
i386        buildonly-randconfig-005-20241112    clang-19
i386        buildonly-randconfig-006-20241112    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241112    clang-19
i386                  randconfig-002-20241112    clang-19
i386                  randconfig-003-20241112    clang-19
i386                  randconfig-004-20241112    clang-19
i386                  randconfig-005-20241112    clang-19
i386                  randconfig-006-20241112    clang-19
i386                  randconfig-011-20241112    clang-19
i386                  randconfig-012-20241112    clang-19
i386                  randconfig-013-20241112    clang-19
i386                  randconfig-014-20241112    clang-19
i386                  randconfig-015-20241112    clang-19
i386                  randconfig-016-20241112    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    clang-20
loongarch             randconfig-001-20241112    gcc-14.2.0
loongarch             randconfig-002-20241112    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           gcw0_defconfig    gcc-14.2.0
mips                           ip30_defconfig    gcc-14.2.0
mips                           mtx1_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241112    gcc-14.2.0
nios2                 randconfig-002-20241112    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241112    gcc-14.2.0
parisc                randconfig-002-20241112    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                     akebono_defconfig    clang-20
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                   lite5200b_defconfig    clang-20
powerpc                   lite5200b_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    clang-20
powerpc               mpc834x_itxgp_defconfig    gcc-14.2.0
powerpc                 mpc836x_rdk_defconfig    clang-20
powerpc                      ppc64e_defconfig    clang-20
powerpc               randconfig-001-20241112    gcc-14.2.0
powerpc               randconfig-002-20241112    gcc-14.2.0
powerpc               randconfig-003-20241112    gcc-14.2.0
powerpc64             randconfig-001-20241112    gcc-14.2.0
powerpc64             randconfig-002-20241112    gcc-14.2.0
powerpc64             randconfig-003-20241112    clang-14
powerpc64             randconfig-003-20241112    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                               defconfig    gcc-14.2.0
riscv                 randconfig-001-20241112    gcc-14.2.0
riscv                 randconfig-002-20241112    clang-20
riscv                 randconfig-002-20241112    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241112    gcc-14.2.0
s390                  randconfig-002-20241112    clang-20
s390                  randconfig-002-20241112    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                         ecovec24_defconfig    clang-20
sh                               j2_defconfig    gcc-14.2.0
sh                    randconfig-001-20241112    gcc-14.2.0
sh                    randconfig-002-20241112    gcc-14.2.0
sh                          rsk7264_defconfig    clang-20
sh                           se7750_defconfig    clang-20
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241112    gcc-14.2.0
sparc64               randconfig-002-20241112    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241112    gcc-12
um                    randconfig-001-20241112    gcc-14.2.0
um                    randconfig-002-20241112    gcc-12
um                    randconfig-002-20241112    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241112    gcc-12
x86_64      buildonly-randconfig-002-20241112    gcc-12
x86_64      buildonly-randconfig-003-20241112    gcc-12
x86_64      buildonly-randconfig-004-20241112    gcc-12
x86_64      buildonly-randconfig-005-20241112    gcc-12
x86_64      buildonly-randconfig-006-20241112    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241112    gcc-12
x86_64                randconfig-002-20241112    gcc-12
x86_64                randconfig-003-20241112    gcc-12
x86_64                randconfig-004-20241112    gcc-12
x86_64                randconfig-005-20241112    gcc-12
x86_64                randconfig-006-20241112    gcc-12
x86_64                randconfig-011-20241112    gcc-12
x86_64                randconfig-012-20241112    gcc-12
x86_64                randconfig-013-20241112    gcc-12
x86_64                randconfig-014-20241112    gcc-12
x86_64                randconfig-015-20241112    gcc-12
x86_64                randconfig-016-20241112    gcc-12
x86_64                randconfig-071-20241112    gcc-12
x86_64                randconfig-072-20241112    gcc-12
x86_64                randconfig-073-20241112    gcc-12
x86_64                randconfig-074-20241112    gcc-12
x86_64                randconfig-075-20241112    gcc-12
x86_64                randconfig-076-20241112    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    clang-20
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20241112    gcc-14.2.0
xtensa                randconfig-002-20241112    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
