Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D2A96FE5E
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Sep 2024 01:18:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X0sbn4PJqz30DR
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Sep 2024 09:18:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725664704;
	cv=none; b=ZulyX/oUbovq6dzUM+HApXtidyQToCxV2jJ1cV3I9bE80LWaF1GXMy/ScCFAbpPWYOd3naMA+Pnl3huOaVivjjT23am8BwE5QWa5dUqIjuZzV5Rgi3KEFP0u0HBzu7YUrYqs2+m6mwu14/cEOOt6xizYHJVf/nU3qXE1nnngQRiPsW74K06tCSJyFf0kB4RPD/0g1grytnC4hZEFlnRmzWyJRfG9nZtwkR0UCqxpcG6mr/HB37zzHsAwsA9C16QarycnX06i5kKpWPgiyvFRCxAviyhjttAgIMTSt6onPvChXU8eOrGVo7oV0wy7zK72ndR5N2kjIhbGGieTEr0gHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725664704; c=relaxed/relaxed;
	bh=EN6EOo2uM1qjf/NPkp3Ck99oismt7o7QwFxwsMqz9i8=;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID; b=CdnFpuvNTKYZoOFHoXSD1f/tNerqUK4kGxUs7yLcTaiPZllUPGuKaM7AL3NjLXBHeJPsfU4i66QzBIIqIzdkX3brQMFrjKHD2gedQMFsyNL4lm16uniZESvCNqoEKtuc1XQJzMazBuIkdF6005eya35/XwqV19YE7v4ltg+LM9c0tPI7I8QEgZBhcNSaJlgyRKD43RuG0S05n1uo0j190emejNNvIMbGNDgOWUMIHpFPNd6mD+eZNy+tCi6cYFqSot0oKbEwCmTUtYT0MzgK/xomfK7UkpiEtV6F+Xe/bnKn6efQ5DDabt1IkOejcOozmnQVmX33/R4q7bA9o1xgHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yi7G/cuw; dkim-atps=neutral; spf=pass (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yi7G/cuw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X0sbf40qlz2yVB
	for <linux-erofs@lists.ozlabs.org>; Sat,  7 Sep 2024 09:18:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725664703; x=1757200703;
  h=date:from:to:cc:subject:message-id;
  bh=GUxjcSyiFmlWw9VmX5xN+FVhDSXga6Vaw5ws9x9sg4Q=;
  b=Yi7G/cuwcF8glyYhWyfZ+NAeh2kGTSpKileR4b1X4HRlu6/jdUIm/VeW
   jTsS5YMxFiad9X49FZg+2wLLZPc1pDeKUbdbKqnxEPnc6PPU4UYwm/dqX
   t48RgAT2Dv904bd5tTx4WNRHrpoAiorYi3GArLKmLwrHObEGNB5yS+jQ5
   O8SJcNpbzLXdYslaFuFfmjzyzM9Hiv0MdH5h+ydkW40QKRoQWV37znC6j
   MirOethn3CHr6dm+09da+uqGd0igXAGoWSF6SbY99jQq00ZMiDLuA2t04
   11DzACVIEsEBtmESP2mD25KwKZJFDFHV2zVqyz26JLpPZEZB7AaOvCNPx
   w==;
X-CSE-ConnectionGUID: 31dFeUExQ8iNBF1frSBqfA==
X-CSE-MsgGUID: 5tXqFdavRXagvSvCvU3eOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="24303393"
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="24303393"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 16:18:17 -0700
X-CSE-ConnectionGUID: +Gzo4JBNRGODekkMhnjTIw==
X-CSE-MsgGUID: DToryH0RR0yXDFFZPm7vVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="70909176"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 06 Sep 2024 16:18:15 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smiDU-000Bqd-36;
	Fri, 06 Sep 2024 23:18:12 +0000
Date: Sat, 07 Sep 2024 07:17:49 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 6f91636b3746d4f5d57cf76a2fe0d61d405c61f0
Message-ID: <202409070747.zLSeqwSi-lkp@intel.com>
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
branch HEAD: 6f91636b3746d4f5d57cf76a2fe0d61d405c61f0  erofs: sunset unneeded NOFAILs

elapsed time: 2153m

configs tested: 110
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                               allnoconfig   gcc-13.2.0
arc                   randconfig-001-20240907   gcc-13.2.0
arc                   randconfig-002-20240907   gcc-13.2.0
arm                               allnoconfig   clang-20
arm                   randconfig-001-20240907   gcc-14.1.0
arm                   randconfig-002-20240907   gcc-14.1.0
arm                   randconfig-003-20240907   gcc-14.1.0
arm                   randconfig-004-20240907   clang-16
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240907   gcc-14.1.0
arm64                 randconfig-002-20240907   gcc-14.1.0
arm64                 randconfig-003-20240907   gcc-14.1.0
arm64                 randconfig-004-20240907   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240907   gcc-14.1.0
csky                  randconfig-002-20240907   gcc-14.1.0
hexagon                           allnoconfig   clang-20
hexagon               randconfig-001-20240907   clang-20
hexagon               randconfig-002-20240907   clang-20
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
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240907   gcc-14.1.0
loongarch             randconfig-002-20240907   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240907   gcc-14.1.0
nios2                 randconfig-002-20240907   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240907   gcc-14.1.0
parisc                randconfig-002-20240907   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc               randconfig-001-20240907   clang-20
powerpc64             randconfig-001-20240907   clang-16
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                               defconfig   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240906   clang-18
x86_64       buildonly-randconfig-002-20240906   clang-18
x86_64       buildonly-randconfig-003-20240906   clang-18
x86_64       buildonly-randconfig-004-20240906   clang-18
x86_64       buildonly-randconfig-005-20240906   clang-18
x86_64       buildonly-randconfig-006-20240906   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240906   clang-18
x86_64                randconfig-002-20240906   gcc-12
x86_64                randconfig-003-20240906   gcc-12
x86_64                randconfig-004-20240906   gcc-12
x86_64                randconfig-005-20240906   gcc-12
x86_64                randconfig-006-20240906   gcc-12
x86_64                randconfig-011-20240906   clang-18
x86_64                randconfig-012-20240906   gcc-12
x86_64                randconfig-013-20240906   clang-18
x86_64                randconfig-014-20240906   clang-18
x86_64                randconfig-015-20240906   clang-18
x86_64                randconfig-016-20240906   clang-18
x86_64                randconfig-071-20240906   gcc-12
x86_64                randconfig-072-20240906   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
