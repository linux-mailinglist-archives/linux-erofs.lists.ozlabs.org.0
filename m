Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE96A407CE
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Feb 2025 12:06:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z0PM43BBNz306x
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Feb 2025 22:06:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740222382;
	cv=none; b=f3P4gzjnF8SiLv88KQb2baHerOf53azhT8RrgHR0LE/2wZQHU/M0ss/SDZZTZSa0OozhdiV31oHF4tEOW0ix91ovoOJQ9IOh7WgBsvBNq5k5AThCLnxW1MfuNVe55g0Qya609COdBy2EpT7gm81o4KbDiO8IgXJYcafl3jibl09yEwLV4mk+/744ZTj2QZLpGi4P9w3Sm57asipFR8LT/STApIOw2kXypKz54No/zkgw3nkY44cZEDMWiBYSc0smYp2wWm1iwEdAm0evL9We8pBIlA6IF4aQjRceLHLcZjURD15pAMjGddqBkfMOuiIsjApEx0ssbv5iilOwDrCuSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740222382; c=relaxed/relaxed;
	bh=Sl9czl4fExLFYPwIaSO1IOOu4ykZ9rpXeljBCwBC4Pg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cAxqoupxBePc2HprnDDA1CPzxcsxN1SaaFHsBf+JPYg7htosXr0wT3kgepcGHp5ioH7P0RESQ2R4Qk50oRGJV1z/jJCWW0iK05X7w4FPgEDbEIHUAZ6F1o49AnMmRIrXP580lufbBZ+pCMoHyUQh0wFnrs/YeHw1qRI35MitSI0f7RiUqCQ6hltPGHDlZ2MdjRZLtySemPT7TytceQShZWQ7n8446BKmuAdEsjHOY4mtijGDmLykpZGMNVXdz89HtDvViST9JPQA2n7YZgtc9agV6bKO+DS7Gb28o2qTIEG/WQnhKXidGh+HKUktKnUxS7D3xjq5lsDbMgo/YgAK+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NGVjf/ki; dkim-atps=neutral; spf=pass (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NGVjf/ki;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z0PLz21bxz2xtK
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Feb 2025 22:06:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740222380; x=1771758380;
  h=date:from:to:cc:subject:message-id;
  bh=lVCjbnJSUBjz7deuiXPlWiNFP2M0asq8/E/ZSStcB9w=;
  b=NGVjf/kid01nnqjbu4e16G1VtEpGtSfAqqlD24OiSmmaO48LCFJYl1zT
   cg6DJg/JWc3jPXEap+EHTrq1ydJczAzbISjgMOvAGZr7dmkyjHw8rPJtS
   3ntdtvPYGP6SaaUFQLDSfbK67i3LwyveBPtPQzFlNP1OaGH88DzIavQEJ
   2hhw+FwfRXj/KYiCXNOFoit+A0CsKhlsR+IzMDgZSFjkQnUDCrC3VhBPk
   fSqq9IFRk358m5X6Gap+4ecnIwBwYKN2cA6THYicqjIPGuGqxhDKHwgIV
   Vihvsw/0O088ITk53rswktVlyxSPf/0ktNdmzyil57RVAO2akdepDOOp7
   w==;
X-CSE-ConnectionGUID: pzy2J/eRTcGHoHHVYxmloQ==
X-CSE-MsgGUID: dat4FPhxQ8GVqkRGq4QZGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="41299729"
X-IronPort-AV: E=Sophos;i="6.13,307,1732608000"; 
   d="scan'208";a="41299729"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 03:06:14 -0800
X-CSE-ConnectionGUID: F/1ObAgrStydqmkvag7zCA==
X-CSE-MsgGUID: 3taGlpnNR4yLC/qbkN4x7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="146497302"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 22 Feb 2025 03:06:12 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlnKk-0006VJ-1g;
	Sat, 22 Feb 2025 11:06:10 +0000
Date: Sat, 22 Feb 2025 19:05:24 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 67039e1ee225d4b41dd8166791e130f237b68ce4
Message-ID: <202502221918.zpXPHTLw-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 67039e1ee225d4b41dd8166791e130f237b68ce4  erofs: clean up header parsing for ztailpacking and fragments

elapsed time: 1450m

configs tested: 63
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250221    gcc-13.2.0
arc                  randconfig-002-20250221    gcc-13.2.0
arm                  randconfig-001-20250221    gcc-14.2.0
arm                  randconfig-002-20250221    clang-19
arm                  randconfig-003-20250221    gcc-14.2.0
arm                  randconfig-004-20250221    clang-21
arm64                randconfig-001-20250221    clang-15
arm64                randconfig-002-20250221    clang-21
arm64                randconfig-003-20250221    clang-21
arm64                randconfig-004-20250221    gcc-14.2.0
csky                 randconfig-001-20250221    gcc-14.2.0
csky                 randconfig-002-20250221    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250221    clang-21
hexagon              randconfig-002-20250221    clang-21
i386       buildonly-randconfig-001-20250221    gcc-12
i386       buildonly-randconfig-002-20250221    gcc-12
i386       buildonly-randconfig-003-20250221    gcc-12
i386       buildonly-randconfig-004-20250221    gcc-12
i386       buildonly-randconfig-005-20250221    clang-19
i386       buildonly-randconfig-006-20250221    clang-19
loongarch            randconfig-001-20250221    gcc-14.2.0
loongarch            randconfig-002-20250221    gcc-14.2.0
nios2                randconfig-001-20250221    gcc-14.2.0
nios2                randconfig-002-20250221    gcc-14.2.0
parisc               randconfig-001-20250221    gcc-14.2.0
parisc               randconfig-002-20250221    gcc-14.2.0
powerpc              randconfig-001-20250221    clang-21
powerpc              randconfig-002-20250221    clang-21
powerpc              randconfig-003-20250221    clang-17
powerpc64            randconfig-001-20250221    clang-21
powerpc64            randconfig-002-20250221    clang-21
powerpc64            randconfig-003-20250221    clang-19
riscv                randconfig-001-20250221    clang-21
riscv                randconfig-002-20250221    clang-21
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250221    gcc-14.2.0
s390                 randconfig-002-20250221    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250221    gcc-14.2.0
sh                   randconfig-002-20250221    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250221    gcc-14.2.0
sparc                randconfig-002-20250221    gcc-14.2.0
sparc64              randconfig-001-20250221    gcc-14.2.0
sparc64              randconfig-002-20250221    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250221    gcc-12
um                   randconfig-002-20250221    gcc-12
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250221    gcc-12
x86_64     buildonly-randconfig-002-20250221    clang-19
x86_64     buildonly-randconfig-003-20250221    clang-19
x86_64     buildonly-randconfig-004-20250221    clang-19
x86_64     buildonly-randconfig-005-20250221    clang-19
x86_64     buildonly-randconfig-006-20250221    clang-19
xtensa               randconfig-001-20250221    gcc-14.2.0
xtensa               randconfig-002-20250221    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
