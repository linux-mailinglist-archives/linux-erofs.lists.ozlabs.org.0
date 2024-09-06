Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238C496FE19
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Sep 2024 00:46:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X0rtp4Mc4z30CM
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Sep 2024 08:46:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725662783;
	cv=none; b=P9svXfUod8tC5T+38S18kkW2Hrb4SYj73XVLr5bqLk8VOCXOC3JN5/dIscG8eW2nD2rwascUseLxAu+ZiEv5rHZxYw4wq02f4Xy/IKm5gEXZV21iaGIpFm5g9DnIvxRW17xG3r+kcS5KTeniZhAHeX//KdfEZSt/PT9JSSGhFNQxBICt0UPVR0medsHmoW9ogpLqANKHLr1XE7H1aGV1Rv6Gd/+1UHxxwrgnz7ifQ2eMXCRjEiKCp/P74MP6JPHVJbA3X6REGRV1SqvRBzniVRGqdqrG9U5DkUO1BBdDnhhm18EjzgRImKmma6DFeXRVf/mY3ctU9ofeCvt2PX+o2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725662783; c=relaxed/relaxed;
	bh=FBpkxKqr1k9qxQz0fUt/UWTVaTc/LEqvyBJXgznPn50=;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID; b=eaZLIanJ+wC67y6VUrEIepvWK0sRjNHbTeh5kRvWvORl7hLdH9XqIWjhDfXYNalvC0YvTCVoPgUsZkZCw8AiL4OB18nxqU36zVOmfeBXCbpBagd3KcvRH4n23Dtk2Tw/1PF22jptsJoycJeM1b9SF0gaLUKehqG3sBbWs9msJvhYNDUm6XTgjsh8bo4iM0PCqciO0/F5xCMWRoB4LJYr+4kpuQIQl9x2lwqJM0ZjeJbK1N5H1EFfk/uestzSevL/y2ZmPdJYgs1iNzpD79aVec26Qx6ojSoei/uwCrf6iH1JJ5g6KhtNVe/Q5TET3+h39cI2tXCLnm1i7lJGBiHG1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EL34OOzK; dkim-atps=neutral; spf=pass (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EL34OOzK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X0rtj35b4z2yF4
	for <linux-erofs@lists.ozlabs.org>; Sat,  7 Sep 2024 08:46:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725662781; x=1757198781;
  h=date:from:to:cc:subject:message-id;
  bh=AZQPg6jbBMfxIRGVySv6phIp5vQdCkpHjfB/Sngun3g=;
  b=EL34OOzK10o6YRkWetbWzUHGp6ftKfuz9h+zkNIZosX9XDnEhKdiMGMq
   9333VPPcwyCe4S6sbF4vHg6XB5OZ6XRq/67R49yv/zPQFlucum3Z1iw7W
   K6Q+yHzSAPIMrJ54pw6FfXaYxQJLAQGRCLxRgHm/9ELzg/uBnK+9f4YVh
   s9m7NMAvUoCracXMdgfLtDjPOX6RU6K0Ob3gdv/vR8tQDdKQNLZKTrdp6
   4M4dVHsCDUEeP/IUgQpvNAvxFqAzpKtNrV01XcddwSeOF9y86d92gBqMy
   s09e72YBf88jFwSUq6CA/j11wkF0wYKhqXu8bHaS8KZovjiXziWQjx88K
   g==;
X-CSE-ConnectionGUID: K9IZx2FYSiO3a7f62BHm8Q==
X-CSE-MsgGUID: 7KdseOGdS32Sxu9AqNRksg==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="35012070"
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="35012070"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 15:46:14 -0700
X-CSE-ConnectionGUID: xb4+TQxGT9O7atr+m6kMDA==
X-CSE-MsgGUID: Xtp8WjjaQ5CBhApQt2VcCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="89361644"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 06 Sep 2024 15:46:13 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smhiV-000Bpf-16;
	Fri, 06 Sep 2024 22:46:11 +0000
Date: Sat, 07 Sep 2024 06:45:38 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 8d8f113f5fa47b78122c9abee3e3ff316d8e7a0f
Message-ID: <202409070635.8bgfJWyP-lkp@intel.com>
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
branch HEAD: 8d8f113f5fa47b78122c9abee3e3ff316d8e7a0f  erofs: simplify erofs_map_blocks_flatmode()

elapsed time: 2121m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                               allnoconfig   gcc-13.2.0
arc                   randconfig-001-20240906   gcc-13.2.0
arc                   randconfig-002-20240906   gcc-13.2.0
arm                               allnoconfig   clang-20
arm                   randconfig-001-20240906   clang-20
arm                   randconfig-002-20240906   gcc-14.1.0
arm                   randconfig-003-20240906   gcc-14.1.0
arm                   randconfig-004-20240906   gcc-14.1.0
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240906   clang-20
arm64                 randconfig-002-20240906   clang-17
arm64                 randconfig-003-20240906   gcc-14.1.0
arm64                 randconfig-004-20240906   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240906   gcc-14.1.0
csky                  randconfig-002-20240906   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240906   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240906   clang-18
i386         buildonly-randconfig-002-20240906   gcc-12
i386         buildonly-randconfig-003-20240906   clang-18
i386         buildonly-randconfig-004-20240906   gcc-12
i386         buildonly-randconfig-005-20240906   clang-18
i386         buildonly-randconfig-006-20240906   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240906   gcc-12
i386                  randconfig-002-20240906   clang-18
i386                  randconfig-003-20240906   gcc-12
i386                  randconfig-004-20240906   clang-18
i386                  randconfig-005-20240906   clang-18
i386                  randconfig-006-20240906   gcc-12
i386                  randconfig-011-20240906   gcc-12
i386                  randconfig-012-20240906   clang-18
i386                  randconfig-013-20240906   gcc-12
i386                  randconfig-014-20240906   gcc-12
i386                  randconfig-015-20240906   gcc-12
i386                  randconfig-016-20240906   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240906   gcc-14.1.0
loongarch             randconfig-002-20240906   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240906   gcc-14.1.0
nios2                 randconfig-002-20240906   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240906   gcc-14.1.0
parisc                randconfig-002-20240906   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc               randconfig-001-20240906   clang-17
powerpc               randconfig-002-20240906   gcc-14.1.0
powerpc               randconfig-003-20240906   clang-15
powerpc64             randconfig-001-20240906   clang-20
powerpc64             randconfig-002-20240906   clang-15
powerpc64             randconfig-003-20240906   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240906   gcc-14.1.0
riscv                 randconfig-002-20240906   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240906   clang-20
s390                  randconfig-002-20240906   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240906   gcc-14.1.0
sh                    randconfig-002-20240906   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240906   gcc-14.1.0
sparc64               randconfig-002-20240906   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240906   clang-20
um                    randconfig-002-20240906   clang-20
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240906   gcc-14.1.0
xtensa                randconfig-002-20240906   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
