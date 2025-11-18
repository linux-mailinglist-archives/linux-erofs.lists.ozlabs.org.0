Return-Path: <linux-erofs+bounces-1408-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 079BAC6994A
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Nov 2025 14:23:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d9lgH6Gxsz2yv9;
	Wed, 19 Nov 2025 00:23:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763472219;
	cv=none; b=gzM49C55WgIb8DnyHBWKptSOdlSZsv+vEQU3lts4l/mqzqBsjhI0H2RnJku+xpRKKJFE+uEVEb/iYsYtYRCiws4YByGqFkGvlygCrSurN4sBQJixi1xrrdINqO1YysB8ge+QYsdhUOo6l795uB1Rpr+CK/0Thj0Fvz7FEVxNM7dPn1r56UgchZ4T/zmBYKhFSdLhzgs6mXZiaKe+Lzdwz9vDJabDn/XcnAp+ZggcNdSsyYGYlsvBBa48yHC4967CnHN9FNyfdSX50DpqNxnmAfSar2Lz8rDTgZdQBH/GIOEpCU4E4Fyvh78miGXrFQ4cmhChB9b0fFCCMPweYjR1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763472219; c=relaxed/relaxed;
	bh=aug+qZz0DdRqGwp3/30c3L5VlxJNyA4VBnhsmPiYTXI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OPRLvthv+Z/N13jNJS51TFmJxbJmatewMQgXpPCos9D5+5ITZ4rDYDxp6bZhQuee26OTE88vkbpnN10X99PSgvuJNk7gSt3LhWce3BurmegUvL8drgd+w1YQWdmCJyr9lf2TM4FoAuvbW1zMjEWmzDxD2iIDQMK4UU7xNxR18+g4yQELEPfZ+3imKNWT7/uYPl/2UVDH1YTI0PreNn3FwdiP2m4dG37gBsq4tmpDPE/pEtE/N0C0nBT+hVbzhSLs+2e2EX+l11GkolcBSHHDNueNavnQf207KXlI+PmjjOwhoV1FtYHxXPe6/efxhpZR/ZAszaBbQxtDfu8X+8UGJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iV6vAI3i; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iV6vAI3i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d9lgF0sJkz2yrg
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Nov 2025 00:23:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763472217; x=1795008217;
  h=date:from:to:cc:subject:message-id;
  bh=tfIg43mUJs0lfK7LqSg2uhjWxK4A8h4Lpsrdwo+R6Ec=;
  b=iV6vAI3iF6Mtde3eFGlh0B6H4Xa45aXyVAUW+j+Me12ZuEaPR3Qclv95
   ZD3cxfeAVhJK5DLwBm7ju7w5Zg0VNtNi0qbhDFLPbGc87yuS8TKy9BJzw
   4Bx3xJmyuEZv7TACzlUorWj5oJ3qQh68UFntmpvzF3Iy83pUfW5SMIWGW
   jzb9iQA7yEG4EmoJOSEOR+gCvFR7pQrIc3yjl3OddO0gFSe69A/N/1ZrT
   YhEZmYcdWMywNPMFE89BJGqrMwBLTogd+pQuEOwGGzgSj8klqbWE4twrE
   uEq1CkWKjeu4vp8dCflf1Z6tEcqm2/93gXFNEa9gOE3p0iBlVCNu6McGm
   w==;
X-CSE-ConnectionGUID: EePKHErbQti2DqLYNmI/OA==
X-CSE-MsgGUID: ng8mJQXKRO+j4f6YkjlZlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="53062124"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="53062124"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 05:23:32 -0800
X-CSE-ConnectionGUID: y+YSQDWiSgqstJ/P42qRiw==
X-CSE-MsgGUID: Uay7M4vBRKOm2euP2CFcaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190020000"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 18 Nov 2025 05:23:31 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLLg8-0001lH-30;
	Tue, 18 Nov 2025 13:23:28 +0000
Date: Tue, 18 Nov 2025 21:23:28 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 3027b141cbeb759f0310bb56de7d4da3a9eb511f
Message-ID: <202511182122.93JvXE5C-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 3027b141cbeb759f0310bb56de7d4da3a9eb511f  erofs: correct FSDAX detection

elapsed time: 1510m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251118    gcc-14.3.0
arc                   randconfig-002-20251118    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20251118    gcc-8.5.0
arm                   randconfig-002-20251118    gcc-10.5.0
arm                   randconfig-003-20251118    clang-22
arm                   randconfig-004-20251118    clang-22
arm                       versatile_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251118    clang-20
arm64                 randconfig-002-20251118    clang-22
arm64                 randconfig-003-20251118    clang-19
arm64                 randconfig-004-20251118    clang-17
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251118    gcc-10.5.0
csky                  randconfig-002-20251118    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251118    clang-16
hexagon               randconfig-002-20251118    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251118    clang-20
i386        buildonly-randconfig-002-20251118    clang-20
i386        buildonly-randconfig-003-20251118    clang-20
i386        buildonly-randconfig-004-20251118    clang-20
i386        buildonly-randconfig-005-20251118    gcc-13
i386        buildonly-randconfig-006-20251118    clang-20
i386                  randconfig-001-20251118    clang-20
i386                  randconfig-002-20251118    clang-20
i386                  randconfig-003-20251118    gcc-14
i386                  randconfig-004-20251118    gcc-14
i386                  randconfig-005-20251118    clang-20
i386                  randconfig-006-20251118    gcc-14
i386                  randconfig-007-20251118    gcc-14
i386                  randconfig-011-20251118    gcc-14
i386                  randconfig-012-20251118    gcc-12
i386                  randconfig-013-20251118    clang-20
i386                  randconfig-014-20251118    gcc-14
i386                  randconfig-015-20251118    gcc-14
i386                  randconfig-016-20251118    gcc-14
i386                  randconfig-017-20251118    clang-20
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251118    gcc-15.1.0
loongarch             randconfig-002-20251118    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm47xx_defconfig    clang-18
mips                           gcw0_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251118    gcc-11.5.0
nios2                 randconfig-002-20251118    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251118    gcc-14.3.0
parisc                randconfig-002-20251118    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251118    clang-22
powerpc               randconfig-002-20251118    clang-22
powerpc                         wii_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251118    gcc-13.4.0
powerpc64             randconfig-002-20251118    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251117    gcc-14.3.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251117    gcc-15.1.0
sh                   rts7751r2dplus_defconfig    gcc-15.1.0
sh                           se7750_defconfig    gcc-15.1.0
sh                     sh7710voipgw_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251118    gcc-8.5.0
sparc                 randconfig-002-20251118    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251118    clang-22
sparc64               randconfig-002-20251118    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-002-20251118    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251118    clang-20
x86_64      buildonly-randconfig-002-20251118    gcc-14
x86_64      buildonly-randconfig-003-20251118    clang-20
x86_64      buildonly-randconfig-004-20251118    clang-20
x86_64      buildonly-randconfig-005-20251118    clang-20
x86_64      buildonly-randconfig-006-20251118    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-013-20251118    gcc-14
x86_64                randconfig-071-20251118    gcc-13
x86_64                randconfig-072-20251118    clang-20
x86_64                randconfig-073-20251118    gcc-14
x86_64                randconfig-074-20251118    gcc-13
x86_64                randconfig-075-20251118    gcc-14
x86_64                randconfig-076-20251118    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

