Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B04197869F
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Sep 2024 19:24:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X51Pv2rtVz2yyq
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Sep 2024 03:24:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726248256;
	cv=none; b=oDSRxO0S/C8cPUyMDU/Qf1lKNJG7yaRHiSJxvc6M5NAPNLrMRsljUMh2QxL4iuguCX3xd4w9jfPSBLHEV0oPKqEPKXcy3hKuR4PTPNr6lVIGegVLXWU4koYGzw48a3NVeNVi48OfstOOkOpcbE9UFboZIOkGyKPjg4tQPKygEpBIjDNIWx0tdu8Rwnm3v4YoWyyOl2sLr9YimRf69RvXQ4EYgn7oKykIXv9+BYPBJlD5QdPXq6Asc1wabog2QLl4AFT6gLXneymN44yrF3/kLRsw4BkKM4WCKWOskfOnixpmfLVPLcA+siYTehDWXeOcj8ciupAgoFJv2LhcE9U/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726248256; c=relaxed/relaxed;
	bh=QinaeAN5kN9pS/IRTvwH2S9eb8cHQYwA5A0ejuaZPrU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=e56hguflMSYNlg1HpjSI5f7sC2QpfdeSscq72648YaTaSieC3PnFMU8H+cLSuoc9HL4ytElk3k5qfsxyrVpUfWRpra5sMUb+vyizLlsaqLv1nxurPwwX3Cuqj/EhTWDlmK/prXdw4kItWY8nTr9yVlJ4XUu6UkVOWGPiI/CilK5hKyjmvd13jJBmdf0OZDXDyTSO0jhDmYrs9U2Krd6GowNlpqIC6r2Mxp7Mii8a9SrcFdzEh8vvOTvYheqy3AEwtORaks+sVBXoRr3eMGKZ2gRmGKv9lGsqxmlOiNJu3Qdj+5Iy9LjiTKbDFc5LVEd+V3Gk8ytM7wzNrvFnZvuvzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Vy1szXjT; dkim-atps=neutral; spf=pass (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Vy1szXjT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X51Pq3VVKz2ytR
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Sep 2024 03:24:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726248255; x=1757784255;
  h=date:from:to:cc:subject:message-id;
  bh=snPVSTxeZBllZKYkMyWdr9j/6PTt5dC1Up5E0wbtJ9c=;
  b=Vy1szXjTEYxsvM+n2mmZlbJ4J5DvFyrFyIJzGktoLn2kwXvt832dnTvP
   DcGLIcZVr08hY2iD5fTyBNJpwnJ5DA1QlT45osX1BI0bDhfT6aV8BNuS0
   2tAXlfGxIuW/ltYdIhtPxu76zLHuyf8MEeMZIh1F1C1jPmL735tn8l/Jd
   FBNHSMjWRvL95hFHDbhqqaJvFXv96ejC9TSbXGzfeQYuIV6cKMiX4y0AA
   oKnJkgjWCAbSB1HImJ+Ox2qQLjc/wk9vpvhPyMBhLxUrCiMPt75fDbULq
   kzTiLAwuT0ATBb5/AarLff8bB/HjX0wKT0WF3vaEqH4SR8vDOrTLNhMpD
   w==;
X-CSE-ConnectionGUID: H4tMEAt+RE+3SyaLA3Dpzg==
X-CSE-MsgGUID: ZVM/AchfRDGeh3UWWL5b8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="24698531"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="24698531"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 10:24:09 -0700
X-CSE-ConnectionGUID: ksonrAs0QcyXmDg8551b4w==
X-CSE-MsgGUID: 5A3BnV+aSdWOC6hO8s511A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="67834907"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 13 Sep 2024 10:24:08 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spA1e-0006js-0z;
	Fri, 13 Sep 2024 17:24:06 +0000
Date: Sat, 14 Sep 2024 01:23:34 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 025497e1d176a9e063d1e60699527e2f3a871935
Message-ID: <202409140125.zibXs7G3-lkp@intel.com>
User-Agent: s-nail v14.9.24
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
branch HEAD: 025497e1d176a9e063d1e60699527e2f3a871935  erofs: reject inodes with negative i_size

elapsed time: 1505m

configs tested: 94
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20240913    clang-18
i386        buildonly-randconfig-002-20240913    clang-18
i386        buildonly-randconfig-003-20240913    clang-18
i386        buildonly-randconfig-004-20240913    clang-18
i386        buildonly-randconfig-005-20240913    clang-18
i386        buildonly-randconfig-006-20240913    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20240913    clang-18
i386                  randconfig-002-20240913    clang-18
i386                  randconfig-003-20240913    clang-18
i386                  randconfig-004-20240913    clang-18
i386                  randconfig-005-20240913    clang-18
i386                  randconfig-006-20240913    clang-18
i386                  randconfig-011-20240913    clang-18
i386                  randconfig-012-20240913    clang-18
i386                  randconfig-013-20240913    clang-18
i386                  randconfig-014-20240913    clang-18
i386                  randconfig-015-20240913    clang-18
i386                  randconfig-016-20240913    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    gcc-12
x86_64                          rhel-8.3-rust    clang-18
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
