Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCDCA38F1A
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2025 23:33:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YxcrY2ZTvz3bkT
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2025 09:33:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739831627;
	cv=none; b=R1Kx+cnrocz469McPCpHToylJEDr6SHinLUWmpkvbLZ0LtG8FVvfPyv4cGkDLTYW2d5sQDJgHKULhmOlLyeBgAu1jGOBxoB/WjN3BvUYOV3Q9ttm4P344AM0Ix+P1FpdkMSH3avN8YUAMrtBxVIfFutD021i78SdfGKDNRNDyqFGqUWx51p632NpXBJmaiH/Ooiu6Ol/SMi+Jp3d2Mzv28cZrGxUg+CTYASordMGGp6BpmYHkgSspTm5vngnD+5f5GXQ2xwBGkCo62u9Jqfr6EzQdmnyORM6drqDOsF5h8urG4tmKB+or1Y/Soj8eN3QolXbaK83r2CIqwp4lC+h5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739831627; c=relaxed/relaxed;
	bh=dbtmc79miKfvKI4Ne9JyX95istodSrFWb3apToVga+Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=e3d9tU5wlsxVJBokbw4rG2NBfMxqlTqXrN64XraEY/eTYMuK1oSOdAXwk66gt7WEU/8lhivjbfg0vAm5S0xU/xbEZV3/z4FemPOBbLqwdWQx3WznCusBYg4cl+hZSnp7/O7zMkh74iKpicVQhOH76CEv1JxAOYo8+JuGdNhIdRpG3g545J1cogbZakuXesO2MVF1maaKz+Mw2Jl+JCjxsUoi3h6hsMyuycAwRsSDJK+vEvVjulH1e0D2DIiIVqX6kotGO1yZNoGQyyDVTnqtxIvulfGc6miFXf+PukXxtRus9ZLKn+n4L1n25B2KeWCz3G8buPQZjn9gjWAA3tCPZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fk7M7aVr; dkim-atps=neutral; spf=pass (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fk7M7aVr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YxcrT2tVLz2yTy
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Feb 2025 09:33:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739831626; x=1771367626;
  h=date:from:to:cc:subject:message-id;
  bh=ygkx9/rwQmrtkuInPix9fta11xBCov0BkiazA35PvY8=;
  b=fk7M7aVrkahxnqGG0nKqABmwTqdGnd375xNFhbqCEz75bJLNACd9Mi8x
   hp6tGr8ui6f2gxm3oiWouYkl5spVddzR3JXDVAt1EjopUpDc2wkZTh/8v
   prmDnabJOC+ZbddbqgfqRjSIuPt5hMIsp+EmE6yHtStJQkDY9OJJ7ZEpH
   jdqOj6gZqrWkXJ/RQiz8CDo+yqg6artb3QNg2Td924zgCB0EIt5i65/u4
   04ao5R81zrQFSbFm1GZPt+vGO8lcgy/+nA2zkhzddLKhd1BoO0sr0l9EO
   zcuhsHBiBh94FB9knDqydxUDzSMnwfZOXQHlwvubAHfirmN/sGNqr2Ors
   A==;
X-CSE-ConnectionGUID: GMjidgQRT/eVM+gVl36tgQ==
X-CSE-MsgGUID: yikx3TYQTZWw8FaJTTQKYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44170926"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="44170926"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 14:33:37 -0800
X-CSE-ConnectionGUID: ymYj60jhQ0esrE/bPY6UHA==
X-CSE-MsgGUID: AhSeRbltT9O2zLOhMYH73w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="114871732"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 17 Feb 2025 14:33:36 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tk9gD-001DeN-2w;
	Mon, 17 Feb 2025 22:33:33 +0000
Date: Tue, 18 Feb 2025 06:32:49 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 78ee54f6e0e8c9c1c39651ef79fe716c8717e403
Message-ID: <202502180643.VsKcqpFw-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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
branch HEAD: 78ee54f6e0e8c9c1c39651ef79fe716c8717e403  erofs: get rid of erofs_kmap_type

elapsed time: 743m

configs tested: 99
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250217    gcc-13.2.0
arc                   randconfig-002-20250217    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250217    gcc-14.2.0
arm                   randconfig-002-20250217    gcc-14.2.0
arm                   randconfig-003-20250217    gcc-14.2.0
arm                   randconfig-004-20250217    clang-19
arm64                            allmodconfig    clang-18
arm64                 randconfig-001-20250217    gcc-14.2.0
arm64                 randconfig-002-20250217    clang-21
arm64                 randconfig-003-20250217    clang-15
arm64                 randconfig-004-20250217    gcc-14.2.0
csky                  randconfig-001-20250217    gcc-14.2.0
csky                  randconfig-002-20250217    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250217    clang-21
hexagon               randconfig-002-20250217    clang-14
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250217    clang-19
i386        buildonly-randconfig-002-20250217    gcc-12
i386        buildonly-randconfig-003-20250217    clang-19
i386        buildonly-randconfig-004-20250217    gcc-12
i386        buildonly-randconfig-005-20250217    gcc-12
i386        buildonly-randconfig-006-20250217    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20250217    gcc-14.2.0
loongarch             randconfig-002-20250217    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250217    gcc-14.2.0
nios2                 randconfig-002-20250217    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250217    gcc-14.2.0
parisc                randconfig-002-20250217    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20250217    clang-17
powerpc               randconfig-002-20250217    clang-15
powerpc               randconfig-003-20250217    gcc-14.2.0
powerpc64             randconfig-001-20250217    clang-19
powerpc64             randconfig-002-20250217    clang-21
powerpc64             randconfig-003-20250217    clang-15
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                 randconfig-001-20250217    gcc-14.2.0
riscv                 randconfig-002-20250217    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250217    gcc-14.2.0
s390                  randconfig-002-20250217    clang-18
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250217    gcc-14.2.0
sh                    randconfig-002-20250217    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250217    gcc-14.2.0
sparc                 randconfig-002-20250217    gcc-14.2.0
sparc64               randconfig-001-20250217    gcc-14.2.0
sparc64               randconfig-002-20250217    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250217    clang-19
um                    randconfig-002-20250217    clang-17
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250217    gcc-12
x86_64      buildonly-randconfig-002-20250217    clang-19
x86_64      buildonly-randconfig-003-20250217    clang-19
x86_64      buildonly-randconfig-004-20250217    gcc-12
x86_64      buildonly-randconfig-005-20250217    gcc-12
x86_64      buildonly-randconfig-006-20250217    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250217    gcc-14.2.0
xtensa                randconfig-002-20250217    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
