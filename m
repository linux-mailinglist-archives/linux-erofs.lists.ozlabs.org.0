Return-Path: <linux-erofs+bounces-302-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75F6AAF42D
	for <lists+linux-erofs@lfdr.de>; Thu,  8 May 2025 08:55:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZtNF725Wgz2yrb;
	Thu,  8 May 2025 16:55:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746687339;
	cv=none; b=hixm+sj9hbWLNOMlRncDLUT7miI43UtG7MequR3ezgD9wg6Q6DnxRYCdgHvk8leFx0kMSUhYvquGRX3y91iZfLrXMgAd8uF0ogcfcR7giuNuWKvh0ocfUNzHbLW3TLOS3QykTydU54eNdP80q3Zx3s06KE4z6x1VRpI+TbYcR/NYQIqWDLQ+NGJ3Q9RCtqhVtO6FHX0ZCFHzVdBRIQPTkXXeQtXtQ42zNCgtjbrQa2eXPSpISfMsLpnzYOb7x9hEdVZef6WXqczNRmA1SIFZ/D77VCvOw6xDfnPvupuxIQUqOs8PkaSsdOBZXDMEZEU/eeGQ880Bx7cbTEA0B2x4uw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746687339; c=relaxed/relaxed;
	bh=mQ/JFE8qHpNeVguUInJ0RE1hB6acA9DgzVg05wegyNw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VTsCSqUXmyPBSKzgzvt9QN7at+I8H+xU/8KBc3mW40bITJI0eQFeiRv4UkUG3+bVy7NcczcwK8H7CUKG1i4tTdSFwy7PW7qSmqp58Hl7F9GYAot8XgRfy8uTm/cskZjN4n3Lnz6nhiOikJ8l+ZFBIXxk1W/OUQBoXyAmNXN1t2mJ3zrn4cp12wPH4Kug8Aj0p/fqgk/SojluT7T3HmMVatr0D5vnKPPiedDS80sNCKHkTOwbo7OrWqyGiA5cl6JynZWv5gOhxqyWuLURTOnC51dyh4PVNVv+Qcam8aBqvjaQvLyPTd8hOsl7f7HPlxE81MtHxprjokdAr/BvmneNsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B/GIgnKX; dkim-atps=neutral; spf=pass (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B/GIgnKX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZtNF45ZsWz2yh4
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 May 2025 16:55:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746687337; x=1778223337;
  h=date:from:to:cc:subject:message-id;
  bh=3eO0eRiLetRgLTLHaKhKJHI2rX/womefkfQhINFcbw8=;
  b=B/GIgnKXIxYQS2bKt7gcmxvssXblTkLUWTjdm+9M5KDg87n2sCJdNC8E
   Y0ou2DXZXJbXAqlGJI+NBHUkztTtfQKORBSMuVtz/QcW6ObayDd0jYcaX
   eim8wYJlpsJAj4hiSS756d3GuVfhwQOQUcj9F1MDjI9lGUk03OxW79Q2G
   vTyeBrwac+qJkaL5/9RElEsnFa70LA4HcW73YLrkuMZ6jZ/LhPXm6mheK
   RhfFRtd/FYlCZ3ViENeBO057+8nUyzdSFw5lglluWuyKU9OywUAJ92biZ
   s/4VLjXUpZqQE9I22j01jp7NInXoSdVSdZT/iIk1g1sB1lJf8mxZKSuAx
   w==;
X-CSE-ConnectionGUID: f4/v5a87ThCGXaMOInIAGw==
X-CSE-MsgGUID: q0fVPj2bRWuI/gyalMN2Vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48538131"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="48538131"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 23:55:30 -0700
X-CSE-ConnectionGUID: jDSqKBvySQSsb/9omibw+A==
X-CSE-MsgGUID: xNNo30olSke2iWjqLiiuZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="140963054"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 May 2025 23:55:29 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCvAE-000Aix-1K;
	Thu, 08 May 2025 06:55:26 +0000
Date: Thu, 08 May 2025 14:55:11 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 35076d2223c731f7be75af61e67f90807384d030
Message-ID: <202505081405.v6UEwL69-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 35076d2223c731f7be75af61e67f90807384d030  erofs: ensure the extra temporary copy is valid for shortened bvecs

elapsed time: 1704m

configs tested: 52
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        allnoconfig    gcc-14.2.0
alpha       allyesconfig    gcc-14.2.0
arc         allmodconfig    gcc-14.2.0
arc          allnoconfig    gcc-14.2.0
arc         allyesconfig    gcc-14.2.0
arm         allmodconfig    gcc-14.2.0
arm          allnoconfig    clang-21
arm         allyesconfig    gcc-14.2.0
arm64       allmodconfig    clang-19
arm64        allnoconfig    gcc-14.2.0
csky         allnoconfig    gcc-14.2.0
hexagon     allmodconfig    clang-17
hexagon      allnoconfig    clang-21
hexagon     allyesconfig    clang-21
i386        allmodconfig    gcc-12
i386         allnoconfig    gcc-12
i386        allyesconfig    gcc-12
i386           defconfig    clang-20
loongarch   allmodconfig    gcc-14.2.0
loongarch    allnoconfig    gcc-14.2.0
m68k        allmodconfig    gcc-14.2.0
m68k         allnoconfig    gcc-14.2.0
m68k        allyesconfig    gcc-14.2.0
microblaze  allmodconfig    gcc-14.2.0
microblaze   allnoconfig    gcc-14.2.0
microblaze  allyesconfig    gcc-14.2.0
mips         allnoconfig    gcc-14.2.0
nios2        allnoconfig    gcc-14.2.0
openrisc     allnoconfig    gcc-14.2.0
openrisc    allyesconfig    gcc-14.2.0
parisc      allmodconfig    gcc-14.2.0
parisc       allnoconfig    gcc-14.2.0
parisc      allyesconfig    gcc-14.2.0
powerpc     allmodconfig    gcc-14.2.0
powerpc      allnoconfig    gcc-14.2.0
powerpc     allyesconfig    clang-21
riscv        allnoconfig    gcc-14.2.0
s390        allmodconfig    clang-18
s390         allnoconfig    clang-21
s390        allyesconfig    gcc-14.2.0
sh          allmodconfig    gcc-14.2.0
sh           allnoconfig    gcc-14.2.0
sh          allyesconfig    gcc-14.2.0
sparc       allmodconfig    gcc-14.2.0
sparc        allnoconfig    gcc-14.2.0
um          allmodconfig    clang-19
um           allnoconfig    clang-21
um          allyesconfig    gcc-12
x86_64       allnoconfig    clang-20
x86_64      allyesconfig    clang-20
x86_64         defconfig    gcc-11
xtensa       allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

