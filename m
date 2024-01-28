Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F0983F883
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Jan 2024 18:20:55 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M/QZOIeE;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TNJ9c5xXNz3bnv
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jan 2024 04:20:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M/QZOIeE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Mon, 29 Jan 2024 04:20:46 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TNJ9V4w89z3bnv
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Jan 2024 04:20:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706462447; x=1737998447;
  h=date:from:to:cc:subject:message-id;
  bh=fKnd6UeMu3Y0T5GgOU/4K9coMMNRdWYtFd0gBhEJeaA=;
  b=M/QZOIeEpUQI16o0eYcoIakDMA7SdbglUP4FhBJIw3Kxlh52FHmG0T8j
   /kAz5Xnum4vKN40fy/4HAn59zcLNablhvPELrMKKeSIKIOTzQ05/9+YWW
   N4NdxeV7wZstXpU0Rb5qgexsN6Ps8o3wzdm9Cwu3KAn9HEaANN4w/42oI
   ya4gQCWTwTWjFCzPXVySBOALNSg/RWFwjlpfhJfnTKov5PsEQMyQsUqoK
   8M+4lxI1B543pYRhI80gNix7TLOUAKhAf2bLovkCw8C/6YD2AlYaON/ad
   MFD/B6CfhzX7bMX2PDuG+bBsW3FPRaGICJWCd/BuOzkzREmrUKn65Nr2Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="2680963"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="2680963"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 09:19:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="3072029"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 28 Jan 2024 09:19:35 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rU8oe-0003b8-1z;
	Sun, 28 Jan 2024 17:19:32 +0000
Date: Mon, 29 Jan 2024 01:19:11 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 d9281660ff3ffb4a05302b485cc59a87e709aefc
Message-ID: <202401290108.CvrVxeKw-lkp@intel.com>
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
branch HEAD: d9281660ff3ffb4a05302b485cc59a87e709aefc  erofs: relaxed temporary buffers allocation on readahead

elapsed time: 2185m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240129   gcc  
arc                   randconfig-002-20240129   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240129   gcc  
arm                   randconfig-002-20240129   gcc  
arm                   randconfig-003-20240129   gcc  
arm                   randconfig-004-20240129   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240129   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
i386         buildonly-randconfig-001-20240128   clang
i386         buildonly-randconfig-002-20240128   clang
i386         buildonly-randconfig-003-20240128   clang
i386         buildonly-randconfig-004-20240128   clang
i386         buildonly-randconfig-005-20240128   clang
i386         buildonly-randconfig-006-20240128   clang
i386                  randconfig-001-20240128   clang
i386                  randconfig-002-20240128   clang
i386                  randconfig-003-20240128   clang
i386                  randconfig-004-20240128   clang
i386                  randconfig-005-20240128   clang
i386                  randconfig-006-20240128   clang
i386                  randconfig-011-20240128   gcc  
i386                  randconfig-012-20240128   gcc  
i386                  randconfig-013-20240128   gcc  
i386                  randconfig-014-20240128   gcc  
i386                  randconfig-015-20240128   gcc  
i386                  randconfig-016-20240128   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
s390                              allnoconfig   gcc  
s390                                defconfig   gcc  
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                              defconfig   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
