Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BC75BE594
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Sep 2022 14:20:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MX0xv6YQCz3bbP
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Sep 2022 22:20:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I2ZO4OQx;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I2ZO4OQx;
	dkim-atps=neutral
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MX0xr1HPDz304j
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Sep 2022 22:20:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663676448; x=1695212448;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9zOSFQk5IsLLJdHt9I0JcKrrNmpJnRFQv2BQFGO1Pe8=;
  b=I2ZO4OQxykFchvCnZe7AJB4rZHS7UWJcpzhRYQmudK/mPU2cIe5z8Doi
   /cxDHVs4asvgPxyG5s5NpwfFW/gv+Z0g8M/gzdXusYpa0MtGV+gNSLJdz
   DswSHNLa5poc4NIRcdqphrooX53wd8jAi9uIs6MTaa5YhBgQk4Fgc4b9U
   4yC48QDYtboSSh8SM8sAdPW8HWWsBgKVFjVj1noBV2MhBOJgJUI9AVjnZ
   Xqm0Lm6SJTLNz934DM2cbDHRp6eeP1EjisVjUCA7jddkEnmUmeiO8YT8a
   8uAapj6HidlnE3ylLF42uHXBA1kDARywJYhzzXzfM9gX6eKgiHIw8ztFg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="282707404"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="282707404"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 05:20:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="649564991"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Sep 2022 05:20:37 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oacEu-0002jr-3C;
	Tue, 20 Sep 2022 12:20:36 +0000
Date: Tue, 20 Sep 2022 20:20:30 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 2ef164414123fcf574aff7a0be5f71f7e60a3fec
Message-ID: <6329b00e.h4vwVSt+fjIsOR8n%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
branch HEAD: 2ef164414123fcf574aff7a0be5f71f7e60a3fec  erofs: introduce 'domain_id' mount option

elapsed time: 720m

configs tested: 84
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                               defconfig
arc                                 defconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                  randconfig-r043-20220919
arc                              allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
s390                             allmodconfig
riscv                randconfig-r042-20220919
i386                                defconfig
s390                 randconfig-r044-20220919
x86_64               randconfig-a012-20220919
x86_64               randconfig-a011-20220919
i386                 randconfig-a012-20220919
x86_64               randconfig-a013-20220919
i386                 randconfig-a011-20220919
x86_64                           rhel-8.3-kvm
i386                 randconfig-a013-20220919
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a015-20220919
x86_64                               rhel-8.3
powerpc                           allnoconfig
i386                 randconfig-a014-20220919
x86_64                           rhel-8.3-syz
sh                               allmodconfig
s390                                defconfig
mips                             allyesconfig
x86_64               randconfig-a016-20220919
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
i386                 randconfig-a016-20220919
x86_64               randconfig-a014-20220919
powerpc                          allmodconfig
i386                 randconfig-a015-20220919
i386                             allyesconfig
s390                             allyesconfig
arm                                 defconfig
x86_64                           allyesconfig
ia64                             allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                             alldefconfig
arm                         s3c6400_defconfig
arm                         lpc18xx_defconfig
sh                          r7785rp_defconfig
powerpc                      chrp32_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                             shx3_defconfig
powerpc                       holly_defconfig
x86_64               randconfig-k001-20220919
sh                          sdk7786_defconfig
powerpc                   motionpro_defconfig
i386                 randconfig-c001-20220919
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
hexagon              randconfig-r041-20220919
hexagon              randconfig-r045-20220919
x86_64               randconfig-a003-20220919
x86_64               randconfig-a006-20220919
x86_64               randconfig-a005-20220919
x86_64               randconfig-a001-20220919
i386                 randconfig-a001-20220919
x86_64               randconfig-a002-20220919
i386                 randconfig-a006-20220919
x86_64               randconfig-a004-20220919
i386                 randconfig-a002-20220919
i386                 randconfig-a003-20220919
i386                 randconfig-a004-20220919
i386                 randconfig-a005-20220919
powerpc                          g5_defconfig
mips                        qi_lb60_defconfig
arm                         palmz72_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
