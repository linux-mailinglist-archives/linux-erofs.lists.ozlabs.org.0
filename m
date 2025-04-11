Return-Path: <linux-erofs+bounces-194-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 959DBA8559B
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Apr 2025 09:40:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZYpVY3CCQz3c2h;
	Fri, 11 Apr 2025 17:39:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744357189;
	cv=none; b=MJrZfstEtHl6gS7OFcnsIH15CTdnO/5kZtj7Trr6WoFhrVLvdy2wuc04hJPHbunH8HEBcox78WKjFAJHYr0Nfdm6a55yWxvix3RUqTwa/aB/kUV3MSdF7TkRG+bslgbRGWiP3hWInqntWk+G9q1wMFs2DccbAwxJC+bjojxPY75jD33vYtexlaZENnjVzSFxD3+xG3r2N+7CtC2XEAWIXHrv3RMQppQNAV34thcxcZTK+R6ai0gjYnjErgBl2stth2Cmg/Z72Xwlvpk8361urSHQoUW8j0FGe/jIgU2A+Wzhb0+LJ9ptczRNoL7VUeYHdpQE9M7J9PjfqiOxPB8jJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744357189; c=relaxed/relaxed;
	bh=exAwrbWg7Q/kU7UF4JV/mFfFM6eyERQWFaBb4as4CTg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LZOOhC7tO5z+MW7YXT2kZNXc6JPObqRtP7tyhAIRiM9SHlx3h9TMOneOQqLQX5yzSl3gCjYpBXH6NKhiT3CNXYiGhUjau8fXNKMeblpGIUj2s6eZxhx4wknI/6cYGHmho/SjDbU3SWXvmxBBxFFXJgb9uvrq986HmCab7kj6g8YMRZ7VOlBAOO7psPTwJIyvCp8Rnc36lWRfUN/ppIwdOEVVqWIeNafN8uIB3BPCHtAAd/kFsxsPQZ8ZmWL6H1IA8u6MGj5Z4guINICdtltwdPhsQxVV/C+nrtHJfUIypflOgHvS/HPp8Ut1otDPKFRapYNZ64oz0Vac7Z+z3iFP/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OeDPTs12; dkim-atps=neutral; spf=pass (client-ip=192.198.163.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OeDPTs12;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZYpVW1KrFz3bqD
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Apr 2025 17:39:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744357187; x=1775893187;
  h=date:from:to:cc:subject:message-id;
  bh=7SAHj5cJGUErR6KuiBPsX6OgKur54Iei5NRv9cD0530=;
  b=OeDPTs127SZSz72CnMtw+6WKJlT7FgUOcO+1zmHwUSnS2IhxHYWq098v
   A2PE+yuIsTKsDPBtSPV2IiOLi68g+FQYuTjpJJtgO2jT+wUxWAT357A8b
   f9FxUn6D74PlSVkjEK+nH7JHPw6QQFGA+tf6QUCx8cOUwtLsOzHpwbRXG
   YkaKKVaa86mxo2cxaXBbpkRX/Owgm4euPbRGBUQmXrWY7O6KrmeaBTMPc
   lPqXq/SdhJ5R1+lrou7+TCZFAmO1fC0n0+mvpdNZSMFKMQDarOYrETw7W
   6o5oK/TN/tgDbRoqPDBvtWorU54WCCAi6uOApeoZVrOoHVKupd0oRux00
   g==;
X-CSE-ConnectionGUID: gq/Wg+zkSbygfcTxB3t5Ng==
X-CSE-MsgGUID: Oy8MxS63Re2V8Mks3b5Xmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="46029843"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="46029843"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 00:39:43 -0700
X-CSE-ConnectionGUID: jYYE8BonSHKvSJWXHRfFLg==
X-CSE-MsgGUID: nMzwKIHaQOuVLWf0ZPKeFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="128895297"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 11 Apr 2025 00:39:42 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u38zD-000AwY-2K;
	Fri, 11 Apr 2025 07:39:39 +0000
Date: Fri, 11 Apr 2025 15:38:40 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 f5ffef9881a76764477978c39f1ad0136a4adcab
Message-ID: <202504111533.sVJKRr5O-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: f5ffef9881a76764477978c39f1ad0136a4adcab  erofs: remove duplicate code

elapsed time: 1458m

configs tested: 109
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250410    gcc-14.2.0
arc                   randconfig-002-20250410    gcc-12.4.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250410    clang-19
arm                   randconfig-002-20250410    clang-19
arm                   randconfig-003-20250410    gcc-7.5.0
arm                   randconfig-004-20250410    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250410    clang-19
arm64                 randconfig-002-20250410    clang-19
arm64                 randconfig-003-20250410    gcc-6.5.0
arm64                 randconfig-004-20250410    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250410    gcc-14.2.0
csky                  randconfig-002-20250410    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250410    clang-19
hexagon               randconfig-001-20250410    clang-21
hexagon               randconfig-002-20250410    clang-19
hexagon               randconfig-002-20250410    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250410    clang-19
i386        buildonly-randconfig-002-20250410    clang-19
i386        buildonly-randconfig-003-20250410    clang-19
i386        buildonly-randconfig-004-20250410    gcc-11
i386        buildonly-randconfig-005-20250410    clang-19
i386        buildonly-randconfig-006-20250410    clang-19
i386        buildonly-randconfig-006-20250410    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250410    gcc-12.4.0
loongarch             randconfig-002-20250410    gcc-12.4.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250410    gcc-14.2.0
nios2                 randconfig-002-20250410    gcc-10.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250410    gcc-5.5.0
parisc                randconfig-002-20250410    gcc-11.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250410    gcc-6.5.0
powerpc               randconfig-002-20250410    gcc-6.5.0
powerpc               randconfig-003-20250410    clang-21
powerpc64             randconfig-001-20250410    clang-21
powerpc64             randconfig-002-20250410    clang-21
powerpc64             randconfig-003-20250410    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250410    clang-21
riscv                 randconfig-002-20250410    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250410    clang-21
s390                  randconfig-002-20250410    gcc-6.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250410    gcc-12.4.0
sh                    randconfig-002-20250410    gcc-10.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250410    gcc-10.3.0
sparc                 randconfig-002-20250410    gcc-7.5.0
sparc64               randconfig-001-20250410    gcc-7.5.0
sparc64               randconfig-002-20250410    gcc-5.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250410    clang-21
um                    randconfig-002-20250410    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250410    clang-20
x86_64      buildonly-randconfig-002-20250410    gcc-12
x86_64      buildonly-randconfig-003-20250410    clang-20
x86_64      buildonly-randconfig-004-20250410    clang-20
x86_64      buildonly-randconfig-005-20250410    clang-20
x86_64      buildonly-randconfig-006-20250410    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250410    gcc-14.2.0
xtensa                randconfig-002-20250410    gcc-7.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

