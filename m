Return-Path: <linux-erofs+bounces-1260-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4266ABECAC7
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Oct 2025 10:45:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cpZyB4rJVz3cgT;
	Sat, 18 Oct 2025 19:45:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760777106;
	cv=none; b=lQFFl6bsLff+h7KMvKxj09Gr9gslvFIDNZozdKPRz3+5Kf3/e0BGewX1GU5zljxK+HJy3xgrnUtDk62zpJGc5mHUdPXRSaFd/y1dEsB0JBjKJ9sI7SVy41UateFfvH3GsXeQ032mT///xtBewRY9JFt+mwdongkKxR1yPOqSEqrrVyw7GCySiugc7akVPzOulhX9HccScA35je6mk/4Hrfmmn1zDzWua0o3USLvyQxTlC7rGAJR14qsmhbIEv53dd1rdLrGfkApGpclcohcY4A/vr/2MY7SquM0pbKrkY1I+VLieQ22zx4fZgr/2X/uf8wmQZDLaDuYT+At3ps3fKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760777106; c=relaxed/relaxed;
	bh=MWTSc+zngRtVvyVki19AM1tXmUyS4OYLtyui8NdB9oI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=b7cQW5ITAarMPtYi5W/yfwMdgtwrhZwW0BmzuU/tN/2mqwCUU/ZiwoHwUyM1Pn9Zg+XAWYaWroJ6QZ0e61IqXO9RfiDu0Mj0U0pm+Tv759Nv0nU2cs+cBSZLVQZyQUs5hMajPyqxUznlz7mNL/A1rPsHhHX0zeb9BN1+itMfZ33y+V5ZGuzw0Ta0s4uUBVSY4qRk7LtezLAh2bwLYXqtDdWbNmDHS/4271Nrk9PdY7LkOK4e3kfIXNXXEZ4S52Njhuc/SxNDTYYE27lkRrpaOmRNih1XT5W+/MW8V8Mzg4rJAT1qj6ZKa+i25Pq5lRZwQu/QWQUhzd9rWnnM+i+uiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bKfwdCy2; dkim-atps=neutral; spf=pass (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bKfwdCy2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cpZy82Tn9z3cgN
	for <linux-erofs@lists.ozlabs.org>; Sat, 18 Oct 2025 19:45:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760777105; x=1792313105;
  h=date:from:to:cc:subject:message-id;
  bh=2SZQFE3gUu6puR4GlVkH4xwJmTondDZeO3EbWSuxfPw=;
  b=bKfwdCy2wAtCzl6GnVT92rXJ4MzEIsD36SESwZ/02zSB6tn9y32eR4x7
   3COrClFfkSEVr85T9CHCDgcJ5CJABbvwim09t98320amLmfSTO09p4ddp
   xugYbVBeJS5IsergJ0KnHdlXXhJ4O/hp8fv75y7lvBDtLwCKYQ5656qCg
   4B1ZjIu9yyA6IP/hK3NQEZvPaqMr7xEk4u1ckQQDXvMiJo+OwaGy5xFZc
   v+oRqUTUk/9qprTZFlDAw8FpXK1Ue2OmteOgYUoyzYUhv5I7pc1FyGZdT
   SqZ8DRDHiMx7YD1S6bulndU8CwBwt02VvM7UHdwtbYiMAsYyXeSmo7+Nr
   w==;
X-CSE-ConnectionGUID: mJ/w0epOTWCbKhRsgZPPqA==
X-CSE-MsgGUID: I1KGDq3jT3iJEAvYGS0Qsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="62016772"
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="62016772"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 01:44:58 -0700
X-CSE-ConnectionGUID: 3NzjIVeHSNSnK9XFI7Kasw==
X-CSE-MsgGUID: sHM+eknmT8eTVu0Vh/wAwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="182931653"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 18 Oct 2025 01:44:57 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vA2YR-0008Al-0v;
	Sat, 18 Oct 2025 08:44:49 +0000
Date: Sat, 18 Oct 2025 16:44:06 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 b63599c5ce9e66c230671eb4cacf62de10b0483d
Message-ID: <202510181600.GN57XaOg-lkp@intel.com>
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
branch HEAD: b63599c5ce9e66c230671eb4cacf62de10b0483d  erofs: consolidate z_erofs_extent_lookback()

elapsed time: 1446m

configs tested: 192
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20251017    gcc-8.5.0
arc                   randconfig-002-20251017    gcc-11.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                        multi_v5_defconfig    gcc-15.1.0
arm                   randconfig-001-20251017    gcc-15.1.0
arm                   randconfig-002-20251017    clang-22
arm                   randconfig-003-20251017    clang-22
arm                   randconfig-004-20251017    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251017    clang-20
arm64                 randconfig-002-20251017    clang-22
arm64                 randconfig-003-20251017    gcc-15.1.0
arm64                 randconfig-004-20251017    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251017    gcc-15.1.0
csky                  randconfig-002-20251017    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251017    clang-22
hexagon               randconfig-002-20251017    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251017    clang-20
i386        buildonly-randconfig-001-20251018    clang-20
i386        buildonly-randconfig-002-20251017    clang-20
i386        buildonly-randconfig-002-20251018    clang-20
i386        buildonly-randconfig-003-20251017    clang-20
i386        buildonly-randconfig-003-20251018    clang-20
i386        buildonly-randconfig-004-20251017    clang-20
i386        buildonly-randconfig-004-20251018    clang-20
i386        buildonly-randconfig-005-20251017    clang-20
i386        buildonly-randconfig-005-20251018    clang-20
i386        buildonly-randconfig-006-20251017    clang-20
i386        buildonly-randconfig-006-20251018    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251018    gcc-14
i386                  randconfig-002-20251018    gcc-14
i386                  randconfig-003-20251018    gcc-14
i386                  randconfig-004-20251018    gcc-14
i386                  randconfig-005-20251018    gcc-14
i386                  randconfig-006-20251018    gcc-14
i386                  randconfig-007-20251018    gcc-14
i386                  randconfig-011-20251018    clang-20
i386                  randconfig-012-20251018    clang-20
i386                  randconfig-013-20251018    clang-20
i386                  randconfig-014-20251018    clang-20
i386                  randconfig-015-20251018    clang-20
i386                  randconfig-016-20251018    clang-20
i386                  randconfig-017-20251018    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch                 loongson3_defconfig    gcc-15.1.0
loongarch             randconfig-001-20251017    gcc-13.4.0
loongarch             randconfig-002-20251017    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                          hp300_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251017    gcc-8.5.0
nios2                 randconfig-002-20251017    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251017    gcc-12.5.0
parisc                randconfig-002-20251017    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20251017    gcc-14.3.0
powerpc               randconfig-002-20251017    clang-22
powerpc               randconfig-003-20251017    gcc-11.5.0
powerpc                    sam440ep_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251017    clang-20
powerpc64             randconfig-002-20251017    gcc-15.1.0
powerpc64             randconfig-003-20251017    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20251018    gcc-8.5.0
riscv                 randconfig-002-20251018    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251018    clang-22
s390                  randconfig-002-20251018    clang-20
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                          lboxre2_defconfig    gcc-15.1.0
sh                    randconfig-001-20251018    gcc-13.4.0
sh                    randconfig-002-20251018    gcc-14.3.0
sh                           se7343_defconfig    gcc-15.1.0
sh                          urquell_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251018    gcc-11.5.0
sparc                 randconfig-002-20251018    gcc-13.4.0
sparc64               randconfig-001-20251018    gcc-8.5.0
sparc64               randconfig-002-20251018    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                    randconfig-001-20251018    gcc-14
um                    randconfig-002-20251018    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251017    gcc-14
x86_64      buildonly-randconfig-001-20251018    clang-20
x86_64      buildonly-randconfig-002-20251017    gcc-14
x86_64      buildonly-randconfig-002-20251018    clang-20
x86_64      buildonly-randconfig-003-20251017    clang-20
x86_64      buildonly-randconfig-003-20251018    clang-20
x86_64      buildonly-randconfig-004-20251017    gcc-14
x86_64      buildonly-randconfig-004-20251018    clang-20
x86_64      buildonly-randconfig-005-20251017    clang-20
x86_64      buildonly-randconfig-005-20251018    clang-20
x86_64      buildonly-randconfig-006-20251017    clang-20
x86_64      buildonly-randconfig-006-20251018    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251018    gcc-14
x86_64                randconfig-002-20251018    gcc-14
x86_64                randconfig-003-20251018    gcc-14
x86_64                randconfig-004-20251018    gcc-14
x86_64                randconfig-005-20251018    gcc-14
x86_64                randconfig-006-20251018    gcc-14
x86_64                randconfig-007-20251018    gcc-14
x86_64                randconfig-008-20251018    gcc-14
x86_64                randconfig-071-20251018    clang-20
x86_64                randconfig-072-20251018    clang-20
x86_64                randconfig-073-20251018    clang-20
x86_64                randconfig-074-20251018    clang-20
x86_64                randconfig-075-20251018    clang-20
x86_64                randconfig-076-20251018    clang-20
x86_64                randconfig-077-20251018    clang-20
x86_64                randconfig-078-20251018    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251018    gcc-13.4.0
xtensa                randconfig-002-20251018    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

