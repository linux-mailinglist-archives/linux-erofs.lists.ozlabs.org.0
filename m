Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 783FD91E580
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Jul 2024 18:39:34 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FbgoMgzw;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WCWwN1hrWz3dBj
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jul 2024 02:39:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FbgoMgzw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WCWwF6GyNz3cR1
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Jul 2024 02:39:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719851966; x=1751387966;
  h=date:from:to:cc:subject:message-id;
  bh=RzP8Mz+UguOjnRq8X0gt4TC8MZkWHhr0WHazvqvLsGQ=;
  b=FbgoMgzwA1iQeMfck/1JAwCO4NbCSYvsz+eXp0PC5GRnQCS+Giz6rSJH
   q7crpF15kq8YzbLcFkm+Plp+wJOvSg+LHVUZ4aZDNrJng5sr6gja9m52P
   ifWAM0h2M/VqIZALG5OlsUWRwQKZTt3r40HICfcv3NK0d49SOd2Yg31BI
   Bhe7yvAzoR8qDq7y14o5NjG5kYNNDFUkOXUo2GBLT09Ym++Cb0DfaMi91
   nSFc0mA/W6etxiyjLfj5bZf4ljcT2NBPPkY3nF6KIQpJmaCoiyUkQ+/Dz
   0tAIkRsNU1AZy5M6HgBBhlh7v0NRFrPBwJv8TL7YnacmlhwgrnwY9fROP
   A==;
X-CSE-ConnectionGUID: L/ArVdDiSum1lCCTk6IaBg==
X-CSE-MsgGUID: Ct4LryE4T6ekE/B6MuTL1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="42417191"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="42417191"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 09:39:20 -0700
X-CSE-ConnectionGUID: AvB4npoKQgaN2hPHQAzaUQ==
X-CSE-MsgGUID: g5CA5F29QHK85pbnP/6joQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="45663776"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 01 Jul 2024 09:39:19 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sOK3h-000N1M-0Z;
	Mon, 01 Jul 2024 16:39:17 +0000
Date: Tue, 02 Jul 2024 00:39:03 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 9b32b063be1001e322c5f6e01f2a649636947851
Message-ID: <202407020001.z9ff2m3N-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 9b32b063be1001e322c5f6e01f2a649636947851  erofs: ensure m_llen is reset to 0 if metadata is invalid

elapsed time: 2036m

configs tested: 111
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                   randconfig-001-20240701   gcc-13.2.0
arc                   randconfig-002-20240701   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                   randconfig-001-20240701   gcc-13.2.0
arm                   randconfig-002-20240701   gcc-13.2.0
arm                   randconfig-003-20240701   clang-19
arm                   randconfig-004-20240701   clang-15
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240701   gcc-13.2.0
arm64                 randconfig-002-20240701   clang-19
arm64                 randconfig-003-20240701   gcc-13.2.0
arm64                 randconfig-004-20240701   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240701   gcc-13.2.0
csky                  randconfig-002-20240701   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon               randconfig-001-20240701   clang-19
hexagon               randconfig-002-20240701   clang-19
i386         buildonly-randconfig-001-20240630   clang-18
i386         buildonly-randconfig-001-20240701   clang-18
i386         buildonly-randconfig-002-20240630   clang-18
i386         buildonly-randconfig-002-20240701   clang-18
i386         buildonly-randconfig-003-20240630   clang-18
i386         buildonly-randconfig-003-20240701   clang-18
i386         buildonly-randconfig-004-20240630   gcc-7
i386         buildonly-randconfig-004-20240701   clang-18
i386         buildonly-randconfig-005-20240630   clang-18
i386         buildonly-randconfig-005-20240701   gcc-13
i386         buildonly-randconfig-006-20240630   gcc-13
i386         buildonly-randconfig-006-20240701   gcc-9
i386                  randconfig-001-20240630   gcc-13
i386                  randconfig-001-20240701   clang-18
i386                  randconfig-002-20240630   gcc-13
i386                  randconfig-002-20240701   clang-18
i386                  randconfig-003-20240630   clang-18
i386                  randconfig-003-20240701   clang-18
i386                  randconfig-004-20240630   gcc-13
i386                  randconfig-004-20240701   gcc-7
i386                  randconfig-005-20240630   clang-18
i386                  randconfig-005-20240701   clang-18
i386                  randconfig-006-20240630   clang-18
i386                  randconfig-006-20240701   gcc-13
i386                  randconfig-011-20240630   gcc-13
i386                  randconfig-011-20240701   gcc-13
i386                  randconfig-012-20240630   clang-18
i386                  randconfig-012-20240701   clang-18
i386                  randconfig-013-20240630   gcc-8
i386                  randconfig-013-20240701   clang-18
i386                  randconfig-014-20240630   gcc-8
i386                  randconfig-014-20240701   gcc-8
i386                  randconfig-015-20240630   gcc-10
i386                  randconfig-015-20240701   gcc-10
i386                  randconfig-016-20240630   gcc-13
i386                  randconfig-016-20240701   clang-18
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240701   gcc-13.2.0
loongarch             randconfig-002-20240701   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240701   gcc-13.2.0
nios2                 randconfig-002-20240701   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240701   gcc-13.2.0
parisc                randconfig-002-20240701   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240701   clang-19
powerpc               randconfig-002-20240701   gcc-13.2.0
powerpc               randconfig-003-20240701   gcc-13.2.0
powerpc64             randconfig-001-20240701   gcc-13.2.0
powerpc64             randconfig-002-20240701   gcc-13.2.0
powerpc64             randconfig-003-20240701   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-002-20240701   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64       buildonly-randconfig-001-20240701   gcc-11
x86_64       buildonly-randconfig-002-20240701   gcc-13
x86_64       buildonly-randconfig-003-20240701   clang-18
x86_64       buildonly-randconfig-004-20240701   clang-18
x86_64       buildonly-randconfig-005-20240701   gcc-13
x86_64       buildonly-randconfig-006-20240701   gcc-11
x86_64                randconfig-001-20240701   gcc-10
x86_64                randconfig-002-20240701   gcc-13
x86_64                randconfig-003-20240701   gcc-13
x86_64                randconfig-004-20240701   clang-18
x86_64                randconfig-005-20240701   gcc-10
x86_64                randconfig-006-20240701   gcc-12
x86_64                randconfig-011-20240701   clang-18
x86_64                randconfig-012-20240701   clang-18
x86_64                randconfig-013-20240701   clang-18
x86_64                randconfig-014-20240701   clang-18
x86_64                randconfig-015-20240701   gcc-9
x86_64                randconfig-016-20240701   gcc-13
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
