Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F865BC192
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Sep 2022 04:58:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MW8W966NYz303t
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Sep 2022 12:58:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E1y+62VU;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E1y+62VU;
	dkim-atps=neutral
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MW8W25tNgz2xkn
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Sep 2022 12:58:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663556286; x=1695092286;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rmrpAXDtphUG+o02LvgUHgWEZr9FrlwGVkbLs7FPeCg=;
  b=E1y+62VUmJPfj/8gLH6hFf6+/hO5jn+1m/PuGj6D0bOTbVp+VEJtemE8
   h5lj5SZaFY4ocp3foFik2uW6Udv8z63ODwi5lQJ4wuOKQiSuweg4RRsqg
   w9ySAuU0TvWgxtkqHJIdqzearMdW95nLrn26ROjGTSvJ5flOCNxqauJYw
   MAu7lTgT1pGkTNJzuVbJ+HnjAl57Xu/dSG2dhkEkVpbWabLAs4rpistAH
   RObTlLQvcT7FjOA6mAyyFqQ3h47DgqgcFWyJnMGCk0T9XwjUTJq/N3ctY
   BqENse2aAnGMyMqR58B3xOrr4cXX21DQAxQNpPOGkcwfVmfdm9cslELlf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="299284682"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="299284682"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 19:58:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="743946349"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Sep 2022 19:58:00 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oa6yt-0001gU-2Y;
	Mon, 19 Sep 2022 02:57:59 +0000
Date: Mon, 19 Sep 2022 10:57:20 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 765749f611e67b0cb8f4254c05ef19316e09cf8c
Message-ID: <6327da90.5aL5f6R7tLuOzdra%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 765749f611e67b0cb8f4254c05ef19316e09cf8c  erofs: introduce 'domain_id' mount option

elapsed time: 723m

configs tested: 74
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                  randconfig-r043-20220918
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
arc                                 defconfig
s390                             allmodconfig
x86_64                              defconfig
alpha                               defconfig
powerpc                          allmodconfig
sh                               allmodconfig
s390                                defconfig
i386                          randconfig-a005
mips                             allyesconfig
arm                                 defconfig
s390                             allyesconfig
i386                          randconfig-a014
x86_64                        randconfig-a013
m68k                             allmodconfig
x86_64                        randconfig-a011
powerpc                           allnoconfig
arc                              allyesconfig
i386                             allyesconfig
x86_64                        randconfig-a015
alpha                            allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a012
x86_64                        randconfig-a004
x86_64                           allyesconfig
m68k                             allyesconfig
i386                          randconfig-a016
arm                              allyesconfig
x86_64                        randconfig-a002
x86_64                          rhel-8.3-func
x86_64                        randconfig-a006
x86_64                         rhel-8.3-kunit
arm64                            allyesconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig

clang tested configs:
hexagon              randconfig-r041-20220918
hexagon              randconfig-r045-20220918
riscv                randconfig-r042-20220918
s390                 randconfig-r044-20220918
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a011
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
arm                      tct_hammer_defconfig
powerpc                     ksi8560_defconfig
mips                          malta_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
