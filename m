Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D797A38EBB
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2025 23:10:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YxcKt24Ywz3bkg
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2025 09:10:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739830241;
	cv=none; b=SebN+e4VH7+ppAjhiI8Key3cLx7EjFKrY1DoqTqpMFzb1Vai4hz6XYJARNawxAo5gQDOZ1wMK/1hd4JAdT+gfV6gDzVSohweTugfXOqpNLEE9p/mawHZ6fQCyIMkzqa5iATulxpRlnrvHYTaV2r66EiPfjQAg/edQII99twd9mEab7/M6do+HDm09YXi9z5cx17g7Y/gnYNxsu+R7GNoLhahXwDvsJo/9XW6N4qdHJLl2+g33cfRA+V1ZkeeJkavn12wEStbfN+2fhL1BvRDhjRI81jwMwrs+mz5KOq/cvMmmycgnZyRDlGrkCFOFI+Q4i9fLKKKB4s75Cn2Zq0BEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739830241; c=relaxed/relaxed;
	bh=f6lFAEA5PQBvPQI8nMOpe2RpIsodZjOB25LimdSjA1U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=g0dfMmeuiBITzv/24mq2orfZYzk+A/N5sHA7giNo9ydcQMuaKedD1jhgEHbIpex51ACfw/2JMbEmjLepE3d/ZViKXr1Ii3Zp9El5iuXmQ5Q9kb0nkf3MKpLLTTjX9Kq7aqmnvsztMsFzLRCz53d7/HIgjcvpWYReUYtRxIMKMn0AnZlsHX2i2yyg2LDoQiqgo3S2FOtLonjgMmPjEWR1j3dFLRjhO+0oHx+pOjyYY6j18ARRNU3r/l7e9F+Mos7LA8BYriYTyS8iyAoBzPislULcm4VfSKv17C7SMW7BuAMalTMmaaJX6WPKyk18WMlMLdAnjIk/e+pnXLokJ4Z8wQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Dv/T0Zjv; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Dv/T0Zjv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YxcKq3Bgqz3005
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Feb 2025 09:10:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739830240; x=1771366240;
  h=date:from:to:cc:subject:message-id;
  bh=UHrYXBc6KNThMRAHTSlQCa2MiBL6Dht/11XJonW1cV0=;
  b=Dv/T0ZjvqURbLPg7nZYivABifGbgXA8o+Zj+0Lkx5Qom2Yhz48k0fhQl
   kW0Pa6i4hn1G9aTO4NodnkZsOTzGXKJ36J4Y+y6lg7q8a1O/ojuN2peZb
   sRU7Xybwx4w6SfCzdlqr351whg0NuxmOvA8GGPjikodDz7WVrge5lMt55
   sHCrwBDRvNA9fwgI7VmrPCOzZ1w2UggiKadb7nPQ/nBYSet3bh4J/WsUg
   F5OxD6VAjVKUs9ADiCy92NN67sjPCzWkXk3TGXVpjZ+eudBzcQfACX4iR
   4Y4BAu3a6xyLN4S64kKT204U5q4jw5MkQZHzlicgUkJEeBROKNP0NZsQ0
   A==;
X-CSE-ConnectionGUID: 6g5w/IgMSeeghM9rF5RzAQ==
X-CSE-MsgGUID: dmj765mvRxSXx2Lo9hBNiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="65870559"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="65870559"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 14:10:34 -0800
X-CSE-ConnectionGUID: vfrSsNvHTbamGgFetCkD9Q==
X-CSE-MsgGUID: 8+Y6GwC0TGeoTWqMS2547g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="114153554"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 17 Feb 2025 14:10:33 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tk9Ju-001DdL-34;
	Mon, 17 Feb 2025 22:10:30 +0000
Date: Tue, 18 Feb 2025 06:10:30 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 09284b6e841888a66cdb832dc57bcf527af6d563
Message-ID: <202502180624.sWNtNn7V-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 09284b6e841888a66cdb832dc57bcf527af6d563  erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify switches

elapsed time: 1088m

configs tested: 115
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250217    gcc-13.2.0
arc                   randconfig-002-20250217    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250217    gcc-14.2.0
arm                   randconfig-002-20250217    gcc-14.2.0
arm                   randconfig-003-20250217    gcc-14.2.0
arm                   randconfig-004-20250217    clang-19
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250217    gcc-14.2.0
arm64                 randconfig-002-20250217    clang-21
arm64                 randconfig-003-20250217    clang-15
arm64                 randconfig-004-20250217    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250217    gcc-14.2.0
csky                  randconfig-002-20250217    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
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
loongarch                         allnoconfig    gcc-14.2.0
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
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
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
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250217    gcc-14.2.0
riscv                 randconfig-002-20250217    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250217    gcc-14.2.0
s390                  randconfig-002-20250217    clang-18
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250217    gcc-14.2.0
sh                    randconfig-002-20250217    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250217    gcc-14.2.0
sparc                 randconfig-002-20250217    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250217    gcc-14.2.0
sparc64               randconfig-002-20250217    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250217    clang-19
um                    randconfig-002-20250217    clang-17
um                           x86_64_defconfig    clang-15
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
