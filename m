Return-Path: <linux-erofs+bounces-894-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2487AB32CE6
	for <lists+linux-erofs@lfdr.de>; Sun, 24 Aug 2025 03:36:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c8c3P5yQvz30Qk;
	Sun, 24 Aug 2025 11:36:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755999409;
	cv=none; b=SreDik9nYiG44eSKXSsUYH/A0/zfOAvWLR7e+DRnEzyjy8IaLj/UoWp2T73fnta20bc6FIBtL9RvCIw3KFycoNUYvoJWSennRZCRGj/QBab/eqB4977FvhkeOK/zDS1V/r9sTBhWlAF90l74lFfDzTnfVIszXS+rCjjGCch8JUpMkQ7xZzUo9VGF4ZUfR1nt0b7a/g9hhxMEJyWZ4rBnbFCOXGkWKRST1UjkdC153kkhlYV4FIqLg387lOkz/YJnNBxG5XKKPe0IaDMYuBlGxO+11tkVi/1iWX5GloMODCXNmo1g+xn4Dezkipo5sVCRGGlhBx3tK+RcN4th2PjAWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755999409; c=relaxed/relaxed;
	bh=XnOzZPpcDLnUY+bLgxwrpd8NhYMYtjNo3KfcGON0feA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KYlesq1egknq1KxvCHO29YkVD8mkQOpAfZXmQt2wLRp/a8u/gMaDs5+0MjRGXXcyjz8dcYlj7IFHP9WRdosFv61OdVfHEU3SjJvl9p7UWcnjotVQfNSviOv76bBgwfoEwYHrBWzWd6UiVNyz8GloyNcGn50kw9Xf8GtLjWgS4RIttffnbOTJ2pWp7AvhtRziMCKPMbAAhFmPwr5Ti1/IBqnDkl7w07l8f264HoqmjPuaXxJDbRYYwwf5TRG81ve6ajtIegs8y0O0139A1sHpBnph7wdffjc49D4UfH2S3svS7eb5yEa+ipgdBHXpO7h4JzUc0OjtcI/Zn7MjeJKOlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ESSo3eyP; dkim-atps=neutral; spf=pass (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ESSo3eyP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c8c3M37Fvz2xS9
	for <linux-erofs@lists.ozlabs.org>; Sun, 24 Aug 2025 11:36:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755999408; x=1787535408;
  h=date:from:to:cc:subject:message-id;
  bh=fEKkJl7b3Bkfn2ik6LzD/egEFk3qXohx69vH9kKbMfQ=;
  b=ESSo3eyPzgbRuxyk50yXWnrTWJ44flWN4R3We5xt1vDQaSPzW41Ws/Wj
   /Cch9x0bsroxzUPph3KRr2hLVfTFC7Ph3/ltosW05fkZnbqSR/wvz5x02
   X9eWh6KXnf4XsFwXczQKTm6QECttj4PgH6l6C9jpjGOyJh0+lj9SWeziG
   WF9gtoV5udgvq9JzFSTpGQKRvMlUpfWT8TZn7wbxBC81X+p/sKOBa08z1
   Bd1stgE9Cqcr8VCgfRWju8GLNERG4xLTqkq2cLjkjEoBu58MEDLy9v0zj
   vr1an5pBYuPfe0VbE79qblNTdMUnLtmfM3M+lPvHZEUGhbF6pjhWea56H
   A==;
X-CSE-ConnectionGUID: Dv08IAYrSu2q3PQQzsZstA==
X-CSE-MsgGUID: s6TV6Z4JQqKIzP6BPG2krw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58184062"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58184062"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 18:36:42 -0700
X-CSE-ConnectionGUID: 5zE8+z9XRO6UWNf2Jxx/2Q==
X-CSE-MsgGUID: j/RHn4XVTGOVOSmnrfVeig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168598261"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 23 Aug 2025 18:36:40 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upzen-000Mh2-0O;
	Sun, 24 Aug 2025 01:36:34 +0000
Date: Sun, 24 Aug 2025 09:35:27 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 b3065ccf5284a25678ce4a32d9cfb9ece91d379e
Message-ID: <202508240920.u1Z9yuvZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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
branch HEAD: b3065ccf5284a25678ce4a32d9cfb9ece91d379e  erofs: fix invalid algorithm for encoded extents

elapsed time: 870m

configs tested: 167
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250823    gcc-9.5.0
arc                   randconfig-001-20250824    gcc-15.1.0
arc                   randconfig-002-20250823    gcc-12.5.0
arc                   randconfig-002-20250824    gcc-10.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250823    clang-17
arm                   randconfig-001-20250824    clang-22
arm                   randconfig-002-20250823    gcc-15.1.0
arm                   randconfig-002-20250824    gcc-13.4.0
arm                   randconfig-003-20250823    clang-20
arm                   randconfig-003-20250824    clang-22
arm                   randconfig-004-20250823    clang-22
arm                   randconfig-004-20250824    clang-22
arm                        realview_defconfig    clang-16
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250823    gcc-11.5.0
arm64                 randconfig-001-20250824    gcc-13.4.0
arm64                 randconfig-002-20250823    clang-22
arm64                 randconfig-002-20250824    gcc-11.5.0
arm64                 randconfig-003-20250823    clang-22
arm64                 randconfig-003-20250824    gcc-10.5.0
arm64                 randconfig-004-20250823    gcc-15.1.0
arm64                 randconfig-004-20250824    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250823    gcc-15.1.0
csky                  randconfig-001-20250824    gcc-10.5.0
csky                  randconfig-002-20250823    gcc-14.3.0
csky                  randconfig-002-20250824    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250823    clang-22
hexagon               randconfig-001-20250824    clang-22
hexagon               randconfig-002-20250823    clang-22
hexagon               randconfig-002-20250824    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250823    clang-20
i386        buildonly-randconfig-001-20250824    gcc-12
i386        buildonly-randconfig-002-20250823    clang-20
i386        buildonly-randconfig-002-20250824    gcc-12
i386        buildonly-randconfig-003-20250823    clang-20
i386        buildonly-randconfig-003-20250824    gcc-12
i386        buildonly-randconfig-004-20250823    clang-20
i386        buildonly-randconfig-004-20250824    gcc-12
i386        buildonly-randconfig-005-20250823    clang-20
i386        buildonly-randconfig-005-20250824    gcc-12
i386        buildonly-randconfig-006-20250823    clang-20
i386        buildonly-randconfig-006-20250824    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250823    clang-22
loongarch             randconfig-001-20250824    gcc-12.5.0
loongarch             randconfig-002-20250823    clang-22
loongarch             randconfig-002-20250824    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          multi_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                   sb1250_swarm_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250823    gcc-11.5.0
nios2                 randconfig-001-20250824    gcc-8.5.0
nios2                 randconfig-002-20250823    gcc-8.5.0
nios2                 randconfig-002-20250824    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250823    gcc-8.5.0
parisc                randconfig-001-20250824    gcc-9.5.0
parisc                randconfig-002-20250823    gcc-15.1.0
parisc                randconfig-002-20250824    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250823    clang-22
powerpc               randconfig-001-20250824    gcc-9.5.0
powerpc               randconfig-002-20250823    clang-22
powerpc               randconfig-002-20250824    clang-22
powerpc               randconfig-003-20250823    clang-22
powerpc               randconfig-003-20250824    gcc-12.5.0
powerpc64             randconfig-001-20250823    gcc-11.5.0
powerpc64             randconfig-001-20250824    gcc-8.5.0
powerpc64             randconfig-002-20250823    clang-22
powerpc64             randconfig-002-20250824    gcc-13.4.0
powerpc64             randconfig-003-20250823    gcc-10.5.0
powerpc64             randconfig-003-20250824    gcc-12.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250823    clang-22
riscv                 randconfig-001-20250824    gcc-11.5.0
riscv                 randconfig-002-20250823    gcc-8.5.0
riscv                 randconfig-002-20250824    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250823    gcc-9.5.0
s390                  randconfig-001-20250824    clang-16
s390                  randconfig-002-20250823    clang-22
s390                  randconfig-002-20250824    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250823    gcc-15.1.0
sh                    randconfig-001-20250824    gcc-15.1.0
sh                    randconfig-002-20250823    gcc-15.1.0
sh                    randconfig-002-20250824    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250823    gcc-8.5.0
sparc                 randconfig-001-20250824    gcc-14.3.0
sparc                 randconfig-002-20250823    gcc-8.5.0
sparc                 randconfig-002-20250824    gcc-8.5.0
sparc64               randconfig-001-20250823    gcc-8.5.0
sparc64               randconfig-001-20250824    clang-22
sparc64               randconfig-002-20250823    clang-22
sparc64               randconfig-002-20250824    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250823    clang-22
um                    randconfig-001-20250824    gcc-12
um                    randconfig-002-20250823    clang-22
um                    randconfig-002-20250824    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250823    gcc-12
x86_64      buildonly-randconfig-001-20250824    gcc-12
x86_64      buildonly-randconfig-002-20250823    gcc-12
x86_64      buildonly-randconfig-002-20250824    clang-20
x86_64      buildonly-randconfig-003-20250823    clang-20
x86_64      buildonly-randconfig-003-20250824    gcc-12
x86_64      buildonly-randconfig-004-20250823    clang-20
x86_64      buildonly-randconfig-004-20250824    clang-20
x86_64      buildonly-randconfig-005-20250823    gcc-12
x86_64      buildonly-randconfig-005-20250824    gcc-12
x86_64      buildonly-randconfig-006-20250823    gcc-12
x86_64      buildonly-randconfig-006-20250824    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250823    gcc-15.1.0
xtensa                randconfig-001-20250824    gcc-9.5.0
xtensa                randconfig-002-20250823    gcc-13.4.0
xtensa                randconfig-002-20250824    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

