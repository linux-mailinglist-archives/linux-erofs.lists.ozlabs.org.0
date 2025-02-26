Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F7CA45FB2
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Feb 2025 13:49:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z2vRh5x77z3bpJ
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Feb 2025 23:49:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740574143;
	cv=none; b=TFa91NXMS2O64Gq803c5f1YX03XxJ7oyk9LatMH3+PMMZUtDs29chtFPIPnmm1j3crL+9wByiBimST+XsvEjVTlL4HA1kYJRE/ZWM+kC7SypGhGDCIrt3R4hRwrUmDEaSen5afzgM/ZlKH0hkyf0s2OMGS+38zL+rs6Ayr39nHewm3MkGqtIv3rQ7EvCZ6bq+xR59isg1FBm3dyZcjC08o9cLPdkoaV6XbR1I9ih6ONrQWUmRJkTxSoZO2s83zHml4fU6wcstK1FVABKztqZjyhkjErtE6V/GUlPheEvxWq2LMwCbt/045dYMwopc6vL16QL9NDVFFO/PA727wiE6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740574143; c=relaxed/relaxed;
	bh=tAIDoJT8CQg2rjis3jonzj4d6VDvJhmmsI//hi08+OI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=de9ibOMMj7smc03wjuPuCBzYFXL8qM7EM/EtFohR0h7cVVTcF3Y9doZj6eu+mDHfDYZYDgDA+RfGPoFoDkVPnV+EXp3vlD4LYmn9B+E0ciY3s3Gk6BSIaN9XyVPF4R9sgaAVFE6JFBKnmff87PzKWlgxyp3MYyNBZr4NDJbXjQKZhoTllXV9FH/VSLjoK0sY1WjSQ+sbvjbLVTSn58mXMgfnxpADEpyfm/w2TfQBdbqr+m7BUtAvhYKCltK9Mw755ccOlHicyFpbRlJjcN9RbnyCN58TChTokTrFc/XJTjynVzpA7+OzwfMtImSiSQmp+U6a3LCG79ncAc63Pudgaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P313gn61; dkim-atps=neutral; spf=pass (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P313gn61;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Wed, 26 Feb 2025 23:49:01 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z2vRd0sL7z3bm3
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Feb 2025 23:49:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740574142; x=1772110142;
  h=date:from:to:cc:subject:message-id;
  bh=e06raAYhTlR9m++I+rq0jYSQRFJhaWBTdNhCFFZo8zk=;
  b=P313gn61p9dXd776Y3heJ3H/k29NgKzL04LvzQscEoLO1bLLdy2/oNhu
   p+TB6lRb9L8iOfZAjU12NOw5T5QLmiKM7RjkJuPSz2tzHbHytF18x8KXY
   P06GORIfzLRVDKDvR73bmnXcqE7bGOCAFASFZeSXFlTxp9pXeBcWPIP5f
   vdizFCkX7nP5HHYARFQDHufVevAIcJFetlEBt5ZBr9mskyphu97/CsROv
   ot4kW4AVMn5KqQgDnu0T5gzPQtwPZjwt0pA2yGtX96dgxlM8Ybpbv3Arm
   homRM2KHapYZbmoCye5qP8qzWv9MtRocJMFPKnQhTaT2fma6CVoAASF9k
   g==;
X-CSE-ConnectionGUID: 7WgOYl64SRaxJXHW4Rh8RA==
X-CSE-MsgGUID: msfVFLP7S5uNbZqvXa6iGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41612099"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41612099"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 04:47:53 -0800
X-CSE-ConnectionGUID: +vnCbJcxTLabIUWVZ/vRfQ==
X-CSE-MsgGUID: kcGDwSQwRLmopSVMJphI8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="116478315"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 26 Feb 2025 04:47:51 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnGpI-000Bi0-1U;
	Wed, 26 Feb 2025 12:47:48 +0000
Date: Wed, 26 Feb 2025 20:46:53 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 0fb25a2943e12f559de081943ce3d0fbe2156488
Message-ID: <202502262046.PQ8suPq5-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 0fb25a2943e12f559de081943ce3d0fbe2156488  erofs: clean up header parsing for ztailpacking and fragments

elapsed time: 1447m

configs tested: 80
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250226    gcc-13.2.0
arc                  randconfig-002-20250226    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250226    gcc-14.2.0
arm                  randconfig-002-20250226    clang-21
arm                  randconfig-003-20250226    gcc-14.2.0
arm                  randconfig-004-20250226    gcc-14.2.0
arm64                           allmodconfig    clang-18
arm64                randconfig-001-20250226    gcc-14.2.0
arm64                randconfig-002-20250226    gcc-14.2.0
arm64                randconfig-003-20250226    clang-21
arm64                randconfig-004-20250226    gcc-14.2.0
csky                 randconfig-001-20250226    gcc-14.2.0
csky                 randconfig-002-20250226    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250226    clang-21
hexagon              randconfig-002-20250226    clang-21
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250225    clang-19
i386       buildonly-randconfig-001-20250226    gcc-12
i386       buildonly-randconfig-002-20250225    gcc-11
i386       buildonly-randconfig-002-20250226    gcc-12
i386       buildonly-randconfig-003-20250225    clang-19
i386       buildonly-randconfig-003-20250226    gcc-12
i386       buildonly-randconfig-004-20250225    clang-19
i386       buildonly-randconfig-004-20250226    clang-19
i386       buildonly-randconfig-005-20250225    gcc-12
i386       buildonly-randconfig-005-20250226    gcc-12
i386       buildonly-randconfig-006-20250225    clang-19
i386       buildonly-randconfig-006-20250226    gcc-12
i386                               defconfig    clang-19
loongarch            randconfig-001-20250226    gcc-14.2.0
loongarch            randconfig-002-20250226    gcc-14.2.0
nios2                randconfig-001-20250226    gcc-14.2.0
nios2                randconfig-002-20250226    gcc-14.2.0
parisc               randconfig-001-20250226    gcc-14.2.0
parisc               randconfig-002-20250226    gcc-14.2.0
powerpc              randconfig-001-20250226    gcc-14.2.0
powerpc              randconfig-002-20250226    clang-18
powerpc              randconfig-003-20250226    clang-21
powerpc64            randconfig-001-20250226    clang-18
powerpc64            randconfig-002-20250226    gcc-14.2.0
powerpc64            randconfig-003-20250226    gcc-14.2.0
riscv                randconfig-001-20250225    clang-15
riscv                randconfig-002-20250225    clang-21
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250225    clang-15
s390                 randconfig-002-20250225    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250225    gcc-14.2.0
sh                   randconfig-002-20250225    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250225    gcc-14.2.0
sparc                randconfig-002-20250225    gcc-14.2.0
sparc64              randconfig-001-20250225    gcc-14.2.0
sparc64              randconfig-002-20250225    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250225    clang-21
um                   randconfig-002-20250225    gcc-12
x86_64                           allnoconfig    clang-19
x86_64                          allyesconfig    clang-19
x86_64     buildonly-randconfig-001-20250225    gcc-12
x86_64     buildonly-randconfig-002-20250225    clang-19
x86_64     buildonly-randconfig-003-20250225    clang-19
x86_64     buildonly-randconfig-004-20250225    gcc-11
x86_64     buildonly-randconfig-005-20250225    gcc-12
x86_64     buildonly-randconfig-006-20250225    clang-19
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250225    gcc-14.2.0
xtensa               randconfig-002-20250225    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
