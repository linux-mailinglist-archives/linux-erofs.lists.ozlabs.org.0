Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8448A5ED061
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Sep 2022 00:46:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4McZVQ1bl2z3bhQ
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Sep 2022 08:46:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dZ6YObFN;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dZ6YObFN;
	dkim-atps=neutral
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4McZVG52wQz2ysx
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Sep 2022 08:46:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664318774; x=1695854774;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XstZDw6HzhwyGyVcmGB78/CukAfNMr1AFN8k3quHD8g=;
  b=dZ6YObFN9dxY6ktrv5N0IbeM8GNzDiNONyKlmANRihPlaggOrQUGZwsu
   sFMvzCQ03pFFDp12K8p3zmRooRBQwZgx4MlAGOq23G/UhH0kvro8pHV++
   2pHnC/aeGZ1UvMy2F1c9uIvgB7iIjhgeclRysHwkG5FylWWeQdhwvq7g8
   G3H5bqdfBzpaR2CsdjXJvf2K3nnrfqY6Lt557n0ALrjG2GQcvUzDrW++m
   3dMmh51ZDYHdYoc0NJhDrClvaLz8FoJ2/SdqWe6LHKIxiO187KlYGoO4J
   vk+wqFVCPWNhsPrBhowfOZUuMb/Ee2oYKjGVs9RTanrqmvPmr5nPqGCOS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="301427071"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="301427071"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 15:45:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="950464774"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="950464774"
Received: from lkp-server02.sh.intel.com (HELO dfa2c9fcd321) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 27 Sep 2022 15:45:56 -0700
Received: from kbuild by dfa2c9fcd321 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1odJKt-0001f2-2X;
	Tue, 27 Sep 2022 22:45:55 +0000
Date: Wed, 28 Sep 2022 06:45:32 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 312fe643ad1153fe0337c46f4573030d0c2bac73
Message-ID: <63337d0c.QC0GtB9RMth8B4lq%lkp@intel.com>
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
branch HEAD: 312fe643ad1153fe0337c46f4573030d0c2bac73  erofs: clean up erofs_iget()

elapsed time: 750m

configs tested: 69
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
i386                 randconfig-a001-20220926
i386                 randconfig-a004-20220926
i386                 randconfig-a002-20220926
i386                 randconfig-a003-20220926
arc                  randconfig-r043-20220925
sh                               allmodconfig
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20220926
x86_64                         rhel-8.3-kunit
i386                 randconfig-a006-20220926
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
i386                 randconfig-a005-20220926
alpha                            allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a002-20220926
arc                              allyesconfig
x86_64                               rhel-8.3
x86_64               randconfig-a001-20220926
m68k                             allmodconfig
x86_64                        randconfig-a004
riscv                randconfig-r042-20220925
m68k                             allyesconfig
x86_64               randconfig-a003-20220926
x86_64                           allyesconfig
x86_64                        randconfig-a002
s390                 randconfig-r044-20220925
i386                                defconfig
x86_64               randconfig-a004-20220926
x86_64               randconfig-a006-20220926
x86_64                        randconfig-a006
x86_64               randconfig-a005-20220926
i386                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220925
s390                 randconfig-r044-20220926
i386                 randconfig-a011-20220926
i386                 randconfig-a015-20220926
i386                 randconfig-a014-20220926
hexagon              randconfig-r045-20220926
i386                 randconfig-a013-20220926
riscv                randconfig-r042-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a016-20220926
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a016-20220926
x86_64               randconfig-a015-20220926
x86_64               randconfig-a014-20220926

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
