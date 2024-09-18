Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4000997BD59
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Sep 2024 15:51:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X80S305Qxz2yFD
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Sep 2024 23:51:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726667488;
	cv=none; b=C7rc4gzsOJ3IUxUxQGANWnc7Hn3KGLY7b/46pyJ0aL8u9899a7xuiijj/dOBQsuv/ZqqGKUcFZOjjSQ99ytKlINcwaebHQBHn16Y41fQseoO+JFomsoKM+sXUNLzxTag9T4XAGRrdvaRBuWW3Ds0mxT+I3pKdod1gcZ71UsdatetPY/fQ/1dMnQi3AZOdvS92d+UgTRJT5ZSS3oMtMWyDtg1EVilvj0EsW4ryjwrIn65mS+gOWfRqLAYZzoe1LilH6DGZAm7zqzpiaE4JP+7DriJxSJenL8GqRK++fnnoTnxROhAjb9TIhwGbPKM480G6XjVJJoJdDJ68cvMYH7BjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726667488; c=relaxed/relaxed;
	bh=eFE0trsi90J6OlaNEDBFyw8Y84wjnbPII/3Aom1Qgg0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PNC5cTlFOb0GkfK6iIne8pBaF8j1/673OmK0qMnlLBna//OthJwR320fzC+Y4rJKq8kq0ww68+pdiuQPuLijeKO2uG9q/DfkYLNP1CAE234rt0/wAlsZ82uYR5bOCpMcGlmaTKFlcCtRcRyXf+m3l/3iElg/nI9vP7/xpdIPiD0zizqySvjbmaGMCgnPfKlCGUkb+9U4UoNIely4Jf+6RfNhsAgXv61FB1QY+NdFuukzYsdN682+ovU2OBuyw2cvYcSAlK5dymitOjb++CCsLiJWY/KpPn/OMBovpeiCj2g6g8k5bBpMziItRZYqlNjPzIBb8qikgLvrXWSQKQduTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gGE8lspD; dkim-atps=neutral; spf=pass (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gGE8lspD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X80Rz1Vxbz2xJF
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Sep 2024 23:51:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726667488; x=1758203488;
  h=date:from:to:cc:subject:message-id;
  bh=o9K8P25SRFI/8QOPL19iQfwXT+QdZUhcbk4Q6sWI6ow=;
  b=gGE8lspDrOC8zF57sc8pqZNR+gjfdDbMsHwLB6n/fGBE5uNRDjg2PKcx
   oPbA1bwIk2lCfHlI4R2aQ57lmV47mAwVWVlXnWg1qllhoBHdeId0Lb+St
   A2CyY9SS+w7/20lc6oadUN/pM69qJ+wMlYgzfGxl9cTGCnnRrqNCg+dDc
   DxwDotwYrR8gdovfGZ9DmIGQxY3gW8exA/eS0zixnBUCvpE3AqY2UnZXT
   sKfKHXYk5KNgB+1th/CGpjzIlnofbWYWoxLOlLjc+2SefzqNTUJeQZM3w
   yApwCgN7LBPErzWAmdG7SzzbusqGqr6ap9uwHJW67y4LNHJ39u0RIe4AT
   g==;
X-CSE-ConnectionGUID: 2mCA5mrtTh2ywTbYtnBP6A==
X-CSE-MsgGUID: 1TW9q5VrSJiVluRRmmx4vQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="28485524"
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="28485524"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 06:51:21 -0700
X-CSE-ConnectionGUID: P4uaVlhATlqxiyvRIgpIcA==
X-CSE-MsgGUID: JHloaaJfQJevUOWjd1mIcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="74396717"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 18 Sep 2024 06:51:20 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sqv5R-000CHG-1X;
	Wed, 18 Sep 2024 13:51:17 +0000
Date: Wed, 18 Sep 2024 21:50:37 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 fc0644e8500541afb17189d7a6cbafe9a20893c5
Message-ID: <202409182128.KYqfuTYD-lkp@intel.com>
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
branch HEAD: fc0644e8500541afb17189d7a6cbafe9a20893c5  erofs: ensure regular inodes for file-backed mounts

elapsed time: 1408m

configs tested: 118
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                            dove_defconfig    clang-14
arm                          ep93xx_defconfig    clang-14
arm                        neponset_defconfig    clang-14
arm                            qcom_defconfig    clang-14
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    clang-14
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240918    clang-18
i386        buildonly-randconfig-002-20240918    clang-18
i386        buildonly-randconfig-003-20240918    clang-18
i386        buildonly-randconfig-004-20240918    clang-18
i386        buildonly-randconfig-005-20240918    clang-18
i386        buildonly-randconfig-006-20240918    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20240918    clang-18
i386                  randconfig-002-20240918    clang-18
i386                  randconfig-003-20240918    clang-18
i386                  randconfig-004-20240918    clang-18
i386                  randconfig-005-20240918    clang-18
i386                  randconfig-006-20240918    clang-18
i386                  randconfig-011-20240918    clang-18
i386                  randconfig-012-20240918    clang-18
i386                  randconfig-013-20240918    clang-18
i386                  randconfig-014-20240918    clang-18
i386                  randconfig-015-20240918    clang-18
i386                  randconfig-016-20240918    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5208evb_defconfig    clang-14
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                      maltaaprp_defconfig    clang-14
mips                      maltasmvp_defconfig    clang-14
mips                      pic32mzda_defconfig    clang-14
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    clang-14
openrisc                    or1ksim_defconfig    clang-14
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                         alldefconfig    clang-14
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                     kmeter1_defconfig    clang-14
powerpc                         ps3_defconfig    clang-14
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                       zfcpdump_defconfig    clang-14
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    clang-14
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                           rhel-8.3-bpf    clang-18
x86_64                           rhel-8.3-bpf    gcc-12
x86_64                         rhel-8.3-kunit    clang-18
x86_64                         rhel-8.3-kunit    gcc-12
x86_64                           rhel-8.3-ltp    clang-18
x86_64                           rhel-8.3-ltp    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
