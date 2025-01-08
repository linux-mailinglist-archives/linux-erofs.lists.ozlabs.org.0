Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E0DA04E41
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Jan 2025 01:48:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSTmQ18sGz30W0
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Jan 2025 11:48:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736297283;
	cv=none; b=GeWSxWgJ8R1TOixz1DcaUxCLl07h3t08Zbo9998n7dpMa5yJK85OIZmn76RD5Ezg9gvsHmcV3G9j16CmwrGOGulBt/7Lgk1VD631Ac/0kMz4X+Kn8nzmNTiTu5b801OA41VCDNGpyKxv5iLwKrUib/CshTuDX3RNF+FmrWcV69YSqDh1NLeE9F8bBXC5aHgX16nEvklExNtB3Z0f+pm5oSla9oJ1XtNAzaCvjNOHtg+wlAJrPsKnt4m0sxfxbQ/0c6OQkX2Q9Fmmv5vnPr9S9c6JKUaxVJT/LCWeEZXGNtQvqR23BRvr6O0tTaEoL6vcYFZsgu8bDXiJhXmyZuM00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736297283; c=relaxed/relaxed;
	bh=TcnFFBvxC+2Lx/N7AcR5APnqWtaaKWiZL7+RIojYS9M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FHU1FvQzURuAXCeTu7C/r6fibBdaVJqJPs7TqYVd/7qqSdNchyCq6ll5T2tkc+wraSkxoLAbnHVqg/cbicoiJIQy+4OtZOBuHNWcWUTYOmnXpL5zPUGwObFTKJEdSkhyAQ4LeYjsiqCKj4yDHMAnxYxoIajWvfOTkbcS/n/w8zlJjv9fhgXFjBCnoA4ErV8T5Qm+JZ4u2C+AHpcawWlAl39Fpq0ueJx0a5FgdN2xclF78bnOrp3cynvMSvmxFAWgrYZHiDU4TfiNKfpXOBdA7JgRFRz5n6erQZcJjesKNw1wAHf5PYV9KU5FTJWrNlk/1fbVkMxDe57u0dDO7FPP3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=herpXBBF; dkim-atps=neutral; spf=pass (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=herpXBBF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSTmK018Wz2xH9
	for <linux-erofs@lists.ozlabs.org>; Wed,  8 Jan 2025 11:47:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736297282; x=1767833282;
  h=date:from:to:cc:subject:message-id;
  bh=XXiOg7vd9gTw9TnPSGFBnUn2WI3a2vyuXlTGZ//mYe0=;
  b=herpXBBFKs0zOEZFZp0XdVRqgoc/l9TdaD5AQ/RhzwtAvdzX6uCX8Xhk
   /GWFINg7MUOoAiJLABrkMsK6ahABUa/RwyWUgA5zMnFUaE5Gi6lRSdpT/
   j8LyIMm7trqeiXWbwItQVAr/xwCocxVYG6iHXp4Ycr6ysyiTybHNzHupw
   yw3AhC7Q82Ds5tPZRRe8jUIosM3TffoUObmrnVER0BN+wAkePPuujpc9/
   z7utneKF2ORastrR9QajFd2Aq4Oj/c4Fn4eZH6fuxQ1aL3eTURHm2bgmX
   jF0GBL9/gFAbfMyFzuUoMm8mTUutbs+/UptJWRUlspTKDsktE7y8L57ND
   w==;
X-CSE-ConnectionGUID: s0X9LksQTj+nIgIQ+1pAkg==
X-CSE-MsgGUID: 9Pgop6ExQbOgz8Zxl/sGtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="40273021"
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="40273021"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 16:47:56 -0800
X-CSE-ConnectionGUID: +et1Ze5vRyWQcXYk/LLt0A==
X-CSE-MsgGUID: cLillWckS7Sr9+GwrMoQ8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108026316"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 07 Jan 2025 16:47:55 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVKEi-000FPX-28;
	Wed, 08 Jan 2025 00:47:52 +0000
Date: Wed, 08 Jan 2025 08:47:05 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 fcb9c5f9bf8faad306eabf74a59733d5f97f1682
Message-ID: <202501080858.w3CV1HWh-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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
branch HEAD: fcb9c5f9bf8faad306eabf74a59733d5f97f1682  erofs: shorten bvecs[] for file-backed mounts

elapsed time: 860m

configs tested: 106
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250107    gcc-13.2.0
arc                   randconfig-002-20250107    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250107    clang-20
arm                   randconfig-002-20250107    clang-19
arm                   randconfig-003-20250107    clang-20
arm                   randconfig-004-20250107    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250107    clang-15
arm64                 randconfig-002-20250107    clang-20
arm64                 randconfig-003-20250107    gcc-14.2.0
arm64                 randconfig-004-20250107    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250107    gcc-14.2.0
csky                  randconfig-002-20250107    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250107    clang-20
hexagon               randconfig-002-20250107    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250107    clang-19
i386        buildonly-randconfig-002-20250107    clang-19
i386        buildonly-randconfig-003-20250107    clang-19
i386        buildonly-randconfig-004-20250107    gcc-12
i386        buildonly-randconfig-005-20250107    gcc-12
i386        buildonly-randconfig-006-20250107    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250107    gcc-14.2.0
loongarch             randconfig-002-20250107    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250107    gcc-14.2.0
nios2                 randconfig-002-20250107    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250107    gcc-14.2.0
parisc                randconfig-002-20250107    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20250107    gcc-14.2.0
powerpc               randconfig-002-20250107    gcc-14.2.0
powerpc               randconfig-003-20250107    clang-20
powerpc64             randconfig-001-20250107    clang-15
powerpc64             randconfig-002-20250107    clang-20
powerpc64             randconfig-003-20250107    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20250107    clang-15
riscv                 randconfig-002-20250107    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250107    gcc-14.2.0
s390                  randconfig-002-20250107    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250107    gcc-14.2.0
sh                    randconfig-002-20250107    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250107    gcc-14.2.0
sparc                 randconfig-002-20250107    gcc-14.2.0
sparc64               randconfig-001-20250107    gcc-14.2.0
sparc64               randconfig-002-20250107    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250107    gcc-12
um                    randconfig-002-20250107    clang-20
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250107    clang-19
x86_64      buildonly-randconfig-002-20250107    gcc-12
x86_64      buildonly-randconfig-003-20250107    clang-19
x86_64      buildonly-randconfig-004-20250107    gcc-12
x86_64      buildonly-randconfig-005-20250107    clang-19
x86_64      buildonly-randconfig-006-20250107    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250107    gcc-14.2.0
xtensa                randconfig-002-20250107    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
